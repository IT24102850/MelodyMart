package com.melodymart.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Review {
    private int reviewId;
    private int orderItemId;
    private int rating;
    private String comment;
    private LocalDateTime reviewDate;
    
    // Additional fields for display purposes (from joins)
    private String customerName; // From Customer/User table
    private String instrumentName; // From Instrument table via OrderItem
    private int instrumentId; // From OrderItem join
    private boolean canEdit; // If current user can edit this review
    private String orderNumber; // From Order table

    // Default constructor
    public Review() {
        this.reviewDate = LocalDateTime.now();
    }

    // Constructor for creating new reviews
    public Review(int orderItemId, int rating, String comment) {
        this();
        this.orderItemId = orderItemId;
        this.rating = rating;
        this.comment = comment;
    }

    // Full constructor
    public Review(int reviewId, int orderItemId, int rating, String comment, LocalDateTime reviewDate) {
        this.reviewId = reviewId;
        this.orderItemId = orderItemId;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
    }

    // Business logic methods
    
    /**
     * Check if review is valid for submission
     */
    public boolean isValid() {
        return rating >= 1 && rating <= 5 && 
               comment != null && comment.trim().length() >= 10 &&
               comment.length() <= 1000 &&
               orderItemId > 0;
    }
    
    /**
     * Get star display for rating (★★★★☆)
     */
    public String getStarDisplay() {
        StringBuilder stars = new StringBuilder();
        for (int i = 1; i <= 5; i++) {
            if (i <= rating) {
                stars.append("★");
            } else {
                stars.append("☆");
            }
        }
        return stars.toString();
    }
    
    /**
     * Get HTML star display with filled and empty stars
     */
    public String getHtmlStarDisplay() {
        StringBuilder html = new StringBuilder();
        for (int i = 1; i <= 5; i++) {
            if (i <= rating) {
                html.append("<i class='fas fa-star' style='color: #ffc107;'></i>");
            } else {
                html.append("<i class='far fa-star' style='color: #ddd;'></i>");
            }
        }
        return html.toString();
    }
    
    /**
     * Get formatted review date
     */
    public String getFormattedDate() {
        if (reviewDate == null) return "";
        return reviewDate.format(DateTimeFormatter.ofPattern("MMM dd, yyyy"));
    }
    
    /**
     * Get formatted review date with time
     */
    public String getFormattedDateTime() {
        if (reviewDate == null) return "";
        return reviewDate.format(DateTimeFormatter.ofPattern("MMM dd, yyyy 'at' hh:mm a"));
    }
    
    /**
     * Get truncated comment for previews
     */
    public String getTruncatedComment(int maxLength) {
        if (comment == null || comment.length() <= maxLength) {
            return comment;
        }
        return comment.substring(0, maxLength - 3) + "...";
    }
    
    /**
     * Get review age in days
     */
    public long getAgeInDays() {
        if (reviewDate == null) return 0;
        return java.time.Duration.between(reviewDate, LocalDateTime.now()).toDays();
    }
    
    /**
     * Check if review is recent (less than 7 days)
     */
    public boolean isRecent() {
        return getAgeInDays() <= 7;
    }
    
    /**
     * Get rating description
     */
    public String getRatingDescription() {
        switch (rating) {
            case 5: return "Excellent";
            case 4: return "Very Good";
            case 3: return "Good";
            case 2: return "Fair";
            case 1: return "Poor";
            default: return "Not Rated";
        }
    }
    
    /**
     * Get rating color for UI
     */
    public String getRatingColor() {
        if (rating >= 4) return "#28a745"; // Green
        if (rating >= 3) return "#ffc107"; // Yellow
        if (rating >= 2) return "#fd7e14"; // Orange
        return "#dc3545"; // Red
    }

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(LocalDateTime reviewDate) {
        this.reviewDate = reviewDate;
    }

    // Additional display fields
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getInstrumentName() {
        return instrumentName;
    }

    public void setInstrumentName(String instrumentName) {
        this.instrumentName = instrumentName;
    }

    public int getInstrumentId() {
        return instrumentId;
    }

    public void setInstrumentId(int instrumentId) {
        this.instrumentId = instrumentId;
    }

    public boolean isCanEdit() {
        return canEdit;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Review review = (Review) obj;
        return reviewId == review.reviewId;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(reviewId);
    }

    @Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", orderItemId=" + orderItemId +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", reviewDate=" + reviewDate +
                ", customerName='" + customerName + '\'' +
                ", instrumentName='" + instrumentName + '\'' +
                ", instrumentId=" + instrumentId +
                ", orderNumber='" + orderNumber + '\'' +
                '}';
    }
}