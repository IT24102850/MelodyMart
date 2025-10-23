package main.java.com.melodymart.strategy;

import java.sql.Connection;
import java.sql.SQLException;

public class VisaPaymentStrategy extends CardPaymentStrategy {

    @Override
    public boolean processPayment(Connection conn, String paymentId, String orderId,
                                  double totalAmount, String cardNumber, String expiryDate,
                                  String cardholderName, String cvv) throws SQLException {

        System.out.println("Processing Visa payment for Order: " + orderId);

        // Save card details to database
        saveCardDetails(conn, paymentId, cardNumber, cardholderName, expiryDate, cvv);

        // Simulate payment processing
        boolean paymentSuccess = simulatePaymentGateway(totalAmount);

        if (paymentSuccess) {
            System.out.println("Visa payment successful for Payment ID: " + paymentId);
            return true;
        } else {
            System.out.println("Visa payment failed for Payment ID: " + paymentId);
            return false;
        }
    }

    @Override
    protected boolean validateCardFormat(String cardNumber) {
        return cardNumber != null &&
                cardNumber.startsWith("4") &&
                cardNumber.length() == 16 &&
                cardNumber.matches("\\d+");
    }

    @Override
    public String getMethodName() {
        return "Visa";
    }

    @Override
    public String getMethodId() {
        return "PM001";
    }
}
