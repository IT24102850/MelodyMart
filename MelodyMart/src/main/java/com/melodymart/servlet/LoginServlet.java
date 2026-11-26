package com.melodymart.servlet;

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

import com.melodymart.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet({"/LoginServlet", "/login"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String email = request.getParameter("email");
        String password = request.getParameter("password");


        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("sign-in.jsp?error=Email and password are required");
            return;
        }

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            if (con == null || con.isClosed()) {
                response.sendRedirect("sign-in.jsp?error=Database connection failed");
                return;
            }

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


                        // Check password (BCrypt comparison)
                        if (BCrypt.checkpw(password, storedPassword)) {
                            // Create session
                            HttpSession old = request.getSession(false);
                            if (old != null) {
                                old.invalidate();
                            }
                            HttpSession session = request.getSession(true);
                            session.setAttribute("userID", personId);
                            session.setAttribute("userName", firstName + " " + lastName);
                            session.setAttribute("userEmail", email.trim().toLowerCase());
                            session.setAttribute("userRole", role.toLowerCase());

                            if ("customer".equals(role.toLowerCase())) {
                                session.setAttribute("customerId", personId); // Use PersonID as customerId
                            } else if ("seller".equals(role.toLowerCase())) {
                                session.setAttribute("sellerId", personId); // Use PersonID as sellerId
                            }


                            // Redirect based on role
                            String redirectUrl = getRedirectUrl(role.toLowerCase());
                            response.sendRedirect(redirectUrl);
                        } else {
                            response.sendRedirect("sign-in.jsp?error=Invalid email or password");
                        }
                    } else {
                        response.sendRedirect("sign-in.jsp?error=Invalid email or password");
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Login failed", e);
            response.sendRedirect("sign-in.jsp?error=Login failed. Please try again.");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Login failed", e);
            response.sendRedirect("sign-in.jsp?error=Login failed. Please try again.");
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                }
            }
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