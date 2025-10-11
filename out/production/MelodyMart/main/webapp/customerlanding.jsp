<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
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
        <%
             session = request.getSession(false);
            if (session == null || session.getAttribute("customerID") == null) {
                response.sendRedirect("sign-in.jsp");
                return;
            }
            String username = (String) session.getAttribute("username");
            int customerID = (Integer) session.getAttribute("customerID");
        %>
        <p>Welcome back, <%= username %> (Customer ID: <%= customerID %>)</p>
    </div>

    <!-- Quick Stats -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #10b981, #059669);">
                <i class="fas fa-shopping-bag"></i>
            </div>
            <div class="stat-info">
                <%
                    int totalOrders = 0;
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        conn = DBConnection.getConnection();
                        stmt = conn.createStatement();
                        String sql = "SELECT COUNT(*) as count FROM Cart WHERE CustomerID = " + customerID;
                        rs = stmt.executeQuery(sql);
                        if (rs.next()) {
                            totalOrders = rs.getInt("count");
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
                <div class="stat-value"><%= totalOrders %></div>
                <div class="stat-label">Total Orders</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #3b82f6, #1d4ed8);">
                <i class="fas fa-heart"></i>
            </div>
            <div class="stat-info">
                <%
                    int wishlistItems = 0;
                    Connection conn2 = null;
                    Statement stmt2 = null;
                    ResultSet rs2 = null;

                    try {
                        conn2 = DBConnection.getConnection();
                        stmt2 = conn2.createStatement();
                        String sql = "SELECT COUNT(*) as count FROM Wishlist WHERE CustomerID = " + customerID;
                        rs2 = stmt2.executeQuery(sql);
                        if (rs2.next()) {
                            wishlistItems = rs2.getInt("count");
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
                <div class="stat-value"><%= wishlistItems %></div>
                <div class="stat-label">Wishlist Items</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #f59e0b, #d97706);">
                <i class="fas fa-tools"></i>
            </div>
            <div class="stat-info">
                <%
                    int activeRepairs = 0;
                    Connection conn3 = null;
                    Statement stmt3 = null;
                    ResultSet rs3 = null;

                    try {
                        conn3 = DBConnection.getConnection();
                        stmt3 = conn3.createStatement();
                        String sql = "SELECT COUNT(*) as count FROM RepairRequests WHERE CustomerID = " + customerID + " AND Status = 'Active'";
                        rs3 = stmt3.executeQuery(sql);
                        if (rs3.next()) {
                            activeRepairs = rs3.getInt("count");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs3 != null) rs3.close();
                            if (stmt3 != null) stmt3.close();
                            if (conn3 != null) conn3.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
                <div class="stat-value"><%= activeRepairs %></div>
                <div class="stat-label">Active Repairs</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #ec4899, #db2777);">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-info">
                <%
                    double avgRating = 0.0;
                    int ratingCount = 0;
                    Connection conn4 = null;
                    Statement stmt4 = null;
                    ResultSet rs4 = null;

                    try {
                        conn4 = DBConnection.getConnection();
                        stmt4 = conn4.createStatement();
                        String sql = "SELECT AVG(Rating) as avg_rating, COUNT(*) as count FROM Reviews WHERE CustomerID = " + customerID;
                        rs4 = stmt4.executeQuery(sql);
                        if (rs4.next()) {
                            avgRating = rs4.getDouble("avg_rating");
                            ratingCount = rs4.getInt("count");
                            if (ratingCount == 0) {
                                avgRating = 0.0;
                            } else {
                                avgRating = Math.round(avgRating * 10.0) / 10.0;
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs4 != null) rs4.close();
                            if (stmt4 != null) stmt4.close();
                            if (conn4 != null) conn4.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
                <div class="stat-value"><%= avgRating %>/5.0</div>
                <div class="stat-label">Your Rating (<%= ratingCount %> Reviews)</div>
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
            <div class="card-value"><%= totalOrders %> Orders</div>
            <div class="card-description">Track your orders, view order history, and manage returns or exchanges.</div>
            <div class="card-change">
                <i class="fas fa-clock"></i>
                <span><%= totalOrders > 0 ? "Check status" : "No orders yet" %></span>
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
            <div class="card-value"><%= wishlistItems %> Items</div>
            <div class="card-description">Save your favorite instruments and accessories for future purchases.</div>
            <div class="card-change">
                <i class="fas fa-tag"></i>
                <span><%= wishlistItems > 0 ? "Check wishlist" : "Add items" %></span>
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
            <div class="card-value"><%= activeRepairs %> Active</div>
            <div class="card-description">Track instrument repairs, schedule appointments, and view repair status.</div>
            <div class="card-change">
                <i class="fas fa-exclamation-circle"></i>
                <span><%= activeRepairs > 0 ? "View details" : "No active repairs" %></span>
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
            <div class="card-value"><%= ratingCount %> Reviews</div>
            <div class="card-description">View and manage your product reviews and ratings.</div>
            <div class="card-change">
                <i class="fas fa-edit"></i>
                <span><%= ratingCount > 0 ? "Manage reviews" : "Write your first review" %></span>
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
            <%
                int unreadMessages = 0;
                Connection conn5 = null;
                Statement stmt5 = null;
                ResultSet rs5 = null;

                try {
                    conn5 = DBConnection.getConnection();
                    stmt5 = conn5.createStatement();
                    String sql = "SELECT COUNT(*) as count FROM Messages WHERE CustomerID = " + customerID + " AND IsRead = FALSE";
                    rs5 = stmt5.executeQuery(sql);
                    if (rs5.next()) {
                        unreadMessages = rs5.getInt("count");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs5 != null) rs5.close();
                        if (stmt5 != null) stmt5.close();
                        if (conn5 != null) conn5.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
            <div class="card-value"><%= unreadMessages %> Unread</div>
            <div class="card-description">Communicate with customer support and sellers.</div>
            <div class="card-change">
                <i class="fas fa-bell"></i>
                <span><%= unreadMessages > 0 ? "Check messages" : "No new messages" %></span>
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
            <div class="card-value"><%= username %></div>
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
            <%
                Connection conn6 = null;
                Statement stmt6 = null;
                ResultSet rs6 = null;

                try {
                    conn6 = DBConnection.getConnection();
                    stmt6 = conn6.createStatement();
                    String sql = "SELECT c.InstrumentID, i.Name, c.Quantity, c.AddedDate FROM Cart c JOIN Instrument i ON c.InstrumentID = i.InstrumentID WHERE c.CustomerID = " + customerID + " ORDER BY c.AddedDate DESC LIMIT 3";
                    rs6 = stmt6.executeQuery(sql);

                    while (rs6.next()) {
                        String instrumentID = rs6.getString("InstrumentID");
                        String name = rs6.getString("Name");
                        int quantity = rs6.getInt("Quantity");
                        java.sql.Timestamp addedDate = rs6.getTimestamp("AddedDate");
                        String status = "Processing"; // Default status, adjust based on your logic
                        if (addedDate != null) {
                            java.util.Date currentDate = new java.util.Date();
                            long diffInDays = (currentDate.getTime() - addedDate.getTime()) / (1000 * 60 * 60 * 24);
                            if (diffInDays > 5) status = "Delivered";
                            else if (diffInDays > 2) status = "Shipped";
                        }
                        double price = 0.0; // Fetch price from Instrument table if needed
            %>
            <li class="product-item">
                <div class="product-icon">
                    <i class="fas fa-guitar"></i>
                </div>
                <div class="product-info">
                    <div class="product-name"><%= name %> (x<%= quantity %>)</div>
                    <div class="product-status">Order #MM<%= String.format("%06d", customerID) + String.format("%03d", instrumentID.hashCode() % 1000) %> • <%= status %> • $0.00</div> <!-- Placeholder price -->
                </div>
            </li>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs6 != null) rs6.close();
                        if (stmt6 != null) stmt6.close();
                        if (conn6 != null) conn6.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
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
            &copy; 2025 MelodyMart. All rights reserved.
        </div>
    </footer>
</div>

<script>
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
            window.location.href = 'LogoutServlet'; // Assuming LogoutServlet invalidates session
        }
    }
</script>