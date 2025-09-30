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

@WebServlet("/UpdatePaymentServlet")
public class UpdatePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String paymentIdStr = request.getParameter("paymentId");
        String status = request.getParameter("status");

        if (paymentIdStr == null || status == null || paymentIdStr.isEmpty() || status.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields");
            return;
        }

        int paymentId = Integer.parseInt(paymentIdStr);

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "UPDATE Payment SET Status = ? WHERE PaymentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, paymentId);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    System.out.println("✅ Payment updated successfully: ID " + paymentId + " → " + status);
                } else {
                    System.out.println("⚠ No payment found with ID: " + paymentId);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error updating payment status", e);
        }

        // Redirect back to dashboard
        response.sendRedirect(request.getContextPath() + "/sellerdashboard.jsp");
    }
}
