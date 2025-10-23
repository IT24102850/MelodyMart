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

public class SellerCancelOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderId = request.getParameter("orderId");
        HttpSession session = request.getSession();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE OrderNow SET Status = 'Cancelled' WHERE OrderID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, orderId);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                session.setAttribute("successMessage", "Order cancelled successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to cancel order.");
            }
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }

        response.sendRedirect("orderManagement.jsp");
    }
}
