package main.java.com.melodymart.strategy;

import main.java.com.melodymart.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class PayPalPayment implements PaymentStrategy {

    private String paypalEmail;

    public PayPalPayment(String paypalEmail) {
        this.paypalEmail = paypalEmail;
    }

    @Override
    public boolean pay(int orderId, double amount, String transactionId, String status) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO Payment (OrderID, PaymentDate, Amount, PaymentMethod, TransactionID, Status, CardName) "
                    + "VALUES (?, GETDATE(), ?, 'PayPal', ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, orderId);
                ps.setDouble(2, amount);
                ps.setString(3, transactionId);
                ps.setString(4, status);
                ps.setString(5, paypalEmail);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
