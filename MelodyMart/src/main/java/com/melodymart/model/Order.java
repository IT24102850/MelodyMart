package com.melodymart.model;

import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private List<Instrument> instruments;
    private double totalPrice;
    private Date orderDate;
    private String status; // e.g., "processing", "shipped", "delivered"
    private String deliveryAddress;

    // Default constructor
    public Order() {
    }

    // Parameterized constructor
    public Order(int id, int userId, List<Instrument> instruments, double totalPrice, Date orderDate, String status, String deliveryAddress) {
        this.id = id;
        this.userId = userId;
        this.instruments = instruments;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.status = status;
        this.deliveryAddress = deliveryAddress;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<Instrument> getInstruments() {
        return instruments;
    }

    public void setInstruments(List<Instrument> instruments) {
        this.instruments = instruments;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", userId=" + userId +
                ", instruments=" + instruments +
                ", totalPrice=" + totalPrice +
                ", orderDate=" + orderDate +
                ", status='" + status + '\'' +
                ", deliveryAddress='" + deliveryAddress + '\'' +
                '}';
    }
}