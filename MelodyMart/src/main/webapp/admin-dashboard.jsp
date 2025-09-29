<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
            background: linear-gradient(135deg, rgba(10, 10, 10, 0.95), rgba(20, 20, 20, 0.95)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-attachment: fixed;
            color: var(--text);
            line-height: 1.6;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .container-fluid {
            padding: 0;
        }

        /* Enhanced Navbar */
        .navbar {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            padding: 15px 40px;
            border-bottom: 1px solid var(--glass-border);
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            animation: slideDown 0.5s ease-out;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            transition: transform 0.3s ease;
            text-decoration: none;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .navbar-brand i {
            margin-right: 10px;
            font-size: 32px;
            animation: pulse 2s infinite;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .nav-link {
            color: var(--text);
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 8px 16px;
            border-radius: 20px;
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .nav-link:hover {
            color: var(--primary-light);
            background: rgba(138, 43, 226, 0.1);
            transform: translateY(-2px);
        }

        .nav-link i {
            margin-right: 8px;
        }

        .nav-link:after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 2px;
            background: var(--gradient);
            transition: width 0.3s ease;
        }

        .nav-link:hover:after {
            width: 80%;
        }

        /* Main Layout */
        .main-wrapper {
            display: flex;
            min-height: calc(100vh - 76px);
        }

        /* Sidebar */
        .sidebar {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--glass-border);
            width: 280px;
            padding: 30px 20px;
            transition: all 0.3s ease;
            position: sticky;
            top: 76px;
            height: calc(100vh - 76px);
            overflow-y: auto;
            animation: slideInLeft 0.5s ease-out;
            box-shadow: 2px 0 20px rgba(0, 0, 0, 0.2);
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
            opacity: 0;
            transform: translateX(-20px);
            animation: fadeInRight 0.5s ease-out forwards;
        }

        .sidebar-menu li:nth-child(1) { animation-delay: 0.1s; }
        .sidebar-menu li:nth-child(2) { animation-delay: 0.15s; }
        .sidebar-menu li:nth-child(3) { animation-delay: 0.2s; }
        .sidebar-menu li:nth-child(4) { animation-delay: 0.25s; }
        .sidebar-menu li:nth-child(5) { animation-delay: 0.3s; }
        .sidebar-menu li:nth-child(6) { animation-delay: 0.35s; }
        .sidebar-menu li:nth-child(7) { animation-delay: 0.4s; }
        .sidebar-menu li:nth-child(8) { animation-delay: 0.45s; }
        .sidebar-menu li:nth-child(9) { animation-delay: 0.5s; }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            color: var(--text);
            text-decoration: none;
            padding: 14px 15px;
            border-radius: 10px;
            transition: all 0.3s ease;
            border: 1px solid transparent;
        }

        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: var(--gradient);
            color: white;
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
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
            background: linear-gradient(to bottom, rgba(10, 10, 10, 0.8), rgba(20, 20, 20, 0.8));
        }

        .dashboard-header {
            margin-bottom: 40px;
            text-align: center;
            animation: fadeInUp 0.5s ease-out 0.3s both;
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
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            border-radius: 18px;
            padding: 25px;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .stat-card:nth-child(1) { animation-delay: 0.4s; }
        .stat-card:nth-child(2) { animation-delay: 0.5s; }
        .stat-card:nth-child(3) { animation-delay: 0.6s; }
        .stat-card:nth-child(4) { animation-delay: 0.7s; }

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
            border-radius: 18px;
        }

        .stat-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 15px 30px rgba(138, 43, 226, 0.25);
        }

        .stat-icon {
            font-size: 36px;
            margin-bottom: 15px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: pulse 2s infinite;
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
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            border-radius: 18px;
            padding: 0;
            margin-bottom: 35px;
            overflow: hidden;
            transition: all 0.4s ease;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .section-card:nth-child(1) { animation-delay: 0.5s; }
        .section-card:nth-child(2) { animation-delay: 0.6s; }
        .section-card:nth-child(3) { animation-delay: 0.7s; }
        .section-card:nth-child(4) { animation-delay: 0.8s; }
        .section-card:nth-child(5) { animation-delay: 0.9s; }
        .section-card:nth-child(6) { animation-delay: 1.0s; }
        .section-card:nth-child(7) { animation-delay: 1.1s; }
        .section-card:nth-child(8) { animation-delay: 1.2s; }

        .section-card:hover {
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
        }

        .card-header {
            background: rgba(138, 43, 226, 0.15);
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
            background: rgba(20, 20, 20, 0.5);
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
            background: rgba(138, 43, 226, 0.1);
            font-weight: 600;
            color: var(--primary-light);
        }

        tr {
            opacity: 0;
            animation: fadeIn 0.6s ease-out forwards;
            transition: background 0.3s ease;
        }

        tr:nth-child(1) { animation-delay: 0.3s; }
        tr:nth-child(2) { animation-delay: 0.4s; }
        tr:nth-child(3) { animation-delay: 0.5s; }

        tr:hover {
            background: rgba(255, 255, 255, 0.08);
        }

        .badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge.bg-success {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .badge.bg-warning {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
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
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
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

        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
        }

        /* Forms */
        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--glass-border);
            background: var(--card-bg);
            color: var(--text);
            border-radius: 8px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.3);
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-secondary);
        }

        .form-select {
            background: var(--card-bg);
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

        /* Alerts */
        .alert {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            animation: slideInRight 0.5s ease-out;
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

        /* List Group */
        .list-group {
            list-style: none;
            border-radius: 10px;
            overflow: hidden;
            background: var(--card-bg);
        }

        .list-group-item {
            padding: 15px;
            border-bottom: 1px solid var(--glass-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s ease;
            opacity: 0;
            animation: fadeInUp 0.5s ease-out forwards;
        }

        .list-group-item:nth-child(1) { animation-delay: 0.3s; }
        .list-group-item:nth-child(2) { animation-delay: 0.4s; }
        .list-group-item:nth-child(3) { animation-delay: 0.5s; }

        .list-group-item:hover {
            background: var(--card-hover);
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
        }

        /* Floating elements */
        .floating-elements {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-element {
            position: absolute;
            font-size: 20px;
            color: rgba(138, 43, 226, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        /* Footer */
        footer {
            background: #0a0a0a;
            padding: 30px 0;
            border-top: 1px solid var(--glass-border);
            text-align: center;
            animation: fadeInUp 0.5s ease-out;
        }

        footer p {
            color: var(--text-secondary);
            margin: 0;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        /* Hover effects */
        .hover-lift {
            transition: transform 0.3s ease;
        }

        .hover-lift:hover {
            transform: translateY(-5px);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .navbar {
                padding: 15px 20px;
            }

            .nav-actions {
                flex-direction: column;
                gap: 10px;
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
        }
    </style>
</head>
<body>
<!-- Floating elements for background -->
<div class="floating-elements">
    <div class="floating-element" style="top: 10%; left: 5%; animation-delay: 0s;">🎸</div>
    <div class="floating-element" style="top: 20%; left: 90%; animation-delay: 2s;">🎹</div>
    <div class="floating-element" style="top: 40%; left: 7%; animation-delay: 4s;">🎷</div>
    <div class="floating-element" style="top: 70%; left: 85%; animation-delay: 1s;">🥁</div>
    <div class="floating-element" style="top: 85%; left: 10%; animation-delay: 3s;">🎻</div>
    <div class="floating-element" style="top: 30%; left: 80%; animation-delay: 5s;">🎺</div>
</div>

<!-- Header/Navbar -->
<nav class="navbar">
    <a class="navbar-brand" href="index.jsp">
        <i class="fas fa-music"></i>Melody Mart Admin
    </a>
    <div class="nav-actions">
        <a href="index.jsp" class="nav-link"><i class="fas fa-home"></i> Home</a>
        <a href="#" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<div class="main-wrapper">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h4>Admin Dashboard</h4>
            <p>Control Center</p>
        </div>
        <ul class="sidebar-menu">
            <li><a href="#user-management" class="active"><i class="fas fa-users"></i> User Management</a></li>
            <li><a href="#stock-management"><i class="fas fa-boxes"></i> Stock Management</a></li>
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
            <p>As of 11:07 AM +0530 on September 18, 2025, manage all aspects of the platform efficiently with premium tools and insights.</p>
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

        <!-- User Management Section -->
        <section id="user-management" class="section-card">
            <div class="card-header">
                <h3><i class="fas fa-users"></i> User Management Section</h3>
                <div class="card-header-actions">
                    <button class="btn btn-sm btn-primary hover-lift"><i class="fas fa-download"></i> Export</button>
                    <button class="btn btn-sm btn-success hover-lift"><i class="fas fa-plus"></i> Add New</button>
                </div>
            </div>
            <div class="card-body">
                <p>Tools to manage users (e.g., view user lists, approve registrations, suspend accounts).</p>
                <div class="table-container">
                    <table>
                        <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1001</td>
                            <td>John Doe</td>
                            <td>Customer</td>
                            <td><span class="badge bg-success">Active</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm hover-lift"><i class="fas fa-edit"></i> Edit</button>
                                <button class="btn btn-warning btn-sm hover-lift"><i class="fas fa-ban"></i> Suspend</button>
                                <button class="btn btn-danger btn-sm hover-lift"><i class="fas fa-trash"></i> Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>1002</td>
                            <td>Jane Smith</td>
                            <td>Seller</td>
                            <td><span class="badge bg-warning">Pending</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm hover-lift"><i class="fas fa-check"></i> Approve</button>
                                <button class="btn btn-danger btn-sm hover-lift"><i class="fas fa-times"></i> Reject</button>
                            </td>
                        </tr>
                        <tr>
                            <td>1003</td>
                            <td>Robert Johnson</td>
                            <td>Admin</td>
                            <td><span class="badge bg-success">Active</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm hover-lift"><i class="fas fa-edit"></i> Edit</button>
                                <button class="btn btn-warning btn-sm hover-lift"><i class="fas fa-ban"></i> Suspend</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>






        <%@ page import="java.sql.Connection" %>
        <%@ page import="java.sql.PreparedStatement" %>
        <%@ page import="java.sql.ResultSet" %>
        <%@ page import="com.melodymart.util.DatabaseUtil" %>

        <!-- ⭐ Improved Stock Management Tools -->
        <section id="stock-management" class="section-card">
            <div class="card-header flex items-center justify-between">
                <h3 class="flex items-center gap-2 text-lg font-semibold">
                    <i class="fas fa-boxes"></i> Stock Management Tools
                </h3>
                <button type="button" class="btn btn-secondary" onclick="refreshStockStatus()">
                    <i class="fas fa-sync-alt"></i> Refresh Status
                </button>
            </div>

            <div class="card-body">
                <p class="text-muted mb-3">
                    Quickly update instrument stock levels, track availability, and get real-time alerts for low or oversold items.
                </p>

                <!-- Update Stock Form -->
                <form id="stockUpdateForm" method="post" action="${pageContext.request.contextPath}/UpdateStockServlet"
                      class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">

                    <!-- Instrument ID -->
                    <div class="form-group">
                        <label for="instrumentId" class="form-label font-weight-bold">Instrument ID</label>
                        <input type="text" class="form-control" id="instrumentId" name="instrumentId" placeholder="Enter ID" required>
                    </div>

                    <!-- Quantity -->
                    <div class="form-group">
                        <label for="stockQuantity" class="form-label font-weight-bold">New Quantity</label>
                        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" placeholder="e.g. 20" min="0" required>
                    </div>

                    <!-- Submit -->
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary hover-lift w-full">
                            <i class="fas fa-save"></i> Update Stock
                        </button>
                    </div>
                </form>

                <!-- 🔔 Stock Alerts (Dynamic from DB) -->
                <div id="stockAlerts" class="mt-5">
                    <h5 class="mb-2"><i class="fas fa-bell text-warning"></i> Stock Alerts</h5>
                    <ul class="list-group">
                        <%
                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            try {
                                conn = DatabaseUtil.getConnection();
                                String sql = "SELECT InstrumentID, Name, StockLevel FROM Instrument WHERE StockLevel IN ('Low Stock', 'Out of Stock')";
                                ps = conn.prepareStatement(sql);
                                rs = ps.executeQuery();
                                while (rs.next()) {
                                    String level = rs.getString("StockLevel");
                                    String icon = "Low Stock".equalsIgnoreCase(level)
                                            ? "<i class='fas fa-exclamation-triangle text-warning'></i>"
                                            : "<i class='fas fa-times-circle text-danger'></i>";
                        %>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span><%= icon %> Item ID <%= rs.getInt("InstrumentID") %> (<%= rs.getString("Name") %>) is <b><%= level %></b></span>
                            <button class="btn btn-sm btn-outline-primary" onclick="quickRestock(<%= rs.getInt("InstrumentID") %>)">Restock</button>
                        </li>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<li class='list-group-item text-danger'>Error: " + e.getMessage() + "</li>");
                            } finally {
                                if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                                if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                                if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                            }
                        %>
                    </ul>
                </div>
            </div>

            <%@ page import="java.sql.Connection" %>
            <%@ page import="java.sql.PreparedStatement" %>
            <%@ page import="java.sql.ResultSet" %>
            <%@ page import="com.melodymart.util.DatabaseUtil" %>

            <!-- 📊 Stock Reports / Audit Section -->
            <section id="stock-reports" class="section-card mt-4">
                <div class="card-header flex items-center justify-between">
                    <h3 class="flex items-center gap-2 text-lg font-semibold">
                        <i class="fas fa-chart-line"></i> Stock Reports & Audits
                    </h3>
                    <div class="d-flex gap-2">
                        <!-- Export Report -->
                        <form method="post" action="${pageContext.request.contextPath}/ExportStockReportServlet" style="display:inline;">
                            <button type="submit" class="btn btn-secondary">
                                <i class="fas fa-file-download"></i> Export Report (CSV)
                            </button>
                        </form>

                        <!-- Remove Instrument (Global) -->
                        <form action="${pageContext.request.contextPath}/RemoveInstrumentServlet"
                              method="post" class="d-flex align-items-center"
                              onsubmit="return confirm('Are you sure you want to remove this instrument from sale?');">
                            <input type="text" name="instrumentId" class="form-control form-control-sm mr-2"
                                   placeholder="Instrument ID" required>
                            <button type="submit" class="btn btn-sm btn-danger">
                                <i class="fas fa-ban"></i> Remove from Sale
                            </button>
                        </form>
                    </div>
                </div>

                <div class="card-body">
                    <p class="text-muted mb-3">Review stock health across all instruments. Export full reports or remove discontinued/policy-restricted items from sale.</p>

                    <!-- Optional summary cards or stock audit table could go here -->
                </div>
            </section>

            <div class="card-body">
                    <p class="text-muted mb-3">Review stock health across all instruments for audits and decision-making.</p>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-center">
                        <%
                             conn = null;
                            ps = null;
                           rs = null;
                            try {
                                conn = DatabaseUtil.getConnection();

                                // Total Instruments
                                ps = conn.prepareStatement("SELECT COUNT(*) FROM Instrument");
                                rs = ps.executeQuery();
                                rs.next();
                                int totalInstruments = rs.getInt(1);
                                rs.close(); ps.close();

                                // In Stock
                                ps = conn.prepareStatement("SELECT COUNT(*) FROM Instrument WHERE StockLevel='In Stock'");
                                rs = ps.executeQuery();
                                rs.next();
                                int inStock = rs.getInt(1);
                                rs.close(); ps.close();

                                // Low Stock
                                ps = conn.prepareStatement("SELECT COUNT(*) FROM Instrument WHERE StockLevel='Low Stock'");
                                rs = ps.executeQuery();
                                rs.next();
                                int lowStock = rs.getInt(1);
                                rs.close(); ps.close();

                                // Out of Stock
                                ps = conn.prepareStatement("SELECT COUNT(*) FROM Instrument WHERE StockLevel='Out of Stock'");
                                rs = ps.executeQuery();
                                rs.next();
                                int outOfStock = rs.getInt(1);
                                rs.close(); ps.close();
                        %>

                        <!-- KPI Cards -->
                        <div class="stat-card bg-light shadow-sm p-3 rounded">
                            <h4>Total Instruments</h4>
                            <p class="font-weight-bold text-primary"><%= totalInstruments %></p>
                        </div>

                        <div class="stat-card bg-light shadow-sm p-3 rounded">
                            <h4>In Stock</h4>
                            <p class="font-weight-bold text-success"><%= inStock %></p>
                        </div>

                        <div class="stat-card bg-light shadow-sm p-3 rounded">
                            <h4>Low Stock</h4>
                            <p class="font-weight-bold text-warning"><%= lowStock %></p>
                        </div>

                        <div class="stat-card bg-light shadow-sm p-3 rounded">
                            <h4>Out of Stock</h4>
                            <p class="font-weight-bold text-danger"><%= outOfStock %></p>
                        </div>

                        <%
                            } catch (Exception e) {
                                out.println("<p class='text-danger'>Error loading report: " + e.getMessage() + "</p>");
                            } finally {
                                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                                try { if (conn != null) conn.close(); } catch (Exception ignored) {}
                            }
                        %>
                    </div>
                </div>
            </section>


            <!-- 🛠 Stock Override / Correction -->
            <section id="stock-override" class="section-card mt-4">
                <div class="card-header">
                    <h3><i class="fas fa-edit"></i> Stock Corrections / Disputes</h3>
                </div>

                <div class="card-body">
                    <p class="text-muted mb-3">
                        Use this tool to override stock levels for audit corrections or dispute resolutions.
                    </p>

                    <form method="post" action="${pageContext.request.contextPath}/StockCorrectionServlet" class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">

                        <!-- Instrument ID -->
                        <div class="form-group">
                            <label for="correctionInstrumentId" class="form-label">Instrument ID</label>
                            <input type="text" class="form-control" id="correctionInstrumentId" name="instrumentId" placeholder="Enter ID" required>
                        </div>

                        <!-- Corrected Quantity -->
                        <div class="form-group">
                            <label for="correctedQuantity" class="form-label">Corrected Quantity</label>
                            <input type="number" class="form-control" id="correctedQuantity" name="correctedQuantity" min="0" required>
                        </div>

                        <!-- Reason -->
                        <div class="form-group">
                            <label for="correctionReason" class="form-label">Reason</label>
                            <input type="text" class="form-control" id="correctionReason" name="reason" placeholder="e.g., Damaged item removed, Audit correction" required>
                        </div>

                        <!-- Submit -->
                        <div class="form-group">
                            <button type="submit" class="btn btn-warning hover-lift w-full">
                                <i class="fas fa-save"></i> Apply Correction
                            </button>
                        </div>
                    </form>
                </div>
            </section>




        </section>

        <script>
            // Simulate stock refresh
            function refreshStockStatus() {
                location.reload(); // simple page reload to update alerts
            }

            // Quick restock helper
            function quickRestock(id) {
                document.getElementById("instrumentId").value = id;
                document.getElementById("stockQuantity").focus();
            }
        </script>




        <!-- Item Review Queue -->
        <section id="item-review" class="section-card">
            <div class="card-header">
                <h3><i class="fas fa-flag"></i> Item Review Queue</h3>
            </div>
            <div class="card-body">
                <p>A list of flagged instruments for review (e.g., those violating guidelines).</p>
                <ul class="list-group">
                    <li class="list-group-item">
                        <div>
                            <strong>Guitar XYZ</strong>
                            <div class="text-muted">Flagged for: Guideline Violation</div>
                        </div>
                        <button class="btn btn-info btn-sm hover-lift"><i class="fas fa-eye"></i> Review</button>
                    </li>
                    <li class="list-group-item">
                        <div>
                            <strong>Drum Set Pro</strong>
                            <div class="text-muted">Flagged for: Suspected Counterfeit</div>
                        </div>
                        <button class="btn btn-info btn-sm hover-lift"><i class="fas fa-eye"></i> Review</button>
                    </li>
                    <li class="list-group-item">
                        <div>
                            <strong>Microphone Studio</strong>
                            <div class="text-muted">Flagged for: Inaccurate Description</div>
                        </div>
                        <button class="btn btn-info btn-sm hover-lift"><i class="fas fa-eye"></i> Review</button>
                    </li>
                </ul>
            </div>
        </section>

        <!-- Reporting Tools -->
        <section id="reporting" class="section-card">
            <div class="card-header">
                <h3><i class="fas fa-chart-bar"></i> Reporting Tools</h3>
            </div>
            <div class="card-body">
                <p>Options to generate system reports on site activity, sales, or user metrics.</p>
                <div class="form-group">
                    <select class="form-select">
                        <option>Select Report Type</option>
                        <option>Sales Report</option>
                        <option>User Activity</option>
                        <option>System Performance</option>
                    </select>
                </div>
                <button class="btn btn-primary hover-lift"><i class="fas fa-file-export"></i> Generate Report</button>
                <div class="chart-container">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </section>

        <!-- Policy Update Interface -->
        <section id="policy-update" class="section-card">
            <div class="card-header">
                <h3><i class="fas fa-file-alt"></i> Policy Update Interface</h3>
            </div>
            <div class="card-body">
                <p>Forms or editors to update platform policies.</p>
                <div class="form-group">
                    <textarea class="form-control" rows="6" placeholder="Update Policy Text Here..."></textarea>
                </div>
                <button class="btn btn-primary hover-lift"><i class="fas fa-save"></i> Save Policy</button>
            </div>
        </section>

        <!-- Admin Management -->
        <section id="admin-management" class="section-card">
            <div class="card-header">
                <h3><i class="fas fa-user-shield"></i> Admin Management</h3>
            </div>
            <div class="card-body">
                <p>Section to add or remove other admins.</p>
                <div class="table-container">
                    <table>
                        <thead>
                        <tr>
                            <th>Admin ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>001</td>
                            <td>Admin User</td>
                            <td>admin@melodymart.com</td>
                            <td><button class="btn btn-danger btn-sm hover-lift"><i class="fas fa-trash"></i> Remove</button></td>
                        </tr>
                        <tr>
                            <td>002</td>
                            <td>Site Manager</td>
                            <td>manager@melodymart.com</td>
                            <td><button class="btn btn-danger btn-sm hover-lift"><i class="fas fa-trash"></i> Remove</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <button class="btn btn-success mt-3 hover-lift"><i class="fas fa-plus"></i> Add New Admin</button>
            </div>
        </section>

        <!-- Feedback Management -->
        <section id="feedback-management" class="section-card">
            <div class="card-header">
                <h3><i class="fas fa-comments"></i> Feedback Management</h3>
            </div>
            <div class="card-body">
                <p>Area to view, delete, or manage user feedbacks and ratings.</p>
                <ul class="list-group">
                    <li class="list-group-item">
                        <div>
                            <strong>Great service!</strong>
                            <div class="text-muted">Rating: 5/5 • Posted by: John D.</div>
                        </div>
                        <button class="btn btn-danger btn-sm hover-lift"><i class="fas fa-trash"></i> Delete</button>
                    </li>
                    <li class="list-group-item">
                        <div>
                            <strong>Product arrived damaged</strong>
                            <div class="text-muted">Rating: 2/5 • Posted by: Sarah M.</div>
                        </div>
                        <button class="btn btn-danger btn-sm hover-lift"><i class="fas fa-trash"></i> Delete</button>
                    </li>
                    <li class="list-group-item">
                        <div>
                            <strong>Fast shipping, great quality</strong>
                            <div class="text-muted">Rating: 5/5 • Posted by: Mike R.</div>
                        </div>
                        <button class="btn btn-danger btn-sm hover-lift"><i class="fas fa-trash"></i> Delete</button>
                    </li>
                </ul>
            </div>
        </section>

        <!-- Monitoring Dashboard -->
        <section id="monitoring" class="section-card">
            <div class="card-header">
                <h3><i class="fas fa-desktop"></i> Monitoring Dashboard</h3>
            </div>
            <div class="card-body">
                <p>Real-time or historical views of site activity, such as user logins, orders, or errors.</p>
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-user-clock"></i></div>
                        <div class="stat-value">152</div>
                        <div class="stat-label">Active Users</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-shopping-bag"></i></div>
                        <div class="stat-value">47</div>
                        <div class="stat-label">Orders Today</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-bug"></i></div>
                        <div class="stat-value">3</div>
                        <div class="stat-label">System Errors</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-server"></i></div>
                        <div class="stat-value">99.8%</div>
                        <div class="stat-label">Uptime</div>
                    </div>
                </div>
                <div class="chart-container">
                    <canvas id="activityChart"></canvas>
                </div>
            </div>
        </section>

        <!-- Notifications and Alerts -->
        <section id="notifications" class="section-card">
            <div class="card-header">
                <h3><i class="fas fa-bell"></i> Notifications & Alerts</h3>
            </div>
            <div class="card-body">
                <p>Inbox for system-generated alerts (e.g., flagged items or stock issues).</p>
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> New item flagged for review: Electric Guitar Pro X
                </div>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> Stock low on Premium Guitar - only 2 left in inventory
                </div>
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-triangle"></i> Unusual login activity detected from new location
                </div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize charts
    document.addEventListener('DOMContentLoaded', function() {
        // Sales Chart
        const salesCtx = document.getElementById('salesChart').getContext('2d');
        const salesChart = new Chart(salesCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
                datasets: [{
                    label: 'Sales ($)',
                    data: [12500, 19000, 18000, 22000, 21000, 25000, 28000, 30000, 32000],
                    borderColor: '#8a2be2',
                    backgroundColor: 'rgba(138, 43, 226, 0.1)',
                    borderWidth: 2,
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        labels: {
                            color: '#ffffff'
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: {
                            color: '#b3b3b3'
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: {
                            color: '#b3b3b3'
                        }
                    }
                }
            }
        });

        // Activity Chart
        const activityCtx = document.getElementById('activityChart').getContext('2d');
        const activityChart = new Chart(activityCtx, {
            type: 'bar',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [{
                    label: 'User Activity',
                    data: [120, 190, 140, 180, 160, 140, 180],
                    backgroundColor: 'rgba(0, 229, 255, 0.5)',
                    borderColor: '#00e5ff',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        labels: {
                            color: '#ffffff'
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: {
                            color: '#b3b3b3'
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: {
                            color: '#b3b3b3'
                        }
                    }
                }
            }
        });

        // Simple script to handle sidebar navigation
        document.querySelectorAll('.sidebar-menu a').forEach(link => {
            link.addEventListener('click', function(e) {
                document.querySelectorAll('.sidebar-menu a').forEach(item => {
                    item.classList.remove('active');
                });
                this.classList.add('active');

                const targetId = this.getAttribute('href');
                const targetSection = document.querySelector(targetId);
                if (targetSection) {
                    targetSection.scrollIntoView({ behavior: 'smooth' });
                }
                e.preventDefault();
            });
        });

        // Add hover effects to cards
        document.querySelectorAll('.stat-card, .section-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.boxShadow = '0 10px 20px rgba(138, 43, 226, 0.2)';
            });

            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = 'none';
            });
        });

        // Animate elements on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = 1;
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        document.querySelectorAll('.stat-card, .section-card').forEach(card => {
            card.style.opacity = 0;
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            observer.observe(card);
        });
    });
</script>
</body>
</html>