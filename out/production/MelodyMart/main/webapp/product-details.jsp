<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
<%
    String instrumentId = request.getParameter("instrumentId");
    if (instrumentId == null || instrumentId.isEmpty()) {
        response.sendRedirect("shop.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String name = "";
    String description = "";
    String brandID = "";
    String model = "";
    String color = "";
    double price = 0;
    String specifications = "";
    String warranty = "";
    int quantity = 0;
    String stockLevel = "";
    String manufacturerID = "";
    String imageURL = "";

    try {
        conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Instrument WHERE InstrumentID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, instrumentId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("Name");
            description = rs.getString("Description");
            brandID = rs.getString("BrandID");
            model = rs.getString("Model");
            color = rs.getString("Color");
            price = rs.getDouble("Price");
            specifications = rs.getString("Specifications");
            warranty = rs.getString("Warranty");
            quantity = rs.getInt("Quantity");
            stockLevel = rs.getString("StockLevel");
            manufacturerID = rs.getString("ManufacturerID");
            imageURL = rs.getString("ImageURL");
        } else {
            response.sendRedirect("shop.jsp?error=Product not found");
            return;
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("shop.jsp?error=Database error");
        return;
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= name %> | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1e88e5;
            --primary-light: #64b5f6;
            --primary-soft: #e3f2fd;
            --secondary: #f8fdff;
            --accent: #00acc1;
            --accent-alt: #ff7043;
            --text: #1565c0;
            --text-secondary: #546e7a;
            --text-soft: #78909c;
            --card-bg: #e8f5fe;
            --card-hover: #d0e9ff;
            --gradient: linear-gradient(135deg, #4fc3f7, #29b6f6, #03a9f4);
            --gradient-soft: linear-gradient(135deg, #e1f5fe, #b3e5fc);
            --glass-bg: rgba(255, 255, 255, 0.85);
            --glass-border: rgba(179, 229, 252, 0.5);
            --shadow: 0 5px 20px rgba(33, 150, 243, 0.15);
            --shadow-hover: 0 10px 30px rgba(33, 150, 243, 0.25);
            --header-bg: rgba(255, 255, 255, 0.95);
            --section-bg: #e1f5fe;
            --border-radius: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.4s ease, color 0.4s ease, border-color 0.4s ease, box-shadow 0.4s ease;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: var(--gradient-soft);
            color: var(--text);
            overflow-x: hidden;
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header & Navigation */
        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            padding: 20px 0;
            transition: all 0.4s ease;
            backdrop-filter: blur(10px);
            background-color: var(--header-bg);
            box-shadow: var(--shadow);
        }

        header.scrolled {
            padding: 15px 0;
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
        }

        .logo i {
            margin-right: 10px;
            font-size: 32px;
        }

        .nav-links {
            display: flex;
            list-style: none;
        }

        .nav-links li {
            margin: 0 15px;
        }

        .nav-links a {
            color: var(--text);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
            position: relative;
            padding: 8px 0;
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--gradient);
            transition: width 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--primary-light);
        }

        .nav-links a:hover:after {
            width: 100%;
        }

        .nav-actions {
            display: flex;
            align-items: center;
        }

        .nav-actions button {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            cursor: pointer;
            transition: color 0.3s ease;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .nav-actions button:hover {
            color: var(--primary-light);
            background: var(--primary-soft);
        }

        /* User Dropdown */
        .user-menu {
            position: relative;
            margin-left: 20px;
        }

        .user-btn {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            cursor: pointer;
            transition: color 0.3s ease;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .user-btn:hover {
            color: var(--primary-light);
            background: var(--primary-soft);
        }

        .dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            width: 180px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(10px);
            transition: opacity 0.3s ease, transform 0.3s ease, visibility 0.3s;
            z-index: 1000;
            box-shadow: var(--shadow-hover);
            padding: 10px 0;
        }

        .user-menu:hover .dropdown {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-item {
            display: block;
            padding: 12px 20px;
            color: var(--text);
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s ease, color 0.3s ease;
            cursor: pointer;
        }

        .dropdown-item:hover {
            background: var(--primary-soft);
            color: var(--primary);
        }

        /* Product Details Container */
        .product-details-container {
            max-width: 1200px;
            margin: 120px auto 60px;
            padding: 0 20px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: var(--text);
            text-decoration: none;
            margin-bottom: 30px;
            font-weight: 500;
            padding: 12px 20px;
            border-radius: 8px;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
        }

        .back-link:hover {
            color: var(--primary-light);
            transform: translateX(-5px);
            box-shadow: var(--shadow);
        }

        .product-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            background: var(--glass-bg);
            border-radius: var(--border-radius);
            padding: 40px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
        }

        /* Product Image Section */
        .product-image-section {
            position: relative;
        }

        .product-image {
            border-radius: var(--border-radius);
            overflow: hidden;
            background: var(--gradient-soft);
            position: relative;
            box-shadow: var(--shadow);
        }

        .product-image img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .product-image:hover img {
            transform: scale(1.05);
        }

        .image-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: var(--gradient);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            z-index: 2;
        }

        .image-actions {
            position: absolute;
            top: 15px;
            right: 15px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            z-index: 2;
        }

        .image-action-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            color: var(--text);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .image-action-btn:hover {
            background: var(--primary-light);
            color: white;
            transform: scale(1.1);
        }

        .image-thumbnails {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .thumbnail {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            overflow: hidden;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .thumbnail.active {
            border-color: var(--primary-light);
        }

        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Product Info Section */
        .product-info h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--text);
            line-height: 1.2;
        }

        .product-meta {
            margin-bottom: 25px;
        }

        .product-rating {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        .rating-stars {
            color: #ffb74d;
        }

        .rating-count {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .stock-status {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
        }

        .in-stock {
            background: rgba(76, 175, 80, 0.1);
            color: #4caf50;
            border: 1px solid rgba(76, 175, 80, 0.3);
        }

        .low-stock {
            background: rgba(255, 112, 67, 0.1);
            color: var(--accent-alt);
            border: 1px solid rgba(255, 112, 67, 0.3);
        }

        .out-of-stock {
            background: rgba(244, 67, 54, 0.1);
            color: #f44336;
            border: 1px solid rgba(244, 67, 54, 0.3);
        }

        .product-price {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .original-price {
            font-size: 1.5rem;
            color: var(--text-secondary);
            text-decoration: line-through;
        }

        .discount-badge {
            background: var(--accent-alt);
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
        }

        .product-desc {
            color: var(--text-secondary);
            line-height: 1.7;
            margin-bottom: 30px;
            font-size: 16px;
        }

        .product-specs {
            margin: 30px 0;
            background: var(--card-bg);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid var(--glass-border);
        }

        .product-specs h3 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            color: var(--text);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .spec-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid var(--glass-border);
        }

        .spec-item:last-child {
            border-bottom: none;
        }

        .spec-label {
            font-weight: 600;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .spec-value {
            color: var(--text);
            font-weight: 500;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 16px 32px;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            flex: 2;
            justify-content: center;
            font-size: 16px;
            box-shadow: var(--shadow);
        }

        .btn-primary:hover:not(:disabled) {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
        }

        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none !important;
        }

        .btn-secondary {
            background: var(--card-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
            padding: 16px 32px;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            flex: 1;
            justify-content: center;
            font-size: 16px;
        }

        .btn-secondary:hover {
            background: var(--primary-soft);
            border-color: var(--primary-light);
            transform: translateY(-3px);
            box-shadow: var(--shadow);
        }

        .btn-outline {
            background: transparent;
            color: var(--text);
            border: 2px solid var(--primary-light);
            padding: 16px 32px;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            flex: 1;
            justify-content: center;
            font-size: 16px;
        }

        .btn-outline:hover {
            background: var(--primary-light);
            color: white;
            transform: translateY(-3px);
            box-shadow: var(--shadow);
        }

        /* Additional Features */
        .delivery-info {
            background: var(--card-bg);
            padding: 20px;
            border-radius: var(--border-radius);
            margin-top: 25px;
            border: 1px solid var(--glass-border);
        }

        .delivery-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .delivery-item:last-child {
            margin-bottom: 0;
        }

        .delivery-icon {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: var(--primary-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-light);
        }

        .delivery-text {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Toast Notification */
        .toast {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            padding: 16px 24px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-hover);
            display: flex;
            align-items: center;
            gap: 12px;
            transform: translateY(100px);
            opacity: 0;
            transition: all 0.4s ease;
            z-index: 1001;
        }

        .toast.show {
            transform: translateY(0);
            opacity: 1;
        }

        .toast-success {
            border-left: 4px solid #4caf50;
        }

        .toast-error {
            border-left: 4px solid #f44336;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .product-details {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .product-info h1 {
                font-size: 2rem;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .product-details-container {
                margin: 100px auto 40px;
            }

            .product-details {
                padding: 25px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-primary, .btn-secondary, .btn-outline {
                flex: none;
                width: 100%;
            }
        }

        @media (max-width: 576px) {
            .product-info h1 {
                font-size: 1.8rem;
            }

            .product-price {
                font-size: 1.8rem;
            }

            .product-specs {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <div class="container nav-container">
        <div class="logo">
            <i class="fas fa-music"></i>
            Melody Mart
        </div>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="shop.jsp">Shop</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a></li>
        </ul>
        <div class="nav-actions">
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i></button>
                <div class="dropdown">
                    <a href="sign-in.jsp" class="dropdown-item">Sign In</a>
                    <a href="sign-up.jsp" class="dropdown-item">Sign Up</a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Toast Notification -->
<div id="toast" class="toast">
    <i class="fas fa-check-circle" style="color: #4caf50;"></i>
    <span id="toast-message">Product added to cart!</span>
</div>

<!-- Product Details -->
<div class="product-details-container">
    <a href="shop.jsp" class="back-link">
        <i class="fas fa-arrow-left"></i>
        Back to Shop
    </a>

    <div class="product-details">
        <!-- Product Image Section -->
        <div class="product-image-section">
            <div class="product-image">
                <div class="image-badge">Featured</div>
                <div class="image-actions">
                    <button class="image-action-btn" onclick="zoomImage()">
                        <i class="fas fa-search-plus"></i>
                    </button>
                    <button class="image-action-btn" onclick="shareProduct()">
                        <i class="fas fa-share-alt"></i>
                    </button>
                </div>
                <%
                    if (imageURL != null && !imageURL.trim().isEmpty()) {
                %>
                <img src="<%= imageURL %>" alt="<%= name %>" id="main-image">
                <%
                } else {
                %>
                <img src="https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="<%= name %>" id="main-image">
                <%
                    }
                %>
            </div>

            <div class="image-thumbnails">
                <div class="thumbnail active">
                    <img src="<%= imageURL != null && !imageURL.trim().isEmpty() ? imageURL : "https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" %>" alt="Thumbnail 1">
                </div>
                <!-- Additional thumbnails would go here -->
            </div>
        </div>

        <!-- Product Info Section -->
        <div class="product-info">
            <h1><%= name %></h1>

            <div class="product-meta">
                <div class="product-rating">
                    <div class="rating-stars">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="rating-count">(42 reviews)</span>
                </div>

                <%
                    String stockClass = "in-stock";
                    String stockText = "In Stock";
                    String stockIcon = "fas fa-check-circle";
                    if (quantity == 0) {
                        stockClass = "out-of-stock";
                        stockText = "Out of Stock";
                        stockIcon = "fas fa-times-circle";
                    } else if (quantity < 5) {
                        stockClass = "low-stock";
                        stockText = "Low Stock - Only " + quantity + " left";
                        stockIcon = "fas fa-exclamation-circle";
                    }
                %>
                <div class="stock-status <%= stockClass %>">
                    <i class="<%= stockIcon %>"></i>
                    <%= stockText %>
                </div>
            </div>

            <div class="product-price">
                $<%= String.format("%.2f", price) %>
                <span class="discount-badge">15% OFF</span>
            </div>

            <p class="product-desc"><%= description != null ? description : "No description available." %></p>

            <div class="product-specs">
                <h3><i class="fas fa-list-alt"></i> Product Details</h3>
                <div class="spec-item">
                    <span class="spec-label"><i class="fas fa-tag"></i> Brand:</span>
                    <span class="spec-value"><%= brandID %></span>
                </div>
                <div class="spec-item">
                    <span class="spec-label"><i class="fas fa-cube"></i> Model:</span>
                    <span class="spec-value"><%= model != null ? model : "N/A" %></span>
                </div>
                <div class="spec-item">
                    <span class="spec-label"><i class="fas fa-palette"></i> Color:</span>
                    <span class="spec-value"><%= color != null ? color : "N/A" %></span>
                </div>
                <div class="spec-item">
                    <span class="spec-label"><i class="fas fa-shield-alt"></i> Warranty:</span>
                    <span class="spec-value"><%= warranty != null ? warranty : "N/A" %></span>
                </div>
                <div class="spec-item">
                    <span class="spec-label"><i class="fas fa-industry"></i> Manufacturer:</span>
                    <span class="spec-value"><%= manufacturerID %></span>
                </div>
            </div>

            <% if (specifications != null && !specifications.trim().isEmpty()) { %>
            <div class="product-specs">
                <h3><i class="fas fa-cogs"></i> Specifications</h3>
                <p><%= specifications %></p>
            </div>
            <% } %>

            <div class="action-buttons">
                <form method="post" action="CartServlet" class="add-to-cart-form" id="cart-form">
                    <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                    <input type="hidden" name="action" value="add">
                    <button type="submit" class="btn-primary" <%= quantity == 0 ? "disabled" : "" %> id="add-to-cart-btn">
                        <i class="fas fa-shopping-cart"></i>
                        Add to Cart
                    </button>
                </form>

                <button class="btn-secondary" id="wishlist-btn">
                    <i class="far fa-heart"></i>
                    Add to Wishlist
                </button>

                <button class="btn-outline" onclick="showDeliveryInfo()">
                    <i class="fas fa-truck"></i>
                    Delivery Info
                </button>
            </div>

            <div class="delivery-info" id="delivery-info" style="display: none;">
                <div class="delivery-item">
                    <div class="delivery-icon">
                        <i class="fas fa-shipping-fast"></i>
                    </div>
                    <div class="delivery-text">
                        <strong>Free Shipping</strong> on orders over $100
                    </div>
                </div>
                <div class="delivery-item">
                    <div class="delivery-icon">
                        <i class="fas fa-undo"></i>
                    </div>
                    <div class="delivery-text">
                        <strong>30-Day Return Policy</strong> - No questions asked
                    </div>
                </div>
                <div class="delivery-item">
                    <div class="delivery-icon">
                        <i class="fas fa-lock"></i>
                    </div>
                    <div class="delivery-text">
                        <strong>Secure Payment</strong> - Your data is protected
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // Filter functionality
    const brandTags = document.querySelectorAll('.brand-tag');
    brandTags.forEach(tag => {
        tag.addEventListener('click', () => {
            tag.classList.toggle('active');
        });
    });

    // View toggle functionality
    const viewBtns = document.querySelectorAll('.view-btn');
    viewBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            viewBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const productsGrid = document.querySelector('.products-grid');
            if (btn.querySelector('.fa-list')) {
                productsGrid.style.gridTemplateColumns = '1fr';
            } else {
                productsGrid.style.gridTemplateColumns = 'repeat(auto-fill, minmax(280px, 1fr))';
            }
        });
    });

    // Wishlist toggle
    const wishlistBtns = document.querySelectorAll('.wishlist-btn');
    wishlistBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.stopPropagation(); // Prevent card click when clicking wishlist
            const icon = btn.querySelector('i');
            if (icon.classList.contains('far')) {
                icon.classList.remove('far');
                icon.classList.add('fas');
                icon.style.color = 'var(--accent-alt)';
            } else {
                icon.classList.remove('fas');
                icon.classList.add('far');
                icon.style.color = '';
            }
        });
    });

    // Add to cart functionality with AJAX
    const addToCartBtns = document.querySelectorAll('.add-to-cart');
    addToCartBtns.forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.stopPropagation(); // Prevent card click when clicking add to cart
            const instrumentID = this.getAttribute('data-id');
            const quantity = 1;

            console.log('Adding to cart:', instrumentID);

            // Disable button during request to prevent multiple clicks
            this.disabled = true;
            const originalText = this.innerHTML;

            // Show loading state
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding...';

            // Create form data
            const formData = new FormData();
            formData.append('instrumentID', instrumentID);
            formData.append('quantity', quantity.toString());

            // Send AJAX request to servlet
            fetch('AddToCartServlet', {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    console.log('Response status:', response.status);
                    console.log('Response type:', response.type);
                    return response.text();
                })
                .then(result => {
                    console.log('Response result:', result);

                    if (result === 'success') {
                        // Success feedback
                        this.innerHTML = '<i class="fas fa-check"></i> Added!';
                        this.style.background = 'var(--accent)';

                        // Update cart count if you have a cart counter
                        updateCartCounter();

                        // Re-enable button after delay
                        setTimeout(() => {
                            this.innerHTML = originalText;
                            this.style.background = '';
                            this.disabled = false;
                        }, 2000);
                    } else {
                        // Error handling
                        let errorMessage = 'Failed to add item to cart.';
                        if (result.includes('error:')) {
                            errorMessage = result.replace('error:', '').trim();
                        }
                        alert(errorMessage);
                        this.innerHTML = originalText;
                        this.disabled = false;
                    }
                })
                .catch(error => {
                    console.error('Fetch Error:', error);
                    alert('An error occurred while adding item to cart. Please check the console for details.');
                    this.innerHTML = originalText;
                    this.disabled = false;
                });
        });
    });

    // Function to redirect to product details page
    function redirectToProductDetails(instrumentID) {
        window.location.href = 'product-details.jsp?instrumentId=' + instrumentID;
    }

    // Make entire product card clickable (except buttons)
    const productCards = document.querySelectorAll('.product-card');
    productCards.forEach(card => {
        card.addEventListener('click', function(e) {
            // Don't redirect if clicking on buttons or links
            if (e.target.closest('.add-to-cart') ||
                e.target.closest('.wishlist-btn') ||
                e.target.tagName === 'BUTTON' ||
                e.target.tagName === 'A') {
                return;
            }
            const instrumentID = this.getAttribute('data-id');
            redirectToProductDetails(instrumentID);
        });
    });

    // Function to update cart counter (optional)
    function updateCartCounter() {
        console.log('Cart updated - item added successfully');

        // If you have a cart badge element, you could update it here:
        // const cartBadge = document.querySelector('.cart-badge');
        // if (cartBadge) {
        //     const currentCount = parseInt(cartBadge.textContent) || 0;
        //     cartBadge.textContent = currentCount + 1;
        // }
    }

    // Price range slider functionality
    const priceSlider = document.querySelector('.price-slider');
    const maxPriceInput = document.querySelector('.price-input[placeholder="Max"]');

    if (priceSlider && maxPriceInput) {
        priceSlider.addEventListener('input', function() {
            maxPriceInput.value = this.value;
        });

        maxPriceInput.addEventListener('input', function() {
            priceSlider.value = this.value;
        });
    }

    // Apply filters button functionality
    const applyFiltersBtn = document.querySelector('.filters-sidebar .cta-btn');
    if (applyFiltersBtn) {
        applyFiltersBtn.addEventListener('click', function() {
            // Collect all filter values
            const selectedCategories = [];
            document.querySelectorAll('.filter-option input[type="checkbox"]:checked').forEach(checkbox => {
                selectedCategories.push(checkbox.nextElementSibling.nextElementSibling.textContent);
            });

            const minPrice = document.querySelector('.price-input[placeholder="Min"]').value;
            const maxPrice = document.querySelector('.price-input[placeholder="Max"]').value;

            const selectedBrands = [];
            document.querySelectorAll('.brand-tag.active').forEach(tag => {
                selectedBrands.push(tag.textContent);
            });

            // Here you would typically send these filters to the server
            // or filter the products on the client side
            console.log('Applied filters:', {
                categories: selectedCategories,
                priceRange: { min: minPrice, max: maxPrice },
                brands: selectedBrands
            });

            alert('Filters applied! (Check console for details)');
        });
    }
</script>
</body>
</html>