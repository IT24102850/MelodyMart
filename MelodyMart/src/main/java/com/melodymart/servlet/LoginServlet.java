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
            String redirectUrl = "sign-in.jsp?error=Email and password are required";
            System.out.println("Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);
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

                        String redirectUrl;
                        switch (role.toLowerCase()) {
                            case "customer":
                                redirectUrl = "customerlanding.jsp";
                                break;
                            case "seller":
                                redirectUrl = "sellerdashboard.jsp";
                                break;
                            case "manufacturer":
                                redirectUrl = "manufacturedashboard.jsp";
                                break;
                            default:
                                System.out.println("Unknown role: " + role);
                                redirectUrl = "sign-in.jsp?error=Unknown role";
                                break;
                        }
                        System.out.println("Redirecting to: " + redirectUrl);
                        response.sendRedirect(redirectUrl);
                    } else {
                        System.out.println("Invalid credentials for email: " + email);
                        String redirectUrl = "sign-in.jsp?error=Invalid credentials";
                        System.out.println("Redirecting to: " + redirectUrl);
                        response.sendRedirect(redirectUrl);
                    }
                } else {
                    System.out.println("No user found for email: " + email);
                    String redirectUrl = "sign-in.jsp?error=Invalid credentials";
                    System.out.println("Redirecting to: " + redirectUrl);
                    response.sendRedirect(redirectUrl);
                }
            }
        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            String redirectUrl = "sign-in.jsp?error=Login failed. Please try again.";
            System.out.println("Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);
        }
    }
}