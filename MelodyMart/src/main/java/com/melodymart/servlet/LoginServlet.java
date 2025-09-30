package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import main.java.com.melodymart.util.DBConnection;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void init() throws ServletException {
        System.out.println("LoginServlet initialized and mapped to /login");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Redirecting GET request to sign-in.jsp");
        response.sendRedirect("sign-in.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Servlet reached for /login");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            System.out.println("Validation failed: Email or password missing");
            response.sendRedirect("sign-in.jsp?error=Email and password are required");
            return;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT PersonID, FirstName, LastName, Password FROM Person WHERE Email = ?")) {

            ps.setString(1, email.toLowerCase());
            System.out.println("Executing query for user: " + email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int personId = rs.getInt("PersonID");
                    String fullName = rs.getString("FirstName") + " " + rs.getString("LastName");
                    String storedHash = rs.getString("Password");

                    if (BCrypt.checkpw(password, storedHash)) {
                        String role = determineRole(con, personId);

                        HttpSession session = request.getSession();
                        session.setAttribute("userId", personId);
                        session.setAttribute("userName", fullName);
                        session.setAttribute("userEmail", email.toLowerCase());
                        session.setAttribute("userRole", role);

                        // ✅ also set customerId if role is customer
                        if ("customer".equalsIgnoreCase(role)) {
                            session.setAttribute("customerId", personId);
                        }

                        System.out.println("Login successful for " + email + " with role: " + role);

                        updateLastLogin(con, personId);

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
                                redirectUrl = "sign-in.jsp?error=Unknown role or page not found";
                                break;
                        }
                        System.out.println("Redirecting to: " + redirectUrl);
                        response.sendRedirect(redirectUrl);
                    } else {
                        System.out.println("Invalid credentials for email: " + email);
                        response.sendRedirect("sign-in.jsp?error=Invalid credentials");
                    }
                } else {
                    System.out.println("No user found for email: " + email);
                    response.sendRedirect("sign-in.jsp?error=Invalid credentials");
                }
            }
        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            if (e instanceof SQLException) {
                SQLException sqlEx = (SQLException) e;
                System.err.println("SQL State: " + sqlEx.getSQLState());
                System.err.println("Error Code: " + sqlEx.getErrorCode());
            }
            response.sendRedirect("sign-in.jsp?error=Login failed. Please try again.");
        }
    }

    private String determineRole(Connection con, int personId) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM Customer WHERE PersonID = ?")) {
            ps.setInt(1, personId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) return "customer";
        }

        try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM Seller WHERE PersonID = ?")) {
            ps.setInt(1, personId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) return "seller";
        }

        try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM Admin WHERE PersonID = ?")) {
            ps.setInt(1, personId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) return "admin";
        }

        try (PreparedStatement ps = con.prepareStatement("SELECT role FROM Person WHERE PersonID = ?")) {
            ps.setInt(1, personId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getString("role") != null) {
                return rs.getString("role").toLowerCase();
            }
        }

        return "unknown";
    }

    private void updateLastLogin(Connection con, int personId) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(
                "UPDATE Person SET LastLogin = GETDATE() WHERE PersonID = ?")) {
            ps.setInt(1, personId);
            ps.executeUpdate();
        }
    }
}
