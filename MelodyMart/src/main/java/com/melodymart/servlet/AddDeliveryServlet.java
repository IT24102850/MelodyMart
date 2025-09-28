package com.melodymart.servlet;

import com.melodymart.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/AddDeliveryServlet")
public class AddDeliveryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");
        String status = request.getParameter("status");
        String notes = request.getParameter("notes");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            int orderId = Integer.parseInt(orderIdStr);

            conn = DatabaseUtil.getConnection();
            String sql = "INSERT INTO DeliveryStatuses (order_id, status, update_date, notes) " +
                    "VALUES (?, ?, GETDATE(), ?)";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setString(2, status);
            ps.setString(3, notes);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("sellerdashboard.jsp?success=DeliveryAdded");
            } else {
                response.sendRedirect("sellerdashboard.jsp?error=DeliveryInsertFailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("sellerdashboard.jsp?error=DeliveryInsertFailed&msg=" + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
