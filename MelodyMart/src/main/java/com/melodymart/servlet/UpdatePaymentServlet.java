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

        String paymentId = request.getParameter("paymentId");
        String status = request.getParameter("status");

        System.out.println("UpdatePaymentServlet - Payment ID: " + paymentId + ", New Status: " + status);

        if (paymentId == null || status == null || paymentId.isEmpty() || status.isEmpty()) {
            response.sendRedirect("PaymentManagementServlet?status=error&msg=Missing required fields");
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "UPDATE Payment SET TransactionStatus = ? WHERE PaymentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setString(2, paymentId);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    System.out.println("Successfully updated payment " + paymentId + " to status: " + status);
                    response.sendRedirect("PaymentManagementServlet?status=success&msg=Payment status updated to " + status);
                } else {
                    System.out.println("No payment found with ID: " + paymentId);
                    response.sendRedirect("PaymentManagementServlet?status=error&msg=No payment found with ID: " + paymentId);
                }
            }
        } catch (Exception e) {
            System.out.println("Error updating payment: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("PaymentManagementServlet?status=error&msg=Error updating payment: " + e.getMessage());
        }
    }
}