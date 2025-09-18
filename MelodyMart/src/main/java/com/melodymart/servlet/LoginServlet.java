package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
        // Always redirect GET to login page
        response.sendRedirect("sign-in.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation: email/password required
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("sign-in.jsp?error=Email and password are required");
            return;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT id, name, email, password, role FROM Users WHERE email = ?")) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");

                    if (BCrypt.checkpw(password, storedHash)) {
                        // ✅ Save user info in session
                        HttpSession session = request.getSession();
                        session.setAttribute("userId", rs.getInt("id"));
                        session.setAttribute("userName", rs.getString("name"));
                        session.setAttribute("userEmail", rs.getString("email"));

                        String role = rs.getString("role");
                        session.setAttribute("userRole", role);

                        // ✅ Redirect based on role
                        String redirectUrl;
                        switch (role.toLowerCase()) {
                            case "customer":
                                redirectUrl = "customerLanding.jsp";
                                break;
                            case "seller":
                                redirectUrl = "sellerDashboard.jsp";
                                break;
                            case "manufacturer":
                                redirectUrl = "manufacturerDashboard.jsp";
                                break;
                            default:
                                redirectUrl = "sign-in.jsp?error=Unknown role";
                                break;
                        }

                        response.sendRedirect(redirectUrl);

                    } else {
                        // ❌ Wrong password
                        response.sendRedirect("sign-in.jsp?error=Invalid credentials");
                    }
                } else {
                    // ❌ No user found
                    response.sendRedirect("sign-in.jsp?error=Invalid credentials");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("sign-in.jsp?error=Login failed. Please try again.");
        }
    }
}
