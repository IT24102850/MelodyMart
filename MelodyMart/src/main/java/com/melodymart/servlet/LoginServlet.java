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
import org.mindrot.jbcrypt.BCrypt;

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

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            System.out.println("❌ Validation failed: Email or password missing");
            response.sendRedirect("sign-in.jsp?error=Email and password are required");
            return;
        }

        Connection con = null;
        try {
            System.out.println("🔧 Attempting database connection...");
            con = DBConnection.getConnection();
            if (con == null || con.isClosed()) {
                System.out.println("❌ Database connection failed - connection is null or closed");
                response.sendRedirect("sign-in.jsp?error=Database connection failed");
                return;
            }
            System.out.println("✅ Database connection established successfully");

            // Query user data
            String sql = "SELECT PersonID, FirstName, LastName, Password, role FROM Person WHERE LOWER(Email) = LOWER(?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, email.trim().toLowerCase());
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String personId = rs.getString("PersonID");
                        String firstName = rs.getString("FirstName");
                        String lastName = rs.getString("LastName");
                        String storedPassword = rs.getString("Password");
                        String role = rs.getString("role");

                        System.out.println("✅ User found in database:");
                        System.out.println("   - PersonID: " + personId);
                        System.out.println("   - FullName: " + firstName + " " + lastName);
                        System.out.println("   - DB Email: " + email);
                        System.out.println("   - Stored Password: " + storedPassword);
                        System.out.println("   - Input Password: " + password);

                        // Check password (BCrypt comparison)
                        if (BCrypt.checkpw(password, storedPassword)) {
                            // Create session
                            HttpSession session = request.getSession();
                            session.setAttribute("userID", personId);
                            session.setAttribute("userName", firstName + " " + lastName);
                            session.setAttribute("userEmail", email.trim().toLowerCase());
                            session.setAttribute("userRole", role.toLowerCase());

                            if ("customer".equals(role.toLowerCase())) {
                                session.setAttribute("customerId", personId); // Use PersonID as customerId
                            } else if ("seller".equals(role.toLowerCase())) {
                                session.setAttribute("sellerId", personId); // Use PersonID as sellerId
                            }

                            System.out.println("✅ Session attributes set:");
                            System.out.println("   - userID: " + session.getAttribute("userID"));
                            System.out.println("   - userRole: " + session.getAttribute("userRole"));
                            System.out.println("   - customerId: " + session.getAttribute("customerId"));
                            System.out.println("   - sellerId: " + session.getAttribute("sellerId"));

                            // Redirect based on role
                            String redirectUrl = getRedirectUrl(role.toLowerCase());
                            System.out.println("➡ Redirecting to: " + redirectUrl);
                            response.sendRedirect(redirectUrl);
                        } else {
                            System.out.println("❌ Password mismatch");
                            response.sendRedirect("sign-in.jsp?error=Invalid email or password");
                        }
                    } else {
                        System.out.println("❌ No user found with email: " + email);
                        response.sendRedirect("sign-in.jsp?error=Invalid email or password");
                    }
                }
            }
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