package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import main.java.com.melodymart.util.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void init() throws ServletException {
        System.out.println("LoginServlet initialized and mapped to /login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Received POST request for /login with email: " + request.getParameter("email"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            System.out.println("Validation failed: Email or password missing");
            response.sendRedirect("sign-in.jsp?error=Email and password are required");
            return;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT id, name, email, password, role FROM Users WHERE email = ?")) {

            ps.setString(1, email);
            System.out.println("Executing query for user: " + email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");
                    if (BCrypt.checkpw(password, storedHash)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("userId", rs.getInt("id"));
                        session.setAttribute("userName", rs.getString("name"));
                        session.setAttribute("userEmail", rs.getString("email"));
                        String role = rs.getString("role");
                        session.setAttribute("userRole", role);
                        System.out.println("Login successful for " + email + " with role: " + role);

                        // Role-based redirection
                        switch (role.toLowerCase()) {
                            case "customer":
                                response.sendRedirect("customerdashboard.jsp");
                                break;
                            case "seller":
                                response.sendRedirect("sellerdashboard.jsp");
                                break;
                            case "manufacturer":
                                response.sendRedirect("manufacturedashboard.jsp");
                                break;
                            default:
                                System.out.println("Unknown role: " + role);
                                response.sendRedirect("sign-in.jsp?error=Unknown role");
                        }
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
            response.sendRedirect("sign-in.jsp?error=Login failed. Please try again.");
        }
    }
}