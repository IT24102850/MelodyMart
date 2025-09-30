package com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

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

        // Get all form parameters
        String orderIdStr = request.getParameter("orderId");
        String amountStr = request.getParameter("amount");
        String paymentMethod = request.getParameter("paymentMethod");
        String transactionId = request.getParameter("transactionId");
        String cvv = request.getParameter("cvv");
        String status = request.getParameter("status");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cardName = request.getParameter("cardName");

        // Validate all required fields
        if (orderIdStr == null || amountStr == null || paymentMethod == null ||
                transactionId == null || cvv == null || status == null ||
                cardNumber == null || expiryDate == null || cardName == null ||
                orderIdStr.isEmpty() || amountStr.isEmpty() || paymentMethod.isEmpty() ||
                transactionId.isEmpty() || cvv.isEmpty() || status.isEmpty() ||
                cardNumber.isEmpty() || expiryDate.isEmpty() || cardName.isEmpty()) {

            request.setAttribute("message", "❌ All payment fields are required.");
            request.getRequestDispatcher("payment-gateway.jsp").forward(request, response);
            return;
        }

        int orderId;
        double amount;
        try {
            orderId = Integer.parseInt(orderIdStr);
            amount = Double.parseDouble(amountStr);
        } catch (NumberFormatException e) {
            request.setAttribute("message", "❌ Invalid OrderID or Amount format.");
            request.getRequestDispatcher("payment-gateway.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Check if order exists
            String checkOrderSql = "SELECT COUNT(*) FROM Instrument WHERE InstrumentID = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkOrderSql)) {
                checkStmt.setInt(1, orderId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) == 0) {
                        request.setAttribute("message", "❌ Order ID " + orderId + " does not exist.");
                        request.getRequestDispatcher("payment-gateway.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Insert payment with all details
            String sql = "INSERT INTO Payment (OrderID, PaymentDate, Amount, PaymentMethod, TransactionID, CVV, Status, CardNumber, ExpiryDate, CardName) " +
                    "VALUES (?, GETDATE(), ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, orderId);
                ps.setDouble(2, amount);
                ps.setString(3, paymentMethod);
                ps.setString(4, transactionId);
                ps.setString(5, cvv);
                ps.setString(6, status);
                ps.setString(7, cardNumber.replaceAll("\\s", "")); // Remove spaces from card number
                ps.setString(8, expiryDate);
                ps.setString(9, cardName);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    if ("Paid".equals(status)) {
                        request.setAttribute("message", "✅ Payment processed successfully! Transaction ID: " + transactionId);
                    } else {
                        request.setAttribute("message", "❌ Payment failed. Transaction ID: " + transactionId);
                    }
                    request.getRequestDispatcher("payment-gateway.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "⚠️ Payment processing failed. Please try again.");
                    request.getRequestDispatcher("payment-gateway.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "❌ Database error: " + e.getMessage());
            request.getRequestDispatcher("payment-gateway.jsp").forward(request, response);
        }
    }
}