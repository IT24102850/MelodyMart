<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard | Melody Mart</title>
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
            --sidebar-width: 280px;
            --header-height: 70px;
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

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--card-bg);
            border-right: 1px solid var(--glass-border);
            height: 100vh;
            position: fixed;
            overflow-y: auto;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid var(--glass-border);
            text-align: center;
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
            justify-content: center;
        }

        .sidebar-logo i {
            margin-right: 10px;
            font-size: 28px;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-category {
            padding: 10px 20px;
            color: var(--text-secondary);
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: var(--text);
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }

        .menu-item:hover, .menu-item.active {
            background: var(--glass-bg);
            color: var(--primary-light);
            border-left-color: var(--primary);
        }

        .menu-item i {
            margin-right: 12px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 20px;
            padding-top: calc(var(--header-height) + 20px);
        }

        .dashboard-header {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--glass-border);
            padding: 0 20px;
            height: var(--header-height);
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            top: 0;
            right: 0;
            left: var(--sidebar-width);
            z-index: 900;
            transition: all 0.3s ease;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .notification-btn, .user-menu-btn {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            cursor: pointer;
            position: relative;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--accent);
            color: var(--secondary);
            font-size: 10px;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        /* Dashboard Sections */
        .dashboard-section {
            display: none;
            animation: fadeIn 0.5s ease;
        }

        .dashboard-section.active {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Stats Overview */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 20px;
            display: flex;
            align-items: center;
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 24px;
            background: var(--gradient);
        }

        .stat-info h3 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Content Cards */
        .content-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid var(--glass-border);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
        }

        .card-actions {
            display: flex;
            gap: 10px;
        }

        /* Tables */
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th, .data-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--glass-border);
        }

        .data-table th {
            color: var(--text-secondary);
            font-weight: 600;
            font-size: 14px;
        }

        .data-table tbody tr {
            transition: all 0.3s ease;
        }

        .data-table tbody tr:hover {
            background: var(--card-hover);
        }

        /* Buttons */
        .btn {
            padding: 8px 16px;
            border-radius: 5px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 14px;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
        }

        .btn-primary:hover {
            background: var(--gradient-alt);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
        }

        .btn-secondary {
            background: transparent;
            border: 1px solid var(--primary-light);
            color: var(--primary-light);
        }

        .btn-secondary:hover {
            background: rgba(138, 43, 226, 0.1);
        }

        .btn-danger {
            background: rgba(220, 53, 69, 0.2);
            border: 1px solid rgba(220, 53, 69, 0.5);
            color: #dc3545;
        }

        .btn-danger:hover {
            background: rgba(220, 53, 69, 0.4);
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 12px;
        }

        /* Status Badges */
        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }

        .status-processing {
            background: rgba(0, 123, 255, 0.2);
            color: #007bff;
        }

        .status-completed {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .status-cancelled {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }

        /* Forms */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            background: var(--secondary);
            border: 1px solid var(--glass-border);
            border-radius: 5px;
            color: var(--text);
            font-family: 'Montserrat', sans-serif;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 2px rgba(138, 43, 226, 0.2);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
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
            padding: 20px;
        }

        .modal-content {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            max-width: 800px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
            border: 1px solid var(--glass-border);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
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

        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            margin-bottom: 20px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Premium Form Styles */
        .premium-form {
            padding: 20px 0;
        }

        .premium-form .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .premium-form .form-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }

        .premium-form .form-subtitle {
            color: var(--text-secondary);
            font-size: 16px;
        }

        .premium-form .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .premium-form .full-width {
            grid-column: span 2;
        }

        .premium-form .form-actions {
            grid-column: span 2;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 20px;
        }

        .premium-form .btn {
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 16px;
        }

        .error-message {
            color: #ff6b6b;
            font-size: 14px;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .error-message i {
            font-size: 16px;
        }

        .notification {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: fadeIn 0.5s ease;
        }

        .notification.error {
            background: rgba(220, 53, 69, 0.2);
            border: 1px solid rgba(220, 53, 69, 0.5);
            color: #dc3545;
        }

        .notification.success {
            background: rgba(40, 167, 69, 0.2);
            border: 1px solid rgba(40, 167, 69, 0.5);
            color: #28a745;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                width: 260px;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .dashboard-header {
                left: 0;
            }

            .menu-toggle {
                display: block;
            }

            .premium-form .form-grid {
                grid-template-columns: 1fr;
            }

            .premium-form .full-width {
                grid-column: span 1;
            }

            .premium-form .form-actions {
                grid-column: span 1;
                flex-direction: column;
            }

            .premium-form .btn {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Toggle button for mobile */
        .menu-toggle {
            display: none;
            background: none;
            border: none;
            color: var(--text);
            font-size: 24px;
            cursor: pointer;
            margin-right: 15px;
        }

        @media (max-width: 992px) {
            .menu-toggle {
                display: block;
            }
        }

        /* Image upload preview */
        .image-upload {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .image-preview {
            width: 100px;
            height: 100px;
            border-radius: 5px;
            overflow: hidden;
            position: relative;
            border: 1px dashed var(--glass-border);
        }

        .image-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .image-preview .remove-image {
            position: absolute;
            top: 5px;
            right: 5px;
            background: rgba(220, 53, 69, 0.8);
            color: white;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            cursor: pointer;
        }

        .upload-btn {
            width: 100px;
            height: 100px;
            border: 1px dashed var(--glass-border);
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .upload-btn:hover {
            border-color: var(--primary-light);
            color: var(--primary-light);
        }

        /* Loading spinner */
        .spinner {
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

        /* Search and filter */
        .search-filter {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-box input {
            padding-left: 40px;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }

        .filter-select {
            min-width: 150px;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <i class="fas fa-music"></i>
                Melody Mart
            </div>
            <small>Seller Dashboard</small>
        </div>

        <div class="sidebar-menu">
            <div class="menu-category">Main</div>
            <a href="#" class="menu-item active" data-section="dashboard">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard</span>
            </a>

            <div class="menu-category">Management</div>
            <a href="#" class="menu-item" data-section="inventory">
                <i class="fas fa-box"></i>
                <span>Inventory</span>
            </a>
            <a href="#" class="menu-item" data-section="orders">
                <i class="fas fa-shopping-cart"></i>
                <span>Orders</span>
            </a>
            <a href="#" class="menu-item" data-section="deliveries">
                <i class="fas fa-truck"></i>
                <span>Deliveries</span>
            </a>
            <a href="#" class="menu-item" data-section="stock">
                <i class="fas fa-cubes"></i>
                <span>Stock Management</span>
            </a>

            <div class="menu-category">Reports</div>
            <a href="#" class="menu-item" data-section="reports">
                <i class="fas fa-chart-bar"></i>
                <span>Sales Reports</span>
            </a>
            <a href="#" class="menu-item" data-section="notifications">
                <i class="fas fa-bell"></i>
                <span>Notifications</span>
            </a>

            <div class="menu-category">Account</div>
            <a href="#" class="menu-item" data-section="profile">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
            <a href="#" class="menu-item" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <header class="dashboard-header">
            <button class="menu-toggle" id="menuToggle">
                <i class="fas fa-bars"></i>
            </button>

            <h1 class="page-title">Seller Dashboard</h1>

            <div class="header-actions">
                <button class="notification-btn">
                    <i class="fas fa-bell"></i>
                    <span class="notification-badge">3</span>
                </button>

                <div class="user-menu">
                    <button class="user-menu-btn">
                        <i class="fas fa-user-circle"></i>
                    </button>
                </div>
            </div>
        </header>

        <!-- Dashboard Section -->
        <section id="dashboard" class="dashboard-section active">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="stat-info">
                        <h3>142</h3>
                        <p>Total Products</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stat-info">
                        <h3>56</h3>
                        <p>New Orders</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-truck"></i>
                    </div>
                    <div class="stat-info">
                        <h3>38</h3>
                        <p>Pending Deliveries</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="stat-info">
                        <h3>$12,458</h3>
                        <p>Total Revenue</p>
                    </div>
                </div>
            </div>

            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Recent Orders</h2>
                    <div class="card-actions">
                        <button class="btn btn-primary">View All</button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Date</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>#ORD-7842</td>
                            <td>John Smith</td>
                            <td>Jul 12, 2025</td>
                            <td>$349.99</td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary">View</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-7841</td>
                            <td>Emma Johnson</td>
                            <td>Jul 12, 2025</td>
                            <td>$1,249.99</td>
                            <td><span class="status-badge status-processing">Processing</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary">View</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-7839</td>
                            <td>Michael Brown</td>
                            <td>Jul 11, 2025</td>
                            <td>$599.99</td>
                            <td><span class="status-badge status-completed">Completed</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary">View</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-7835</td>
                            <td>Sarah Wilson</td>
                            <td>Jul 10, 2025</td>
                            <td>$2,199.99</td>
                            <td><span class="status-badge status-processing">Processing</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary">View</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Low Stock Alert</h2>
                    <div class="card-actions">
                        <button class="btn btn-secondary">View Inventory</button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Product</th>
                            <th>SKU</th>
                            <th>Current Stock</th>
                            <th>Alert Level</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>Fender Stratocaster Electric Guitar</td>
                            <td>PROD-4872</td>
                            <td>3</td>
                            <td>5</td>
                            <td>
                                <button class="btn btn-sm btn-primary">Restock</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Yamaha HS8 Studio Monitor</td>
                            <td>PROD-5321</td>
                            <td>2</td>
                            <td>4</td>
                            <td>
                                <button class="btn btn-sm btn-primary">Restock</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Shure SM58 Microphone</td>
                            <td>PROD-2154</td>
                            <td>4</td>
                            <td>10</td>
                            <td>
                                <button class="btn btn-sm btn-primary">Restock</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Inventory Section -->


        <%@ page import="java.sql.Connection" %>
        <%@ page import="java.sql.PreparedStatement" %>
        <%@ page import="java.sql.ResultSet" %>
        <%@ page import="com.melodymart.util.DatabaseUtil" %>

        <!-- Inventory Section -->
        <section id="inventory" class="dashboard-section">
            <div class="search-filter">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" class="form-control" placeholder="Search products...">
                </div>
                <select id="statusFilter" class="form-control filter-select">
                    <option value="">All Statuses</option>
                    <option value="In Stock">In Stock</option>
                    <option value="Low Stock">Low Stock</option>
                    <option value="Out of Stock">Out of Stock</option>
                </select>
                <button class="btn btn-secondary" id="resetFilters">Reset</button>
            </div>

            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Inventory Management</h2>
                    <div class="card-actions">
                        <button class="btn btn-primary" onclick="openModal('addProductModal')">
                            <i class="fas fa-plus"></i> Add New Instrument
                        </button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Model</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            try {
                                conn = DatabaseUtil.getConnection();
                                String sql = "SELECT InstrumentID, Name, Description, Model, Price, Quantity, StockLevel, ImageURL FROM Instrument";
                                ps = conn.prepareStatement(sql);
                                rs = ps.executeQuery();
                                while (rs.next()) {
                                    String stockLevel = rs.getString("StockLevel");
                                    String statusClass =
                                            "In Stock".equalsIgnoreCase(stockLevel) ? "status-completed" :
                                                    "Low Stock".equalsIgnoreCase(stockLevel) ? "status-pending" :
                                                            "status-cancelled";
                        %>
                        <tr>
                            <td>
                                <%
                                    String img = rs.getString("ImageURL");
                                    if (img != null && !img.isEmpty()) {
                                %>
                                <img src="<%= img %>" alt="<%= rs.getString("Name") %>"
                                     style="width:40px; height:40px; border-radius:5px; object-fit:cover;">
                                <%
                                } else {
                                %>
                                <img src="https://via.placeholder.com/40" alt="No image"
                                     style="width:40px; height:40px; border-radius:5px; object-fit:cover;">
                                <%
                                    }
                                %>
                            </td>
                            <td><%= rs.getString("Name") %></td>
                            <td><%= rs.getString("Description") %></td>
                            <td><%= rs.getString("Model") %></td>
                            <td>$<%= rs.getDouble("Price") %></td>
                            <td><%= rs.getInt("Quantity") %></td>
                            <td>
                                <span class="status-badge <%= statusClass %>"><%= stockLevel %></span>
                            </td>
                            <td>
                                <!-- Edit button -->
                                <button class="btn btn-sm btn-primary"
                                        onclick="openEditModal(<%= rs.getInt("InstrumentID") %>,
                                                '<%= rs.getString("Name") %>',
                                                '<%= rs.getString("Description") %>',
                                                '<%= rs.getString("Model") %>',
                                            <%= rs.getDouble("Price") %>,
                                            <%= rs.getInt("Quantity") %>,
                                                '<%= stockLevel %>',
                                                '<%= rs.getString("ImageURL") %>')">
                                    Edit
                                </button>

                                <!-- Delete form -->
                                <form action="${pageContext.request.contextPath}/DeleteInstrumentServlet"
                                      method="post" style="display:inline;"
                                      onsubmit="return confirm('Are you sure you want to delete this instrument?');">
                                    <input type="hidden" name="instrumentId" value="<%= rs.getInt("InstrumentID") %>">
                                    <button type="submit" class="btn btn-sm btn-secondary">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='8' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                            } finally {
                                if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                                if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                                if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Edit Instrument Modal -->
        <div class="modal" id="editInstrumentModal" style="display:none;">
            <div class="modal-content">
                <button class="modal-close" onclick="closeModal('editInstrumentModal')">&times;</button>
                <h2>Edit Instrument</h2>
                <form action="${pageContext.request.contextPath}/UpdateInstrumentServlet" method="post">
                    <input type="hidden" id="editInstrumentId" name="instrumentId">

                    <label>Name:</label>
                    <input type="text" id="editName" name="name" required><br>

                    <label>Description:</label>
                    <input type="text" id="editDescription" name="description"><br>

                    <label>Model:</label>
                    <input type="text" id="editModel" name="model"><br>

                    <label>Price:</label>
                    <input type="number" id="editPrice" name="price" step="0.01"><br>

                    <label>Quantity:</label>
                    <input type="number" id="editQuantity" name="quantity"><br>

                    <label>Stock Level:</label>
                    <select id="editStockLevel" name="stockLevel">
                        <option value="In Stock">In Stock</option>
                        <option value="Low Stock">Low Stock</option>
                        <option value="Out of Stock">Out of Stock</option>
                    </select><br>

                    <label>Image URL:</label>
                    <input type="text" id="editImageUrl" name="imageUrl"><br>

                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form>
            </div>
        </div>

        <script>
            // Open edit modal with data
            function openEditModal(id, name, description, model, price, quantity, stockLevel, imageUrl) {
                document.getElementById("editInstrumentId").value = id;
                document.getElementById("editName").value = name;
                document.getElementById("editDescription").value = description;
                document.getElementById("editModel").value = model;
                document.getElementById("editPrice").value = price;
                document.getElementById("editQuantity").value = quantity;
                document.getElementById("editStockLevel").value = stockLevel;
                document.getElementById("editImageUrl").value = imageUrl;

                document.getElementById("editInstrumentModal").style.display = "flex";
            }

            // Close modal
            function closeModal(id) {
                document.getElementById(id).style.display = "none";
            }
        </script>












        <!-- Other sections would be defined here (Orders, Deliveries, Stock, Reports, etc.) -->
        <section id="orders" class="dashboard-section">
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Order Management</h2>
                </div>
                <p>Order management content goes here...</p>
            </div>
        </section>

        <section id="deliveries" class="dashboard-section">
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Delivery Coordination</h2>
                </div>
                <p>Delivery coordination content goes here...</p>
            </div>
        </section>

        <section id="stock" class="dashboard-section">
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Stock Management</h2>
                </div>
                <p>Stock management content goes here...</p>
            </div>
        </section>

        <section id="reports" class="dashboard-section">
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Sales Reports</h2>
                </div>
                <p>Sales reports content goes here...</p>
            </div>
        </section>

        <section id="notifications" class="dashboard-section">
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Notifications</h2>
                </div>
                <p>Notifications content goes here...</p>
            </div>
        </section>

        <section id="profile" class="dashboard-section">
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Profile Settings</h2>
                </div>
                <p>Profile settings content goes here...</p>
            </div>
        </section>
    </div>
</div>

<!-- Add/Edit Product Modal -->
<div class="modal" id="addProductModal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('addProductModal')">&times;</button>

        <div class="premium-form">
            <div class="form-header">
                <h2 class="form-title">Add New Instrument</h2>
                <p class="form-subtitle">Fill in the details below to add a new instrument to your inventory</p>
            </div>

            <!-- Display error message if exists -->
            <div class="notification error" style="display: none;" id="errorNotification">
                <i class="fas fa-exclamation-circle"></i>
                <span id="errorText"></span>
            </div>

            <!-- Display success message if exists -->
            <div class="notification success" style="display: none;" id="successNotification">
                <i class="fas fa-check-circle"></i>
                <span id="successText"></span>
            </div>

            <form id="instrumentForm" action="SaveInstrument" method="post" enctype="multipart/form-data">
                <input type="hidden" id="instrumentId" name="instrumentId">
                <input type="hidden" id="actionType" name="actionType" value="add">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="name" class="form-label">Name *</label>
                        <input type="text" id="name" name="name" class="form-control" required
                               placeholder="e.g., Fender Stratocaster">
                        <div class="error-message" id="nameError" style="display: none;"></div>
                    </div>

                    <div class="form-group">
                        <label for="price" class="form-label">Price ($) *</label>
                        <input type="number" id="price" name="price" class="form-control"
                               step="0.01" min="0.01" required placeholder="0.00">
                        <div class="error-message" id="priceError" style="display: none;"></div>
                    </div>

                    <div class="form-group">
                        <label for="brandId" class="form-label">Brand ID</label>
                        <input type="number" id="brandId" name="brandId" class="form-control"
                               min="1" placeholder="Optional">
                        <small style="color: var(--text-secondary); font-size: 11px;">Leave empty if unknown</small>
                    </div>

                    <div class="form-group">
                        <label for="model" class="form-label">Model</label>
                        <input type="text" id="model" name="model" class="form-control"
                               placeholder="e.g., American Professional II">
                    </div>

                    <div class="form-group">
                        <label for="color" class="form-label">Color</label>
                        <input type="text" id="color" name="color" class="form-control"
                               placeholder="e.g., Sunburst, Black, White">
                    </div>

                    <div class="form-group">
                        <label for="quantity" class="form-label">Quantity *</label>
                        <input type="number" id="quantity" name="quantity" class="form-control"
                               min="0" required placeholder="0">
                        <div class="error-message" id="quantityError" style="display: none;"></div>
                    </div>

                    <div class="form-group">
                        <label for="stockLevel" class="form-label">Stock Level</label>
                        <select id="stockLevel" name="stockLevel" class="form-control">
                            <option value="In Stock">In Stock</option>
                            <option value="Low Stock">Low Stock</option>
                            <option value="Out of Stock">Out of Stock</option>
                        </select>
                        <small style="color: var(--text-secondary); font-size: 11px;">Will auto-update based on quantity</small>
                    </div>

                    <div class="form-group">
                        <label for="manufacturerId" class="form-label">Manufacturer ID</label>
                        <input type="number" id="manufacturerId" name="manufacturerId" class="form-control"
                               min="1" placeholder="Optional">
                        <small style="color: var(--text-secondary); font-size: 11px;">Leave empty if unknown</small>
                    </div>

                    <div class="form-group full-width">
                        <label for="description" class="form-label">Description</label>
                        <textarea id="description" name="description" class="form-control" rows="3"
                                  placeholder="Describe the instrument's features, condition, and any special characteristics..."></textarea>
                    </div>

                    <div class="form-group full-width">
                        <label for="specifications" class="form-label">Specifications</label>
                        <textarea id="specifications" name="specifications" class="form-control" rows="3"
                                  placeholder="Technical specifications like dimensions, materials, pickup types, etc..."></textarea>
                    </div>

                    <div class="form-group">
                        <label for="warranty" class="form-label">Warranty</label>
                        <input type="text" id="warranty" name="warranty" class="form-control"
                               placeholder="e.g., 2 years, Limited lifetime">
                    </div>

                    <div class="form-group full-width">
                        <label for="imageFile" class="form-label">Product Image</label>
                        <div class="image-upload" id="imageUpload">
                            <div class="upload-btn" onclick="document.getElementById('imageFile').click()">
                                <i class="fas fa-plus"></i>
                                <span style="margin-left: 5px; font-size: 12px;">Add Image</span>
                            </div>
                        </div>
                        <input type="file" id="imageFile" name="imageFile" accept="image/jpeg,image/jpg,image/png,image/gif"
                               style="display: none;" onchange="handleImageUpload(this)">
                        <input type="hidden" id="imageUrl" name="imageUrl">
                        <small style="color: var(--text-secondary); font-size: 12px; margin-top: 5px; display: block;">
                            Upload a clear product image. Max size: 5MB. Formats: JPG, PNG, GIF
                        </small>
                        <div class="error-message" id="imageError" style="display: none;"></div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="cancelForm()">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="submitBtn">
                            <i class="fas fa-plus"></i> Add Instrument
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Instrument Modal -->
<div class="modal" id="editInstrumentModal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('editInstrumentModal')">&times;</button>

        <div class="premium-form">
            <div class="form-header">
                <h2 class="form-title">Edit Instrument</h2>
                <p class="form-subtitle">Update the details of this instrument</p>
            </div>

            <!-- Display error message if exists -->
            <div class="notification error" style="display: none;" id="editErrorNotification">
                <i class="fas fa-exclamation-circle"></i>
                <span id="editErrorText"></span>
            </div>

            <!-- Display success message if exists -->
            <div class="notification success" style="display: none;" id="editSuccessNotification">
                <i class="fas fa-check-circle"></i>
                <span id="editSuccessText"></span>
            </div>

            <form id="editInstrumentForm" action="UpdateInstrumentServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" id="editInstrumentId" name="instrumentId">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="editName" class="form-label">Name *</label>
                        <input type="text" id="editName" name="name" class="form-control" required
                               placeholder="e.g., Fender Stratocaster">
                        <div class="error-message" id="editNameError" style="display: none;"></div>
                    </div>

                    <div class="form-group">
                        <label for="editPrice" class="form-label">Price ($) *</label>
                        <input type="number" id="editPrice" name="price" class="form-control"
                               step="0.01" min="0.01" required placeholder="0.00">
                        <div class="error-message" id="editPriceError" style="display: none;"></div>
                    </div>

                    <div class="form-group">
                        <label for="editBrandId" class="form-label">Brand ID</label>
                        <input type="number" id="editBrandId" name="brandId" class="form-control"
                               min="1" placeholder="Optional">
                        <small style="color: var(--text-secondary); font-size: 11px;">Leave empty if unknown</small>
                    </div>

                    <div class="form-group">
                        <label for="editModel" class="form-label">Model</label>
                        <input type="text" id="editModel" name="model" class="form-control"
                               placeholder="e.g., American Professional II">
                    </div>

                    <div class="form-group">
                        <label for="editColor" class="form-label">Color</label>
                        <input type="text" id="editColor" name="color" class="form-control"
                               placeholder="e.g., Sunburst, Black, White">
                    </div>

                    <div class="form-group">
                        <label for="editQuantity" class="form-label">Quantity *</label>
                        <input type="number" id="editQuantity" name="quantity" class="form-control"
                               min="0" required placeholder="0">
                        <div class="error-message" id="editQuantityError" style="display: none;"></div>
                    </div>

                    <div class="form-group">
                        <label for="editStockLevel" class="form-label">Stock Level</label>
                        <select id="editStockLevel" name="stockLevel" class="form-control">
                            <option value="In Stock">In Stock</option>
                            <option value="Low Stock">Low Stock</option>
                            <option value="Out of Stock">Out of Stock</option>
                        </select>
                        <small style="color: var(--text-secondary); font-size: 11px;">Will auto-update based on quantity</small>
                    </div>

                    <div class="form-group">
                        <label for="editManufacturerId" class="form-label">Manufacturer ID</label>
                        <input type="number" id="editManufacturerId" name="manufacturerId" class="form-control"
                               min="1" placeholder="Optional">
                        <small style="color: var(--text-secondary); font-size: 11px;">Leave empty if unknown</small>
                    </div>

                    <div class="form-group full-width">
                        <label for="editDescription" class="form-label">Description</label>
                        <textarea id="editDescription" name="description" class="form-control" rows="3"
                                  placeholder="Describe the instrument's features, condition, and any special characteristics..."></textarea>
                    </div>

                    <div class="form-group full-width">
                        <label for="editSpecifications" class="form-label">Specifications</label>
                        <textarea id="editSpecifications" name="specifications" class="form-control" rows="3"
                                  placeholder="Technical specifications like dimensions, materials, pickup types, etc..."></textarea>
                    </div>

                    <div class="form-group">
                        <label for="editWarranty" class="form-label">Warranty</label>
                        <input type="text" id="editWarranty" name="warranty" class="form-control"
                               placeholder="e.g., 2 years, Limited lifetime">
                    </div>

                    <div class="form-group full-width">
                        <label for="editImageFile" class="form-label">Product Image</label>
                        <div class="image-upload" id="editImageUpload">
                            <div class="upload-btn" onclick="document.getElementById('editImageFile').click()">
                                <i class="fas fa-plus"></i>
                                <span style="margin-left: 5px; font-size: 12px;">Add Image</span>
                            </div>
                        </div>
                        <input type="file" id="editImageFile" name="imageFile" accept="image/jpeg,image/jpg,image/png,image/gif"
                               style="display: none;" onchange="handleEditImageUpload(this)">
                        <input type="hidden" id="editImageUrl" name="imageUrl">
                        <small style="color: var(--text-secondary); font-size: 12px; margin-top: 5px; display: block;">
                            Upload a clear product image. Max size: 5MB. Formats: JPG, PNG, GIF
                        </small>
                        <div class="error-message" id="editImageError" style="display: none;"></div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeModal('editInstrumentModal')">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="editSubmitBtn">
                            <i class="fas fa-save"></i> Update Instrument
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Enhanced form handling and validation
    document.getElementById('instrumentForm').addEventListener('submit', function(e) {
        e.preventDefault(); // Prevent default submission initially

        // Clear previous errors
        clearAllErrors();

        // Validate form
        if (validateForm()) {
            // Show loading state
            const submitBtn = document.getElementById('submitBtn');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<div class="spinner"></div> Saving...';
            submitBtn.disabled = true;

            // Submit the form
            this.submit();
        }
    });

    // Edit form handling and validation
    document.getElementById('editInstrumentForm').addEventListener('submit', function(e) {
        e.preventDefault(); // Prevent default submission initially

        // Clear previous errors
        clearEditErrors();

        // Validate form
        if (validateEditForm()) {
            // Show loading state
            const submitBtn = document.getElementById('editSubmitBtn');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<div class="spinner"></div> Updating...';
            submitBtn.disabled = true;

            // Submit the form
            this.submit();
        }
    });

    function validateForm() {
        let isValid = true;

        // Validate name
        const name = document.getElementById('name');
        if (!name.value.trim()) {
            showFieldError('nameError', 'Product name is required');
            name.focus();
            isValid = false;
        }

        // Validate price
        const price = document.getElementById('price');
        const priceValue = parseFloat(price.value);
        if (!price.value || priceValue <= 0) {
            showFieldError('priceError', 'Price must be greater than 0');
            if (isValid) price.focus(); // Focus first error
            isValid = false;
        } else if (priceValue > 999999.99) {
            showFieldError('priceError', 'Price cannot exceed $999,999.99');
            if (isValid) price.focus();
            isValid = false;
        }

        // Validate quantity
        const quantity = document.getElementById('quantity');
        const quantityValue = parseInt(quantity.value);
        if (!quantity.value || quantityValue < 0) {
            showFieldError('quantityError', 'Quantity must be 0 or greater');
            if (isValid) quantity.focus();
            isValid = false;
        } else if (quantityValue > 10000) {
            showFieldError('quantityError', 'Quantity cannot exceed 10,000');
            if (isValid) quantity.focus();
            isValid = false;
        }

        // Auto-update stock level based on quantity
        updateStockLevelFromQuantity();

        return isValid;
    }

    function validateEditForm() {
        let isValid = true;

        // Validate name
        const name = document.getElementById('editName');
        if (!name.value.trim()) {
            showEditFieldError('editNameError', 'Product name is required');
            name.focus();
            isValid = false;
        }

        // Validate price
        const price = document.getElementById('editPrice');
        const priceValue = parseFloat(price.value);
        if (!price.value || priceValue <= 0) {
            showEditFieldError('editPriceError', 'Price must be greater than 0');
            if (isValid) price.focus(); // Focus first error
            isValid = false;
        } else if (priceValue > 999999.99) {
            showEditFieldError('editPriceError', 'Price cannot exceed $999,999.99');
            if (isValid) price.focus();
            isValid = false;
        }

        // Validate quantity
        const quantity = document.getElementById('editQuantity');
        const quantityValue = parseInt(quantity.value);
        if (!quantity.value || quantityValue < 0) {
            showEditFieldError('editQuantityError', 'Quantity must be 0 or greater');
            if (isValid) quantity.focus();
            isValid = false;
        } else if (quantityValue > 10000) {
            showEditFieldError('editQuantityError', 'Quantity cannot exceed 10,000');
            if (isValid) quantity.focus();
            isValid = false;
        }

        // Auto-update stock level based on quantity
        updateEditStockLevelFromQuantity();

        return isValid;
    }

    function showFieldError(errorId, message) {
        const errorElement = document.getElementById(errorId);
        errorElement.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
        errorElement.style.display = 'flex';
    }

    function showEditFieldError(errorId, message) {
        const errorElement = document.getElementById(errorId);
        errorElement.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
        errorElement.style.display = 'flex';
    }

    function clearAllErrors() {
        const errorElements = document.querySelectorAll('.error-message');
        errorElements.forEach(element => {
            element.style.display = 'none';
            element.innerHTML = '';
        });
    }

    function clearEditErrors() {
        const errorElements = document.querySelectorAll('#editInstrumentModal .error-message');
        errorElements.forEach(element => {
            element.style.display = 'none';
            element.innerHTML = '';
        });
    }

    function updateStockLevelFromQuantity() {
        const quantity = parseInt(document.getElementById('quantity').value) || 0;
        const stockLevel = document.getElementById('stockLevel');

        if (quantity === 0) {
            stockLevel.value = 'Out of Stock';
        } else if (quantity <= 5) {
            stockLevel.value = 'Low Stock';
        } else {
            stockLevel.value = 'In Stock';
        }
    }

    function updateEditStockLevelFromQuantity() {
        const quantity = parseInt(document.getElementById('editQuantity').value) || 0;
        const stockLevel = document.getElementById('editStockLevel');

        if (quantity === 0) {
            stockLevel.value = 'Out of Stock';
        } else if (quantity <= 5) {
            stockLevel.value = 'Low Stock';
        } else {
            stockLevel.value = 'In Stock';
        }
    }

    // Auto-update stock level when quantity changes
    document.getElementById('quantity').addEventListener('input', updateStockLevelFromQuantity);
    document.getElementById('editQuantity').addEventListener('input', updateEditStockLevelFromQuantity);

    function handleImageUpload(input) {
        const file = input.files[0];
        const imageError = document.getElementById('imageError');

        // Clear previous errors
        imageError.style.display = 'none';

        if (file) {
            // Validate file type
            const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type.toLowerCase())) {
                showFieldError('imageError', 'Please select a valid image file (JPG, PNG, GIF)');
                input.value = '';
                removeImagePreview();
                return;
            }

            // Validate file size (5MB max)
            if (file.size > 5 * 1024 * 1024) {
                showFieldError('imageError', 'Image size must be less than 5MB');
                input.value = '';
                removeImagePreview();
                return;
            }

            // Create preview
            const reader = new FileReader();
            reader.onload = function(e) {
                createImagePreview(e.target.result, file.name);
                // Clear the hidden imageUrl since new file is uploaded
                document.getElementById('imageUrl').value = '';
            };
            reader.readAsDataURL(file);
        }
    }

    function handleEditImageUpload(input) {
        const file = input.files[0];
        const imageError = document.getElementById('editImageError');

        // Clear previous errors
        imageError.style.display = 'none';

        if (file) {
            // Validate file type
            const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type.toLowerCase())) {
                showEditFieldError('editImageError', 'Please select a valid image file (JPG, PNG, GIF)');
                input.value = '';
                removeEditImagePreview();
                return;
            }

            // Validate file size (5MB max)
            if (file.size > 5 * 1024 * 1024) {
                showEditFieldError('editImageError', 'Image size must be less than 5MB');
                input.value = '';
                removeEditImagePreview();
                return;
            }

            // Create preview
            const reader = new FileReader();
            reader.onload = function(e) {
                createEditImagePreview(e.target.result, file.name);
                // Clear the hidden imageUrl since new file is uploaded
                document.getElementById('editImageUrl').value = '';
            };
            reader.readAsDataURL(file);
        }
    }

    function createImagePreview(src, filename) {
        const uploadContainer = document.getElementById('imageUpload');

        // Remove existing previews
        const existingPreviews = uploadContainer.querySelectorAll('.image-preview');
        existingPreviews.forEach(preview => preview.remove());

        // Create new preview
        const preview = document.createElement('div');
        preview.className = 'image-preview';
        preview.innerHTML = `
            <img src="${src}" alt="Preview" style="width: 100%; height: 100%; object-fit: cover;">
            <button type="button" class="remove-image" onclick="removeImagePreview()" title="Remove image">
                <i class="fas fa-times"></i>
            </button>
            <div style="position: absolute; bottom: 2px; left: 2px; right: 2px; background: rgba(0,0,0,0.7); color: white; font-size: 10px; padding: 2px; border-radius: 2px; text-align: center;">
                ${filename.length > 15 ? filename.substring(0, 12) + '...' : filename}
            </div>
        `;

        // Insert before upload button
        const uploadBtn = uploadContainer.querySelector('.upload-btn');
        uploadContainer.insertBefore(preview, uploadBtn);

        // Update upload button text
        uploadBtn.innerHTML = '<i class="fas fa-sync"></i><span style="margin-left: 5px; font-size: 12px;">Change</span>';
    }

    function createEditImagePreview(src, filename) {
        const uploadContainer = document.getElementById('editImageUpload');

        // Remove existing previews
        const existingPreviews = uploadContainer.querySelectorAll('.image-preview');
        existingPreviews.forEach(preview => preview.remove());

        // Create new preview
        const preview = document.createElement('div');
        preview.className = 'image-preview';
        preview.innerHTML = `
            <img src="${src}" alt="Preview" style="width: 100%; height: 100%; object-fit: cover;">
            <button type="button" class="remove-image" onclick="removeEditImagePreview()" title="Remove image">
                <i class="fas fa-times"></i>
            </button>
            <div style="position: absolute; bottom: 2px; left: 2px; right: 2px; background: rgba(0,0,0,0.7); color: white; font-size: 10px; padding: 2px; border-radius: 2px; text-align: center;">
                ${filename.length > 15 ? filename.substring(0, 12) + '...' : filename}
            </div>
        `;

        // Insert before upload button
        const uploadBtn = uploadContainer.querySelector('.upload-btn');
        uploadContainer.insertBefore(preview, uploadBtn);

        // Update upload button text
        uploadBtn.innerHTML = '<i class="fas fa-sync"></i><span style="margin-left: 5px; font-size: 12px;">Change</span>';
    }

    function removeImagePreview() {
        const uploadContainer = document.getElementById('imageUpload');
        const preview = uploadContainer.querySelector('.image-preview');
        const imageFile = document.getElementById('imageFile');
        const imageUrl = document.getElementById('imageUrl');
        const uploadBtn = uploadContainer.querySelector('.upload-btn');

        if (preview) {
            preview.remove();
        }
        imageFile.value = '';
        imageUrl.value = '';

        // Reset upload button text
        uploadBtn.innerHTML = '<i class="fas fa-plus"></i><span style="margin-left: 5px; font-size: 12px;">Add Image</span>';
    }

    function removeEditImagePreview() {
        const uploadContainer = document.getElementById('editImageUpload');
        const preview = uploadContainer.querySelector('.image-preview');
        const imageFile = document.getElementById('editImageFile');
        const imageUrl = document.getElementById('editImageUrl');
        const uploadBtn = uploadContainer.querySelector('.upload-btn');

        if (preview) {
            preview.remove();
        }
        imageFile.value = '';
        imageUrl.value = '';

        // Reset upload button text
        uploadBtn.innerHTML = '<i class="fas fa-plus"></i><span style="margin-left: 5px; font-size: 12px;">Add Image</span>';
    }

    function cancelForm() {
        // Clear form
        document.getElementById('instrumentForm').reset();
        removeImagePreview();
        clearAllErrors();

        // Reset submit button
        const submitBtn = document.getElementById('submitBtn');
        submitBtn.innerHTML = '<i class="fas fa-plus"></i> Add Instrument';
        submitBtn.disabled = false;

        // Close modal
        closeModal('addProductModal');
    }

    // Reset form when modal is opened for add
    function openModal(modalId) {
        if (modalId === 'addProductModal') {
            // Reset form state for add
            document.getElementById('instrumentForm').reset();
            removeImagePreview();
            clearAllErrors();
            document.getElementById('instrumentId').value = '';
            document.getElementById('actionType').value = 'add';
            document.querySelector('.form-title').textContent = 'Add New Instrument';
            document.querySelector('.form-subtitle').textContent = 'Fill in the details below to add a new instrument to your inventory';
            document.getElementById('submitBtn').innerHTML = '<i class="fas fa-plus"></i> Add Instrument';
            document.getElementById('submitBtn').disabled = false;
        }
        document.getElementById(modalId).style.display = 'flex';
    }

    // Sidebar toggle for mobile
    document.getElementById('menuToggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
    });

    // Section navigation
    document.querySelectorAll('.menu-item').forEach(item => {
        if (item.getAttribute('data-section')) {
            item.addEventListener('click', function(e) {
                e.preventDefault();

                // Remove active class from all menu items and sections
                document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                document.querySelectorAll('.dashboard-section').forEach(s => s.classList.remove('active'));

                // Add active class to clicked menu item
                this.classList.add('active');

                // Show the corresponding section
                const sectionId = this.getAttribute('data-section');
                document.getElementById(sectionId).classList.add('active');

                // Update page title
                document.querySelector('.page-title').textContent = this.querySelector('span').textContent;

                // Close sidebar on mobile after selection
                if (window.innerWidth < 992) {
                    document.getElementById('sidebar').classList.remove('active');
                }
            });
        }
    });

    // Modal functions
    function openModal(modalId) {
        document.getElementById(modalId).style.display = 'flex';
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    // Close modal when clicking outside
    window.addEventListener('click', function(e) {
        document.querySelectorAll('.modal').forEach(modal => {
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        });
    });

    // Logout function
    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = 'index.jsp';
        }
    }

    // Check if there's an error message from the server
    window.addEventListener('DOMContentLoaded', function() {
        const errorNotification = document.getElementById('errorNotification');
        const errorText = document.getElementById('errorText');

        // Simulating server-side error (replace with actual server response handling)
        const addStatus = ""; // This would come from your JSP
        if (addStatus) {
            errorText.textContent = addStatus;
            errorNotification.style.display = 'flex';
        }
    });

    // Inventory search and filter functionality
    document.getElementById('searchInput').addEventListener('input', filterInventory);
    document.getElementById('statusFilter').addEventListener('change', filterInventory);
    document.getElementById('resetFilters').addEventListener('click', resetFilters);

    function filterInventory() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const statusFilter = document.getElementById('statusFilter').value;
        const rows = document.querySelectorAll('#inventoryTableBody tr');

        rows.forEach(row => {
            const name = row.cells[1].textContent.toLowerCase();
            const description = row.cells[2].textContent.toLowerCase();
            const status = row.cells[6].textContent;

            const matchesSearch = name.includes(searchTerm) || description.includes(searchTerm);
            const matchesStatus = !statusFilter || status === statusFilter;

            row.style.display = matchesSearch && matchesStatus ? '' : 'none';
        });
    }

    function resetFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('statusFilter').value = '';
        filterInventory();
    }

    // Edit instrument function
    function openEditModal(id) {
        // In a real implementation, this would fetch the instrument data from your database
        // For now, we'll use sample data
        const sampleData = {
            1: {
                name: 'Fender Stratocaster',
                description: 'Electric Guitar',
                model: 'American Professional II',
                price: '1499.99',
                quantity: '12',
                stockLevel: 'In Stock',
                brandId: '1',
                color: 'Sunburst',
                manufacturerId: '1',
                warranty: 'Lifetime',
                specifications: 'Alder body, Maple neck, Rosewood fingerboard',
                imageUrl: 'https://via.placeholder.com/40'
            },
            2: {
                name: 'Yamaha HS8',
                description: 'Studio Monitor',
                model: 'HS8',
                price: '349.99',
                quantity: '3',
                stockLevel: 'Low Stock',
                brandId: '2',
                color: 'Black',
                manufacturerId: '2',
                warranty: '2 years',
                specifications: '8-inch cone woofer, 1-inch dome tweeter',
                imageUrl: 'https://via.placeholder.com/40'
            },
            3: {
                name: 'Shure SM58',
                description: 'Dynamic Microphone',
                model: 'SM58',
                price: '99.99',
                quantity: '0',
                stockLevel: 'Out of Stock',
                brandId: '3',
                color: 'Black',
                manufacturerId: '3',
                warranty: '2 years',
                specifications: 'Cardioid polar pattern, 50Hz-15kHz frequency response',
                imageUrl: 'https://via.placeholder.com/40'
            }
        };

        const data = sampleData[id] || sampleData[1];

        // Populate the edit form with data
        document.getElementById('editInstrumentId').value = id;
        document.getElementById('editName').value = data.name;
        document.getElementById('editDescription').value = data.description;
        document.getElementById('editModel').value = data.model;
        document.getElementById('editPrice').value = data.price;
        document.getElementById('editQuantity').value = data.quantity;
        document.getElementById('editStockLevel').value = data.stockLevel;
        document.getElementById('editBrandId').value = data.brandId;
        document.getElementById('editColor').value = data.color;
        document.getElementById('editManufacturerId').value = data.manufacturerId;
        document.getElementById('editWarranty').value = data.warranty;
        document.getElementById('editSpecifications').value = data.specifications;
        document.getElementById('editImageUrl').value = data.imageUrl;

        // Show the edit modal
        openModal('editInstrumentModal');
    }

    // Delete instrument function
    function deleteInstrument(id) {
        if (confirm('Are you sure you want to delete this instrument? This action cannot be undone.')) {
            // In a real implementation, this would send a request to delete the instrument
            alert('Delete functionality for instrument ID: ' + id + ' would be implemented here');

            // Simulate removing the row from the table
            const rows = document.querySelectorAll('#inventoryTableBody tr');
            rows.forEach(row => {
                if (row.querySelector('button').onclick.toString().includes(id)) {
                    row.remove();
                }
            });
        }
    }
</script>
</body>
</html>