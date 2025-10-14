package com.melodymart.servlet;

import main.java.com.melodymart.strategy.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        String paymentMethod = request.getParameter("paymentMethod");
        String transactionId = request.getParameter("transactionId");
        String status = request.getParameter("status");

        PaymentStrategy paymentStrategy = null;

        // Choose strategy dynamically
        switch (paymentMethod) {
            case "CreditCard":
                paymentStrategy = new CreditCardPayment(
                        request.getParameter("cardNumber"),
                        request.getParameter("expiryDate"),
                        request.getParameter("cardName"),
                        request.getParameter("cvv")
                );
                break;
            case "PayPal":
                paymentStrategy = new PayPalPayment(request.getParameter("paypalEmail"));
                break;
            default:
                request.setAttribute("message", "❌ Invalid payment method selected.");
                request.getRequestDispatcher("payment-gateway.jsp").forward(request, response);
                return;
        }

        // Execute selected strategy
        boolean success = paymentStrategy.pay(orderId, amount, transactionId, status);
        if (success) {
            request.setAttribute("message", "✅ Payment processed successfully! Transaction ID: " + transactionId);
            // Update order status to paid
            updateOrderStatus(orderId, "Paid");
        } else {
            request.setAttribute("message", "⚠️ Payment failed. Please try again.");
        }
        request.getRequestDispatcher("payment-gateway.jsp").forward(request, response);
    }

    private void updateOrderStatus(int orderId, String status) {
        try {
            // Update order status in database
            // You'll need to implement this method based on your database structure
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}