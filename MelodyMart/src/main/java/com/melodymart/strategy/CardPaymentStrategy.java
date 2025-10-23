package main.java.com.melodymart.strategy;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public abstract class CardPaymentStrategy implements PaymentStrategy {

    @Override
    public boolean requiresCardDetails() {
        return true;
    }

    @Override
    public boolean validatePaymentDetails(String cardNumber, String expiryDate,
                                          String cvv, String cardholderName) {
        if (cardNumber == null || cardNumber.trim().isEmpty()) return false;
        if (expiryDate == null || expiryDate.trim().isEmpty()) return false;
        if (cvv == null || cvv.trim().isEmpty()) return false;
        if (cardholderName == null || cardholderName.trim().isEmpty()) return false;

        String cleanCardNumber = cardNumber.replaceAll("\\s+", "");
        return validateCardFormat(cleanCardNumber);
    }

    protected abstract boolean validateCardFormat(String cardNumber);

    protected void saveCardDetails(Connection conn, String paymentId, String cardNumber,
                                   String cardholderName, String expiryDate, String cvv)
            throws SQLException {
        String cardSql = "INSERT INTO CardPayment (CardNumber, PaymentID, CardHolderName, CardExpiry, CardCVV) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(cardSql);
        pstmt.setString(1, cardNumber);
        pstmt.setString(2, paymentId);
        pstmt.setString(3, cardholderName);

        // Convert MM/YY to proper date format (same as your existing code)
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

    protected boolean simulatePaymentGateway(double amount) {
        // Simulate payment processing - 95% success rate
        return Math.random() > 0.05;
    }
}
