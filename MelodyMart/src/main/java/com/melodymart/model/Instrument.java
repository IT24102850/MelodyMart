package com.melodymart.model;

public class Instrument {
    private int instrumentId;
    private String name;
    private String description;
    private Integer brandId;  // Nullable foreign key
    private String model;
    private String color;
    private double price;
    private String specifications;
    private String warranty;
    private String imageUrl;
    private int quantity;
    private String stockLevel;  // e.g., 'In Stock', 'Low Stock', 'Out of Stock'
    private Integer manufacturerId;  // Nullable foreign key

    // Default constructor
    public Instrument() {
    }

    // Parameterized constructor
    public Instrument(int instrumentId, String name, String description, Integer brandId, String model, String color,
                      double price, String specifications, String warranty, String imageUrl, int quantity,
                      String stockLevel, Integer manufacturerId) {
        this.instrumentId = instrumentId;
        this.name = name;
        this.description = description;
        this.brandId = brandId;
        this.model = model;
        this.color = color;
        this.price = price;
        this.specifications = specifications;
        this.warranty = warranty;
        this.imageUrl = imageUrl;
        this.quantity = quantity;
        this.stockLevel = stockLevel;
        this.manufacturerId = manufacturerId;
    }

    // Getters and Setters
    public int getInstrumentId() {
        return instrumentId;
    }

    public void setInstrumentId(int instrumentId) {
        this.instrumentId = instrumentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getSpecifications() {
        return specifications;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
    }

    public String getWarranty() {
        return warranty;
    }

    public void setWarranty(String warranty) {
        this.warranty = warranty;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStockLevel() {
        return stockLevel;
    }

    public void setStockLevel(String stockLevel) {
        this.stockLevel = stockLevel;
    }

    public Integer getManufacturerId() {
        return manufacturerId;
    }

    public void setManufacturerId(Integer manufacturerId) {
        this.manufacturerId = manufacturerId;
    }

    @Override
    public String toString() {
        return "Instrument{" +
                "instrumentId=" + instrumentId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", brandId=" + brandId +
                ", model='" + model + '\'' +
                ", color='" + color + '\'' +
                ", price=" + price +
                ", specifications='" + specifications + '\'' +
                ", warranty='" + warranty + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", quantity=" + quantity +
                ", stockLevel='" + stockLevel + '\'' +
                ", manufacturerId=" + manufacturerId +
                '}';
    }
}