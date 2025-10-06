<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Repair Requests | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <style>
        :root {
            --primary: #1e40af;
            --primary-light: #3b82f6;
            --primary-soft: #dbeafe;
            --secondary: #ffffff;
            --accent: #06b6d4;
            --accent-alt: #ef4444;
            --text: #1e293b;
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
            --secondary: #0f172a;
            --accent: #22d3ee;
            --accent-alt: #f87171;
            --text: #f1f5f9;
            --text-secondary: #cbd5e1;
            --text-soft: #94a3b8;
            --card-bg: #1e293b;
            --card-hover: #334155;
            --glass-bg: rgba(30, 41, 59, 0.9);
            --glass-border: rgba(255, 255, 255, 0.1);
            --shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
            --shadow-hover: 0 10px 30px rgba(0, 0, 0, 0.4);
            --header-bg: rgba(15, 23, 42, 0.95);
            --section-bg: #0f172a;
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
            padding-top: 80px;
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
            background: var(--header-bg);
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

        .search-btn, .cart-btn, .theme-toggle {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            margin-left: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .search-btn:hover, .cart-btn:hover, .theme-toggle:hover {
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

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px 0;
            border-bottom: 1px solid var(--glass-border);
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 36px;
            font-weight: 700;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 1s ease, transform 1s ease;
        }

        .page-title.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .page-title:after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 0;
            width: 100px;
            height: 4px;
            background: var(--gradient);
            border-radius: 2px;
        }

        /* Form Styles */
        .form-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 30px;
            margin-bottom: 40px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
            transition: all 0.5s ease;
            opacity: 0;
            transform: translateY(50px);
        }

        .form-container.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .form-container:hover {
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .form-title {
            font-size: 24px;
            margin-bottom: 20px;
            color: var(--primary);
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text);
        }

        .form-control, .form-control-file {
            width: 100%;
            padding: 12px 15px;
            border-radius: 10px;
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-control-file:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }

        .form-control-file {
            padding: 10px;
        }

        .preview-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        .preview-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--glass-border);
            transition: transform 0.3s ease;
            box-shadow: var(--shadow);
        }

        .preview-img:hover {
            transform: scale(1.05);
        }

        /* Table Styles */
        .table-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-top: 30px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: all 0.5s ease;
            opacity: 0;
            transform: translateY(50px);
        }

        .table-container.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .table-container:hover {
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .data-table th {
            background: rgba(59, 130, 246, 0.1);
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: var(--primary);
            border-bottom: 1px solid var(--glass-border);
        }

        .data-table td {
            padding: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-table tr:hover {
            background: rgba(59, 130, 246, 0.05);
        }

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-new {
            background: rgba(0, 123, 255, 0.2);
            color: #007bff;
        }

        .status-in-progress {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }

        .status-completed {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        /* Action Buttons */
        .action-btn {
            background: none;
            border: none;
            color: var(--primary);
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
            transition: all 0.3s ease;
            padding: 8px;
            border-radius: 50%;
            width: 36px;
            height: 36px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .action-btn:hover {
            background: var(--primary-soft);
            transform: scale(1.1);
        }

        .action-btn.delete-btn {
            color: #ef4444;
        }

        .action-btn.delete-btn:hover {
            background: rgba(239, 68, 68, 0.1);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(5px);
        }

        .modal-content {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 40px;
            max-width: 600px;
            width: 90%;
            position: relative;
            opacity: 0;
            transform: scale(0.8) translateY(20px);
            transition: opacity 0.4s ease, transform 0.4s ease;
            box-shadow: var(--shadow-hover);
        }

        .modal.active .modal-content {
            opacity: 1;
            transform: scale(1) translateY(0);
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
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-close:hover {
            color: var(--primary-light);
            background: var(--primary-soft);
        }

        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            margin-bottom: 20px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Photo Gallery */
        .photo-gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        .gallery-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--glass-border);
            cursor: pointer;
            transition: transform 0.3s ease;
            box-shadow: var(--shadow);
        }

        .gallery-img:hover {
            transform: scale(1.1);
        }

        /* Hero Section */
        .repair-hero {
            background: var(--gradient-soft);
            padding: 80px 0;
            margin-bottom: 60px;
            border-radius: var(--border-radius);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .repair-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><path fill="rgba(59, 130, 246, 0.1)" d="M500,250c138.07,0,250,111.93,250,250s-111.93,250-250,250s-250-111.93-250-250S361.93,250,500,250z"/></svg>') no-repeat center;
            background-size: cover;
            opacity: 0.2;
        }

        .repair-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 48px;
            margin-bottom: 20px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .repair-hero p {
            max-width: 600px;
            margin: 0 auto;
            color: var(--text-secondary);
            font-size: 18px;
        }

        /* Floating Icons */
        .floating-icons {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            overflow: hidden;
            z-index: -1;
        }

        .floating-icon {
            position: absolute;
            font-size: 24px;
            color: rgba(59, 130, 246, 0.15);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .data-table {
                display: block;
                overflow-x: auto;
            }

            .page-title {
                font-size: 28px;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .form-container, .table-container {
                padding: 20px;
            }

            .modal-content {
                padding: 20px;
            }

            .user-menu:hover .dropdown {
                display: none;
            }

            .repair-hero h1 {
                font-size: 36px;
            }
        }

        @media (max-width: 576px) {
            body {
                padding-top: 70px;
            }

            .page-title {
                font-size: 24px;
            }

            .form-title {
                font-size: 20px;
            }

            .data-table th, .data-table td {
                padding: 10px;
            }

            .repair-hero {
                padding: 60px 20px;
            }

            .repair-hero h1 {
                font-size: 32px;
            }
        }

        /* Animation for table rows */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .data-table tbody tr {
            animation: fadeIn 0.5s ease forwards;
        }

        .data-table tbody tr:nth-child(1) { animation-delay: 0.1s; }
        .data-table tbody tr:nth-child(2) { animation-delay: 0.2s; }
        .data-table tbody tr:nth-child(3) { animation-delay: 0.3s; }
        .data-table tbody tr:nth-child(4) { animation-delay: 0.4s; }
        .data-table tbody tr:nth-child(5) { animation-delay: 0.5s; }
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
            <li><a href="index.jsp">Home</a></li>
            <li><a href="shop.jsp">Shop</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="repair-requests.jsp" style="color: var(--primary-light);">Repair Requests</a></li>
            <li><a href="order.jsp">My Orders</a></li>
            <li><a href="profile.jsp">Profile</a></li>
        </ul>

        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <button class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></button>
            <button class="theme-toggle" aria-label="Toggle Theme" id="themeToggle">
                <i class="fas fa-moon"></i>
            </button>
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i> Customer</button>
                <div class="dropdown">
                    <a href="profile.jsp" class="dropdown-item"><i class="fas fa-user-circle"></i> My Profile</a>
                    <a href="orders.jsp" class="dropdown-item"><i class="fas fa-shopping-bag"></i> My Orders</a>
                    <a href="repair-requests.jsp" class="dropdown-item"><i class="fas fa-tools"></i> Repair Requests</a>
                    <a href="wishlist.jsp" class="dropdown-item"><i class="fas fa-heart"></i> Wishlist</a>
                    <a href="settings.jsp" class="dropdown-item"><i class="fas fa-cog"></i> Settings</a>
                    <a href="index.jsp" class="dropdown-item"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Hero Section -->
<section class="repair-hero">
    <div class="container">
        <h1>Instrument Repair Services</h1>
        <p>Professional repair services to keep your instruments sounding their best. Submit a request and let our experts handle the rest.</p>
    </div>
    <div class="floating-icons">
        <i class="floating-icon" style="top: 20%; left: 5%; animation-delay: 0s;">🔧</i>
        <i class="floating-icon" style="top: 60%; left: 10%; animation-delay: 1s;">🎸</i>
        <i class="floating-icon" style="top: 30%; right: 15%; animation-delay: 2s;">🎹</i>
        <i class="floating-icon" style="top: 70%; right: 5%; animation-delay: 3s;">🥁</i>
        <i class="floating-icon" style="top: 40%; left: 15%; animation-delay: 4s;">🎻</i>
    </div>
</section>

<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">Repair Requests</h1>
        <button class="cta-btn" id="newRequestBtn">
            <i class="fas fa-plus"></i> New Repair Request
        </button>
    </div>

    <!-- New Repair Request Form -->
    <div class="form-container" id="requestForm">
        <h2 class="form-title">Submit New Repair Request</h2>
        <form id="repairRequestForm" method="post" action="${pageContext.request.contextPath}/SubmitRepairRequestServlet" enctype="multipart/form-data">
            <div class="form-group">
                <label class="form-label">Order ID</label>
                <input type="text" class="form-control" name="orderId" placeholder="e.g., MM-7892" required>
            </div>
            <div class="form-group">
                <label class="form-label">Issue Description</label>
                <textarea class="form-control" name="issueDescription" placeholder="Describe the issue in detail..." rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label class="form-label">Upload Photos</label>
                <input type="file" class="form-control-file" name="photos" multiple accept="image/*" id="photoUpload">
                <div id="previewContainer" class="preview-container"></div>
            </div>
            <div class="form-group">
                <label class="form-label">Select Repair Date</label>
                <input type="text" class="form-control" id="repairDatePicker" name="repairDate" required>
            </div>
            <button type="submit" class="cta-btn" style="width: 100%;">
                <i class="fas fa-paper-plane"></i> Submit Request
            </button>
        </form>
    </div>

    <!-- Repair Requests Table -->
    <div class="table-container">
        <h2 class="form-title">Your Repair Requests</h2>
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
                    %>
                    <div class="photo-gallery">
                        <%
                            for (String photoPath : photos) {
                        %>
                        <img src="<%= photoPath.replace("\\", "/") %>" class="gallery-img" alt="Repair Photo">
                        <%
                            }
                        %>
                    </div>
                    <%
                    } else {
                    %>
                    <span style="color: var(--text-secondary); font-style: italic;">No photos</span>
                    <%
                        }
                    %>
                </td>
                <td><span class="status-badge status-<%= status.toLowerCase().replace(" ", "-") %>"><%= status %></span></td>
                <td><span style="color: <%= rs.getBoolean("Approved") ? "#28a745" : "#ef4444" %>;"><%= rs.getBoolean("Approved") ? "Yes" : "No" %></span></td>
                <td><%= rs.getString("Comment") != null ? rs.getString("Comment") : "<span style='color: var(--text-secondary); font-style: italic;'>No comment</span>" %></td>
                <td style="font-weight: 600; color: var(--accent);">$<%= rs.getBigDecimal("EstimatedCost") != null ? rs.getBigDecimal("EstimatedCost") : "0.00" %></td>
                <td><%= rs.getDate("RepairDate") %></td>
                <td>
                    <button class="action-btn" title="Update Request"
                            onclick="openUpdateModal(<%= rs.getInt("RepairRequestID") %>, '<%= rs.getString("IssueDescription").replace("'", "\\'") %>', '<%= rs.getString("Comment") != null ? rs.getString("Comment").replace("'", "\\'") : "" %>', '<%= rs.getDate("RepairDate") %>')">
                        <i class="fas fa-edit"></i>
                    </button>
                    <% if (canDelete) { %>
                    <button class="action-btn delete-btn" title="Delete Request" onclick="deleteRepairRequest(<%= rs.getInt("RepairRequestID") %>)">
                        <i class="fas fa-trash"></i>
                    </button>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='10' style='color:#ef4444; text-align:center; padding:20px;'>Error loading repair requests: " + e.getMessage() + "</td></tr>");
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

<!-- Update Repair Request Modal -->
<div class="modal" id="updateRepairModal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('updateRepairModal')">&times;</button>
        <h2 class="modal-title">Update Repair Request</h2>
        <form id="updateRepairForm" method="post" action="${pageContext.request.contextPath}/UpdateRepairRequestServlet" enctype="multipart/form-data">
            <input type="hidden" name="repairRequestId" id="updateRepairRequestId">
            <div class="form-group">
                <label class="form-label">Issue Description</label>
                <textarea class="form-control" name="issueDescription" id="updateIssueDescription" rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label class="form-label">Additional Comments</label>
                <textarea class="form-control" name="additionalComment" id="updateComment" rows="4" placeholder="Add any additional comments or updates..."></textarea>
            </div>
            <div class="form-group">
                <label class="form-label">Upload Additional Photos</label>
                <input type="file" class="form-control-file" name="additionalPhotos" multiple accept="image/*" id="updatePhotoUpload">
                <div id="updatePreviewContainer" class="preview-container"></div>
            </div>
            <div class="form-group">
                <label class="form-label">Select Repair Date</label>
                <input type="text" class="form-control" id="updateRepairDatePicker" name="repairDate" required>
            </div>
            <button type="submit" class="cta-btn" style="width: 100%;">
                <i class="fas fa-save"></i> Update Request
            </button>
        </form>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
    // Theme toggle functionality
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = themeToggle.querySelector('i');

    // Check for saved theme preference or default to light
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

    function updateThemeIcon(theme) {
        if (theme === 'light') {
            themeIcon.className = 'fas fa-moon';
        } else {
            themeIcon.className = 'fas fa-sun';
        }
    }

    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    $(function() {
        $("#repairDatePicker, #updateRepairDatePicker").datepicker({
            dateFormat: "yy-mm-dd",
            minDate: 0,
            showAnim: "fadeIn"
        });
    });

    // Toggle form visibility
    document.getElementById('newRequestBtn').addEventListener('click', function() {
        const form = document.getElementById('requestForm');
        if (form.style.display === 'none') {
            form.style.display = 'block';
            form.scrollIntoView({ behavior: 'smooth' });
        } else {
            form.style.display = 'none';
        }
    });

    // Image preview functionality
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
                        img.className = "preview-img";
                        previewContainer.appendChild(img);
                    };
                    reader.readAsDataURL(file);
                }
            });
        });
    }

    setupPreview("photoUpload", "previewContainer");
    setupPreview("updatePhotoUpload", "updatePreviewContainer");

    // Modal functions
    function openModal(modalId) {
        const modal = document.getElementById(modalId);
        modal.style.display = "flex";
        setTimeout(() => modal.classList.add("active"), 10);
    }

    function closeModal(modalId) {
        const modal = document.getElementById(modalId);
        modal.classList.remove("active");
        setTimeout(() => modal.style.display = "none", 300);
    }

    function openUpdateModal(id, issue, comment, date) {
        document.getElementById("updateRepairRequestId").value = id;
        document.getElementById("updateIssueDescription").value = issue;
        document.getElementById("updateComment").value = comment;
        document.getElementById("updateRepairDatePicker").value = date;
        document.getElementById("updatePreviewContainer").innerHTML = "";
        openModal("updateRepairModal");
    }

    function deleteRepairRequest(id) {
        if (confirm("Are you sure you want to delete this repair request? This action cannot be undone.")) {
            const form = document.createElement("form");
            form.method = "POST";
            form.action = "${pageContext.request.contextPath}/DeleteRepairRequestServlet";
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = "repairRequestId";
            input.value = id;
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    }

    // Close modal when clicking outside
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                closeModal(modal.id);
            }
        });
    });

    // Form submission handlers
    document.getElementById('repairRequestForm').addEventListener('submit', function(e) {
        // Add loading state to button
        const submitBtn = this.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
        submitBtn.disabled = true;

        // Reset button after 3 seconds (for demo purposes)
        setTimeout(() => {
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
        }, 3000);
    });

    document.getElementById('updateRepairForm').addEventListener('submit', function(e) {
        // Add loading state to button
        const submitBtn = this.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
        submitBtn.disabled = true;

        // Reset button after 3 seconds (for demo purposes)
        setTimeout(() => {
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
        }, 3000);
    });

    // Intersection Observer for animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.page-title, .form-container, .table-container').forEach((el) => {
        observer.observe(el);
    });
</script>

</body>
</html>