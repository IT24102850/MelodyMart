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
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");
        String amountStr = request.getParameter("amount");
        String paymentMethod = request.getParameter("paymentMethod");
        String transactionId = request.getParameter("transactionId");
        String cvv = request.getParameter("cvv");
        String status = request.getParameter("status"); // New field from form

        // ✅ Validate required fields
        if (orderIdStr == null || amountStr == null || paymentMethod == null ||
                transactionId == null || cvv == null || status == null ||
                orderIdStr.isEmpty() || amountStr.isEmpty() || paymentMethod.isEmpty() ||
                transactionId.isEmpty() || cvv.isEmpty() || status.isEmpty()) {

            request.setAttribute("message", "Missing required payment fields.");
            request.getRequestDispatcher("payment-error.jsp").forward(request, response);
            return;
        }

        int orderId;
        double amount;
        try {
            orderId = Integer.parseInt(orderIdStr);
            amount = Double.parseDouble(amountStr);
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid OrderID or Amount format.");
            request.getRequestDispatcher("payment-error.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection()) {
            // ✅ Check if order exists
            String checkOrderSql = "SELECT COUNT(*) FROM OrderNow WHERE OrderID = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkOrderSql)) {
                checkStmt.setInt(1, orderId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) == 0) {
                        request.setAttribute("message", "Order ID " + orderId + " does not exist.");
                        request.getRequestDispatcher("payment-error.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // ✅ Insert payment
            String sql = "INSERT INTO Payment (OrderID, PaymentDate, Amount, PaymentMethod, TransactionID, CVV, Status) " +
                    "VALUES (?, GETDATE(), ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, orderId);
                ps.setDouble(2, amount);
                ps.setString(3, paymentMethod);
                ps.setString(4, transactionId);
                ps.setString(5, cvv);
                ps.setString(6, status);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    request.setAttribute("message", "✅ Payment saved successfully for Order ID " + orderId);
                    request.getRequestDispatcher("payment-success.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "⚠️ Payment failed. Please try again.");
                    request.getRequestDispatcher("payment-error.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "❌ Database error: " + e.getMessage());
            request.getRequestDispatcher("payment-error.jsp").forward(request, response);
        }
    }
}
