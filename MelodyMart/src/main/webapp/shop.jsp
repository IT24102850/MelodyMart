<%@ page import="java.sql.*, com.melodymart.util.DatabaseUtil" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop | Melody Mart</title>
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #6c757d;
            --success: #4cc9f0;
            --danger: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
            --border: #e9ecef;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --radius: 10px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fb;
            color: var(--dark);
            line-height: 1.6;
        }

        .shop-section {
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 20px;
        }

        .shop-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .shop-header h1 {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .shop-header p {
            color: var(--secondary);
            font-size: 1.1rem;
        }

        /* Success/Error Messages */
        .message {
            max-width: 600px;
            margin: 0 auto 30px;
            padding: 15px 20px;
            border-radius: var(--radius);
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideDown 0.3s ease;
        }

        .message.success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .message.error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Product Grid */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }

        .product-card {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }

        .product-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            background: var(--light);
        }

        .product-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .product-name {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 8px;
        }

        .product-brand {
            color: var(--secondary);
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .product-description {
            color: var(--secondary);
            font-size: 0.9rem;
            margin-bottom: 15px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            flex: 1;
        }

        .product-stock {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.85rem;
            margin-bottom: 10px;
        }

        .stock-badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.8rem;
        }

        .stock-badge.in-stock {
            background: #d4edda;
            color: #155724;
        }

        .stock-badge.low-stock {
            background: #fff3cd;
            color: #856404;
        }

        .stock-badge.out-of-stock {
            background: #f8d7da;
            color: #721c24;
        }

        .product-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid var(--border);
        }

        .product-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
        }

        .add-to-cart-btn {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .add-to-cart-btn:hover:not(:disabled) {
            background: var(--primary-dark);
            transform: scale(1.05);
        }

        .add-to-cart-btn:disabled {
            background: var(--secondary);
            cursor: not-allowed;
            opacity: 0.6;
        }

        .cart-icon {
            width: 18px;
            height: 18px;
        }

        .no-products {
            text-align: center;
            padding: 60px 20px;
            color: var(--secondary);
        }

        .no-products-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        /* View Cart Button */
        .view-cart-float {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: var(--primary);
            color: white;
            padding: 15px 25px;
            border-radius: 50px;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.4);
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .view-cart-float:hover {
            background: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(67, 97, 238, 0.5);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .shop-header h1 {
                font-size: 2rem;
            }

            .products-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
                gap: 20px;
            }

            .product-image {
                height: 200px;
            }

            .view-cart-float {
                bottom: 20px;
                right: 20px;
                padding: 12px 20px;
            }
        }

        @media (max-width: 480px) {
            .shop-section {
                padding: 20px 10px;
            }

            .products-grid {
                grid-template-columns: 1fr;
            }

            .product-footer {
                flex-direction: column;
                gap: 10px;
                align-items: stretch;
            }

            .add-to-cart-btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<section class="shop-section">
    <div class="shop-header">
        <h1>🎵 Our Instrument Collection</h1>
        <p>Discover high-quality musical instruments for every musician</p>
    </div>

    <%
        // Display success or error messages
        String message = request.getParameter("message");
        String error = request.getParameter("error");

        if (message != null && !message.isEmpty()) {
    %>
    <div class="message success">
        <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
        </svg>
        <%= message %>
    </div>
    <%
        }

        if (error != null && !error.isEmpty()) {
    %>
    <div class="message error">
        <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
        </svg>
        <%= error %>
    </div>
    <%
        }
    %>

    <div class="products-grid">
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            boolean hasProducts = false;

            try {
                conn = DatabaseUtil.getConnection();

                // Query to fetch all instruments with their details
                String sql = "SELECT i.InstrumentID, i.Name, i.Description, i.Price, " +
                        "i.Quantity, i.StockLevel, i.ImageURL, i.BrandID, " +
                        "i.Model, i.Color " +
                        "FROM Instrument i " +
                        "ORDER BY i.Name";

                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    hasProducts = true;
                    String instrumentId = rs.getString("InstrumentID");
                    String name = rs.getString("Name");
                    String description = rs.getString("Description");
                    double price = rs.getDouble("Price");
                    int quantity = rs.getInt("Quantity");
                    String stockLevel = rs.getString("StockLevel");
                    String imageUrl = rs.getString("ImageURL");
                    String model = rs.getString("Model");
                    String color = rs.getString("Color");

                    // Default image if none provided
                    if (imageUrl == null || imageUrl.isEmpty()) {
                        imageUrl = "https://via.placeholder.com/300x250?text=" + name.replace(" ", "+");
                    }

                    // Determine stock status
                    boolean inStock = quantity > 0;
                    String stockBadgeClass = "";
                    String stockText = "";

                    if (quantity == 0) {
                        stockBadgeClass = "out-of-stock";
                        stockText = "Out of Stock";
                    } else if (quantity < 5) {
                        stockBadgeClass = "low-stock";
                        stockText = "Only " + quantity + " left!";
                    } else {
                        stockBadgeClass = "in-stock";
                        stockText = "In Stock";
                    }
        %>
        <div class="product-card">
            <img src="<%= imageUrl %>" alt="<%= name %>" class="product-image">
            <div class="product-info">
                <h3 class="product-name"><%= name %></h3>
                <% if (model != null && !model.isEmpty()) { %>
                <div class="product-brand">Model: <%= model %><% if (color != null && !color.isEmpty()) { %> • <%= color %><% } %></div>
                <% } %>
                <% if (description != null && !description.isEmpty()) { %>
                <p class="product-description"><%= description %></p>
                <% } %>

                <div class="product-stock">
                    <span class="stock-badge <%= stockBadgeClass %>"><%= stockText %></span>
                </div>

                <div class="product-footer">
                    <div class="product-price">$<%= String.format("%.2f", price) %></div>
                    <form action="AddToCartServlet" method="post" style="margin: 0;">
                        <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="add-to-cart-btn" <%= !inStock ? "disabled" : "" %>>
                            <svg class="cart-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
                            </svg>
                            <%= inStock ? "Add to Cart" : "Out of Stock" %>
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <%
            }

            if (!hasProducts) {
        %>
        <div class="no-products">
            <div class="no-products-icon">🎸</div>
            <h2>No Instruments Available</h2>
            <p>Check back soon for new arrivals!</p>
        </div>
        <%
            }

        } catch (Exception e) {
        %>
        <div class="message error">
            Error loading products: <%= e.getMessage() %>
        </div>
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                if (conn != null) try { conn.close(); } catch (Exception ignored) {}
            }
        %>
    </div>
</section>

<!-- Floating Cart Button -->
<%
    String customerIdStr = (String) session.getAttribute("CustomerID");
    if (customerIdStr != null) {
%>
<a href="cart.jsp" class="view-cart-float">
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
    </svg>
    View Cart
</a>
<% } %>
</body>
</html>