package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import main.java.com.melodymart.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String selectedRole = request.getParameter("selectedRole");

        // Validate input
        if (email == null || email.isEmpty() || password == null || password.isEmpty() || selectedRole == null) {
            response.sendRedirect("login.jsp?error=All fields are required");
            return;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT id, name, email, role, password FROM Users WHERE email = ?")) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedHashedPassword = rs.getString("password");
                    String dbRole = rs.getString("role").toLowerCase();
                    if (BCrypt.checkpw(password, storedHashedPassword) && selectedRole.equals(dbRole)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("userId", rs.getInt("id"));
                        session.setAttribute("userName", rs.getString("name"));
                        session.setAttribute("userEmail", rs.getString("email"));
                        session.setAttribute("userRole", dbRole);

                        // Role-based redirection
                        switch (dbRole) {
                            case "customer":
                                response.sendRedirect("customerDashboard.jsp");
                                break;
                            case "admin":
                                response.sendRedirect("adminDashboard.jsp");
                                break;
                            case "seller":
                                response.sendRedirect("sellerDashboard.jsp");
                                break;
                            case "manufacturer":
                                response.sendRedirect("manufacturerDashboard.jsp");
                                break;
                            default:
                                response.sendRedirect("login.jsp?error=Invalid user role");
                                break;
                        }
                    } else {
                        response.sendRedirect("login.jsp?error=Invalid credentials or role mismatch");
                    }
                } else {
                    response.sendRedirect("login.jsp?error=Invalid credentials");
                }
            }
        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            response.sendRedirect("login.jsp?error=Login failed. Please try again.");
        }
    }
}