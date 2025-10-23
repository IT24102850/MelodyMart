package main.java.com.melodymart.servlet;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import main.java.com.melodymart.util.DBConnection;

public class CancelOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect("orders.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        String orderId = request.getParameter("orderId");

        if (orderId == null || orderId.trim().isEmpty()) {
            session.setAttribute("errorMessage", "⚠️ Invalid order ID.");
            response.sendRedirect("orders.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE OrderNow SET Status = 'Cancelled' WHERE OrderID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, orderId);

            int rows = ps.executeUpdate();
            ps.close();

            if (rows > 0) {
                session.setAttribute("successMessage", "✅ Order cancelled successfully.");
            } else {
                session.setAttribute("errorMessage", "⚠️ Order not found for ID: " + orderId);
            }
            response.sendRedirect("orders.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
            response.sendRedirect("orders.jsp");
        }
    }
}
