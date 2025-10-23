package main.java.com.melodymart.strategy;

import java.sql.Connection;
import java.sql.SQLException;

public class CashOnDeliveryStrategy implements PaymentStrategy {

    @Override
    public boolean processPayment(Connection conn, String paymentId, String orderId,
                                  double totalAmount, String cardNumber, String expiryDate,
                                  String cardholderName, String cvv) throws SQLException {

        System.out.println("Processing Cash on Delivery for Order: " + orderId);
        System.out.println("Amount to be collected: $" + totalAmount);

        // For Cash on Delivery, no immediate payment processing needed
        // Just record the payment method and return success
        System.out.println("Cash on Delivery order confirmed for Payment ID: " + paymentId);
        return true;
    }

    @Override
    public boolean validatePaymentDetails(String cardNumber, String expiryDate,
                                          String cvv, String cardholderName) {
        // Cash on Delivery doesn't require card validation
        return true;
    }

    @Override
    public String getMethodName() {
        return "Cash on Delivery";
    }

    @Override
    public String getMethodId() {
        return "PM006";
    }

    @Override
    public boolean requiresCardDetails() {
        return false;
    }
}