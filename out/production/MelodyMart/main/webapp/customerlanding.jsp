<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    // Assume you have a login process that validated the user and got their CustomerID
    String customerId = (String) request.getAttribute("CustomerID");

    // If it's passed from login servlet or JSP
    if (customerId == null && request.getParameter("CustomerID") != null) {
        customerId = request.getParameter("CustomerID");
    }

    if (customerId != null) {
        session.setAttribute("CustomerID", customerId); // ✅ Store in session
        System.out.println("Customer Logged In: " + customerId);
    } else {
        System.out.println("⚠ No CustomerID found during login.");
    }
%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Customer Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f0f9ff 0%, #e1f5fe 100%);
            color: #333;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Navigation Bar Styles */
        .navbar {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 0 20px;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            height: 70px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 24px;
            font-weight: 700;
            color: #1e40af;
            text-decoration: none;
        }

        .logo i {
            font-size: 28px;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 30px;
        }

        .nav-links a {
            color: #475569;
            text-decoration: none;
            font-weight: 500;
            padding: 10px 15px;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-links a:hover {
            background: #f1f5f9;
            color: #1e40af;
        }

        .nav-links a.active {
            background: #1e40af;
            color: white;
        }

        .nav-links a i {
            font-size: 16px;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logout-btn {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            background: linear-gradient(135deg, #dc2626, #b91c1c);
        }

        .user-profile {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3b82f6, #1e40af);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Dashboard Header */
        .dashboard-header {
            text-align: center;
            margin: 40px 0;
            padding: 0 20px;
        }

        .dashboard-header h1 {
            font-size: 36px;
            color: #1e40af;
            margin-bottom: 10px;
        }

        .dashboard-header p {
            font-size: 18px;
            color: #64748b;
        }

        /* Section Headers */
        .section-header {
            font-size: 24px;
            color: #1e40af;
            margin: 40px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
        }

        /* Cards Grid */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            background: #f8fafc;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #475569;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 22px;
        }

        .orders .card-icon {
            background: linear-gradient(135deg, #10b981, #059669);
        }

        .wishlist .card-icon {
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
        }

        .repairs .card-icon {
            background: linear-gradient(135deg, #f59e0b, #d97706);
        }

        .reviews .card-icon {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
        }

        .messages .card-icon {
            background: linear-gradient(135deg, #ec4899, #db2777);
        }

        .profile .card-icon {
            background: linear-gradient(135deg, #06b6d4, #0891b2);
        }

        .notifications .card-icon {
            background: linear-gradient(135deg, #84cc16, #65a30d);
        }

        .settings .card-icon {
            background: linear-gradient(135deg, #f97316, #ea580c);
        }

        .card-value {
            font-size: 32px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 10px;
        }

        .card-description {
            font-size: 14px;
            color: #64748b;
            line-height: 1.5;
        }

        .card-change {
            font-size: 14px;
            color: #10b981;
            display: flex;
            align-items: center;
            gap: 5px;
            margin-top: 10px;
        }

        .card-change.negative {
            color: #ef4444;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
        }

        .stat-info {
            flex: 1;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
            color: #1e293b;
        }

        .stat-label {
            font-size: 14px;
            color: #64748b;
        }

        /* Products List */
        .products-list {
            list-style: none;
            margin-top: 15px;
        }

        .product-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .product-item:last-child {
            border-bottom: none;
        }

        .product-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: #e0f2fe;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: #0369a1;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-weight: 500;
            margin-bottom: 4px;
        }

        .product-status {
            font-size: 14px;
            color: #64748b;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 30px 0;
            color: #64748b;
            border-top: 1px solid #e2e8f0;
            margin-top: 30px;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin: 20px 0;
        }

        .footer-links a {
            color: #475569;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: #1e40af;
        }

        .copyright {
            font-size: 14px;
        }

        /* Mobile Navigation */
        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            font-size: 24px;
            color: #1e40af;
            cursor: pointer;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .cards-grid, .stats-grid {
                grid-template-columns: 1fr;
            }

            .footer-links {
                flex-direction: column;
                gap: 10px;
            }

            .nav-links {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: white;
                flex-direction: column;
                padding: 20px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                gap: 10px;
            }

            .nav-links.active {
                display: flex;
            }

            .nav-links a {
                padding: 15px;
                border-radius: 8px;
            }

            .mobile-menu-btn {
                display: block;
            }

            .logout-btn span {
                display: none;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="nav-container">
        <a href="customerlanding.jsp" class="logo">
            <i class="fas fa-music"></i>
            <span>MelodyMart</span>
        </a>

        <button class="mobile-menu-btn" id="mobileMenuBtn">
            <i class="fas fa-bars"></i>
        </button>

        <ul class="nav-links" id="navLinks">
            <li><a href="customerlanding.jsp" class="active"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="shop.jsp"><i class="fas fa-shopping-cart"></i> Shop</a></li>
            <li><a href="orders.jsp"><i class="fas fa-shopping-bag"></i> Orders</a></li>
            <li><a href="wishlist.jsp"><i class="fas fa-heart"></i> Wishlist</a></li>
            <li><a href="repair.jsp"><i class="fas fa-tools"></i> Repairs</a></li>
            <li><a href="profile.jsp"><i class="fas fa-user"></i> Profile</a></li>
        </ul>

        <div class="nav-actions">
            <button class="logout-btn" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </button>
            <div class="user-profile">
                <i class="fas fa-user"></i>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h1>Customer Dashboard</h1>
        <p>Welcome back, Alex Johnson</p>
    </div>

    <!-- Quick Stats -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #10b981, #059669);">
                <i class="fas fa-shopping-bag"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value">12</div>
                <div class="stat-label">Total Orders</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #3b82f6, #1d4ed8);">
                <i class="fas fa-heart"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value">8</div>
                <div class="stat-label">Wishlist Items</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #f59e0b, #d97706);">
                <i class="fas fa-tools"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value">3</div>
                <div class="stat-label">Active Repairs</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #ec4899, #db2777);">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value">4.8/5.0</div>
                <div class="stat-label">Your Rating</div>
            </div>
        </div>
    </div>

    <!-- Main Navigation Cards -->
    <h2 class="section-header">My Account</h2>
    <div class="cards-grid">
        <!-- Orders Card -->
        <a href="orders.jsp" class="card orders">
            <div class="card-header">
                <div class="card-title">My Orders</div>
                <div class="card-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
            </div>
            <div class="card-value">12 Orders</div>
            <div class="card-description">Track your orders, view order history, and manage returns or exchanges.</div>
            <div class="card-change">
                <i class="fas fa-clock"></i>
                <span>2 orders in transit</span>
            </div>
        </a>

        <!-- Wishlist Card -->
        <a href="wishlist.jsp" class="card wishlist">
            <div class="card-header">
                <div class="card-title">My Wishlist</div>
                <div class="card-icon">
                    <i class="fas fa-heart"></i>
                </div>
            </div>
            <div class="card-value">8 Items</div>
            <div class="card-description">Save your favorite instruments and accessories for future purchases.</div>
            <div class="card-change">
                <i class="fas fa-tag"></i>
                <span>3 items on sale</span>
            </div>
        </a>

        <!-- Repair Requests Card -->
        <a href="repairs.jsp" class="card repairs">
            <div class="card-header">
                <div class="card-title">Repair Requests</div>
                <div class="card-icon">
                    <i class="fas fa-tools"></i>
                </div>
            </div>
            <div class="card-value">3 Active</div>
            <div class="card-description">Track instrument repairs, schedule appointments, and view repair status.</div>
            <div class="card-change">
                <i class="fas fa-exclamation-circle"></i>
                <span>1 repair in progress</span>
            </div>
        </a>

        <!-- Reviews Card -->
        <a href="reviews.jsp" class="card reviews">
            <div class="card-header">
                <div class="card-title">My Reviews</div>
                <div class="card-icon">
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <div class="card-value">7 Reviews</div>
            <div class="card-description">View and manage your product reviews and ratings.</div>
            <div class="card-change">
                <i class="fas fa-edit"></i>
                <span>Write new reviews</span>
            </div>
        </a>

        <!-- Messages Card -->
        <a href="messages.jsp" class="card messages">
            <div class="card-header">
                <div class="card-title">Messages</div>
                <div class="card-icon">
                    <i class="fas fa-envelope"></i>
                </div>
            </div>
            <div class="card-value">5 Unread</div>
            <div class="card-description">Communicate with customer support and sellers.</div>
            <div class="card-change">
                <i class="fas fa-bell"></i>
                <span>2 new messages</span>
            </div>
        </a>

        <!-- Profile Card -->
        <a href="profile.jsp" class="card profile">
            <div class="card-header">
                <div class="card-title">Profile</div>
                <div class="card-icon">
                    <i class="fas fa-user"></i>
                </div>
            </div>
            <div class="card-value">Alex Johnson</div>
            <div class="card-description">Update your account information, change password, and manage preferences.</div>
            <div class="card-change">
                <i class="fas fa-cog"></i>
                <span>Update settings</span>
            </div>
        </a>
    </div>

    <!-- Recent Orders Section -->
    <h2 class="section-header">Recent Orders</h2>
    <div class="card">
        <div class="card-header">
            <div class="card-title">Latest Purchases</div>
            <div class="card-icon" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);">
                <i class="fas fa-shopping-bag"></i>
            </div>
        </div>
        <ul class="products-list">
            <li class="product-item">
                <div class="product-icon">
                    <i class="fas fa-guitar"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Professional Electric Guitar</div>
                    <div class="product-status">Order #MM2025001 • Delivered • $1,299.99</div>
                </div>
            </li>
            <li class="product-item">
                <div class="product-icon">
                    <i class="fas fa-headphones"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Studio Headphones</div>
                    <div class="product-status">Order #MM2025002 • Shipped • $249.99</div>
                </div>
            </li>
            <li class="product-item">
                <div class="product-icon">
                    <i class="fas fa-music"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Guitar Strings Set</div>
                    <div class="product-status">Order #MM2025003 • Processing • $29.99</div>
                </div>
            </li>
        </ul>
    </div>

    <!-- Recommended Products Section -->
    <h2 class="section-header">Recommended For You</h2>
    <div class="cards-grid">
        <!-- Guitar Accessories Card -->
        <a href="shop.jsp?category=guitar-accessories" class="card notifications">
            <div class="card-header">
                <div class="card-title">Guitar Accessories</div>
                <div class="card-icon">
                    <i class="fas fa-guitar"></i>
                </div>
            </div>
            <div class="card-value">Based on your purchase</div>
            <div class="card-description">Amplifiers, pedals, cases, and more for your electric guitar.</div>
            <div class="card-change">
                <i class="fas fa-arrow-right"></i>
                <span>Explore accessories</span>
            </div>
        </a>

        <!-- Sheet Music Card -->
        <a href="shop.jsp?category=sheet-music" class="card settings">
            <div class="card-header">
                <div class="card-title">Sheet Music</div>
                <div class="card-icon">
                    <i class="fas fa-music"></i>
                </div>
            </div>
            <div class="card-value">New Arrivals</div>
            <div class="card-description">Find the perfect sheet music for your favorite songs and genres.</div>
            <div class="card-change">
                <i class="fas fa-arrow-right"></i>
                <span>Browse collection</span>
            </div>
        </a>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-links">
            <a href="#"><i class="fas fa-phone-alt"></i> Customer Support</a>
            <a href="#"><i class="fas fa-file-contract"></i> Terms of Service</a>
            <a href="#"><i class="fas fa-shield-alt"></i> Privacy Policy</a>
        </div>
        <div class="copyright">
            &copy; 2023 MelodyMart. All rights reserved.
        </div>
    </footer>
</div>

<script>

    session.setAttribute("CustomerID", resultSet.getString("CustomerID"));
    response.sendRedirect("shop.jsp");

    // Mobile menu functionality
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const navLinks = document.getElementById('navLinks');

    mobileMenuBtn.addEventListener('click', () => {
        navLinks.classList.toggle('active');
    });

    // Close mobile menu when clicking outside
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.nav-container')) {
            navLinks.classList.remove('active');
        }
    });

    // Simple animation for cards on page load
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.card');

        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';

            setTimeout(() => {
                card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });

    // Logout function
    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            // Redirect to login page or perform logout action
            window.location.href = 'index.jsp';
        }
    }
</script>
</body>
</html>