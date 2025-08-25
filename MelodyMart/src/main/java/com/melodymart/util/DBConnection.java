package main.java.com.melodymart.util;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true";
    private static final String USER = "sa"; // or your SQL username
    private static final String PASS = "H@5iru"; // your SQL password

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Load SQL Server JDBC driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
