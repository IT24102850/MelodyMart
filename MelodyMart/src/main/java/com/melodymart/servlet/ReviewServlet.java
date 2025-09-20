package main.java.com.melodymart.servlet.review;

import main.java.com.melodymart.dao.ReviewDAO;
import com.melodymart.model.Review;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import com.google.gson.Gson;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ReviewServlet.class.getName());
    private ReviewDAO reviewDAO = new ReviewDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "view") {
                case "viewReviews":
                    viewReviews(request, response);
                    break;
                case "getReviewStats":
                    getReviewStats(request, response);
                    break;
                case "getReviewableItems":
                    getReviewableItems(request, response);
                    break;
                case "viewCustomerReviews":
                    viewCustomerReviews(request, response);
                    break;
                case "viewAllReviews":
                    viewAllReviews(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error in ReviewServlet: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "addReview":
                    addReview(request, response);
                    break;
                case "updateReview":
                    updateReview(request, response);
                    break;
                case "deleteReview":
                    deleteReview(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error in ReviewServlet: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    /**
     * View reviews for a specific instrument
     */
    private void viewReviews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        String instrumentIdStr = request.getParameter("instrumentId");

        if (instrumentIdStr == null || instrumentIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Instrument ID is required");
            return;
        }

        try {
            int instrumentId = Integer.parseInt(instrumentIdStr);
            List<Review> reviews = reviewDAO.getReviewsByInstrument(instrumentId);
            Map<String, Object> stats = reviewDAO.getReviewStats(instrumentId);

            // Return JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Map<String, Object> result = Map.of(
                    "reviews", reviews,
                    "stats", stats
            );

            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(result));
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid instrument ID format");
        }
    }

    /**
     * Get review statistics for an instrument
     */
    private void getReviewStats(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        String instrumentIdStr = request.getParameter("instrumentId");

        if (instrumentIdStr == null || instrumentIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Instrument ID is required");
            return;
        }

        try {
            int instrumentId = Integer.parseInt(instrumentIdStr);
            Map<String, Object> stats = reviewDAO.getReviewStats(instrumentId);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(stats));
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid instrument ID format");
        }
    }

    /**
     * Get items that a customer can review
     */
    private void getReviewableItems(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Customer not logged in");
            return;
        }

        List<Map<String, Object>> items = reviewDAO.getReviewableItems(customerId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(items));
        }
    }

    /**
     * View reviews by a specific customer
     */
    private void viewCustomerReviews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Customer not logged in");
            return;
        }

        List<Review> reviews = reviewDAO.getReviewsByCustomer(customerId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(reviews));
        }
    }

    /**
     * View all reviews (admin function)
     */
    private void viewAllReviews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        // Check if user is admin (implement your admin check logic)
        HttpSession session = request.getSession();
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

        if (isAdmin == null || !isAdmin) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
            return;
        }

        int page = 1;
        int pageSize = 20;

        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");

        try {
            if (pageStr != null) page = Integer.parseInt(pageStr);
            if (pageSizeStr != null) pageSize = Integer.parseInt(pageSizeStr);
        } catch (NumberFormatException e) {
            // Use default values
        }

        List<Review> reviews = reviewDAO.getAllReviews(page, pageSize);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(reviews));
        }
    }

    /**
     * Add a new review
     */
    private void addReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Customer not logged in");
            return;
        }

        String orderItemIdStr = request.getParameter("orderItemId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        if (orderItemIdStr == null || ratingStr == null || comment == null ||
                orderItemIdStr.isEmpty() || ratingStr.isEmpty() || comment.trim().isEmpty()) {

            sendJsonResponse(response, false, "All fields are required");
            return;
        }

        try {
            int orderItemId = Integer.parseInt(orderItemIdStr);
            int rating = Integer.parseInt(ratingStr);

            // Validate rating
            if (rating < 1 || rating > 5) {
                sendJsonResponse(response, false, "Rating must be between 1 and 5");
                return;
            }

            // Validate comment length
            if (comment.length() < 10 || comment.length() > 1000) {
                sendJsonResponse(response, false, "Comment must be between 10 and 1000 characters");
                return;
            }

            // Check if customer can review this item
            if (!reviewDAO.canCustomerReviewOrderItem(customerId, orderItemId)) {
                sendJsonResponse(response, false, "You cannot review this item");
                return;
            }

            // Create and save review
            Review review = new Review(orderItemId, rating, comment);
            review.setReviewDate(LocalDateTime.now());

            boolean success = reviewDAO.addReview(review);

            if (success) {
                sendJsonResponse(response, true, "Review added successfully");
                LOGGER.info("Review added by customer " + customerId + " for order item " + orderItemId);
            } else {
                sendJsonResponse(response, false, "Failed to add review");
            }

        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "Invalid number format");
        }
    }

    /**
     * Update an existing review
     */
    private void updateReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Customer not logged in");
            return;
        }

        String reviewIdStr = request.getParameter("reviewId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        if (reviewIdStr == null || ratingStr == null || comment == null ||
                reviewIdStr.isEmpty() || ratingStr.isEmpty() || comment.trim().isEmpty()) {

            sendJsonResponse(response, false, "All fields are required");
            return;
        }

        try {
            int reviewId = Integer.parseInt(reviewIdStr);
            int rating = Integer.parseInt(ratingStr);

            // Validate rating
            if (rating < 1 || rating > 5) {
                sendJsonResponse(response, false, "Rating must be between 1 and 5");
                return;
            }

            // Validate comment length
            if (comment.length() < 10 || comment.length() > 1000) {
                sendJsonResponse(response, false, "Comment must be between 10 and 1000 characters");
                return;
            }

            // Create review object with updated data
            Review review = new Review();
            review.setReviewId(reviewId);
            review.setRating(rating);
            review.setComment(comment);

            boolean success = reviewDAO.updateReview(review);

            if (success) {
                sendJsonResponse(response, true, "Review updated successfully");
                LOGGER.info("Review updated by customer " + customerId + ", review ID: " + reviewId);
            } else {
                sendJsonResponse(response, false, "Failed to update review");
            }

        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "Invalid number format");
        }
    }

    /**
     * Delete a review
     */
    private void deleteReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

        if (customerId == null && (isAdmin == null || !isAdmin)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access denied");
            return;
        }

        String reviewIdStr = request.getParameter("reviewId");

        if (reviewIdStr == null || reviewIdStr.isEmpty()) {
            sendJsonResponse(response, false, "Review ID is required");
            return;
        }

        try {
            int reviewId = Integer.parseInt(reviewIdStr);

            boolean success = reviewDAO.deleteReview(reviewId);

            if (success) {
                sendJsonResponse(response, true, "Review deleted successfully");
                LOGGER.info("Review deleted, ID: " + reviewId);
            } else {
                sendJsonResponse(response, false, "Failed to delete review");
            }

        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "Invalid review ID format");
        }
    }

    /**
     * Send JSON response
     */
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = Map.of(
                "success", success,
                "message", message
        );

        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(result));
        }
    }
}