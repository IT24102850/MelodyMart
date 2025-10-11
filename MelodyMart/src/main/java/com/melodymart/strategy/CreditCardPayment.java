package main.java.com.melodymart.strategy;

import main.java.com.melodymart.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class CreditCardPayment implements PaymentStrategy {

    private String cardNumber;
    private String expiryDate;
    private String cardName;
    private String cvv;

    public CreditCardPayment(String cardNumber, String expiryDate, String cardName, String cvv) {
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.cardName = cardName;
        this.cvv = cvv;
    }

    @Override
    public boolean pay(int orderId, double amount, String transactionId, String status) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO Payment (OrderID, PaymentDate, Amount, PaymentMethod, TransactionID, CVV, Status, CardNumber, ExpiryDate, CardName) "
                    + "VALUES (?, GETDATE(), ?, 'Credit Card', ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, orderId);
                ps.setDouble(2, amount);
                ps.setString(3, transactionId);
                ps.setString(4, cvv);
                ps.setString(5, status);
                ps.setString(6, cardNumber);
                ps.setString(7, expiryDate);
                ps.setString(8, cardName);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
