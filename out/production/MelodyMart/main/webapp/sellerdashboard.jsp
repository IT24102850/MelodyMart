<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard - Melody Mart</title>
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
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.85)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-attachment: fixed;
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
            width: 280px;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-right: 1px solid var(--glass-border);
            padding: 30px 0;
            position: fixed;
            height: 100vh;
            z-index: 100;
            transition: all 0.3s ease;
            overflow-y: auto;
        }

        .sidebar.collapsed {
            transform: translateX(-100%);
        }

        .logo-container {
            padding: 0 30px 30px;
            border-bottom: 1px solid var(--glass-border);
            margin-bottom: 30px;
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
        }

        .logo i {
            margin-right: 10px;
            font-size: 28px;
        }

        .nav-links {
            list-style: none;
            padding: 0 20px;
        }

        .nav-item {
            margin-bottom: 10px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: var(--text);
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--gradient);
            color: white;
        }

        .nav-link i {
            margin-right: 15px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        .nav-link .badge {
            position: absolute;
            right: 20px;
            background: var(--accent);
            color: var(--secondary);
            font-size: 12px;
            font-weight: 600;
            padding: 2px 8px;
            border-radius: 20px;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 30px;
            transition: margin-left 0.3s ease;
        }

        .main-content.expanded {
            margin-left: 0;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--glass-border);
        }

        .toggle-sidebar {
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            color: var(--text);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .toggle-sidebar:hover {
            background: var(--gradient);
            transform: rotate(180deg);
        }

        .user-menu {
            display: flex;
            align-items: center;
        }

        .user-info {
            margin-right: 15px;
            text-align: right;
        }

        .user-name {
            font-weight: 600;
            font-size: 16px;
        }

        .user-role {
            font-size: 12px;
            color: var(--text-secondary);
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            cursor: pointer;
            position: relative;
        }

        /* Dashboard Cards */
        .welcome-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .welcome-card h1 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            margin-bottom: 15px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 25px;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 20px;
        }

        .stat-info h3 {
            font-size: 14px;
            color: var(--text-secondary);
            margin-bottom: 5px;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
        }

        .stat-change {
            font-size: 12px;
            margin-top: 5px;
        }

        .positive {
            color: #00ff8c;
        }

        .negative {
            color: #ff3860;
        }

        /* Content Cards */
        .content-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 700;
        }

        .card-actions button {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .card-actions button:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
        }

        /* Forms */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-secondary);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            background: var(--secondary);
            border: 1px solid var(--glass-border);
            border-radius: 8px;
            color: var(--text);
            font-family: 'Montserrat', sans-serif;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.3);
        }

        /* Buttons */
        .btn {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            border: none;
            font-family: 'Montserrat', sans-serif;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn-primary:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background: var(--gradient-alt);
            transition: all 0.4s ease;
            z-index: -1;
        }

        .btn-primary:hover:before {
            width: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--primary-light);
            color: var(--text);
        }

        .btn-outline:hover {
            background: var(--primary-light);
            color: white;
        }

        .btn-danger {
            background: #ff3860;
            color: white;
        }

        .btn-danger:hover {
            background: #ff2b56;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 56, 96, 0.4);
        }

        /* Tables */
        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--glass-border);
        }

        thead th {
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: rgba(138, 43, 226, 0.1);
        }

        .status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-processing {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }

        .status-shipped {
            background: rgba(0, 230, 118, 0.2);
            color: #00e676;
        }

        .status-pending {
            background: rgba(255, 152, 0, 0.2);
            color: #ff9800;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .edit-btn {
            background: rgba(138, 43, 226, 0.2);
            color: var(--primary-light);
        }

        .edit-btn:hover {
            background: var(--primary-light);
            color: white;
        }

        .delete-btn {
            background: rgba(255, 56, 96, 0.2);
            color: #ff3860;
        }

        .delete-btn:hover {
            background: #ff3860;
            color: white;
        }

        /* Floating elements */
        .floating-elements {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 99;
        }

        .floating-btn {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--gradient);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            box-shadow: 0 5px 20px rgba(138, 43, 226, 0.4);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .floating-btn:hover {
            transform: translateY(-5px) rotate(90deg);
            box-shadow: 0 10px 25px rgba(138, 43, 226, 0.6);
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-in {
            animation: fadeIn 0.6s ease forwards;
        }

        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                width: 230px;
            }
            .main-content {
                margin-left: 230px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.collapsed {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <div id="sidebar" class="sidebar">
        <div class="logo-container">
            <div class="logo">
                <i class="fas fa-music"></i>
                Melody Mart
            </div>
        </div>

        <ul class="nav-links">
            <li class="nav-item">
                <a href="#" class="nav-link active">
                    <i class="fas fa-th-large"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a href="#inventory" class="nav-link">
                    <i class="fas fa-box"></i>
                    Inventory
                    <span class="badge">5</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#orders" class="nav-link">
                    <i class="fas fa-shopping-cart"></i>
                    Orders
                    <span class="badge">3</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#inquiries" class="nav-link">
                    <i class="fas fa-question-circle"></i>
                    Inquiries
                    <span class="badge">2</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#analytics" class="nav-link">
                    <i class="fas fa-chart-line"></i>
                    Analytics
                </a>
            </li>
            <li class="nav-item">
                <a href="#profile" class="nav-link">
                    <i class="fas fa-user"></i>
                    Profile
                </a>
            </li>
            <li class="nav-item">
                <a href="logout.jsp" class="nav-link">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div id="main-content" class="main-content">
        <div class="header">
            <button id="toggle-sidebar" class="toggle-sidebar">
                <i class="fas fa-bars"></i>
            </button>

            <div class="user-menu">
                <div class="user-info">
                    <div class="user-name"><% out.print(session.getAttribute("sellerName") != null ? session.getAttribute("sellerName") : "Seller"); %></div>
                    <div class="user-role">Premium Seller</div>
                </div>
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
            </div>
        </div>

        <!-- Welcome Card -->
        <div class="welcome-card animate-in">
            <h1>Welcome, <% out.print(session.getAttribute("sellerName") != null ? session.getAttribute("sellerName") : "Seller"); %>!</h1>
            <p>Manage your inventory, track orders, and respond to customers with ease. Your dashboard is updated with the latest metrics.</p>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card animate-in delay-1">
                <div class="stat-icon">
                    <i class="fas fa-box"></i>
                </div>
                <div class="stat-info">
                    <h3>Total Products</h3>
                    <div class="stat-value">27</div>
                    <div class="stat-change positive">+4 this month</div>
                </div>
            </div>

            <div class="stat-card animate-in delay-2">
                <div class="stat-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="stat-info">
                    <h3>Total Orders</h3>
                    <div class="stat-value">18</div>
                    <div class="stat-change positive">+2 today</div>
                </div>
            </div>

            <div class="stat-card animate-in delay-3">
                <div class="stat-icon">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="stat-info">
                    <h3>Revenue</h3>
                    <div class="stat-value">$8,245</div>
                    <div class="stat-change positive">+12% this month</div>
                </div>
            </div>

            <div class="stat-card animate-in delay-4">
                <div class="stat-icon">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-info">
                    <h3>Avg. Rating</h3>
                    <div class="stat-value">4.8</div>
                    <div class="stat-change positive">+0.2 this week</div>
                </div>
            </div>
        </div>

        <!-- Inventory Management -->
        <div id="inventory" class="content-card animate-in">
            <div class="card-header">
                <h2 class="card-title">Inventory Management</h2>
                <div class="card-actions">
                    <button class="btn-primary" data-toggle="modal" data-target="#addProductModal">
                        <i class="fas fa-plus"></i> Add Product
                    </button>
                </div>
            </div>

            <form class="form-grid">
                <div class="form-group">
                    <label for="productName">Instrument Name</label>
                    <input type="text" id="productName" class="form-control" placeholder="e.g., Professional Electric Guitar" required>
                </div>
                <div class="form-group">
                    <label for="productPrice">Price ($)</label>
                    <input type="number" id="productPrice" class="form-control" step="0.01" placeholder="0.00" required>
                </div>
                <div class="form-group">
                    <label for="productStock">Stock</label>
                    <input type="number" id="productStock" class="form-control" placeholder="0" required>
                </div>
                <div class="form-group">
                    <label for="productCategory">Category</label>
                    <select id="productCategory" class="form-control" required>
                        <option value="">Select Category</option>
                        <option value="guitars">Guitars</option>
                        <option value="drums">Drums & Percussion</option>
                        <option value="pianos">Pianos & Keyboards</option>
                        <option value="recording">Recording Equipment</option>
                        <option value="accessories">Accessories</option>
                    </select>
                </div>
                <div class="form-group" style="grid-column: 1 / -1;">
                    <label for="productDescription">Description</label>
                    <textarea id="productDescription" class="form-control" rows="3" placeholder="Product description..."></textarea>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-primary">Add Instrument</button>
                </div>
            </form>

            <div class="table-responsive">
                <table>
                    <thead>
                    <tr>
                        <th>Instrument</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Category</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Acoustic Guitar</td>
                        <td>$299.99</td>
                        <td>15</td>
                        <td>Guitars</td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i>
                                </div>
                                <div class="action-btn delete-btn">
                                    <i class="fas fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Electric Drum Set</td>
                        <td>$799.99</td>
                        <td>8</td>
                        <td>Drums</td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i>
                                </div>
                                <div class="action-btn delete-btn">
                                    <i class="fas fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Digital Piano</td>
                        <td>$1,199.99</td>
                        <td>5</td>
                        <td>Pianos</td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i>
                                </div>
                                <div class="action-btn delete-btn">
                                    <i class="fas fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Order Management -->
        <div id="orders" class="content-card animate-in">
            <div class="card-header">
                <h2 class="card-title">Order Management</h2>
                <div class="card-actions">
                    <button class="btn-outline">
                        <i class="fas fa-download"></i> Export
                    </button>
                </div>
            </div>

            <div class="table-responsive">
                <table>
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Instrument</th>
                        <th>Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>#ORD001</td>
                        <td>John Doe</td>
                        <td>Acoustic Guitar</td>
                        <td>Oct 12, 2023</td>
                        <td>$299.99</td>
                        <td><span class="status status-processing">Processing</span></td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>#ORD002</td>
                        <td>Jane Smith</td>
                        <td>Electric Drum Set</td>
                        <td>Oct 10, 2023</td>
                        <td>$799.99</td>
                        <td><span class="status status-shipped">Shipped</span></td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>#ORD003</td>
                        <td>Alex Johnson</td>
                        <td>Digital Piano</td>
                        <td>Oct 8, 2023</td>
                        <td>$1,199.99</td>
                        <td><span class="status status-pending">Pending</span></td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Customer Inquiries -->
        <div id="inquiries" class="content-card animate-in">
            <div class="card-header">
                <h2 class="card-title">Customer Inquiries</h2>
                <div class="card-actions">
                    <button class="btn-outline">
                        <i class="fas fa-filter"></i> Filter
                    </button>
                </div>
            </div>

            <div class="table-responsive">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Subject</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>#INQ001</td>
                        <td>Alex Brown</td>
                        <td>Need help with order #ORD001</td>
                        <td>Oct 13, 2023</td>
                        <td><span class="status status-pending">Pending</span></td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn">
                                    <i class="fas fa-reply"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>#INQ002</td>
                        <td>Sara Lee</td>
                        <td>Delivery status for #ORD002</td>
                        <td>Oct 11, 2023</td>
                        <td><span class="status status-pending">Pending</span></td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn">
                                    <i class="fas fa-reply"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Profile Section -->
        <div id="profile" class="content-card animate-in">
            <div class="card-header">
                <h2 class="card-title">Profile Settings</h2>
            </div>

            <form class="form-grid">
                <div class="form-group">
                    <label for="sellerName">Seller Name</label>
                    <input type="text" id="sellerName" class="form-control" value="<% out.print(session.getAttribute("sellerName") != null ? session.getAttribute("sellerName") : "Seller Name"); %>">
                </div>
                <div class="form-group">
                    <label for="sellerEmail">Email</label>
                    <input type="email" id="sellerEmail" class="form-control" value="seller@example.com">
                </div>
                <div class="form-group">
                    <label for="sellerPhone">Phone</label>
                    <input type="tel" id="sellerPhone" class="form-control" value="+1 (555) 123-4567">
                </div>
                <div class="form-group">
                    <label for="sellerStore">Store Name</label>
                    <input type="text" id="sellerStore" class="form-control" value="Melody Mart Pro Shop">
                </div>
                <div class="form-group" style="grid-column: 1 / -1;">
                    <label for="sellerBio">Bio</label>
                    <textarea id="sellerBio" class="form-control" rows="3">Premium musical instruments seller with over 10 years of experience.</textarea>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-primary">Update Profile</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Floating Action Button -->
<div class="floating-elements">
    <div class="floating-btn">
        <i class="fas fa-plus"></i>
    </div>
</div>

<script>
    // Toggle sidebar
    document.getElementById('toggle-sidebar').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('collapsed');
        document.getElementById('main-content').classList.toggle('expanded');
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add animation to elements when they come into view
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.content-card').forEach((card) => {
        observer.observe(card);
    });
</script>
</body>
</html>