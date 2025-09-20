package com.melodymart.dao;

import com.melodymart.model.Review;
import com.melodymart.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

public class ReviewDAO {
    private static final Logger LOGGER = Logger.getLogger(ReviewDAO.class.getName());

    /**
     * Add a new review for an order item
     */
    public boolean addReview(Review review) throws SQLException {
        String sql = "INSERT INTO Review (OrderItemID, Rating, Comment, ReviewDate) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, review.getOrderItemId());
            pstmt.setInt(2, review.getRating());
            pstmt.setString(3, review.getComment());
            pstmt.setTimestamp(4, Timestamp.valueOf(review.getReviewDate()));

            int result = pstmt.executeUpdate();

            if (result > 0) {
                // Get the generated review ID
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        review.setReviewId(rs.getInt(1));
                    }
                }
                LOGGER.info("Review added successfully for order item ID: " + review.getOrderItemId());
                return true;
            }

        } catch (SQLException e) {
            LOGGER.severe("Error adding review: " + e.getMessage());
            throw e;
        }
        return false;
    }

    /**
     * Get all reviews for a specific instrument
     */
    public List<Review> getReviewsByInstrument(int instrumentId) throws SQLException {
        String sql = "SELECT r.ReviewID, r.OrderItemID, r.Rating, r.Comment, r.ReviewDate, " +
                "c.FirstName + ' ' + c.LastName as CustomerName, " +
                "i.Name as InstrumentName, i.InstrumentID, " +
                "o.OrderNumber " +
                "FROM Review r " +
                "INNER JOIN OrderItem oi ON r.OrderItemID = oi.OrderItemID " +
                "INNER JOIN Instrument i ON oi.InstrumentID = i.InstrumentID " +
                "INNER JOIN [Order] o ON oi.OrderID = o.OrderID " +
                "INNER JOIN Customer c ON o.CustomerID = c.CustomerID " +
                "WHERE i.InstrumentID = ? " +
                "ORDER BY r.ReviewDate DESC";

        List<Review> reviews = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, instrumentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Review review = mapResultSetToReview(rs);
                    review.setCustomerName(rs.getString("CustomerName"));
                    review.setInstrumentName(rs.getString("InstrumentName"));
                    review.setInstrumentId(rs.getInt("InstrumentID"));
                    review.setOrderNumber(rs.getString("OrderNumber"));
                    reviews.add(review);
                }
            }

        } catch (SQLException e) {
            LOGGER.severe("Error retrieving reviews for instrument " + instrumentId + ": " + e.getMessage());
            throw e;
        }

        return reviews;
    }

    /**
     * Get reviews by customer
     */
    public List<Review> getReviewsByCustomer(int customerId) throws SQLException {
        String sql = "SELECT r.ReviewID, r.OrderItemID, r.Rating, r.Comment, r.ReviewDate, " +
                "c.FirstName + ' ' + c.LastName as CustomerName, " +
                "i.Name as InstrumentName, i.InstrumentID, " +
                "o.OrderNumber " +
                "FROM Review r " +
                "INNER JOIN OrderItem oi ON r.OrderItemID = oi.OrderItemID " +
                "INNER JOIN Instrument i ON oi.InstrumentID = i.InstrumentID " +
                "INNER JOIN [Order] o ON oi.OrderID = o.OrderID " +
                "INNER JOIN Customer c ON o.CustomerID = c.CustomerID " +
                "WHERE c.CustomerID = ? " +
                "ORDER BY r.ReviewDate DESC";

        List<Review> reviews = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, customerId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Review review = mapResultSetToReview(rs);
                    review.setCustomerName(rs.getString("CustomerName"));
                    review.setInstrumentName(rs.getString("InstrumentName"));
                    review.setInstrumentId(rs.getInt("InstrumentID"));
                    review.setOrderNumber(rs.getString("OrderNumber"));
                    reviews.add(review);
                }
            }

        } catch (SQLException e) {
            LOGGER.severe("Error retrieving reviews for customer " + customerId + ": " + e.getMessage());
            throw e;
        }

        return reviews;
    }

    /**
     * Get all reviews (for admin management)
     */
    public List<Review> getAllReviews(int page, int pageSize) throws SQLException {
        String sql = "SELECT r.ReviewID, r.OrderItemID, r.Rating, r.Comment, r.ReviewDate, " +
                "c.FirstName + ' ' + c.LastName as CustomerName, " +
                "i.Name as InstrumentName, i.InstrumentID, " +
                "o.OrderNumber " +
                "FROM Review r " +
                "INNER JOIN OrderItem oi ON r.OrderItemID = oi.OrderItemID " +
                "INNER JOIN Instrument i ON oi.InstrumentID = i.InstrumentID " +
                "INNER JOIN [Order] o ON oi.OrderID = o.OrderID " +
                "INNER JOIN Customer c ON o.CustomerID = c.CustomerID " +
                "ORDER BY r.ReviewDate DESC " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        List<Review> reviews = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, (page - 1) * pageSize);
            pstmt.setInt(2, pageSize);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Review review = mapResultSetToReview(rs);
                    review.setCustomerName(rs.getString("CustomerName"));
                    review.setInstrumentName(rs.getString("InstrumentName"));
                    review.setInstrumentId(rs.getInt("InstrumentID"));
                    review.setOrderNumber(rs.getString("OrderNumber"));
                    reviews.add(review);
                }
            }

        } catch (SQLException e) {
            LOGGER.severe("Error retrieving all reviews: " + e.getMessage());
            throw e;
        }

        return reviews;
    }

    /**
     * Get review statistics for an instrument
     */
    public Map<String, Object> getReviewStats(int instrumentId) throws SQLException {
        String sql = "SELECT " +
                "COUNT(*) as TotalReviews, " +
                "AVG(CAST(Rating AS DECIMAL(3,2))) as AverageRating, " +
                "SUM(CASE WHEN Rating = 5 THEN 1 ELSE 0 END) as FiveStars, " +
                "SUM(CASE WHEN Rating = 4 THEN 1 ELSE 0 END) as FourStars, " +
                "SUM(CASE WHEN Rating = 3 THEN 1 ELSE 0 END) as ThreeStars, " +
                "SUM(CASE WHEN Rating = 2 THEN 1 ELSE 0 END) as TwoStars, " +
                "SUM(CASE WHEN Rating = 1 THEN 1 ELSE 0 END) as OneStar " +
                "FROM Review r " +
                "INNER JOIN OrderItem oi ON r.OrderItemID = oi.OrderItemID " +
                "WHERE oi.InstrumentID = ?";

        Map<String, Object> stats = new HashMap<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, instrumentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    stats.put("totalReviews", rs.getInt("TotalReviews"));
                    stats.put("averageRating", rs.getDouble("AverageRating"));
                    stats.put("fiveStars", rs.getInt("FiveStars"));
                    stats.put("fourStars", rs.getInt("FourStars"));
                    stats.put("threeStars", rs.getInt("ThreeStars"));
                    stats.put("twoStars", rs.getInt("TwoStars"));
                    stats.put("oneStar", rs.getInt("OneStar"));
                } else {
                    // No reviews found
                    stats.put("totalReviews", 0);
                    stats.put("averageRating", 0.0);
                    for (int i = 1; i <= 5; i++) {
                        stats.put(getStarKey(i), 0);
                    }
                }
            }

        } catch (SQLException e) {
            LOGGER.severe("Error retrieving review stats for instrument " + instrumentId + ": " + e.getMessage());
            throw e;
        }

        return stats;
    }

    /**
     * Check if customer can review an order item (purchased and not yet reviewed)
     */
    public boolean canCustomerReviewOrderItem(int customerId, int orderItemId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM OrderItem oi " +
                "INNER JOIN [Order] o ON oi.OrderID = o.OrderID " +
                "LEFT JOIN Review r ON oi.OrderItemID = r.OrderItemID " +
                "WHERE o.CustomerID = ? AND oi.OrderItemID = ? " +
                "AND o.OrderStatus = 'Delivered' " + // Only delivered orders can be reviewed
                "AND r.ReviewID IS NULL"; // Not already reviewed

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, customerId);
            pstmt.setInt(2, orderItemId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            LOGGER.severe("Error checking review eligibility: " + e.getMessage());
            throw e;
        }

        return false;
    }

    /**
     * Get reviewable items for a customer (delivered but not reviewed)
     */
    public List<Map<String, Object>> getReviewableItems(int customerId) throws SQLException {
        String sql = "SELECT oi.OrderItemID, oi.InstrumentID, i.Name as InstrumentName, " +
                "o.OrderID, o.OrderNumber, o.OrderDate " +
                "FROM OrderItem oi " +
                "INNER JOIN [Order] o ON oi.OrderID = o.OrderID " +
                "INNER JOIN Instrument i ON oi.InstrumentID = i.InstrumentID " +
                "LEFT JOIN Review r ON oi.OrderItemID = r.OrderItemID " +
                "WHERE o.CustomerID = ? " +
                "AND o.OrderStatus = 'Delivered' " +
                "AND r.ReviewID IS NULL " +
                "ORDER BY o.OrderDate DESC";

        List<Map<String, Object>> items = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, customerId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("orderItemId", rs.getInt("OrderItemID"));
                    item.put("instrumentId", rs.getInt("InstrumentID"));
                    item.put("instrumentName", rs.getString("InstrumentName"));
                    item.put("orderId", rs.getInt("OrderID"));
                    item.put("orderNumber", rs.getString("OrderNumber"));
                    item.put("orderDate", rs.getDate("OrderDate"));
                    items.add(item);
                }
            }

        } catch (SQLException e) {
            LOGGER.severe("Error retrieving reviewable items: " + e.getMessage());
            throw e;
        }

        return items;
    }

    /**
     * Delete a review
     */
    public boolean deleteReview(int reviewId) throws SQLException {
        String sql = "DELETE FROM Review WHERE ReviewID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, reviewId);
            int result = pstmt.executeUpdate();

            if (result > 0) {
                LOGGER.info("Review deleted: " + reviewId);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.severe("Error deleting review " + reviewId + ": " + e.getMessage());
            throw e;
        }

        return false;
    }

    /**
     * Update a review
     */
    public boolean updateReview(Review review) throws SQLException {
        String sql = "UPDATE Review SET Rating = ?, Comment = ? WHERE ReviewID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, review.getRating());
            pstmt.setString(2, review.getComment());
            pstmt.setInt(3, review.getReviewId());

            int result = pstmt.executeUpdate();

            if (result > 0) {
                LOGGER.info("Review updated: " + review.getReviewId());
                return true;
            }

        } catch (SQLException e) {
            LOGGER.severe("Error updating review " + review.getReviewId() + ": " + e.getMessage());
            throw e;
        }

        return false;
    }

    // Helper methods

    private Review mapResultSetToReview(ResultSet rs) throws SQLException {
        Review review = new Review();
        review.setReviewId(rs.getInt("ReviewID"));
        review.setOrderItemId(rs.getInt("OrderItemID"));
        review.setRating(rs.getInt("Rating"));
        review.setComment(rs.getString("Comment"));

        Timestamp reviewDate = rs.getTimestamp("ReviewDate");
        if (reviewDate != null) {
            review.setReviewDate(reviewDate.toLocalDateTime());
        }

        return review;
    }

    private String getStarKey(int stars) {
        switch (stars) {
            case 5: return "fiveStars";
            case 4: return "fourStars";
            case 3: return "threeStars";
            case 2: return "twoStars";
            case 1: return "oneStar";
            default: return "unknown";
        }
    }
}Stars, " +
        "SUM(CASE WHEN Rating = 3 THEN 1 ELSE 0 END) as ThreeStars, " +
        "SUM(CASE WHEN Rating = 2 THEN 1 ELSE 0 END) as TwoStars, " +
        "SUM(CASE WHEN Rating = 1 THEN 1 ELSE 0 END) as OneStar " +
        "FROM Review WHERE InstrumentID = ? AND IsApproved = 1";

Map<String, Object> stats = new HashMap<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, instrumentId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
        if (rs.next()) {
        stats.put("totalReviews", rs.getInt("TotalReviews"));
        stats.put("averageRating", rs.getDouble("AverageRating"));
        stats.put("fiveStars", rs.getInt("FiveStars"));
        stats.put("fourStars", rs.getInt("FourStars"));
        stats.put("threeStars", rs.getInt("ThreeStars"));
        stats.put("twoStars", rs.getInt("TwoStars"));
        stats.put("oneStar", rs.getInt("OneStar"));
        } else {
        // No reviews found
        stats.put("totalReviews", 0);
                    stats.put("averageRating", 0.0);
                    for (int i = 1; i <= 5; i++) {
        stats.put(getStarKey(i), 0);
        }
        }
        }

        } catch (SQLException e) {
        LOGGER.severe("Error retrieving review stats for instrument " + instrumentId + ": " + e.getMessage());
        throw e;
        }

                return stats;
    }

/**
 * Approve a review (admin function)
 */
public boolean approveReview(int reviewId) throws SQLException {
    String sql = "UPDATE Review SET IsApproved = 1, UpdatedAt = GETDATE() WHERE ReviewID = ?";

    try (Connection conn = DatabaseUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, reviewId);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            LOGGER.info("Review approved: " + reviewId);
            return true;
        }

    } catch (SQLException e) {
        LOGGER.severe("Error approving review " + reviewId + ": " + e.getMessage());
        throw e;
    }

    return false;
}

/**
 * Report a review as inappropriate
 */
public boolean reportReview(int reviewId) throws SQLException {
    String sql = "UPDATE Review SET IsReported = 1, UpdatedAt = GETDATE() WHERE ReviewID = ?";

    try (Connection conn = DatabaseUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, reviewId);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            LOGGER.info("Review reported: " + reviewId);
            return true;
        }

    } catch (SQLException e) {
        LOGGER.severe("Error reporting review " + reviewId + ": " + e.getMessage());
        throw e;
    }

    return false;
}

/**
 * Delete a review (admin function)
 */
public boolean deleteReview(int reviewId) throws SQLException {
    String sql = "DELETE FROM Review WHERE ReviewID = ?";

    try (Connection conn = DatabaseUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, reviewId);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            LOGGER.info("Review deleted: " + reviewId);
            return true;
        }

    } catch (SQLException e) {
        LOGGER.severe("Error deleting review " + reviewId + ": " + e.getMessage());
        throw e;
    }

    return false;
}

/**
 * Check if user has already reviewed this instrument
 */
public boolean hasUserReviewedInstrument(int userId, int instrumentId) throws SQLException {
    String sql = "SELECT COUNT(*) FROM Review WHERE UserID = ? AND InstrumentID = ?";

    try (Connection conn = DatabaseUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, userId);
        pstmt.setInt(2, instrumentId);

        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }

    } catch (SQLException e) {
        LOGGER.severe("Error checking user review status: " + e.getMessage());
        throw e;
    }

    return false;
}

/**
 * Add a helpful vote to a review
 */
public boolean addHelpfulVote(int reviewId, int userId, boolean isHelpful) throws SQLException {
    // First, check if user has already voted
    String checkSql = "SELECT COUNT(*) FROM ReviewVotes WHERE ReviewID = ? AND UserID = ?";
    String insertSql = "INSERT INTO ReviewVotes (ReviewID, UserID, IsHelpful) VALUES (?, ?, ?)";
    String updateCountSql = "UPDATE Review SET HelpfulCount = " +
            "(SELECT COUNT(*) FROM ReviewVotes WHERE ReviewID = ? AND IsHelpful = 1) " +
            "WHERE ReviewID = ?";

    try (Connection conn = DatabaseUtil.getConnection()) {
        conn.setAutoCommit(false);

        try {
            // Check existing vote
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, reviewId);
                checkStmt.setInt(2, userId);

                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        // User has already voted
                        conn.rollback();
                        return false;
                    }
                }
            }

            // Add vote
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setInt(1, reviewId);
                insertStmt.setInt(2, userId);
                insertStmt.setBoolean(3, isHelpful);
                insertStmt.executeUpdate();
            }

            // Update helpful count
            try (PreparedStatement updateStmt = conn.prepareStatement(updateCountSql)) {
                updateStmt.setInt(1, reviewId);
                updateStmt.setInt(2, reviewId);
                updateStmt.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            conn.rollback();
            throw e;
        }

    } catch (SQLException e) {
        LOGGER.severe("Error adding helpful vote: " + e.getMessage());
        throw e;
    }
}

/**
 * Get user's reviews
 */
public List<Review> getReviewsByUser(int userId) throws SQLException {
    String sql = "SELECT r.*, i.Name as InstrumentName " +
            "FROM Review r " +
            "LEFT JOIN Instrument i ON r.InstrumentID = i.InstrumentID " +
            "WHERE r.UserID = ? " +
            "ORDER BY r.ReviewDate DESC";

    List<Review> reviews = new ArrayList<>();

    try (Connection conn = DatabaseUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, userId);

        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Review review = mapResultSetToReview(rs);
                review.setInstrumentName(rs.getString("InstrumentName"));
                reviews.add(review);
            }
        }

    } catch (SQLException e) {
        LOGGER.severe("Error retrieving user reviews: " + e.getMessage());
        throw e;
    }

    return reviews;
}

// Helper methods

private Review mapResultSetToReview(ResultSet rs) throws SQLException {
    Review review = new Review();
    review.setReviewId(rs.getInt("ReviewID"));
    review.setInstrumentId(rs.getInt("InstrumentID"));
    review.setUserId(rs.getInt("UserID"));
    review.setRating(rs.getInt("Rating"));
    review.setReviewTitle(rs.getString("ReviewTitle"));
    review.setReviewText(rs.getString("ReviewText"));

    Timestamp reviewDate = rs.getTimestamp("ReviewDate");
    if (reviewDate != null) {
        review.setReviewDate(reviewDate.toLocalDateTime());
    }

    review.setApproved(rs.getBoolean("IsApproved"));
    review.setReported(rs.getBoolean("IsReported"));
    review.setHelpfulCount(rs.getInt("HelpfulCount"));

    Timestamp createdAt = rs.getTimestamp("CreatedAt");
    if (createdAt != null) {
        review.setCreatedAt(createdAt.toLocalDateTime());
    }

    Timestamp updatedAt = rs.getTimestamp("UpdatedAt");
    if (updatedAt != null) {
        review.setUpdatedAt(updatedAt.toLocalDateTime());
    }

    return review;
}

private String getStarKey(int stars) {
    switch (stars) {
        case 5: return "fiveStars";
        case 4: return "fourStars";
        case 3: return "threeStars";
        case 2: return "twoStars";
        case 1: return "oneStar";
        default: return "unknown";
    }
}
}