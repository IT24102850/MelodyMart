<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<% if(request.getParameter("success") != null) { %>
<div class="alert alert-success">✅ Repair request submitted successfully!</div>
<% } %>

<% if(request.getParameter("error") != null) { %>
<div class="alert alert-danger">❌ Failed to submit repair request.</div>
<% } %>

<% if(request.getParameter("error") != null && request.getParameter("error").equals("db")) { %>
<div class="alert alert-warning">⚠️ Database error occurred. Please try again later.</div>
<% } %>





<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --accent-alt: #ff00c8;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --card-hover: #2a2a2a;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
            --glass-bg: rgba(30, 30, 30, 0.7);
            --glass-border: rgba(255, 255, 255, 0.1);
            --success: #00cc66;
            --warning: #ffaa00;
            --danger: #ff4444;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--secondary);
            color: var(--text);
            overflow-x: hidden;
            line-height: 1.6;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background: var(--card-bg);
            padding: 30px 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 100;
            transition: all 0.3s ease;
            border-right: 1px solid var(--glass-border);
        }

        .sidebar-header {
            padding: 0 25px 30px;
            border-bottom: 1px solid var(--glass-border);
            margin-bottom: 20px;
        }

        .sidebar-logo {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
        }

        .sidebar-logo i {
            margin-right: 10px;
            font-size: 28px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            margin-top: 20px;
            padding: 15px;
            background: var(--glass-bg);
            border-radius: 10px;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 20px;
        }

        .user-info h3 {
            font-size: 16px;
            margin-bottom: 5px;
        }

        .user-info p {
            font-size: 12px;
            color: var(--text-secondary);
        }

        .sidebar-menu {
            list-style: none;
            padding: 0 15px;
        }

        .menu-item {
            margin-bottom: 5px;
        }

        .menu-item a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: var(--text);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .menu-item a:hover, .menu-item a.active {
            background: var(--glass-bg);
            color: var(--primary-light);
        }

        .menu-item a i {
            margin-right: 10px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        .menu-item a .badge {
            margin-left: auto;
            background: var(--primary);
            color: white;
            border-radius: 20px;
            padding: 2px 8px;
            font-size: 12px;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 260px;
            padding: 30px;
            transition: all 0.3s ease;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--glass-border);
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 700;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            background: var(--card-bg);
            border-radius: 30px;
            padding: 8px 15px;
            width: 300px;
        }

        .search-bar input {
            background: transparent;
            border: none;
            color: var(--text);
            width: 100%;
            padding: 5px 10px;
            outline: none;
        }

        .notification-btn, .mobile-menu-btn {
            background: var(--card-bg);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text);
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .notification-btn:hover, .mobile-menu-btn:hover {
            background: var(--primary-light);
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--danger);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .mobile-menu-btn {
            display: none;
        }

        /* Dashboard Cards */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 24px;
        }

        .stat-icon.orders {
            background: linear-gradient(135deg, #ff9a9e, #fad0c4);
        }

        .stat-icon.cart {
            background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
        }

        .stat-icon.wishlist {
            background: linear-gradient(135deg, #ffecd2, #fcb69f);
        }

        .stat-icon.repairs {
            background: linear-gradient(135deg, #84fab0, #8fd3f4);
        }

        .stat-info h3 {
            font-size: 28px;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Content Sections */
        .content-section {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid var(--glass-border);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
        }

        .view-all {
            color: var(--primary-light);
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .view-all:hover {
            color: var(--accent);
        }

        /* Tables */
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th {
            text-align: left;
            padding: 12px 15px;
            border-bottom: 1px solid var(--glass-border);
            color: var(--text-secondary);
            font-weight: 500;
            font-size: 14px;
        }

        .data-table td {
            padding: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-table tr:hover {
            background: rgba(255, 255, 255, 0.03);
        }

        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-pending {
            background: rgba(255, 170, 0, 0.2);
            color: var(--warning);
        }

        .status-processing {
            background: rgba(0, 204, 102, 0.2);
            color: var(--success);
        }

        .status-delivered {
            background: rgba(0, 204, 102, 0.2);
            color: var(--success);
        }

        .status-cancelled {
            background: rgba(255, 68, 68, 0.2);
            color: var(--danger);
        }

        .action-btn {
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            margin-right: 10px;
            transition: color 0.3s ease;
        }

        .action-btn:hover {
            color: var(--primary-light);
        }

        /* Forms */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            background: var(--secondary);
            border: 1px solid var(--glass-border);
            border-radius: 5px;
            color: var(--text);
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 5px rgba(138, 43, 226, 0.5);
        }

        .form-row {
            display: flex;
            gap: 20px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
        }

        .btn-primary:hover {
            background: var(--gradient-alt);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--primary-light);
            color: var(--primary-light);
        }

        .btn-outline:hover {
            background: var(--primary-light);
            color: white;
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background: #ff2222;
            transform: translateY(-2px);
        }

        /* Tabs */
        .tabs {
            display: flex;
            border-bottom: 1px solid var(--glass-border);
            margin-bottom: 20px;
        }

        .tab {
            padding: 12px 20px;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .tab.active {
            border-bottom: 2px solid var(--primary-light);
            color: var(--primary-light);
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 30px;
            max-width: 500px;
            width: 90%;
            position: relative;
            opacity: 0;
            transform: scale(0.8);
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .modal.active .modal-content {
            opacity: 1;
            transform: scale(1);
        }

        .modal-close {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            color: var(--text);
            font-size: 20px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .modal-close:hover {
            color: var(--primary-light);
        }

        .modal-header {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .modal-title {
            font-size: 24px;
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .mobile-menu-btn {
                display: flex;
            }

            .search-bar {
                width: 200px;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
            }

            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .header-actions {
                width: 100%;
                justify-content: space-between;
            }

            .search-bar {
                width: 100%;
                max-width: 300px;
            }

            .stats-cards {
                grid-template-columns: 1fr;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }

        @media (max-width: 576px) {
            .main-content {
                padding: 15px;
            }

            .page-title {
                font-size: 24px;
            }

            .content-section {
                padding: 15px;
            }

            .data-table {
                display: block;
                overflow-x: auto;
            }

            .tabs {
                flex-wrap: wrap;
            }

            .tab {
                flex: 1;
                min-width: 120px;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <i class="fas fa-music"></i>
                Melody Mart
            </div>
            <div class="user-profile">
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="user-info">
                    <h3>Alex Johnson</h3>
                    <p>Premium Member</p>
                </div>
            </div>
        </div>

        <ul class="sidebar-menu">
            <li class="menu-item">
                <a href="#" class="active" data-tab="dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
            </li>
            <li class="menu-item">
                <a href="#" data-tab="profile">
                    <i class="fas fa-user"></i> My Profile
                </a>
            </li>
            <li class="menu-item">
                <a href="#" data-tab="orders">
                    <i class="fas fa-shopping-bag"></i> My Orders <span class="badge">3</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="#" data-tab="cart">
                    <i class="fas fa-shopping-cart"></i> Shopping Cart <span class="badge">2</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="#" data-tab="wishlist">
                    <i class="fas fa-heart"></i> Wishlist <span class="badge">5</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="#" data-tab="payments">
                    <i class="fas fa-credit-card"></i> Payment Methods
                </a>
            </li>
            <li class="menu-item">
                <a href="#" data-tab="deliveries">
                    <i class="fas fa-shipping-fast"></i> Delivery Tracking
                </a>
            </li>
            <li class="menu-item">
                <a href="#" data-tab="repairs">
                    <i class="fas fa-tools"></i> Repair Requests <span class="badge">1</span>
                </a>
            </li>
            <li class="menu-item">
                <a href="#" data-tab="reviews">
                    <i class="fas fa-star"></i> My Reviews
                </a>
            </li>
            <li class="menu-item">
                <a href="#" data-tab="security">
                    <i class="fas fa-shield-alt"></i> Security
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="dashboard-header">
            <h1 class="page-title">Customer Dashboard</h1>
            <div class="header-actions">
                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search dashboard...">
                </div>
                <button class="notification-btn">
                    <i class="fas fa-bell"></i>
                    <span class="notification-badge">3</span>
                </button>
                <button class="mobile-menu-btn">
                    <i class="fas fa-bars"></i>
                </button>
            </div>
        </div>

        <!-- Dashboard Overview -->
        <div class="tab-content active" id="dashboard">
            <div class="stats-cards">
                <div class="stat-card">
                    <div class="stat-icon orders">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <div class="stat-info">
                        <h3>12</h3>
                        <p>Total Orders</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon cart">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stat-info">
                        <h3>2</h3>
                        <p>Items in Cart</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon wishlist">
                        <i class="fas fa-heart"></i>
                    </div>
                    <div class="stat-info">
                        <h3>5</h3>
                        <p>Wishlisted Items</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon repairs">
                        <i class="fas fa-tools"></i>
                    </div>
                    <div class="stat-info">
                        <h3>1</h3>
                        <p>Active Repairs</p>
                    </div>
                </div>
            </div>

            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Recent Orders</h2>
                    <a href="#" class="view-all">View All</a>
                </div>
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Date</th>
                        <th>Items</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>#MM-7892</td>
                        <td>15 Mar 2025</td>
                        <td>Electric Guitar</td>
                        <td>$1,299.99</td>
                        <td><span class="status-badge status-delivered">Delivered</span></td>
                        <td>
                            <button class="action-btn" title="View Details"><i class="fas fa-eye"></i></button>
                            <button class="action-btn" title="Track Order"><i class="fas fa-shipping-fast"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>#MM-7854</td>
                        <td>10 Mar 2025</td>
                        <td>Drum Set, Sticks</td>
                        <td>$2,599.99</td>
                        <td><span class="status-badge status-processing">Processing</span></td>
                        <td>
                            <button class="action-btn" title="View Details"><i class="fas fa-eye"></i></button>
                            <button class="action-btn" title="Track Order"><i class="fas fa-shipping-fast"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>#MM-7821</td>
                        <td>05 Mar 2025</td>
                        <td>Microphone, Stand</td>
                        <td>$349.99</td>
                        <td><span class="status-badge status-pending">Pending</span></td>
                        <td>
                            <button class="action-btn" title="View Details"><i class="fas fa-eye"></i></button>
                            <button class="action-btn" title="Cancel Order"><i class="fas fa-times"></i></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Active Repair Requests</h2>
                    <a href="#" class="view-all">View All</a>
                </div>
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Request ID</th>
                        <th>Instrument</th>
                        <th>Issue</th>
                        <th>Submitted</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>#RR-4521</td>
                        <td>Fender Stratocaster</td>
                        <td>Fret buzz on high E string</td>
                        <td>12 Mar 2025</td>
                        <td><span class="status-badge status-processing">In Progress</span></td>
                        <td>
                            <button class="action-btn" title="View Details"><i class="fas fa-eye"></i></button>
                            <button class="action-btn" title="Update Request"><i class="fas fa-edit"></i></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Profile Management -->
        <div class="tab-content" id="profile">
            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">My Profile</h2>
                </div>
                <form id="profileForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">First Name</label>
                            <input type="text" class="form-control" value="Alex">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" value="Johnson">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" value="alex.johnson@example.com">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Phone</label>
                        <input type="tel" class="form-control" value="+1 (555) 123-4567">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Address</label>
                        <textarea class="form-control" rows="3">123 Music Street, Nashville, TN 37203, USA</textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                </form>
            </div>
        </div>

        <!-- Orders Management -->
        <div class="tab-content" id="orders">
            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Order History</h2>
                </div>
                <div class="tabs">
                    <div class="tab active" data-order-tab="all">All Orders</div>
                    <div class="tab" data-order-tab="pending">Pending</div>
                    <div class="tab" data-order-tab="delivered">Delivered</div>
                    <div class="tab" data-order-tab="cancelled">Cancelled</div>
                </div>

                <div class="tab-content active" id="all-orders">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Items</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>#MM-7892</td>
                            <td>15 Mar 2025</td>
                            <td>Electric Guitar</td>
                            <td>$1,299.99</td>
                            <td><span class="status-badge status-delivered">Delivered</span></td>
                            <td>
                                <button class="action-btn" title="View Details"><i class="fas fa-eye"></i></button>
                                <button class="action-btn" title="Reorder"><i class="fas fa-redo"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>#MM-7854</td>
                            <td>10 Mar 2025</td>
                            <td>Drum Set, Sticks</td>
                            <td>$2,599.99</td>
                            <td><span class="status-badge status-processing">Processing</span></td>
                            <td>
                                <button class="action-btn" title="View Details"><i class="fas fa-eye"></i></button>
                                <button class="action-btn" title="Track Order"><i class="fas fa-shipping-fast"></i></button>
                                <button class="action-btn" title="Cancel Order"><i class="fas fa-times"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>#MM-7821</td>
                            <td>05 Mar 2025</td>
                            <td>Microphone, Stand</td>
                            <td>$349.99</td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                            <td>
                                <button class="action-btn" title="View Details"><i class="fas fa-eye"></i></button>
                                <button class="action-btn" title="Cancel Order"><i class="fas fa-times"></i></button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Shopping Cart -->
        <div class="tab-content" id="cart">
            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Shopping Cart</h2>
                </div>
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center;">
                                <div style="width: 60px; height: 60px; background: var(--glass-bg); border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 15px;">
                                    <i class="fas fa-guitar" style="font-size: 24px; color: var(--primary-light);"></i>
                                </div>
                                <div>
                                    <div style="font-weight: 600;">Professional Electric Guitar</div>
                                    <div style="font-size: 12px; color: var(--text-secondary);">Model: Fender Stratocaster</div>
                                </div>
                            </div>
                        </td>
                        <td>$1,299.99</td>
                        <td>
                            <div style="display: flex; align-items: center;">
                                <button class="action-btn"><i class="fas fa-minus"></i></button>
                                <span style="margin: 0 10px;">1</span>
                                <button class="action-btn"><i class="fas fa-plus"></i></button>
                            </div>
                        </td>
                        <td>$1,299.99</td>
                        <td>
                            <button class="action-btn" title="Remove"><i class="fas fa-trash"></i></button>
                            <button class="action-btn" title="Move to Wishlist"><i class="fas fa-heart"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center;">
                                <div style="width: 60px; height: 60px; background: var(--glass-bg); border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 15px;">
                                    <i class="fas fa-drum" style="font-size: 24px; color: var(--primary-light);"></i>
                                </div>
                                <div>
                                    <div style="font-weight: 600;">Premium Drum Sticks</div>
                                    <div style="font-size: 12px; color: var(--text-secondary);">Pair - 5A Wood Tip</div>
                                </div>
                            </div>
                        </td>
                        <td>$24.99</td>
                        <td>
                            <div style="display: flex; align-items: center;">
                                <button class="action-btn"><i class="fas fa-minus"></i></button>
                                <span style="margin: 0 10px;">2</span>
                                <button class="action-btn"><i class="fas fa-plus"></i></button>
                            </div>
                        </td>
                        <td>$49.98</td>
                        <td>
                            <button class="action-btn" title="Remove"><i class="fas fa-trash"></i></button>
                            <button class="action-btn" title="Move to Wishlist"><i class="fas fa-heart"></i></button>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--glass-border);">
                    <div>
                        <div style="font-size: 18px; font-weight: 600;">Total: $1,349.97</div>
                        <div style="font-size: 12px; color: var(--text-secondary);">Shipping calculated at checkout</div>
                    </div>
                    <button class="btn btn-primary">Proceed to Checkout</button>
                </div>
            </div>
        </div>

        <!-- Continue with other tab contents for Wishlist, Payments, Deliveries, Repairs, Reviews, Security -->


        <%@ page import="java.sql.Connection" %>
        <%@ page import="java.sql.PreparedStatement" %>
        <%@ page import="java.sql.ResultSet" %>
        <%@ page import="main.java.com.melodymart.util.DBConnection" %>

        <!-- Submit New Repair Request -->
        <form id="repairRequestForm" method="post" action="${pageContext.request.contextPath}/SubmitRepairRequestServlet" enctype="multipart/form-data" style="background: var(--card-bg); border: 1px solid var(--glass-border); padding: 20px; border-radius: 15px;">
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Order ID</label>
                    <input type="text" class="form-control" name="orderId" placeholder="e.g., MM-7892" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Issue Description</label>
                    <input type="text" class="form-control" name="issueDescription" placeholder="e.g., Fret buzz on high E string" required>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Upload Photos</label>
                <input type="file" class="form-control-file" name="photos" multiple accept="image/*" id="photoUpload">
                <div id="previewContainer" class="mt-2 d-flex flex-wrap"></div>
            </div>
            <div class="form-group">
                <label class="form-label">Select Repair Date</label>
                <input type="text" class="form-control" id="repairDatePicker" name="repairDate" placeholder="Choose a date" required>
            </div>
            <button type="submit" class="btn btn-primary">Submit Request</button>
        </form>

        <!-- Repair Requests Table -->
        <div class="content-section mt-4">
            <h4>Repair Requests</h4>
            <table class="data-table">
                <thead>
                <tr>
                    <th>Request ID</th>
                    <th>Order ID</th>
                    <th>Description</th>
                    <th>Photos</th>
                    <th>Status</th>
                    <th>Approved</th>
                    <th>Comment</th>
                    <th>Estimated Cost</th>
                    <th>Repair Date</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        conn = DBConnection.getConnection();
                        String sql = "SELECT RepairRequestID, OrderID, IssueDescription, Photos, Status, Approved, Comment, EstimatedCost, RepairDate FROM RepairRequest";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            String status = rs.getString("Status");
                            boolean canDelete = !status.equalsIgnoreCase("In Progress") && !status.equalsIgnoreCase("Completed");
                %>
                <tr>
                    <td>#RR-<%= rs.getInt("RepairRequestID") %></td>
                    <td>#MM-<%= rs.getInt("OrderID") %></td>
                    <td><%= rs.getString("IssueDescription") %></td>
                    <td>
                        <%
                            String photo = rs.getString("Photos");
                            if (photo != null && !photo.isEmpty()) {
                                String[] photos = photo.split(";");
                                for (String photoPath : photos) {
                        %>
                        <img src="<%= photoPath.replace("\\", "/") %>" class="img-thumbnail m-1"
                             style="width:80px; height:80px; object-fit:cover;" alt="Repair Photo">
                        <%
                            }
                        } else {
                        %>
                        <span class="text-muted">No Photo</span>
                        <%
                            }
                        %>
                    </td>
                    <td><span class="status-badge status-<%= status.toLowerCase().replace(" ", "-") %>"><%= status %></span></td>
                    <td><%= rs.getBoolean("Approved") ? "Yes" : "No" %></td>
                    <td><%= rs.getString("Comment") != null ? rs.getString("Comment") : "-" %></td>
                    <td>$<%= rs.getBigDecimal("EstimatedCost") != null ? rs.getBigDecimal("EstimatedCost") : "0.00" %></td>
                    <td><%= rs.getDate("RepairDate") %></td>
                    <td>
                        <button class="action-btn" title="Update Request" onclick="openUpdateModal(<%= rs.getInt("RepairRequestID") %>, '<%= rs.getString("IssueDescription").replace("'", "\\'") %>', '<%= rs.getString("Comment") != null ? rs.getString("Comment").replace("'", "\\'") : "" %>', '<%= rs.getDate("RepairDate") %>')"><i class="fas fa-edit"></i></button>
                        <% if (canDelete) { %>
                        <button class="action-btn" title="Delete Request" onclick="deleteRepairRequest(<%= rs.getInt("RepairRequestID") %>)"><i class="fas fa-trash"></i></button>
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='10' style='color: var(--danger);'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                        if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Update Repair Request Modal -->
        <div class="modal" id="updateRepairModal">
            <div class="modal-content">
                <button class="modal-close">&times;</button>
                <div class="modal-header">
                    <h2 class="modal-title">Update Repair Request</h2>
                </div>
                <form id="updateRepairForm" method="post" action="${pageContext.request.contextPath}/UpdateRepairRequestServlet" enctype="multipart/form-data">
                    <input type="hidden" name="repairRequestId" id="updateRepairRequestId">
                    <div class="form-group">
                        <label class="form-label">Issue Description</label>
                        <input type="text" class="form-control" name="issueDescription" id="updateIssueDescription" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Additional Comments</label>
                        <textarea class="form-control" name="additionalComment" id="updateComment" rows="4" placeholder="Add or update comments..."></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Upload Additional Photos</label>
                        <input type="file" class="form-control-file" name="additionalPhotos" multiple accept="image/*" id="updatePhotoUpload">
                        <div id="updatePreviewContainer" class="mt-2 d-flex flex-wrap"></div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Select Repair Date</label>
                        <input type="text" class="form-control" id="updateRepairDatePicker" name="repairDate" placeholder="Choose a date" required>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Update Request</button>
                </form>
            </div>
        </div>

        <!-- Scripts -->
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script>
            // Initialize datepickers
            $(function() {
                $("#repairDatePicker, #updateRepairDatePicker").datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: 0,
                    showAnim: "fadeIn"
                });
            });

            // Image preview for both forms
            function setupPreview(inputId, previewId) {
                document.getElementById(inputId).addEventListener("change", function(event) {
                    const previewContainer = document.getElementById(previewId);
                    previewContainer.innerHTML = "";
                    Array.from(event.target.files).forEach(file => {
                        if (file.type.startsWith("image/")) {
                            const reader = new FileReader();
                            reader.onload = function(e) {
                                const img = document.createElement("img");
                                img.src = e.target.result;
                                img.className = "m-1 border rounded";
                                img.style.width = "100px";
                                img.style.height = "100px";
                                img.style.objectFit = "cover";
                                previewContainer.appendChild(img);
                            };
                            reader.readAsDataURL(file);
                        }
                    });
                });
            }
            setupPreview("photoUpload", "previewContainer");
            setupPreview("updatePhotoUpload", "updatePreviewContainer");

            // Open update modal with pre-filled data
            function openUpdateModal(repairRequestId, issueDescription, comment, repairDate) {
                document.getElementById("updateRepairRequestId").value = repairRequestId;
                document.getElementById("updateIssueDescription").value = issueDescription;
                document.getElementById("updateComment").value = comment;
                document.getElementById("updateRepairDatePicker").value = repairDate;
                document.getElementById("updatePreviewContainer").innerHTML = "";
                document.getElementById("updatePhotoUpload").value = "";
                document.getElementById("updateRepairModal").style.display = "flex";
                setTimeout(() => {
                    document.getElementById("updateRepairModal").classList.add("active");
                }, 10);
            }

            // Delete repair request
            function deleteRepairRequest(repairRequestId) {
                if (confirm("Are you sure you want to delete this repair request? This action cannot be undone.")) {
                    const form = document.createElement("form");
                    form.method = "POST";
                    form.action = "${pageContext.request.contextPath}/DeleteRepairRequestServlet";
                    const input = document.createElement("input");
                    input.type = "hidden";
                    input.name = "repairRequestId";
                    input.value = repairRequestId;
                    form.appendChild(input);
                    document.body.appendChild(form);
                    form.submit();
                }
            }
        </script>







    </div>



    <!-- This would follow the same pattern as above sections -->

</div>
</div>

<!-- Modals for various actions -->
<div class="modal" id="editProfileModal">
    <div class="modal-content">
        <button class="modal-close">&times;</button>
        <div class="modal-header">
            <h2 class="modal-title">Edit Profile</h2>
        </div>
        <form>
            <!-- Form content would go here -->
            <div class="form-group">
                <button type="submit" class="btn btn-primary" style="width: 100%;">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Tab navigation
    document.querySelectorAll('.sidebar-menu a').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();

            // Remove active class from all links
            document.querySelectorAll('.sidebar-menu a').forEach(item => {
                item.classList.remove('active');
            });

            // Add active class to clicked link
            this.classList.add('active');

            // Hide all tab contents
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });

            // Show selected tab content
            const tabId = this.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Order tabs
    document.querySelectorAll('[data-order-tab]').forEach(tab => {
        tab.addEventListener('click', function() {
            document.querySelectorAll('[data-order-tab]').forEach(t => {
                t.classList.remove('active');
            });
            this.classList.add('active');

            // Logic to filter orders would go here
        });
    });

    // Mobile menu toggle
    document.querySelector('.mobile-menu-btn').addEventListener('click', function() {
        document.querySelector('.sidebar').classList.toggle('active');
    });

    // Modal handling
    function openModal(modalId) {
        document.getElementById(modalId).style.display = 'flex';
        setTimeout(() => {
            document.getElementById(modalId).classList.add('active');
        }, 10);
    }

    function closeModal(modalId) {
        document.getElementById(modalId).classList.remove('active');
        setTimeout(() => {
            document.getElementById(modalId).style.display = 'none';
        }, 300);
    }

    // Close modal when clicking outside content
    window.addEventListener('click', function(e) {
        document.querySelectorAll('.modal').forEach(modal => {
            if (e.target === modal) {
                closeModal(modal.id);
            }
        });
    });

    // Close modals with close buttons
    document.querySelectorAll('.modal-close').forEach(button => {
        button.addEventListener('click', function() {
            const modal = this.closest('.modal');
            closeModal(modal.id);
        });
    });
</script>
</body>
</html>