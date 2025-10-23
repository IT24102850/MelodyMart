<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
<%
    // ✅ Retrieve customer data from session (set during login)
    String customerId = (String) session.getAttribute("customerId");
    String customerName = (String) session.getAttribute("userName");

    // ✅ Security check — redirect if not logged in
    if (customerId == null || customerName == null) {
        response.sendRedirect("sign-in.jsp");
        return;
    }

    // ✅ Generate initials
    String customerInitials = "U";
    if (customerName != null && !customerName.trim().isEmpty()) {
        String[] parts = customerName.trim().split("\\s+");
        if (parts.length >= 2) {
            customerInitials = ("" + parts[0].charAt(0) + parts[1].charAt(0)).toUpperCase();
        } else {
            customerInitials = ("" + parts[0].charAt(0)).toUpperCase();
        }
    }

    // ✅ Initialize cart count
    Integer cartCount = (Integer) session.getAttribute("cartCount");
    if (cartCount == null) {
        cartCount = 0;
        session.setAttribute("cartCount", cartCount);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop | Melody Mart</title>
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
            --filter-bg: #e1f5fe;
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

        .cta-btn {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-left: 20px;
            position: relative;
            overflow: hidden;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: var(--shadow);
        }

        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
        }

        .cta-btn:focus {
            outline: 2px solid var(--primary-light);
            outline-offset: 3px;
        }

        .cta-btn i {
            font-size: 16px;
            transition: transform 0.3s ease;
        }

        .cta-btn:hover i {
            transform: translateX(6px);
        }

        /* User Dropdown */
        .user-menu {
            position: relative;
            margin-left: 20px;
        }

        .user-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3b82f6, #1e40af);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .user-avatar:hover {
            transform: scale(1.05);
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
            display: flex;
            align-items: center;
            gap: 10px;
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

        /* Cart Icon */
        .cart-icon-container {
            position: relative;
            margin-left: 15px;
        }

        .cart-icon {
            color: var(--text);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 8px 15px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .cart-icon:hover {
            background: var(--primary-soft);
        }

        .cart-count {
            background: var(--accent-alt);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 600;
            position: absolute;
            top: -5px;
            right: 0;
        }

        /* Page Header */
        .page-header {
            background: var(--gradient);
            padding: 150px 0 80px;
            text-align: center;
            margin-top: 80px;
            position: relative;
            overflow: hidden;
        }

        .page-header:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><path fill="rgba(255,255,255,0.1)" d="M500,250c138.07,0,250,111.93,250,250s-111.93,250-250,250s-250-111.93-250-250S361.93,250,500,250z"/></svg>') no-repeat center;
            background-size: cover;
            opacity: 0.2;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            color: white;
            position: relative;
            z-index: 2;
        }

        .page-subtitle {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 600px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        /* Message Styles */
        .message-success, .message-error, .message-warning {
            padding: 15px 20px;
            text-align: center;
            border-radius: var(--border-radius);
            margin: 20px auto;
            max-width: 1200px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 500;
            box-shadow: var(--shadow);
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message-success {
            background: #ecfdf5;
            color: #047857;
            border: 1px solid #a7f3d0;
        }

        .message-error {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .message-warning {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
        }

        /* Search Section */
        .search-section {
            background: var(--glass-bg);
            padding: 30px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            margin: 40px 0;
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            transition: transform 0.3s ease;
        }

        .search-section:hover {
            transform: translateY(-5px);
        }

        .search-container {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .search-box {
            flex: 1;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 15px 20px 15px 50px;
            border: 1px solid var(--glass-border);
            border-radius: 8px;
            font-size: 16px;
            background: var(--card-bg);
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }

        .search-btn {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        /* Products Section */
        .products-section {
            margin-bottom: 50px;
        }

        .products-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: var(--glass-bg);
            padding: 20px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            transition: transform 0.3s ease;
        }

        .products-header:hover {
            transform: translateY(-3px);
        }

        .products-count {
            color: var(--text-secondary);
        }

        .sort-options {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .sort-select {
            padding: 10px 15px;
            border-radius: 8px;
            background: var(--card-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .sort-select:hover {
            box-shadow: var(--shadow);
        }

        .view-options {
            display: flex;
            gap: 10px;
        }

        .view-btn {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--card-bg);
            color: var(--text-secondary);
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .view-btn.active, .view-btn:hover {
            background: var(--primary-light);
            color: white;
            transform: translateY(-2px);
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .product-card {
            background: var(--glass-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            transition: all 0.5s ease;
            position: relative;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            cursor: pointer;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .product-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: var(--accent-alt);
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            z-index: 2;
            animation: pulse 2s infinite;
        }

        .product-badge.out-of-stock {
            background: #6b7280;
        }

        .product-badge.low-stock {
            background: #f59e0b;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .product-img {
            height: 220px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            transition: transform 0.5s ease;
            background: var(--gradient-soft);
        }

        .product-card:hover .product-img {
            transform: scale(1.05);
        }

        .product-img:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, transparent, rgba(100, 181, 246, 0.1));
            transition: opacity 0.3s ease;
        }

        .product-card:hover .product-img:after {
            opacity: 0.8;
        }

        .product-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .product-card:hover .product-img img {
            transform: scale(1.1);
        }

        .product-info {
            padding: 20px;
        }

        .product-category {
            color: var(--accent);
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .product-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            line-height: 1.4;
        }

        .product-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 10px;
        }

        .rating-stars {
            color: var(--accent);
        }

        .rating-count {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .product-price {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        .current-price {
            color: var(--text);
            font-weight: 700;
            font-size: 20px;
        }

        .original-price {
            color: var(--text-secondary);
            text-decoration: line-through;
            font-size: 16px;
        }

        .product-desc {
            color: var(--text-secondary);
            font-size: 14px;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .product-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            font-size: 0.9rem;
            text-align: center;
            min-height: 44px;
        }

        .btn-order {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            flex: 2;
            box-shadow: 0 2px 8px rgba(16, 185, 129, 0.3);
        }

        .btn-order:hover {
            background: linear-gradient(135deg, #059669, #047857);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
        }

        .btn-cart {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            color: white;
            flex: 1;
            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3);
        }

        .btn-cart:hover {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
        }

        .btn:disabled {
            background: #9ca3af;
            cursor: not-allowed;
            opacity: 0.6;
            transform: none;
            box-shadow: none;
        }

        .btn:disabled:hover {
            background: #9ca3af;
            transform: none;
            box-shadow: none;
        }

        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 50px;
            gap: 10px;
        }

        .pagination-btn {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--glass-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pagination-btn.active, .pagination-btn:hover {
            background: var(--primary-light);
            color: white;
            transform: translateY(-2px);
        }

        /* Footer */
        footer {
            background: var(--glass-bg);
            padding: 80px 0 30px;
            border-top: 1px solid var(--glass-border);
            margin-top: 60px;
            backdrop-filter: blur(10px);
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 50px;
        }

        .footer-column h3 {
            font-size: 20px;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 10px;
            color: var(--primary);
        }

        .footer-column h3:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: var(--gradient);
            border-radius: 2px;
        }

        .footer-column p {
            color: var(--text-secondary);
            margin-bottom: 25px;
            line-height: 1.7;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 15px;
        }

        .footer-links a {
            color: var(--text-secondary);
            text-decoration: none;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
        }

        .footer-links a:before {
            content: '▸';
            margin-right: 10px;
            color: var(--primary-soft);
            transition: all 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--primary);
        }

        .footer-links a:hover:before {
            color: var(--primary);
            transform: translateX(5px);
        }

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: var(--card-bg);
            color: var(--text);
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
        }

        .social-links a:hover {
            background: var(--gradient);
            color: white;
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .copyright {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid var(--glass-border);
            color: var(--text-secondary);
            font-size: 15px;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .products-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .products-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }

            .page-title {
                font-size: 2.5rem;
            }

            .product-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .search-container {
                flex-direction: column;
            }
        }

        @media (max-width: 576px) {
            .products-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- Header & Navigation -->
<header>
    <div class="container nav-container">
        <div class="logo">
            <i class="fas fa-music"></i>
            Melody Mart
        </div>

        <ul class="nav-links">
            <li><a href="customerlanding.jsp">Home</a></li>
            <li><a href="shop.jsp" class="active">Shop</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>

        <div class="nav-actions">
            <div class="cart-icon-container">
                <a href="cart.jsp" class="cart-icon">
                    <i class="fas fa-shopping-cart"></i>
                    Cart
                    <% if (cartCount > 0) { %>
                    <span class="cart-count"><%= cartCount %></span>
                    <% } %>
                </a>
            </div>
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu">
                    <div class="user-avatar"><%= customerInitials %></div>
                </button>
                <div class="dropdown">
                    <a href="customerlanding.jsp" class="dropdown-item"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    <a href="profile.jsp" class="dropdown-item"><i class="fas fa-user"></i> Profile</a>
                    <a href="orders.jsp" class="dropdown-item"><i class="fas fa-shopping-bag"></i> Orders</a>
                    <a href="wishlist.jsp" class="dropdown-item"><i class="fas fa-heart"></i> Wishlist</a>
                    <hr style="margin: 5px 0; border: none; border-top: 1px solid var(--glass-border);">
                    <a href="logout.jsp" class="dropdown-item"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1 class="page-title">Premium Instruments Shop</h1>
        <p class="page-subtitle">
            Welcome back, <%= customerName %>! Discover our curated collection of professional musical instruments and equipment.
        </p>
    </div>
</section>

<!-- ✅ Enhanced Message Block -->
<%
    String added = request.getParameter("added");
    String reason = request.getParameter("reason");

    System.out.println("DEBUG: added=" + added + ", reason=" + reason);

    if ("success".equals(added)) {
%>
<div class="message-success">
    <i class="fas fa-check-circle"></i>
     Item added to your cart successfully!
</div>
<%
} else if ("fail".equals(added)) {
    if ("out_of_stock".equals(reason)) {
%>
<div class="message-error">
    <i class="fas fa-exclamation-circle"></i>
    ❌ Item is out of stock. Please try another product.
</div>
<%
} else {
%>
<div class="message-error">
    <i class="fas fa-exclamation-circle"></i>
    ❌ Failed to add item. Please try again.
</div>
<%
    }
} else if ("error".equals(added)) {
%>
<div class="message-warning">
    <i class="fas fa-exclamation-triangle"></i>
    ⚠ Server error occurred. Try again later.
</div>
<%
    }
%>

<!-- Search Section -->
<div class="container">
    <div class="search-section">
        <div class="search-container">
            <div class="search-box">
                <i class="fas fa-search search-icon"></i>
                <input type="text" class="search-input" placeholder="Search for instruments, brands, or categories...">
            </div>
            <button class="search-btn">
                <i class="fas fa-search"></i>
                Search
            </button>
        </div>
    </div>
</div>

<!-- Products Section -->
<div class="container">
    <main class="products-section">
        <div class="products-header">
            <div>
                <h2 style="margin-bottom: 5px;">All Instruments</h2>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    int productCount = 0;
                    try {
                        conn = DBConnection.getConnection();
                        stmt = conn.createStatement();
                        String sql = "SELECT COUNT(*) AS count FROM Instrument";
                        rs = stmt.executeQuery(sql);
                        if (rs.next()) {
                            productCount = rs.getInt("count");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
                <p class="products-count">Showing <%= productCount %> products</p>
            </div>
            <div class="sort-options">
                <select class="sort-select">
                    <option>Sort by: Featured</option>
                    <option>Price: Low to High</option>
                    <option>Price: High to Low</option>
                    <option>Customer Rating</option>
                    <option>Newest Arrivals</option>
                </select>
                <div class="view-options">
                    <button class="view-btn active"><i class="fas fa-th"></i></button>
                    <button class="view-btn"><i class="fas fa-list"></i></button>
                </div>
            </div>
        </div>

        <div class="products-grid">
            <%
                Connection conn2 = null;
                Statement stmt2 = null;
                ResultSet rs2 = null;
                try {
                    conn2 = DBConnection.getConnection();
                    stmt2 = conn2.createStatement();
                    String sql = "SELECT * FROM Instrument";
                    rs2 = stmt2.executeQuery(sql);

                    while (rs2.next()) {
                        String instrumentID = rs2.getString("InstrumentID");
                        String name = rs2.getString("Name");
                        String description = rs2.getString("Description");
                        String brandID = rs2.getString("BrandID");
                        double price = rs2.getDouble("Price");
                        int quantity = rs2.getInt("Quantity");
                        String imageURL = rs2.getString("ImageURL");

                        String badgeClass = "product-badge";
                        String badgeText = "In Stock";
                        boolean inStock = quantity > 0;

                        if (!inStock) {
                            badgeClass += " out-of-stock";
                            badgeText = "Out of Stock";
                        } else if (quantity < 5) {
                            badgeClass += " low-stock";
                            badgeText = "Low Stock";
                        }

                        double rating = Math.floor(Math.random() * 3) + 3;
                        int ratingCount = (int)(Math.random() * 50) + 10;
            %>
            <div class="product-card" onclick="window.location.href='product-details.jsp?instrumentId=<%= instrumentID %>'">
                <div class="<%= badgeClass %>"><%= badgeText %></div>
                <div class="product-img">
                    <img src="<%= imageURL != null && !imageURL.trim().isEmpty() ? imageURL :
                        "https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?auto=format&fit=crop&w=1740&q=80" %>"
                         alt="<%= name %>" onerror="this.src='https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?auto=format&fit=crop&w=1740&q=80'">
                </div>
                <div class="product-info">
                    <div class="product-category"><%= brandID %></div>
                    <h3 class="product-title"><%= name %></h3>
                    <div class="product-rating">
                        <div class="rating-stars">
                            <% for (int i = 1; i <= 5; i++) {
                                if (i <= rating) { %><i class="fas fa-star"></i><% }
                        else if (i - rating < 1) { %><i class="fas fa-star-half-alt"></i><% }
                        else { %><i class="far fa-star"></i><% }
                        } %>
                        </div>
                        <span class="rating-count">(<%= ratingCount %>)</span>
                    </div>
                    <div class="product-price">
                        <span class="current-price">$<%= String.format("%.2f", price) %></span>
                    </div>
                    <p class="product-desc">
                        <%= description != null && description.length() > 100 ?
                                description.substring(0, 100) + "..." : description %>
                    </p>
                    <div class="product-actions">
                        <form action="order-summary.jsp" method="get" style="display: inline;" onsubmit="event.stopPropagation()">
                            <input type="hidden" name="instrumentId" value="<%= instrumentID %>">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="btn btn-order">
                                <i class="fas fa-bolt"></i> Order Now
                            </button>
                        </form>

                        </a>


                        <!-- ✅ Fixed Add to Cart Form - No Lag Version -->
                        <form action="AddToCartServlet" method="post" style="display:inline; margin:0; flex:1;">
                            <input type="hidden" name="instrumentId" value="<%= instrumentID %>">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="btn btn-cart" <%= !inStock ? "disabled" : "" %> onclick="event.stopPropagation()">
                                <i class="fas fa-shopping-cart"></i> Add to Cart
                            </button>
                        </form>

                    </div>
                </div>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs2 != null) rs2.close();
                        if (stmt2 != null) stmt2.close();
                        if (conn2 != null) conn2.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <div class="pagination-btn active">1</div>
            <div class="pagination-btn">2</div>
            <div class="pagination-btn">3</div>
            <div class="pagination-btn">4</div>
            <div class="pagination-btn">5</div>
            <div class="pagination-btn"><i class="fas fa-chevron-right"></i></div>
        </div>
    </main>
</div>

<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-column">
                <h3>Melody Mart</h3>
                <p>Your premier destination for professional musical instruments and equipment. We provide quality products for musicians of all levels.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            <div class="footer-column">
                <h3>Quick Links</h3>
                <ul class="footer-links">
                    <li><a href="customerlanding.jsp">Home</a></li>
                    <li><a href="shop.jsp">Shop</a></li>
                    <li><a href="categories.jsp">Categories</a></li>
                    <li><a href="brands.jsp">Brands</a></li>
                    <li><a href="about.jsp">About Us</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Customer Service</h3>
                <ul class="footer-links">
                    <li><a href="contact.jsp">Contact Us</a></li>
                    <li><a href="#">Shipping Policy</a></li>
                    <li><a href="#">Returns & Refunds</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Contact Info</h3>
                <ul class="footer-links">
                    <li><a href="#"><i class="fas fa-map-marker-alt"></i> 123 Music Street, Melody City</a></li>
                    <li><a href="#"><i class="fas fa-phone"></i> +1 (555) 123-4567</a></li>
                    <li><a href="#"><i class="fas fa-envelope"></i> support@melodymart.com</a></li>
                </ul>
            </div>
        </div>
        <div class="copyright">
            &copy; 2025 Melody Mart. All rights reserved.
        </div>
    </div>
</footer>

<script>
    // Header scroll effect
    window.addEventListener('scroll', () => {
        const header = document.querySelector('header');
        if (window.scrollY > 50) header.classList.add('scrolled');
        else header.classList.remove('scrolled');
    });

    // View options
    const viewBtns = document.querySelectorAll('.view-btn');
    viewBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            viewBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            const productsGrid = document.querySelector('.products-grid');
            productsGrid.style.gridTemplateColumns =
                btn.querySelector('.fa-list') ? '1fr' : 'repeat(auto-fill, minmax(280px, 1fr))';
        });
    });

    // ✅ FIXED: Simple Add to Cart with NO LAG
    function handleAddToCart(event, button) {
        event.stopPropagation();

        if (button.disabled) return;

        // Show loading state for only 0.3 seconds (very brief)
        const originalHTML = button.innerHTML;
        button.innerHTML = '<div class="loading"></div>';
        button.disabled = true;

        // Very brief loading state, then let form submit normally
        setTimeout(() => {
            button.innerHTML = originalHTML;
            button.disabled = false;
        }, 300);

        // Form will submit normally and page will reload with success message
        // No need to prevent default - let the form submit work naturally
    }

    // Update cart count from session
    function updateCartCount() {
        const cartCount = <%= cartCount %>;
        const cartCountEl = document.querySelector('.cart-count');
        if (cartCount > 0) {
            if (cartCountEl) {
                cartCountEl.textContent = cartCount;
                cartCountEl.style.display = 'flex';
            } else {
                // Create cart count element if it doesn't exist
                const cartIcon = document.querySelector('.cart-icon');
                if (cartIcon) {
                    const countEl = document.createElement('span');
                    countEl.className = 'cart-count';
                    countEl.textContent = cartCount;
                    countEl.style.display = 'flex';
                    cartIcon.appendChild(countEl);
                }
            }
        }
    }

    // Search functionality
    const searchInput = document.querySelector('.search-input');
    const searchBtn = document.querySelector('.search-btn');

    searchBtn.addEventListener('click', performSearch);
    searchInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') performSearch();
    });

    function performSearch() {
        const searchTerm = searchInput.value.trim().toLowerCase();
        if (searchTerm) {
            const productCards = document.querySelectorAll('.product-card');
            productCards.forEach(card => {
                const productName = card.querySelector('.product-title').textContent.toLowerCase();
                const productCategory = card.querySelector('.product-category').textContent.toLowerCase();
                const productDesc = card.querySelector('.product-desc').textContent.toLowerCase();

                if (productName.includes(searchTerm) ||
                    productCategory.includes(searchTerm) ||
                    productDesc.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        } else {
            const productCards = document.querySelectorAll('.product-card');
            productCards.forEach(card => {
                card.style.display = 'block';
            });
        }
    }

    // Product card animations on scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    document.querySelectorAll('.product-card').forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
        observer.observe(card);
    });

    // Auto-hide messages after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        const messages = document.querySelectorAll('.message-success, .message-error, .message-warning');
        messages.forEach(message => {
            setTimeout(() => {
                message.style.opacity = '0';
                message.style.transform = 'translateY(-20px)';
                setTimeout(() => {
                    message.remove();
                }, 500);
            }, 5000);
        });

        // Update cart count on page load
        updateCartCount();
    });
</script>
</body>
</html>