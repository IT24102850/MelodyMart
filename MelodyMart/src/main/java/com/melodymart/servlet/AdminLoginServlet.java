package main.java.com.melodymart.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.melodymart.util.DatabaseUtil; // Assuming this is your database utility class
import org.mindrot.jbcrypt.BCrypt; // For password hashing (add BCrypt dependency)

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("ravini");
        String password = request.getParameter("ravini2004");

        if (isValidCredentials(username, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", username);
            response.sendRedirect("AdminDashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
        }
    }

    private boolean isValidCredentials(String username, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection(); // Use your DatabaseUtil class
            String sql = "SELECT username, password FROM Admins WHERE username = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                // Verify hashed password using BCrypt
                return BCrypt.checkpw(password, storedPassword);
            }
            return false; // No user found
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }
}