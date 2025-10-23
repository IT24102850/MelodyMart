package main.java.com.melodymart.dao;

import main.java.com.melodymart.model.User;
import main.java.com.melodymart.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class UserDAO {

    public boolean registerUser(User user) {
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement psRole = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // 🔹 Insert minimal info into Person (auto-generates PersonID)
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            String sql = "INSERT INTO Person (FirstName, LastName, Email, Password, Country, role) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, user.getName());          // Use name as FirstName
            ps.setString(2, user.getName());          // Reuse if no LastName field exists
            ps.setString(3, user.getEmail().trim().toLowerCase());
            ps.setString(4, hashedPassword);
            ps.setString(5, user.getCountry());
            ps.setString(6, user.getRole().toLowerCase());
            ps.executeUpdate();

            con.commit();

            // 🔹 Retrieve generated PersonID
            String personId = null;
            String getID = "SELECT PersonID FROM Person WHERE Email = ?";
            try (PreparedStatement ps2 = con.prepareStatement(getID)) {
                ps2.setString(1, user.getEmail().trim().toLowerCase());
                try (ResultSet rs = ps2.executeQuery()) {
                    if (rs.next()) personId = rs.getString(1);
                }
            }

            if (personId == null) {
                System.err.println("Could not find PersonID for: " + user.getEmail());
                return false;
            }

            // 🔹 Insert into Customer (only if role == customer)
            if ("customer".equalsIgnoreCase(user.getRole())) {
                String insertCustomer = "INSERT INTO Customer (PersonID, LoyaltyPoints, PreferredPaymentMethod) VALUES (?, ?, ?)";
                psRole = con.prepareStatement(insertCustomer);
                psRole.setString(1, personId);
                psRole.setInt(2, 0);
                psRole.setString(3, "Card");
                psRole.executeUpdate();
            }

            con.commit();
            System.out.println("✅ Registered user " + user.getEmail() + " with PersonID " + personId);
            return true;

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;

        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            try { if (psRole != null) psRole.close(); } catch (SQLException ignored) {}
            try { if (con != null) con.close(); } catch (SQLException ignored) {}
        }
    }

    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM Person WHERE Email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.trim().toLowerCase());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String hash = rs.getString("Password");
                if (BCrypt.checkpw(password, hash)) {
                    User u = new User();
                    u.setId(0); // optional
                    u.setName(rs.getString("FirstName"));
                    u.setEmail(rs.getString("Email"));
                    u.setRole(rs.getString("role"));
                    u.setCountry(rs.getString("Country"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isEmailRegistered(String email) {
        String sql = "SELECT 1 FROM Person WHERE Email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
