package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import main.java.com.melodymart.util.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== LOGIN ATTEMPT STARTED ===");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Login attempt for email: " + email);

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            System.out.println("❌ Validation failed: Email or password missing");
            response.sendRedirect("sign-in.jsp?error=Email and password are required");
            return;
        }

        Connection con = null;
        try {
            // Test database connection
            System.out.println("🔧 Attempting database connection...");
            con = DBConnection.getConnection();
            if (con == null || con.isClosed()) {
                System.out.println("❌ Database connection failed - connection is null or closed");
                response.sendRedirect("sign-in.jsp?error=Database connection failed");
                return;
            }
            System.out.println("✅ Database connection established successfully");

            // Try different column name variations
            String userData = getUserData(con, email);
            if (userData == null) {
                System.out.println("❌ No user found with email: " + email);
                response.sendRedirect("sign-in.jsp?error=Invalid email or password");
                return;
            }

            // Parse user data (format: NIC|Name|Password|Email)
            String[] userParts = userData.split("\\|");
            String nic = userParts[0];
            String fullName = userParts[1];
            String storedPassword = userParts[2];
            String dbEmail = userParts[3];

            System.out.println("✅ User found in database:");
            System.out.println("   - NIC: " + nic);
            System.out.println("   - Name: " + fullName);
            System.out.println("   - DB Email: " + dbEmail);
            System.out.println("   - Stored Password: " + storedPassword);
            System.out.println("   - Input Password: " + password);

            // Check password (plain text comparison)
            if (!password.equals(storedPassword)) {
                System.out.println("❌ Password mismatch");
                response.sendRedirect("sign-in.jsp?error=Invalid email or password");
                return;
            }

            // Check if user is active
            if (!isUserActive(con, nic)) {
                System.out.println("❌ User account is inactive");
                response.sendRedirect("sign-in.jsp?error=Account is inactive");
                return;
            }

            // Determine user role
            String userRole = determineUserRole(con, nic);
            System.out.println("🎭 Determined user role: " + userRole);

            if ("unknown".equals(userRole)) {
                System.out.println("❌ No role found for user");
                response.sendRedirect("sign-in.jsp?error=User role not found");
                return;
            }

            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("userID", nic);
            session.setAttribute("userId", nic);
            session.setAttribute("userName", fullName);
            session.setAttribute("userEmail", email);
            session.setAttribute("userRole", userRole);

            // Set customerId for customers
            if ("customer".equals(userRole)) {
                session.setAttribute("customerId", nic);
            }

            System.out.println("✅ Session attributes set:");
            System.out.println("   - userID: " + session.getAttribute("userID"));
            System.out.println("   - userRole: " + session.getAttribute("userRole"));
            System.out.println("   - customerId: " + session.getAttribute("customerId"));

            // Update last login
            updateLastLogin(con, nic);

            // Redirect based on role
            String redirectUrl = getRedirectUrl(userRole);
            System.out.println("➡ Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);

        } catch (SQLException e) {
            System.err.println("❌ SQL Error during login: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("sign-in.jsp?error=Login failed. Please try again.");
        } catch (Exception e) {
            System.err.println("❌ Unexpected error during login: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("sign-in.jsp?error=Login failed. Please try again.");
        } finally {
            if (con != null) {
                try {
                    con.close();
                    System.out.println("🔧 Database connection closed");
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
            System.out.println("=== LOGIN ATTEMPT COMPLETED ===");
        }
    }

    private String getUserData(Connection con, String email) throws SQLException {
        // Try different column name variations
        String[] columnVariations = {
                // Try exact case first
                "SELECT NIC, Name, Password, Email FROM Person WHERE LOWER(Email) = LOWER(?)",
                // Try lowercase
                "SELECT nic, name, password, email FROM Person WHERE LOWER(Email) = LOWER(?)",
                // Try with brackets for case sensitivity
                "SELECT [NIC], [Name], [Password], [Email] FROM Person WHERE LOWER(Email) = LOWER(?)",
                // Try with different column names
                "SELECT PersonID, Name, Password, Email FROM Person WHERE LOWER(Email) = LOWER(?)",
                "SELECT UserID, Name, Password, Email FROM Person WHERE LOWER(Email) = LOWER(?)"
        };

        for (String sql : columnVariations) {
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        System.out.println("✅ Found user with query: " + sql);
                        try {
                            String nic = rs.getString(1);  // First column
                            String name = rs.getString(2); // Second column
                            String password = rs.getString(3); // Third column
                            String dbEmail = rs.getString(4); // Fourth column
                            return nic + "|" + name + "|" + password + "|" + dbEmail;
                        } catch (SQLException e) {
                            System.out.println("⚠️ Column access failed for query: " + sql);
                            continue; // Try next variation
                        }
                    }
                }
            } catch (SQLException e) {
                System.out.println("⚠️ Query failed: " + sql + " - " + e.getMessage());
                // Continue to next variation
            }
        }

        return null; // No user found with any column variation
    }

    private boolean isUserActive(Connection con, String nic) {
        try {
            // Check if isActive column exists with different name variations
            String[] activeColumnVariations = {"isActive", "IsActive", "active", "Active", "status", "Status"};

            for (String column : activeColumnVariations) {
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Person' AND COLUMN_NAME = ?")) {
                    ps.setString(1, column);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            // Column exists, check active status
                            String sql = "SELECT " + column + " FROM Person WHERE NIC = ?";
                            try (PreparedStatement ps2 = con.prepareStatement(sql)) {
                                ps2.setString(1, nic);
                                try (ResultSet rs2 = ps2.executeQuery()) {
                                    if (rs2.next()) {
                                        boolean isActive = rs2.getBoolean(1);
                                        System.out.println("🔍 User active status (" + column + "): " + isActive);
                                        return isActive;
                                    }
                                }
                            }
                        }
                    }
                } catch (SQLException e) {
                    // Continue to next variation
                }
            }

            // If no active column found, consider user active
            System.out.println("ℹ️ No active status column found, considering user active");
            return true;
        } catch (Exception e) {
            System.err.println("⚠️ Error checking active status: " + e.getMessage());
            return true; // Default to active if there's an error
        }
    }

    private String determineUserRole(Connection con, String nic) throws SQLException {
        System.out.println("🔍 Determining role for NIC: " + nic);

        // Check Seller table
        try (PreparedStatement ps = con.prepareStatement("SELECT 1 FROM Seller WHERE SellerNIC = ?")) {
            ps.setString(1, nic);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("✅ User is a SELLER");
                    return "seller";
                }
            }
        }

        // Check Customer table
        try (PreparedStatement ps = con.prepareStatement("SELECT 1 FROM Customer WHERE CustomerNIC = ?")) {
            ps.setString(1, nic);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("✅ User is a CUSTOMER");
                    return "customer";
                }
            }
        }

        // Check Admin table
        try (PreparedStatement ps = con.prepareStatement("SELECT 1 FROM Admin WHERE AdminNIC = ?")) {
            ps.setString(1, nic);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("✅ User is an ADMIN");
                    return "admin";
                }
            }
        }

        System.out.println("❌ No role found for NIC: " + nic);
        return "unknown";
    }

    private void updateLastLogin(Connection con, String nic) {
        try (PreparedStatement ps = con.prepareStatement(
                "UPDATE Person SET LastLogin = GETDATE() WHERE NIC = ?")) {
            ps.setString(1, nic);
            int updated = ps.executeUpdate();
            System.out.println("✅ LastLogin updated for " + nic + " - Rows affected: " + updated);
        } catch (Exception e) {
            System.err.println("⚠️ Error updating LastLogin for NIC " + nic + ": " + e.getMessage());
        }
    }

    private String getRedirectUrl(String role) {
        switch (role != null ? role.toLowerCase() : "unknown") {
            case "customer":
                return "customerlanding.jsp";
            case "seller":
                return "sellerdashboard.jsp";
            case "admin":
                return "admin-dashboard.jsp";
            default:
                return "sign-in.jsp?error=Access denied - unknown role";
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("sign-in.jsp");
    }
}