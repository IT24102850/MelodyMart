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

@WebServlet("/DeletePaymentServlet")
public class DeletePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String paymentIdStr = request.getParameter("paymentId");

        if (paymentIdStr == null || paymentIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing paymentId");
            return;
        }

        int paymentId = Integer.parseInt(paymentIdStr);

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "DELETE FROM Payment WHERE PaymentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, paymentId);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    System.out.println("🗑 Payment reversed/deleted successfully: ID " + paymentId);
                } else {
                    System.out.println("⚠ No payment found with ID: " + paymentId);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error deleting payment", e);
        }

        // Redirect back to dashboard
        response.sendRedirect(request.getContextPath() + "/sellerdashboard.jsp");
    }
}
