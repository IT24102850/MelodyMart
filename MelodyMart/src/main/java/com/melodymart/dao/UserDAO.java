package com.melodymart.dao;

import com.melodymart.model.User;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private DataSource dataSource;

    public UserDAO() {
        // Initialize DataSource (e.g., via JNDI or a connection pool in your server config)
        // This is a placeholder; configure it based on your environment
        // dataSource = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/melodymartDB");
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void registerUser(User user) {
        String sql = "INSERT INTO Users (fullName, email, password, role, country) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword()); // In production, hash the password
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getCountry());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}