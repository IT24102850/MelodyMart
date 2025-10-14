package main.java.com.melodymart.strategy;

public interface PaymentStrategy {
    boolean pay(int orderId, double amount, String transactionId, String status);
}
