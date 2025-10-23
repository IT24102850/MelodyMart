package main.java.com.melodymart.strategy;

import java.sql.Connection;
import java.sql.SQLException;

public class AmexPaymentStrategy extends CardPaymentStrategy {

    @Override
    public boolean processPayment(Connection conn, String paymentId, String orderId,
                                  double totalAmount, String cardNumber, String expiryDate,
                                  String cardholderName, String cvv) throws SQLException {

        System.out.println("Processing American Express payment for Order: " + orderId);

        // Save card details to database
        saveCardDetails(conn, paymentId, cardNumber, cardholderName, expiryDate, cvv);

        // Simulate payment processing
        boolean paymentSuccess = simulatePaymentGateway(totalAmount);

        if (paymentSuccess) {
            System.out.println("American Express payment successful for Payment ID: " + paymentId);
            return true;
        } else {
            System.out.println("American Express payment failed for Payment ID: " + paymentId);
            return false;
        }
    }

    @Override
    protected boolean validateCardFormat(String cardNumber) {
        return cardNumber != null &&
                cardNumber.length() == 15 &&
                cardNumber.matches("\\d+") &&
                (cardNumber.startsWith("34") || cardNumber.startsWith("37"));
    }

    @Override
    public String getMethodName() {
        return "American Express";
    }

    @Override
    public String getMethodId() {
        return "PM003";
    }
}
