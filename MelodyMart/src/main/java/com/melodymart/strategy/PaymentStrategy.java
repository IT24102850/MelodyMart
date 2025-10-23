package main.java.com.melodymart.strategy;


import java.sql.Connection;
import java.sql.SQLException;

public interface PaymentStrategy {

    /**
     * Processes the payment using the specific strategy
     * @param conn Database connection
     * @param paymentId Payment ID
     * @param orderId Order ID
     * @param totalAmount Total amount to charge
     * @param cardNumber Card number (for card payments)
     * @param expiryDate Expiry date (for card payments)
     * @param cardholderName Cardholder name (for card payments)
     * @param cvv CVV (for card payments)
     * @return boolean indicating payment success
     * @throws SQLException
     */
    boolean processPayment(Connection conn, String paymentId, String orderId,
                           double totalAmount, String cardNumber, String expiryDate,
                           String cardholderName, String cvv) throws SQLException;

    /**
     * Validates payment details
     * @param cardNumber Card number
     * @param expiryDate Expiry date
     * @param cvv CVV
     * @param cardholderName Cardholder name
     * @return boolean indicating valid details
     */
    boolean validatePaymentDetails(String cardNumber, String expiryDate,
                                   String cvv, String cardholderName);

    /**
     * Returns payment method name
     * @return String method name
     */
    String getMethodName();

    /**
     * Returns database MethodID
     * @return String method ID
     */
    String getMethodId();

    /**
     * Checks if card details are required
     * @return boolean
     */
    boolean requiresCardDetails();
}


