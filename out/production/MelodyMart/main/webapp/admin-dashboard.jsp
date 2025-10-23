<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Your existing CSS - keeping it all */
        :root {
            --primary: #1e40af;
            --primary-light: #3b82f6;
            --primary-soft: #dbeafe;
            --secondary: #ffffff;
            --accent: #06b6d4;
            --accent-alt: #ef4444;
            --text: #1e40af;
            --text-secondary: #475569;
            --text-soft: #64748b;
            --card-bg: #f8fafc;
            --card-hover: #ffffff;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
            --gradient-soft: linear-gradient(135deg, var(--primary-soft), #e0f2fe);
            --glass-bg: rgba(255, 255, 255, 0.9);
            --glass-border: rgba(255, 255, 255, 0.3);
            --shadow: 0 5px 20px rgba(30, 64, 175, 0.1);
            --shadow-hover: 0 10px 30px rgba(30, 64, 175, 0.2);
            --header-bg: rgba(255, 255, 255, 0.95);
            --section-bg: #f1f5f9;
            --border-radius: 16px;
        }

        [data-theme="dark"] {
            --primary: #3b82f6;
            --primary-light: #60a5fa;
            --primary-soft: #1e3a8a;
            --secondary: #1e40af;
            --accent: #22d3ee;
            --accent-alt: #f87171;
            --text: #f1f5f9;
            --text-secondary: #cbd5e1;
            --text-soft: #94a3b8;
            --card-bg: #1e293b;
            --card-hover: #334155;
            --glass-bg: rgba(30, 64, 175, 0.9);
            --glass-border: rgba(255, 255, 255, 0.1);
            --shadow: 0 5px 20px rgba(30, 64, 175, 0.3);
            --shadow-hover: 0 10px 30px rgba(30, 64, 175, 0.4);
            --header-bg: rgba(30, 64, 175, 0.95);
            --section-bg: #1e40af;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.4s ease, color 0.4s ease, border-color 0.4s ease, box-shadow 0.4s ease;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--secondary);
            color: var(--text);
            overflow-x: hidden;
            line-height: 1.6;
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
        }

        header.scrolled {
            padding: 15px 0;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
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

        .nav-links a.active {
            color: var(--primary-light);
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
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-left: 20px;
            position: relative;
            overflow: hidden;
            z-index: 1;
            box-shadow: 0 4px 15px rgba(30, 64, 175, 0.3);
        }

        .cta-btn:before {
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

        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(30, 64, 175, 0.4);
        }

        .cta-btn:hover:before {
            width: 100%;
        }

        /* Main Layout */
        .main-wrapper {
            display: flex;
            min-height: calc(100vh - 76px);
            margin-top: 76px;
        }

        /* Sidebar */
        .sidebar {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-right: 1px solid var(--glass-border);
            width: 280px;
            padding: 30px 20px;
            transition: all 0.3s ease;
            position: sticky;
            top: 76px;
            height: calc(100vh - 76px);
            overflow-y: auto;
            box-shadow: var(--shadow);
        }

        .sidebar-header {
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
            text-align: center;
        }

        .sidebar-header h4 {
            font-family: 'Playfair Display', serif;
            font-size: 26px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }

        .sidebar-header p {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .sidebar-menu {
            list-style: none;
        }

        .sidebar-menu li {
            margin-bottom: 12px;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            color: var(--text);
            text-decoration: none;
            padding: 14px 15px;
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
            border: 1px solid transparent;
        }

        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: var(--gradient);
            color: white;
            transform: translateX(5px);
            box-shadow: var(--shadow-hover);
            border-color: var(--primary-light);
        }

        .sidebar-menu i {
            margin-right: 12px;
            font-size: 18px;
            width: 24px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .sidebar-menu a:hover i, .sidebar-menu a.active i {
            transform: rotate(15deg);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
            background: var(--section-bg);
        }

        .dashboard-header {
            margin-bottom: 40px;
            text-align: center;
        }

        .dashboard-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 36px;
            margin-bottom: 10px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .dashboard-header p {
            color: var(--text-secondary);
            font-size: 16px;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 25px;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--gradient);
            opacity: 0.05;
            z-index: -1;
            border-radius: var(--border-radius);
        }

        .stat-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--shadow-hover);
        }

        .stat-icon {
            font-size: 36px;
            margin-bottom: 15px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 5px;
            color: var(--primary-light);
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Section Cards */
        .section-card {
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 0;
            margin-bottom: 35px;
            overflow: hidden;
            transition: all 0.4s ease;
            box-shadow: var(--shadow);
        }

        .section-card:hover {
            box-shadow: var(--shadow-hover);
        }

        .card-header {
            background: var(--primary-soft);
            padding: 25px;
            border-bottom: 1px solid var(--glass-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h3 {
            font-family: 'Playfair Display', serif;
            font-size: 26px;
            margin: 0;
            display: flex;
            align-items: center;
            color: var(--text);
        }

        .card-header h3 i {
            margin-right: 12px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 24px;
        }

        .card-header-actions {
            display: flex;
            gap: 10px;
        }

        .card-body {
            padding: 25px;
        }

        /* Tables */
        .table-container {
            overflow-x: auto;
            border-radius: 10px;
            background: var(--secondary);
            margin-top: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            color: var(--text);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--glass-border);
        }

        th {
            background: var(--primary-soft);
            font-weight: 600;
            color: var(--primary-light);
        }

        tr {
            transition: background 0.3s ease;
        }

        tr:hover {
            background: var(--primary-soft);
        }

        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            color: white;
        }

        .bg-success {
            background: linear-gradient(135deg, #28a745, #20c997);
        }

        .bg-warning {
            background: linear-gradient(135deg, #ffc107, #ff9800);
        }

        .bg-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
        }

        .bg-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
        }

        /* Forms */
        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            border-radius: 8px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.3);
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-secondary);
        }

        .form-select {
            background: var(--secondary);
            color: var(--text);
            border: 1px solid var(--glass-border);
            border-radius: 8px;
            padding: 12px 15px;
            width: 100%;
            transition: border-color 0.3s ease;
        }

        .form-select:focus {
            outline: none;
            border-color: var(--primary-light);
        }

        /* Grid System */
        .grid {
            display: grid;
        }

        .grid-cols-1 {
            grid-template-columns: repeat(1, 1fr);
        }

        .md\:grid-cols-2 {
            grid-template-columns: repeat(2, 1fr);
        }

        .md\:grid-cols-3 {
            grid-template-columns: repeat(3, 1fr);
        }

        .md\:grid-cols-4 {
            grid-template-columns: repeat(4, 1fr);
        }

        .md\:col-span-2 {
            grid-column: span 2;
        }

        .gap-4 {
            gap: 1rem;
        }

        /* Alerts */
        .alert {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            border-left: 4px solid;
        }

        .alert i {
            margin-right: 10px;
            font-size: 20px;
        }

        .alert-info {
            background: rgba(23, 162, 184, 0.1);
            border-left-color: #17a2b8;
            color: #17a2b8;
        }

        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            border-left-color: #dc3545;
            color: #dc3545;
        }

        .alert-warning {
            background: rgba(255, 193, 7, 0.1);
            border-left-color: #ffc107;
            color: #ffc107;
        }

        .alert-success {
            background: rgba(40, 167, 69, 0.1);
            border-left-color: #28a745;
            color: #28a745;
        }

        /* List Group */
        .list-group {
            list-style: none;
            border-radius: 10px;
            overflow: hidden;
            background: var(--secondary);
        }

        .list-group-item {
            padding: 15px;
            border-bottom: 1px solid var(--glass-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background 0.3s ease;
        }

        .list-group-item:hover {
            background: var(--primary-soft);
        }

        .list-group-item:last-child {
            border-bottom: none;
        }

        /* Charts */
        .chart-container {
            position: relative;
            height: 350px;
            width: 100%;
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
            background: var(--secondary);
            padding: 20px;
        }

        /* Buttons */
        .btn {
            padding: 10px 18px;
            border: none;
            border-radius: 20px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.4s ease, height 0.4s ease;
        }

        .btn:hover::before {
            width: 200px;
            height: 200px;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
        }

        .btn-primary:hover {
            background: var(--gradient-alt);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(30, 64, 175, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffc107, #ff9800);
            color: white;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
        }

        .btn-info {
            background: linear-gradient(135deg, #17a2b8, #138496);
            color: white;
        }

        .btn-info:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(23, 162, 184, 0.4);
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
        }

        .btn-outline-primary {
            background: transparent;
            border: 2px solid var(--primary-light);
            color: var(--primary-light);
        }

        .btn-outline-primary:hover {
            background: var(--primary-light);
            color: white;
        }

        /* Utility Classes */
        .mt-3 { margin-top: 0.75rem; }
        .mt-4 { margin-top: 1rem; }
        .mt-5 { margin-top: 1.25rem; }
        .mb-2 { margin-bottom: 0.5rem; }
        .py-4 { padding-top: 1rem; padding-bottom: 1rem; }
        .text-center { text-align: center; }
        .text-muted { color: var(--text-soft); }
        .w-full { width: 100%; }
        .float-right { float: right; }
        .text-sm { font-size: 0.875rem; }
        .font-semibold { font-weight: 600; }
        .flex { display: flex; }
        .flex-wrap { flex-wrap: wrap; }
        .gap-2 { gap: 0.5rem; }

        /* Footer */
        footer {
            background: var(--card-bg);
            padding: 30px 0;
            border-top: 1px solid var(--glass-border);
            text-align: center;
        }

        footer p {
            color: var(--text-secondary);
            margin: 0;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .nav-links {
                display: none;
            }

            .sidebar {
                width: 250px;
            }

            .main-content {
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            .main-wrapper {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                height: auto;
                position: static;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .card-header {
                flex-direction: column;
                gap: 10px;
            }

            .card-header-actions {
                align-self: flex-start;
            }

            .grid-cols-1, .md\:grid-cols-2, .md\:grid-cols-3, .md\:grid-cols-4 {
                grid-template-columns: 1fr;
            }

            .md\:col-span-2 {
                grid-column: 1;
            }
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: var(--card-bg);
            margin: 10% auto;
            padding: 20px;
            border-radius: var(--border-radius);
            width: 500px;
            max-width: 90%;
            box-shadow: var(--shadow-hover);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-secondary {
            background: var(--text-soft);
            color: white;
        }

        .btn-secondary:hover {
            background: var(--text-secondary);
        }
    </style>
</head>
<body>

<!-- Header/Navbar -->
<header>
    <div class="container nav-container">
        <div class="logo">
            <i class="fas fa-music"></i>
            Melody Mart Admin
        </div>

        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="admin-dashboard.jsp" class="active">Admin</a></li>
        </ul>

        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <button class="theme-toggle" aria-label="Toggle Theme" id="themeToggle">
                <i class="fas fa-moon"></i>
            </button>
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i></button>
            </div>
        </div>
    </div>
</header>

<div class="main-wrapper">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h4>Admin Dashboard</h4>
            <p>Control Center</p>
        </div>
        <ul class="sidebar-menu">
            <li><a href="#user-management"><i class="fas fa-users"></i> User Management</a></li>
            <li><a href="#stock-management" class="active"><i class="fas fa-boxes"></i> Stock Management</a></li>
            <li><a href="#item-review"><i class="fas fa-flag"></i> Item Review Queue</a></li>
            <li><a href="#reporting"><i class="fas fa-chart-bar"></i> Reporting Tools</a></li>
            <li><a href="#policy-update"><i class="fas fa-file-alt"></i> Policy Update</a></li>
            <li><a href="#admin-management"><i class="fas fa-user-shield"></i> Admin Management</a></li>
            <li><a href="#feedback-management"><i class="fas fa-comments"></i> Feedback Management</a></li>
            <li><a href="#monitoring"><i class="fas fa-desktop"></i> Monitoring Dashboard</a></li>
            <li><a href="#notifications"><i class="fas fa-bell"></i> Notifications & Alerts</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="dashboard-header">
            <h2>Admin Dashboard</h2>
            <p>As of 11:07 AM +0530 on October 23, 2025, manage all aspects of the platform efficiently with premium tools and insights.</p>
        </div>

        <!-- Stats Overview -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-users"></i></div>
                <div class="stat-value">1,248</div>
                <div class="stat-label">Total Users</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-shopping-cart"></i></div>
                <div class="stat-value">356</div>
                <div class="stat-label">Orders Today</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-box-open"></i></div>
                <div class="stat-value">5,892</div>
                <div class="stat-label">Products in Stock</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-star"></i></div>
                <div class="stat-value">4.8/5</div>
                <div class="stat-label">Average Rating</div>
            </div>
        </div>

        <!-- Stock Management Section -->
        <section id="stock-management" class="section-card">
            <div class="card-header">
                <h3><i class="fas fa-boxes"></i> Stock Management Tools</h3>
                <div class="card-header-actions">
                    <form action="${pageContext.request.contextPath}/ExportStockReportServlet" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-sm btn-success">
                            <i class="fas fa-file-export"></i> Export CSV
                        </button>
                    </form>
                    <button class="btn btn-sm btn-primary" onclick="refreshStockStatus()">
                        <i class="fas fa-sync-alt"></i> Refresh Status
                    </button>
                </div>
            </div>

            <div class="card-body">
                <p>Quickly update instrument stock levels, track availability, and get real-time alerts for low or oversold items.</p>

                <!-- Success/Error Messages -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${message}
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <!-- Instrument List with Filters -->
                <div class="instrument-list mt-4">
                    <h5><i class="fas fa-list text-info"></i> Instrument List with Filters</h5>

                    <!-- Filter Form -->
                    <form id="filterForm" class="grid grid-cols-1 md:grid-cols-4 gap-4 mt-3">
                        <div class="form-group">
                            <label class="form-label">Search by Name</label>
                            <input type="text" id="nameFilter" name="name" class="form-control" placeholder="Instrument name...">
                        </div>

                        <div class="form-group">
                            <label class="form-label">Category</label>
                            <select id="categoryFilter" name="category" class="form-select">
                                <option value="">All Categories</option>
                                <option value="Guitars">Guitars</option>
                                <option value="Pianos">Pianos</option>
                                <option value="Drums">Drums</option>
                                <option value="Violins">Violins</option>
                                <option value="Wind Instruments">Wind Instruments</option>
                                <option value="Studio Monitors">Studio Monitors</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Stock Level</label>
                            <select id="stockLevelFilter" name="stockLevel" class="form-select">
                                <option value="">All Stock Levels</option>
                                <option value="In Stock">In Stock</option>
                                <option value="Low Stock">Low Stock</option>
                                <option value="Out of Stock">Out of Stock</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label">&nbsp;</label>
                            <div class="flex gap-2">
                                <button type="button" onclick="filterInstruments()" class="btn btn-info w-full">
                                    <i class="fas fa-filter"></i> Filter
                                </button>
                                <button type="button" onclick="clearFilters()" class="btn btn-outline-primary">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Instrument List Table -->
                    <div class="table-container mt-4">
                        <table id="instrumentsTable" class="w-full">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Quantity</th>
                                <th>Stock Level</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Evidence</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody id="instrumentsTableBody">
                            <!-- Sample Data -->
                            <tr data-name="fender stratocaster" data-category="Guitars" data-stock="In Stock">
                                <td>1</td>
                                <td>Fender Stratocaster</td>
                                <td>15</td>
                                <td><span class="badge bg-success">In Stock</span></td>
                                <td>Guitars</td>
                                <td>$1499.99</td>
                                <td>No evidence</td>
                                <td>
                                    <button onclick="quickUpdate(1)" class="btn btn-sm btn-primary">
                                        <i class="fas fa-edit"></i> Update
                                    </button>
                                    <button onclick="quickRemove(1)" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i> Remove
                                    </button>
                                    <button onclick="quickCorrection(1)" class="btn btn-sm btn-warning">
                                        <i class="fas fa-exchange-alt"></i> Correct
                                    </button>
                                </td>
                            </tr>
                            <tr data-name="yamaha hs8" data-category="Studio Monitors" data-stock="Low Stock">
                                <td>2</td>
                                <td>Yamaha HS8</td>
                                <td>3</td>
                                <td><span class="badge bg-warning">Low Stock</span></td>
                                <td>Studio Monitors</td>
                                <td>$349.99</td>
                                <td>No evidence</td>
                                <td>
                                    <button onclick="quickUpdate(2)" class="btn btn-sm btn-primary">
                                        <i class="fas fa-edit"></i> Update
                                    </button>
                                    <button onclick="quickRemove(2)" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i> Remove
                                    </button>
                                    <button onclick="quickCorrection(2)" class="btn btn-sm btn-warning">
                                        <i class="fas fa-exchange-alt"></i> Correct
                                    </button>
                                </td>
                            </tr>
                            <tr data-name="yamaha piano" data-category="Pianos" data-stock="In Stock">
                                <td>3</td>
                                <td>Yamaha Grand Piano</td>
                                <td>8</td>
                                <td><span class="badge bg-success">In Stock</span></td>
                                <td>Pianos</td>
                                <td>$4500.00</td>
                                <td>No evidence</td>
                                <td>
                                    <button onclick="quickUpdate(3)" class="btn btn-sm btn-primary">
                                        <i class="fas fa-edit"></i> Update
                                    </button>
                                    <button onclick="quickRemove(3)" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i> Remove
                                    </button>
                                    <button onclick="quickCorrection(3)" class="btn btn-sm btn-warning">
                                        <i class="fas fa-exchange-alt"></i> Correct
                                    </button>
                                </td>
                            </tr>
                            <tr data-name="pearl drum set" data-category="Drums" data-stock="Out of Stock">
                                <td>4</td>
                                <td>Pearl Drum Set</td>
                                <td>0</td>
                                <td><span class="badge bg-danger">Out of Stock</span></td>
                                <td>Drums</td>
                                <td>$1200.00</td>
                                <td>No evidence</td>
                                <td>
                                    <button onclick="quickUpdate(4)" class="btn btn-sm btn-primary">
                                        <i class="fas fa-edit"></i> Update
                                    </button>
                                    <button onclick="quickRemove(4)" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i> Remove
                                    </button>
                                    <button onclick="quickCorrection(4)" class="btn btn-sm btn-warning">
                                        <i class="fas fa-exchange-alt"></i> Correct
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div id="noInstrumentsMessage" class="text-center py-4 text-muted" style="display: none;">
                            <i class="fas fa-search fa-2x mb-2"></i><br>
                            No instruments found. Try adjusting your filters.
                        </div>
                    </div>
                </div>

                <!-- Simple Stock Update Form -->
                <div class="simple-stock-update mt-5">
                    <h5><i class="fas fa-sync-alt text-success"></i> Quick Stock Update</h5>
                    <form action="${pageContext.request.contextPath}/UpdateStockServlet" method="post" class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-3">
                        <div class="form-group">
                            <label for="instrumentId" class="form-label">Instrument ID</label>
                            <input type="text" class="form-control" id="instrumentId" name="instrumentId" placeholder="Enter ID" required>
                        </div>
                        <div class="form-group">
                            <label for="stockQuantity" class="form-label">New Quantity</label>
                            <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" placeholder="e.g. 20" min="0" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">&nbsp;</label>
                            <button type="submit" class="btn btn-success w-full">
                                <i class="fas fa-save"></i> Update Stock
                            </button>
                        </div>
                    </form>
                </div>-

                <!-- Stock Correction Form with Evidence -->
                <div class="stock-correction mt-5">
                    <h5><i class="fas fa-exchange-alt text-primary"></i> Stock Correction with Evidence</h5>

                    <div class="stock-correction-form">
                        <form action="${pageContext.request.contextPath}/StockCorrectionServlet"
                              method="post"
                              enctype="multipart/form-data"
                              onsubmit="return validateStockCorrection()"
                              id="stockCorrectionForm">

                            <h3><i class="fas fa-clipboard-check"></i> Stock Correction with Evidence</h3>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div class="form-group">
                                    <label for="correctionInstrumentId" class="form-label">Instrument ID</label>
                                    <select name="instrumentId" id="correctionInstrumentId" class="form-control" required>
                                        <option value="">Select Instrument ID</option>
                                        <%
                                            List<String> instrumentIDs = new ArrayList<>();
                                            try (Connection conn = DBConnection.getConnection()) {
                                                String sql = "SELECT InstrumentID FROM Instrument ORDER BY InstrumentID";
                                                PreparedStatement ps = conn.prepareStatement(sql);
                                                ResultSet rs = ps.executeQuery();
                                                while (rs.next()) {
                                                    instrumentIDs.add(rs.getString("InstrumentID"));
                                                }
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            }
                                            for (String id : instrumentIDs) {
                                        %>
                                        <option value="<%= id %>"><%= id %></option>
                                        <% } %>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="correctedQuantity" class="form-label">Corrected Quantity</label>
                                    <input type="number"
                                           name="correctedQuantity"
                                           id="correctedQuantity"
                                           class="form-control"
                                           placeholder="Enter new quantity"
                                           min="0"
                                           required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="reason" class="form-label">Reason for Correction</label>
                                <textarea name="reason"
                                          id="reason"
                                          class="form-control"
                                          placeholder="Enter detailed reason for stock correction..."
                                          rows="3"
                                          required></textarea>
                            </div>

                            <div class="form-group">
                                <label for="evidenceNote" class="form-label">Evidence Note (Optional)</label>
                                <textarea name="evidenceNote"
                                          id="evidenceNote"
                                          class="form-control"
                                          placeholder="Reference numbers, additional notes, etc."
                                          rows="2"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="evidenceImages" class="form-label">
                                    <i class="fas fa-images"></i> Image Evidence
                                </label>
                                <input type="file"
                                       name="evidenceImages"
                                       id="evidenceImages"
                                       class="form-control"
                                       accept=".jpg,.jpeg,.png,.pdf"
                                       multiple>
                                <small class="form-text">You can attach multiple images (JPG, PNG, PDF). Max file size: 5MB each.</small>
                                <div id="fileList" class="file-list"></div>
                            </div>

                            <div class="form-group">
                                <label for="adminUsername" class="form-label">Admin Username</label>
                                <input type="text"
                                       name="adminUsername"
                                       id="adminUsername"
                                       class="form-control"
                                       placeholder="Enter username"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="adminPassword" class="form-label">Admin Password</label>
                                <input type="password"
                                       name="adminPassword"
                                       id="adminPassword"
                                       class="form-control"
                                       placeholder="Enter password"
                                       required>
                            </div>

                            <div class="form-actions">
                                <button type="button" class="btn btn-secondary" onclick="clearCorrectionForm()">
                                    <i class="fas fa-times"></i> Cancel
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-check-circle"></i> Apply Stock Correction
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <%@ page import="java.sql.*, java.util.*" %>
                <%
                    // Handle Admin Management Operations
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        String action = request.getParameter("action");
                        String adminID = request.getParameter("adminID");
                        String email = request.getParameter("email");
                        String clearanceLevel = request.getParameter("clearanceLevel");

                        Connection adminConn = null;
                        PreparedStatement adminStmt = null;
                        ResultSet adminRs = null;

                        try {
                            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                            String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true";
                            String dbUser = "Hasiru";
                            String dbPassword = "hasiru2004";

                            adminConn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                            if ("add".equals(action)) {
                                // Grant admin access to existing user
                                if (email != null && clearanceLevel != null) {
                                    // Check if person exists
                                    String checkSql = "SELECT PersonID FROM Person WHERE Email = ?";
                                    adminStmt = adminConn.prepareStatement(checkSql);
                                    adminStmt.setString(1, email.trim().toLowerCase());
                                    adminRs = adminStmt.executeQuery();

                                    if (adminRs.next()) {
                                        int personId = adminRs.getInt("PersonID");

                                        // Check if already admin
                                        String adminCheckSql = "SELECT COUNT(*) FROM Admin WHERE PersonID = ?";
                                        adminStmt = adminConn.prepareStatement(adminCheckSql);
                                        adminStmt.setInt(1, personId);
                                        adminRs = adminStmt.executeQuery();
                                        adminRs.next();

                                        if (adminRs.getInt(1) > 0) {
                                            session.setAttribute("adminError", "User is already an admin");
                                        } else {
                                            // Grant admin access
                                            String insertSql = "INSERT INTO Admin (AdminID, PersonID, ClearanceLevel, JoinDate) VALUES (?, ?, ?, GETDATE())";
                                            adminStmt = adminConn.prepareStatement(insertSql);
                                            adminStmt.setInt(1, personId);
                                            adminStmt.setInt(2, personId);
                                            adminStmt.setString(3, clearanceLevel);

                                            int result = adminStmt.executeUpdate();
                                            if (result > 0) {
                                                session.setAttribute("adminMessage", "Admin access granted successfully!");
                                            }
                                        }
                                    } else {
                                        session.setAttribute("adminError", "User with this email not found");
                                    }
                                }
                            }
                            else if ("update".equals(action)) {
                                // Update clearance level
                                if (adminID != null && clearanceLevel != null) {
                                    String sql = "UPDATE Admin SET ClearanceLevel = ? WHERE AdminID = ?";
                                    adminStmt = adminConn.prepareStatement(sql);
                                    adminStmt.setString(1, clearanceLevel);
                                    adminStmt.setInt(2, Integer.parseInt(adminID));

                                    int rowsAffected = adminStmt.executeUpdate();
                                    if (rowsAffected > 0) {
                                        session.setAttribute("adminMessage", "Clearance level updated successfully!");
                                    } else {
                                        session.setAttribute("adminError", "Admin not found");
                                    }
                                }
                            }
                            else if ("delete".equals(action)) {
                                // Revoke admin access
                                if (adminID != null) {
                                    int adminId = Integer.parseInt(adminID);

                                    // Prevent removing yourself
                                    Integer currentAdminId = (Integer) session.getAttribute("adminId");
                                    if (currentAdminId != null && currentAdminId == adminId) {
                                        session.setAttribute("adminError", "Cannot revoke your own admin access");
                                    } else {
                                        // Check if this is the last super admin
                                        boolean isLastSuperAdmin = false;
                                        String checkSql = "SELECT 1 FROM Admin WHERE AdminID = ? AND ClearanceLevel = 'Super'";
                                        adminStmt = adminConn.prepareStatement(checkSql);
                                        adminStmt.setInt(1, adminId);
                                        adminRs = adminStmt.executeQuery();

                                        boolean isSuperAdmin = adminRs.next();

                                        if (isSuperAdmin) {
                                            String countSql = "SELECT COUNT(*) as superAdminCount FROM Admin WHERE ClearanceLevel = 'Super'";
                                            adminStmt = adminConn.prepareStatement(countSql);
                                            adminRs = adminStmt.executeQuery();

                                            if (adminRs.next()) {
                                                int superAdminCount = adminRs.getInt("superAdminCount");
                                                isLastSuperAdmin = (superAdminCount <= 1);
                                            }
                                        }

                                        if (isLastSuperAdmin) {
                                            session.setAttribute("adminError", "Cannot remove the last super admin");
                                        } else {
                                            String sql = "DELETE FROM Admin WHERE AdminID = ?";
                                            adminStmt = adminConn.prepareStatement(sql);
                                            adminStmt.setInt(1, adminId);

                                            int rowsAffected = adminStmt.executeUpdate();
                                            if (rowsAffected > 0) {
                                                session.setAttribute("adminMessage", "Admin access revoked successfully!");
                                            } else {
                                                session.setAttribute("adminError", "Admin not found");
                                            }
                                        }
                                    }
                                }
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                            session.setAttribute("adminError", "Database error: " + e.getMessage());
                        } finally {
                            if (adminRs != null) try { adminRs.close(); } catch (SQLException e) {}
                            if (adminStmt != null) try { adminStmt.close(); } catch (SQLException e) {}
                            if (adminConn != null) try { adminConn.close(); } catch (SQLException e) {}

                            // Redirect to avoid form resubmission
                            response.sendRedirect("admin-dashboard.jsp#admin-management");
                            return;
                        }
                    }

                    // Get current admins for display
                    List<Map<String, String>> adminList = new ArrayList<>();
                    Connection displayConn = null;
                    PreparedStatement displayStmt = null;
                    ResultSet displayRs = null;

                    try {
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true";
                        String dbUser = "Hasiru";
                        String dbPassword = "hasiru2004";

                        displayConn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                        String sql = "SELECT p.PersonID, p.FirstName, p.LastName, p.Email, " +
                                "a.ClearanceLevel, a.JoinDate, a.LastLogin " +
                                "FROM Person p " +
                                "INNER JOIN Admin a ON p.PersonID = a.PersonID " +
                                "ORDER BY p.PersonID";

                        displayStmt = displayConn.prepareStatement(sql);
                        displayRs = displayStmt.executeQuery();

                        while (displayRs.next()) {
                            Map<String, String> admin = new HashMap<>();
                            admin.put("personId", String.valueOf(displayRs.getInt("PersonID")));
                            admin.put("firstName", displayRs.getString("FirstName"));
                            admin.put("lastName", displayRs.getString("LastName"));
                            admin.put("email", displayRs.getString("Email"));
                            admin.put("clearanceLevel", displayRs.getString("ClearanceLevel"));
                            admin.put("joinDate", displayRs.getDate("JoinDate").toString());
                            admin.put("lastLogin", displayRs.getTimestamp("LastLogin") != null ?
                                    displayRs.getTimestamp("LastLogin").toString() : "Never");
                            adminList.add(admin);
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (displayRs != null) try { displayRs.close(); } catch (SQLException e) {}
                        if (displayStmt != null) try { displayStmt.close(); } catch (SQLException e) {}
                        if (displayConn != null) try { displayConn.close(); } catch (SQLException e) {}
                    }
                %>



                <!-- Other sections (User Management, Item Review, etc.) would go here -->
                <!-- Admin Management Section -->
                <section id="admin-management" class="section-card">
                    <div class="card-header">
                        <h3><i class="fas fa-user-shield"></i> Admin Management</h3>
                        <div class="card-header-actions">
                            <button class="btn btn-sm btn-success" onclick="showAddAdminModal()">
                                <i class="fas fa-plus"></i> Grant Admin Access
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Success/Error Messages -->
                        <c:if test="${not empty adminMessage}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle"></i> ${adminMessage}
                            </div>
                            <c:remove var="adminMessage" scope="session"/>
                        </c:if>
                        <c:if test="${not empty adminError}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-circle"></i> ${adminError}
                            </div>
                            <c:remove var="adminError" scope="session"/>
                        </c:if>

                        <!-- Current Admins Table -->
                        <div class="table-container">
                            <table id="adminsTable">
                                <thead>
                                <tr>
                                    <th>Admin ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Clearance Level</th>
                                    <th>Join Date</th>
                                    <th>Last Login</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% for (Map<String, String> admin : adminList) { %>
                                <tr>
                                    <td><%= admin.get("personId") %></td>
                                    <td><%= admin.get("firstName") %> <%= admin.get("lastName") %></td>
                                    <td><%= admin.get("email") %></td>
                                    <td>
                                        <form method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="adminID" value="<%= admin.get("personId") %>">
                                            <select name="clearanceLevel" class="form-select" onchange="this.form.submit()">
                                                <option value="Low" <%= "Low".equals(admin.get("clearanceLevel")) ? "selected" : "" %>>Low</option>
                                                <option value="Medium" <%= "Medium".equals(admin.get("clearanceLevel")) ? "selected" : "" %>>Medium</option>
                                                <option value="High" <%= "High".equals(admin.get("clearanceLevel")) ? "selected" : "" %>>High</option>
                                                <option value="Super" <%= "Super".equals(admin.get("clearanceLevel")) ? "selected" : "" %>>Super</option>
                                            </select>
                                        </form>
                                    </td>
                                    <td><%= admin.get("joinDate") %></td>
                                    <td><%= admin.get("lastLogin") %></td>
                                    <td>
                                        <form method="post" style="display: inline;"
                                              onsubmit="return confirm('Are you sure you want to revoke admin privileges from <%= admin.get("firstName") %> <%= admin.get("lastName") %>?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="adminID" value="<%= admin.get("personId") %>">
                                            <button type="submit" class="btn btn-sm btn-danger"
                                                    <%= (Integer) session.getAttribute("adminId") != null &&
                                                            (Integer) session.getAttribute("adminId") == Integer.parseInt(admin.get("personId")) ? "disabled" : "" %>>
                                                <i class="fas fa-trash"></i> Revoke
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                <% } %>
                                <% if (adminList.isEmpty()) { %>
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">
                                        <i class="fas fa-users fa-2x mb-2"></i><br>
                                        No admins found. Grant admin access to users to get started.
                                    </td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Grant Admin Access Modal -->
                        <div id="addAdminModal" class="modal">
                            <div class="modal-content">
                                <h4>Grant Admin Access</h4>
                                <form method="post">
                                    <input type="hidden" name="action" value="add">
                                    <div class="form-group">
                                        <label class="form-label">Find User by Email</label>
                                        <input type="email" name="email" class="form-control" placeholder="Enter user's email" required>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Clearance Level</label>
                                        <select name="clearanceLevel" class="form-control" required>
                                            <option value="">Select Clearance Level</option>
                                            <option value="Low">Low - Basic access</option>
                                            <option value="Medium">Medium - Moderate access</option>
                                            <option value="High">High - Full access</option>
                                            <option value="Super">Super - Full system access</option>
                                        </select>
                                    </div>
                                    <div class="form-actions">
                                        <button type="button" onclick="hideAddAdminModal()" class="btn btn-secondary">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Grant Admin Access</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </section>



    </div>
</div>

<!-- Footer -->
<footer>
    <div class="container">
        <p>© 2025 Melody Mart. All rights reserved.</p>
    </div>
</footer>

<script>

    // Sample instrument data
    const sampleInstruments = [
        { id: 1, name: "Fender Stratocaster", quantity: 15, stockLevel: "In Stock", category: "Guitars", price: 1499.99 },
        { id: 2, name: "Yamaha HS8", quantity: 3, stockLevel: "Low Stock", category: "Studio Monitors", price: 349.99 },
        { id: 3, name: "Yamaha Grand Piano", quantity: 8, stockLevel: "In Stock", category: "Pianos", price: 4500.00 },
        { id: 4, name: "Pearl Drum Set", quantity: 0, stockLevel: "Out of Stock", category: "Drums", price: 1200.00 }
    ];

    // Initialize when page loads
    // Initialize when page loads
    document.addEventListener('DOMContentLoaded', function() {
        initializeTheme();
        initializeSidebarNavigation();

        // Show all instruments initially
        filterInstruments();

        // Add real-time filtering
        document.getElementById('nameFilter').addEventListener('input', filterInstruments);
        document.getElementById('categoryFilter').addEventListener('change', filterInstruments);
        document.getElementById('stockLevelFilter').addEventListener('change', filterInstruments);
    });
    // Theme toggle functionality
    function initializeTheme() {
        const themeToggle = document.getElementById('themeToggle');
        const themeIcon = themeToggle.querySelector('i');

        const currentTheme = localStorage.getItem('theme') || 'light';
        document.documentElement.setAttribute('data-theme', currentTheme);
        updateThemeIcon(currentTheme);

        themeToggle.addEventListener('click', () => {
            const currentTheme = document.documentElement.getAttribute('data-theme');
            const newTheme = currentTheme === 'light' ? 'dark' : 'light';

            document.documentElement.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            updateThemeIcon(newTheme);
        });

        // SIMPLE Admin Management Functions - No Servlet Needed
        function updateClearanceLevel(selectElement) {
            const adminID = selectElement.getAttribute('data-admin-id');
            const newLevel = selectElement.value;

            // Just show a success message
            showAlert(`Clearance level for admin ${adminID} updated to ${newLevel}`, 'success');
        }

        function removeAdmin(adminID) {
            if(confirm('Are you sure you want to remove this admin? They will lose all admin privileges.')) {
                // Just show a success message
                showAlert(`Admin ${adminID} has been removed`, 'success');
            }
        }

        function handleAddAdmin(event) {
            event.preventDefault();

            const formData = new FormData(event.target);
            const firstName = formData.get('firstName');
            const lastName = formData.get('lastName');

            // Just show a success message
            showAlert(`New admin ${firstName} ${lastName} has been added successfully!`, 'success');

            // Hide the modal
            hideAddAdminModal();

            // Reset the form
            event.target.reset();

            return false;
        }

        function showAlert(message, type) {
            // Create a simple alert
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type}`;
            alertDiv.innerHTML = `<i class="fas fa-${type == 'success' ? 'check' : 'exclamation'}-circle"></i> ${message}`;

            // Add to the page
            document.querySelector('.main-content').insertBefore(alertDiv, document.querySelector('.main-content').firstChild);

            // Remove after 5 seconds
            setTimeout(() => {
                alertDiv.remove();
            }, 5000);
        }

        function showAddAdminModal() {
            document.getElementById('addAdminModal').style.display = 'block';
        }

        function hideAddAdminModal() {
            document.getElementById('addAdminModal').style.display = 'none';
        }

        document.getElementById("evidenceImages").addEventListener("change", function(event) {
            const files = event.target.files;
            if (files.length > 0) {
                const fileNames = Array.from(files).map(file => file.name);
                console.log("Uploaded Image Names:", fileNames);

            }
        });

        function submitStockCorrection() {
            const form = document.querySelector('form[action*="StockCorrectionServlet"]');
            const formData = new FormData(form);

            console.log("Submitting to:", form.action);
            console.log("Form data:", {
                instrumentId: formData.get('instrumentId'),
                correctedQuantity: formData.get('correctedQuantity'),
                reason: formData.get('reason'),
                evidenceNote: formData.get('evidenceNote'),
                imageNames: formData.get('evidenceImages') // ✅ list of image names
            });

            return true; // Allow form to submit
        }

        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            const modal = document.getElementById('addAdminModal');
            if (event.target === modal) {
                hideAddAdminModal();
            }
        });

        function updateThemeIcon(theme) {
            themeIcon.className = theme === 'light' ? 'fas fa-moon' : 'fas fa-sun';
        }
    }

    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        header.classList.toggle('scrolled', window.scrollY > 50);
    });

    // FIXED Filter instruments function
    function filterInstruments() {
        console.log("=== FILTERING INSTRUMENTS ===");

        const nameFilter = document.getElementById('nameFilter').value.toLowerCase();
        const categoryFilter = document.getElementById('categoryFilter').value;
        const stockLevelFilter = document.getElementById('stockLevelFilter').value;

        console.log("Filters:", { nameFilter, categoryFilter, stockLevelFilter });

        const rows = document.querySelectorAll('#instrumentsTableBody tr');
        console.log("Total rows found:", rows.length);

        let visibleCount = 0;

        rows.forEach((row, index) => {
            // Get data from each row more reliably
            const name = row.cells[1].textContent.toLowerCase();
            const category = row.cells[4].textContent;
            const stockLevel = row.cells[3].querySelector('.badge').textContent;

            console.log(`Row ${index}:`, { name, category, stockLevel });

            const matchesName = nameFilter === '' || name.includes(nameFilter);
            const matchesCategory = categoryFilter === '' || category === categoryFilter;
            const matchesStockLevel = stockLevelFilter === '' || stockLevel === stockLevelFilter;

            console.log(`Row ${index} matches:`, { matchesName, matchesCategory, matchesStockLevel });

            if (matchesName && matchesCategory && matchesStockLevel) {
                row.style.display = '';
                visibleCount++;
                console.log(`Row ${index}: SHOW`);
            } else {
                row.style.display = 'none';
                console.log(`Row ${index}: HIDE`);
            }
        });

        console.log("Visible count after filtering:", visibleCount);

        document.getElementById('noInstrumentsMessage').style.display =
            visibleCount === 0 ? 'block' : 'none';
    }

    function clearFilters() {
        document.getElementById('nameFilter').value = '';
        document.getElementById('categoryFilter').value = '';
        document.getElementById('stockLevelFilter').value = '';
        filterInstruments();
    }

    function refreshStockStatus() {
        alert('Refreshing stock status...');
        // Add your refresh logic here
    }

    function quickUpdate(id) {
        alert('Quick update for instrument ID: ' + id);
    }

    function quickRemove(id) {
        if(confirm('Are you sure you want to remove instrument ' + id + '?')) {
            alert('Removing instrument: ' + id);
        }
    }

    function quickCorrection(id) {
        alert('Quick correction for instrument ID: ' + id);
    }

    // Sidebar navigation
    function initializeSidebarNavigation() {
        const sidebarLinks = document.querySelectorAll('.sidebar-menu a');
        sidebarLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                sidebarLinks.forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            });
        });
    }
    function validateStockCorrection() {
        const instrumentId = document.getElementById('correctionInstrumentId').value;
        const quantity = document.getElementById('correctedQuantity').value;
        const reason = document.getElementById('reason').value;
        const username = document.getElementById('adminUsername').value;
        const password = document.getElementById('adminPassword').value;

        console.log("Validating stock correction:");
        console.log("Instrument ID:", instrumentId);
        console.log("Quantity:", quantity);
        console.log("Reason:", reason);

        // Basic validation
        if (!instrumentId || !quantity || !reason || !username || !password) {
            alert("Please fill in all fields");
            return false;
        }

        if (quantity < 0) {
            alert("Quantity cannot be negative");
            return false;
        }

        // Hardcoded credential check
        if (username !== 'ravini' || password !== 'ravini2004') {
            alert("Invalid admin credentials");
            return false;
        }

        // Optional: enforce at least one image
        // const images = document.getElementById('evidenceImages').files;
        // if (images.length === 0) {
        //     alert("Please attach at least one evidence image.");
        //     return false;
        // }

        console.log("Validation passed - submitting form");
        return true;
    }

    // Admin Management Functions
    function showAddAdminModal() {
        document.getElementById('addAdminModal').style.display = 'block';
    }

    function hideAddAdminModal() {
        document.getElementById('addAdminModal').style.display = 'none';
    }

    // Close modal when clicking outside
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('addAdminModal');
        if (event.target === modal) {
            hideAddAdminModal();
        }
    });
</script>
</body>
</html>