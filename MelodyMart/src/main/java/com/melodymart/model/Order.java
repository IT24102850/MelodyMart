package com.melodymart.model;

public class Order {
    private int id;
    private int customerId;
    private int instrumentId;
    private int quantity;
    private double totalPrice;
    private String status;
    private String deliveryAddress;

    // Constructor
    public Order() {}

    public Order(int id, int customerId, int instrumentId, int quantity, double totalPrice, String status, String deliveryAddress) {
        this.id = id;
        this.customerId = customerId;
        this.instrumentId = instrumentId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.status = status;
        this.deliveryAddress = deliveryAddress;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public int getInstrumentId() { return instrumentId; }
    public void setInstrumentId(int instrumentId) { this.instrumentId = instrumentId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
}