package com.melodymart.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.logging.Logger;

public class DatabaseUtil {
    private static final Logger LOGGER = Logger.getLogger(DatabaseUtil.class.getName());
    private static final String PROPERTIES_FILE = "db.properties";
    private static String url;
    private static String user;
    private static String password;
    private static String driver;
    public static String test = "test";
    static {
        try (InputStream input = DatabaseUtil.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                throw new RuntimeException("Cannot find " + PROPERTIES_FILE + " file in classpath");
            }
            Properties prop = new Properties();
            prop.load(input);
            url = prop.getProperty("db.url");
            user = prop.getProperty("db.username");
            password = prop.getProperty("db.password");
            driver = prop.getProperty("db.driver");
            Class.forName(driver); // Load the driver
        } catch (IOException | ClassNotFoundException e) {
            LOGGER.severe("Error loading database configuration: " + e.getMessage());
            throw new RuntimeException("Cannot find " + PROPERTIES_FILE + " file in classpath", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (url == null || url.isEmpty()) {
            throw new SQLException("The url cannot be null");
        }
        return DriverManager.getConnection(url, user, password);
    }
}