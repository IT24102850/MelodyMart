package main.java.com.melodymart.util;




import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL =
            "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true;user=Hasiru;password=hasiru2004";
    private static final String USER = "Hasiru";
    private static final String PASSWORD = "hasiru2004";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("JDBC driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading JDBC Driver: " + e.getMessage());
        }

        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        System.out.println("✅ Database connected successfully!");
        return conn;
    }

    public static void main(String[] args) {
        try (Connection conn = getConnection()) {
            if (conn != null) {
                System.out.println("Connection test OK.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
