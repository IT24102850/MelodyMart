package main.java.com.melodymart.dao;

import main.java.com.melodymart.model.User;
import main.java.com.melodymart.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    /**
     * Registers a new user into the Users table.
     * Passwords are hashed using BCrypt.
     *
     * @param user User object with registration details
     * @return true if registration is successful, false otherwise
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO Users (name, email, password, role, country, created_at) " +
                "VALUES (?, ?, ?, ?, ?, GETDATE())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName().trim());
            stmt.setString(2, user.getEmail().trim().toLowerCase());

            // Hash the password
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            stmt.setString(3, hashedPassword);

            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getCountry());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            // Handle duplicate email
            if (e.getMessage().contains("UNIQUE") || e.getMessage().contains("duplicate")) {
                System.err.println("Email already exists: " + user.getEmail());
            } else {
                e.printStackTrace();
            }
            return false;
        }
    }

    /**
     * Authenticates a user by email and password.
     * Returns the User object if successful, null otherwise.
     *
     * @param email    User email
     * @param password User password (plain text)
     * @return User object if login succeeds, null otherwise
     */
    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM Users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email.trim().toLowerCase());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");

                // Verify password using BCrypt
                if (BCrypt.checkpw(password, storedHash)) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(storedHash); // Keep hashed password
                    user.setRole(rs.getString("role"));

                    user.setCountry(rs.getString("country"));
                    return user;
                } else {
                    System.err.println("Incorrect password for user: " + email);
                }
            } else {
                System.err.println("No user found with email: " + email);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Checks if an email is already registered.
     *
     * @param email Email to check
     * @return true if email exists, false otherwise
     */
    public boolean isEmailRegistered(String email) {
        String sql = "SELECT 1 FROM Users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email.trim().toLowerCase());
            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
