package com.melodymart.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Single source of database connections for the whole application.
 *
 * <p>Configuration is read, in order of precedence, from:
 * <ol>
 *   <li>Environment variables {@code DB_URL}, {@code DB_USER}, {@code DB_PASSWORD}</li>
 *   <li>JVM system properties {@code db.url}, {@code db.username}, {@code db.password}</li>
 *   <li>{@code db.properties} on the classpath (local development only, never commit real credentials)</li>
 * </ol>
 */
public final class DBConnection {
    private static final Logger LOGGER = Logger.getLogger(DBConnection.class.getName());
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    private static final String URL;
    private static final String USER;
    private static final String PASSWORD;

    static {
        Properties file = new Properties();
        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                file.load(in);
            }
        } catch (IOException e) {
            LOGGER.log(Level.WARNING, "Could not read db.properties", e);
        }
        URL = resolve("DB_URL", "db.url", file);
        USER = resolve("DB_USER", "db.username", file);
        PASSWORD = resolve("DB_PASSWORD", "db.password", file);
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "SQL Server JDBC driver not on classpath", e);
        }
    }

    private DBConnection() {
    }

    static String resolve(String envName, String propName, Properties file) {
        String value = System.getenv(envName);
        if (isBlank(value)) {
            value = System.getProperty(propName);
        }
        if (isBlank(value)) {
            value = file.getProperty(propName);
        }
        return isBlank(value) ? null : value.trim();
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    public static Connection getConnection() throws SQLException {
        if (URL == null) {
            throw new SQLException("Database is not configured: set the DB_URL, DB_USER and DB_PASSWORD environment variables");
        }
        return USER == null
                ? DriverManager.getConnection(URL)
                : DriverManager.getConnection(URL, USER, PASSWORD);
    }

    /** Returns true when the database answers a trivial query. Used by the health check. */
    public static boolean isHealthy() {
        try (Connection c = getConnection()) {
            return c.isValid(3);
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Database health check failed: {0}", e.getMessage());
            return false;
        }
    }
}
