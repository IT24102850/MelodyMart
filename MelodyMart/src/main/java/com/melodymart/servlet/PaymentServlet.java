package com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;
import main.java.com.melodymart.strategy.PaymentContext;
import main.java.com.melodymart.strategy.PaymentStrategy;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from payment-method.jsp
        String orderId = request.getParameter("orderId");
        String paymentId = request.getParameter("paymentId");
        String instrumentId = request.getParameter("instrumentId");
        String quantityStr = request.getParameter("quantity");
        String paymentMethod = request.getParameter("paymentMethod");
        String cardType = request.getParameter("cardType");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cardholderName = request.getParameter("cardholderName");
        String cvv = request.getParameter("cvv");
        boolean saveCard = "true".equals(request.getParameter("saveCard"));
        String totalAmountStr = request.getParameter("totalAmount");

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Verify order exists
            String checkOrderSql = "SELECT OrderID FROM OrderTable WHERE OrderID = ?";
            PreparedStatement pstmt = conn.prepareStatement(checkOrderSql);
            pstmt.setString(1, orderId);
            ResultSet rs = pstmt.executeQuery();

            if (!rs.next()) {
                request.setAttribute("error", "Order not found: " + orderId);
                request.getRequestDispatcher("payment-failed.jsp").forward(request, response);
                return;
            }
            rs.close();
            pstmt.close();

            // 2. STRATEGY PATTERN INTEGRATION - Create and execute payment strategy
            PaymentStrategy paymentStrategy = PaymentContext.createStrategy(paymentMethod, cardType);
            PaymentContext paymentContext = new PaymentContext(paymentStrategy);

            // Process payment using strategy pattern
            boolean paymentSuccess = paymentContext.executePayment(
                    conn, paymentId, orderId, Double.parseDouble(totalAmountStr),
                    cardNumber, expiryDate, cardholderName, cvv
            );

            if (!paymentSuccess) {
                throw new SQLException("Payment processing failed - declined by payment gateway");
            }

            // 3. Add order items to OrderContains
            String orderContainsSql = "INSERT INTO OrderContains (InstrumentID, OrderID, Quantity) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(orderContainsSql);
            pstmt.setString(1, instrumentId);
            pstmt.setString(2, orderId);
            pstmt.setInt(3, Integer.parseInt(quantityStr));
            pstmt.executeUpdate();
            pstmt.close();

            // 4. Save card details if requested and payment succeeded
            if (saveCard && "card".equalsIgnoreCase(paymentMethod) && paymentSuccess) {
                saveCardDetails(conn, paymentId, cardNumber, cardholderName, expiryDate, cvv);
            }

            // 5. Update order status to 'Paid'
            String updateOrderSql = "UPDATE OrderTable SET Status = 'Paid' WHERE OrderID = ?";
            pstmt = conn.prepareStatement(updateOrderSql);
            pstmt.setString(1, orderId);
            pstmt.executeUpdate();
            pstmt.close();

            conn.commit(); // Commit transaction

            // Set success attributes for payment-success.jsp
            request.setAttribute("orderId", orderId);
            request.setAttribute("paymentId", paymentId);
            request.setAttribute("totalAmount", totalAmountStr);
            request.setAttribute("paymentMethod", paymentMethod);
            request.setAttribute("message", "Payment processed successfully!");

            // Redirect to payment-success.jsp
            request.getRequestDispatcher("payment-success.jsp").forward(request, response);

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            request.setAttribute("error", "Payment failed: " + e.getMessage());
            request.getRequestDispatcher("payment-failed.jsp").forward(request, response);
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Save card details to database
     */
    private void saveCardDetails(Connection conn, String paymentId, String cardNumber,
                                 String cardholderName, String expiryDate, String cvv)
            throws SQLException {

        if (cardNumber == null || cardNumber.trim().isEmpty()) {
            return; // Don't save if no card number provided
        }

        String cardSql = "INSERT INTO CardPayment (CardNumber, PaymentID, CardHolderName, CardExpiry, CardCVV) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(cardSql);
        pstmt.setString(1, cardNumber);
        pstmt.setString(2, paymentId);
        pstmt.setString(3, cardholderName);

        // Convert MM/YY to proper date format
        if (expiryDate != null && expiryDate.length() == 5) {
            String[] parts = expiryDate.split("/");
            if (parts.length == 2) {
                String expiryYear = "20" + parts[1];
                String expiryDateStr = expiryYear + "-" + parts[0] + "-01";
                pstmt.setString(4, expiryDateStr);
            } else {
                pstmt.setString(4, "2026-12-01");
            }
        } else {
            pstmt.setString(4, "2026-12-01");
        }

        pstmt.setString(5, cvv);
        pstmt.executeUpdate();
        pstmt.close();
    }
}