package main.java.com.melodymart.seller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import main.java.com.melodymart.util.DBConnection;

public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        HttpSession session = request.getSession();

        if (orderId == null || status == null) {
            session.setAttribute("errorMessage", "Invalid request. Missing order ID or status.");
            response.sendRedirect(request.getContextPath() + "/orderManagement.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                throw new SQLException("Database connection is null.");
            }

            String sql = "UPDATE OrderNow SET Status = ? WHERE OrderID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, orderId);

            int rows = ps.executeUpdate();
            ps.close();

            if (rows > 0) {
                session.setAttribute("successMessage", "Order status updated successfully!");
                System.out.println("✅ Order updated: " + orderId + " → " + status);
            } else {
                session.setAttribute("errorMessage", "No order found with ID: " + orderId);
                System.out.println("⚠️ No order found with ID: " + orderId);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }

        // ✅ Redirect back to the correct JSP (context-safe)
        response.sendRedirect(request.getContextPath() + "/orderManagement.jsp");
    }
}
