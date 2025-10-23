package main.java.com.melodymart.strategy;

import java.sql.Connection;
import java.sql.SQLException;

public class MastercardPaymentStrategy extends CardPaymentStrategy {

    @Override
    public boolean processPayment(Connection conn, String paymentId, String orderId,
                                  double totalAmount, String cardNumber, String expiryDate,
                                  String cardholderName, String cvv) throws SQLException {

        System.out.println("Processing Mastercard payment for Order: " + orderId);

        // Save card details to database
        saveCardDetails(conn, paymentId, cardNumber, cardholderName, expiryDate, cvv);

        // Simulate payment processing
        boolean paymentSuccess = simulatePaymentGateway(totalAmount);

        if (paymentSuccess) {
            System.out.println("Mastercard payment successful for Payment ID: " + paymentId);
            return true;
        } else {
            System.out.println("Mastercard payment failed for Payment ID: " + paymentId);
            return false;
        }
    }

    @Override
    protected boolean validateCardFormat(String cardNumber) {
        return cardNumber != null &&
                cardNumber.length() == 16 &&
                cardNumber.matches("\\d+") &&
                (cardNumber.startsWith("51") ||
                        cardNumber.startsWith("52") ||
                        cardNumber.startsWith("53") ||
                        cardNumber.startsWith("54") ||
                        cardNumber.startsWith("55"));
    }

    @Override
    public String getMethodName() {
        return "Mastercard";
    }

    @Override
    public String getMethodId() {
        return "PM002";
    }
}
