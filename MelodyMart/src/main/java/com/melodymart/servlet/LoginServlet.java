package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;
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
    public void init() throws ServletException {
        System.out.println("✅ LoginServlet initialized and mapped to /LoginServlet");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("➡ Redirecting GET request to sign-in.jsp");
        response.sendRedirect("sign-in.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("➡ Login request received");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Basic validation
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            System.out.println("❌ Validation failed: Email or password missing");
            response.sendRedirect("sign-in.jsp?error=Email and password are required");
            return;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT PersonID, FirstName, LastName, Password, role FROM Person WHERE LOWER(Email) = ?")) {

            ps.setString(1, email.toLowerCase());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String personId = rs.getString("PersonID");
                String fullName = rs.getString("FirstName") + " " + rs.getString("LastName");
                String storedHash = rs.getString("Password");
                String role = rs.getString("role");

                boolean passwordMatch = false;

                // BCrypt hash comparison (secure)
                if (storedHash != null && storedHash.startsWith("$2a$")) {
                    passwordMatch = BCrypt.checkpw(password, storedHash);
                } else {
                    // Support for legacy plaintext passwords
                    passwordMatch = password.equals(storedHash);
                }

                if (passwordMatch) {
                    // ✅ Store session attributes
                    HttpSession session = request.getSession();
                    session.setAttribute("userID", personId);   // <-- main ID used across JSPs
                    session.setAttribute("userId", personId);   // backward compatibility
                    session.setAttribute("userName", fullName);
                    session.setAttribute("userEmail", email.toLowerCase());
                    session.setAttribute("userRole", role != null ? role : "unknown");

                    // Optional alias for customers
                    if ("customer".equalsIgnoreCase(role)) {
                        session.setAttribute("customerId", personId);
                    }

                    System.out.println("✅ Login successful for " + email + " with role: " + role);

                    updateLastLogin(con, personId);

                    // 🔀 Role-based redirection
                    if (role == null) role = "unknown";

                    String redirectUrl;
                    switch (role.toLowerCase()) {
                        case "customer":
                            redirectUrl = "customerlanding.jsp";
                            break;
                        case "seller":
                            redirectUrl = "sellerdashboard.jsp";
                            break;
                        case "admin":
                            redirectUrl = "admin-dashboard.jsp";
                            break;
                        default:
                            redirectUrl = "sign-in.jsp?error=Access denied";
                            break;
                    }

                    System.out.println("➡ Redirecting to: " + redirectUrl);
                    response.sendRedirect(redirectUrl);

                } else {
                    System.out.println("❌ Invalid credentials for email: " + email);
                    response.sendRedirect("sign-in.jsp?error=Invalid email or password");
                }

            } else {
                System.out.println("❌ No user found for email: " + email);
                response.sendRedirect("sign-in.jsp?error=Invalid email or password");
            }

        } catch (Exception e) {
            System.err.println("⚠️ Login error: " + e.getMessage());
            if (e instanceof SQLException sqlEx) {
                System.err.println("SQL State: " + sqlEx.getSQLState());
                System.err.println("Error Code: " + sqlEx.getErrorCode());
            }
            response.sendRedirect("sign-in.jsp?error=Login failed. Please try again.");
        }
    }

    private void updateLastLogin(Connection con, String personId) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(
                "UPDATE Person SET LastLogin = GETDATE() WHERE PersonID = ?")) {
            ps.setString(1, personId);
            ps.executeUpdate();
        }
    }
}
