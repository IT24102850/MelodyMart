package main.java.com.melodymart.strategy;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Context class that uses the Payment Strategy
 */
public class PaymentContext {
    private PaymentStrategy paymentStrategy;

    public PaymentContext() {
        // Default constructor
    }

    public PaymentContext(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    /**
     * Executes payment using the current strategy
     */
    public boolean executePayment(Connection conn, String paymentId, String orderId,
                                  double totalAmount, String cardNumber, String expiryDate,
                                  String cardholderName, String cvv) throws SQLException {

        if (paymentStrategy == null) {
            throw new IllegalStateException("Payment strategy not set");
        }

        // Validate payment details if required
        if (paymentStrategy.requiresCardDetails()) {
            if (!paymentStrategy.validatePaymentDetails(cardNumber, expiryDate, cvv, cardholderName)) {
                throw new IllegalArgumentException("Invalid payment details");
            }
        }

        // Process payment using the selected strategy
        return paymentStrategy.processPayment(conn, paymentId, orderId, totalAmount,
                cardNumber, expiryDate, cardholderName, cvv);
    }

    /**
     * Factory method to create appropriate strategy
     */
    public static PaymentStrategy createStrategy(String paymentMethod, String cardType) {
        if ("cash".equalsIgnoreCase(paymentMethod)) {
            return new CashOnDeliveryStrategy();
        } else if ("card".equalsIgnoreCase(paymentMethod)) {
            if ("Visa".equalsIgnoreCase(cardType)) {
                return new VisaPaymentStrategy();
            } else if ("Mastercard".equalsIgnoreCase(cardType)) {
                return new MastercardPaymentStrategy();
            } else if ("Amex".equalsIgnoreCase(cardType) || "American Express".equalsIgnoreCase(cardType)) {
                return new AmexPaymentStrategy();
            }
        }

        // Default to Cash on Delivery
        return new CashOnDeliveryStrategy();
    }
}
