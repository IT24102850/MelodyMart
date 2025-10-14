package main.java.com.melodymart.model;

import java.util.Date;

public class Order {
    private String orderID;
    private Date orderDate;
    private double totalAmount;
    private String status;
    private String street;
    private String postalCode;
    private String customerID;

    // Constructors
    public Order() {}

    public Order(String orderID, Date orderDate, double totalAmount, String status,
                 String street, String postalCode, String customerID) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.street = street;
        this.postalCode = postalCode;
        this.customerID = customerID;
    }

    // Getters and Setters
    public String getOrderID() { return orderID; }
    public void setOrderID(String orderID) { this.orderID = orderID; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getStreet() { return street; }
    public void setStreet(String street) { this.street = street; }

    public String getPostalCode() { return postalCode; }
    public void setPostalCode(String postalCode) { this.postalCode = postalCode; }

    public String getCustomerID() { return customerID; }
    public void setCustomerID(String customerID) { this.customerID = customerID; }
}