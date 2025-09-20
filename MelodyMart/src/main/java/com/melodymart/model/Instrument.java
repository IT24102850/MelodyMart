package com.melodymart.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;

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
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Stock level constants
    public static final String STOCK_IN = "In Stock";
    public static final String STOCK_LOW = "Low Stock";
    public static final String STOCK_OUT = "Out of Stock";

    // Low stock threshold
    public static final int LOW_STOCK_THRESHOLD = 5;

    // Default constructor
    public Instrument() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
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
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // Constructor without ID (for creating new instruments)
    public Instrument(String name, String description, Integer brandId, String model, String color,
                      double price, String specifications, String warranty, String imageUrl, int quantity,
                      String stockLevel, Integer manufacturerId) {
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
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // Business logic methods

    /**
     * Check if the instrument is in low stock based on quantity
     */
    public boolean isLowStock() {
        return this.quantity <= LOW_STOCK_THRESHOLD && this.quantity > 0;
    }

    /**
     * Check if the instrument is out of stock
     */
    public boolean isOutOfStock() {
        return this.quantity <= 0;
    }

    /**
     * Get formatted price with currency symbol
     */
    public String getFormattedPrice() {
        BigDecimal bd = new BigDecimal(this.price);
        bd = bd.setScale(2, RoundingMode.HALF_UP);
        return "$" + bd.toString();
    }

    /**
     * Calculate total value of stock (price * quantity)
     */
    public double getTotalStockValue() {
        return this.price * this.quantity;
    }

    /**
     * Get formatted total stock value
     */
    public String getFormattedTotalStockValue() {
        BigDecimal bd = new BigDecimal(getTotalStockValue());
        bd = bd.setScale(2, RoundingMode.HALF_UP);
        return "$" + bd.toString();
    }

    /**
     * Auto-update stock level based on current quantity
     */
    public void updateStockLevel() {
        if (this.quantity <= 0) {
            this.stockLevel = STOCK_OUT;
        } else if (this.quantity <= LOW_STOCK_THRESHOLD) {
            this.stockLevel = STOCK_LOW;
        } else {
            this.stockLevel = STOCK_IN;
        }
        this.updatedAt = LocalDateTime.now();
    }

    /**
     * Reduce quantity (for sales/orders)
     */
    public boolean reduceQuantity(int amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }

        if (this.quantity >= amount) {
            this.quantity -= amount;
            updateStockLevel();
            return true;
        }
        return false; // Insufficient stock
    }

    /**
     * Increase quantity (for restocking)
     */
    public void increaseQuantity(int amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }

        this.quantity += amount;
        updateStockLevel();
    }

    /**
     * Validate instrument data
     */
    public boolean isValid() {
        return name != null && !name.trim().isEmpty() &&
                price > 0 &&
                quantity >= 0;
    }

    /**
     * Get stock status color for UI
     */
    public String getStockStatusColor() {
        switch (this.stockLevel) {
            case STOCK_IN:
                return "#28a745"; // Green
            case STOCK_LOW:
                return "#ffc107"; // Yellow
            case STOCK_OUT:
                return "#dc3545"; // Red
            default:
                return "#6c757d"; // Gray
        }
    }

    /**
     * Get a short description (first 100 characters)
     */
    public String getShortDescription() {
        if (description == null || description.length() <= 100) {
            return description;
        }
        return description.substring(0, 97) + "...";
    }

    /**
     * Check if instrument has an image
     */
    public boolean hasImage() {
        return imageUrl != null && !imageUrl.trim().isEmpty();
    }

    /**
     * Get image URL with fallback to default placeholder
     */
    public String getImageUrlWithFallback() {
        if (hasImage()) {
            return imageUrl;
        }
        return "images/placeholder/instrument-placeholder.jpg";
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
        this.updatedAt = LocalDateTime.now();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
        this.updatedAt = LocalDateTime.now();
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
        this.updatedAt = LocalDateTime.now();
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
        this.updatedAt = LocalDateTime.now();
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
        this.updatedAt = LocalDateTime.now();
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
        this.updatedAt = LocalDateTime.now();
    }

    public String getSpecifications() {
        return specifications;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
        this.updatedAt = LocalDateTime.now();
    }

    public String getWarranty() {
        return warranty;
    }

    public void setWarranty(String warranty) {
        this.warranty = warranty;
        this.updatedAt = LocalDateTime.now();
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
        this.updatedAt = LocalDateTime.now();
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        updateStockLevel(); // Auto-update stock level when quantity changes
    }

    public String getStockLevel() {
        return stockLevel;
    }

    public void setStockLevel(String stockLevel) {
        this.stockLevel = stockLevel;
        this.updatedAt = LocalDateTime.now();
    }

    public Integer getManufacturerId() {
        return manufacturerId;
    }

    public void setManufacturerId(Integer manufacturerId) {
        this.manufacturerId = manufacturerId;
        this.updatedAt = LocalDateTime.now();
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Utility methods for object comparison
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Instrument that = (Instrument) obj;
        return instrumentId == that.instrumentId;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(instrumentId);
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
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}