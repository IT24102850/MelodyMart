<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${name} - Melody Mart</title>
    <!-- Reuse styles from shop.jsp -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        /* Copy the :root and other styles from shop.jsp here for consistency */
        /* ... (paste the full <style> block from shop.jsp) */

        /* Additional styles for detail page */
        .product-detail-container {
            display: flex;
            gap: 40px;
            padding: 40px 0;
        }
        .product-image-large {
            width: 50%;
            height: 500px;
            object-fit: cover;
            border-radius: 15px;
        }
        .product-details {
            width: 50%;
        }
        .specs-list {
            list-style: none;
            margin: 20px 0;
        }
        .specs-list li {
            margin-bottom: 10px;
        }
        .reviews-section {
            margin-top: 40px;
        }
    </style>
</head>
<body>
<!-- Header (copy from shop.jsp) -->
<header class="header">
    <!-- ... (paste header code) -->
</header>

<div class="container">
    <div class="product-detail-container">
        <img src="${image_url}" alt="${name}" class="product-image-large">
        <div class="product-details">
            <% if (request.getAttribute("badge") != null) { %>
            <div class="product-badge">${badge}</div>
            <% } %>
            <div class="product-category">${category}</div>
            <h1 class="product-title">${name}</h1>
            <div class="product-rating">
                <div class="stars">★${rating}</div>  <!-- Simplify; adjust for exact stars -->
                <div class="rating-count">(${rating_count})</div>
            </div>
            <div class="product-price">
                <div class="current-price">$${price}</div>
                <% if (request.getAttribute("original_price") != null) { %>
                <div class="original-price">$${original_price}</div>
                <% } %>
            </div>
            <p>${description}</p>
            <h3>Specifications</h3>
            <ul class="specs-list">
                <%
                    String specs = (String) request.getAttribute("specs");
                    String[] specItems = specs.split(", ");
                    for (String spec : specItems) {
                        out.println("<li>" + spec + "</li>");
                    }
                %>
            </ul>
            <div class="product-actions">
                <button class="btn btn-primary add-to-cart">
                    <i class="fas fa-shopping-cart"></i>Add to Cart
                </button>
                <button class="wishlist-btn">
                    <i class="far fa-heart"></i>
                </button>
            </div>
            <!-- Reviews Section (extend for dynamic reviews) -->
            <div class="reviews-section">
                <h3>Customer Reviews</h3>
                <!-- Add form for rating/review as per use case -->
                <form action="submitReview" method="post">  <!-- Placeholder -->
                    <textarea placeholder="Write a review..."></textarea>
                    <button class="btn btn-primary">Submit Review</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Scripts (copy from shop.jsp and add if needed) -->
<script>
    // Reuse/add JS for add-to-cart, wishlist, etc.
</script>
</body>
</html>
