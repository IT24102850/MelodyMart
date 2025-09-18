<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Assume session has seller details from login
    String sellerEmail = (String) session.getAttribute("userEmail");
    int sellerId = 0;
    String sellerName = (String) session.getAttribute("userName");

    // Database connection details
    String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true";
    String dbUser = "Hasiru";
    String dbPassword = "hasiru2004";

    // Get SellerID from session or query
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // Fetch SellerID based on email
        pstmt = conn.prepareStatement("SELECT PersonID FROM Person p JOIN Seller s ON p.PersonID = s.PersonID WHERE p.Email = ?");
        pstmt.setString(1, sellerEmail);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            sellerId = rs.getInt("PersonID");
        }
        rs.close();
        pstmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Fetch Orders for this seller
    List<Map<String, Object>> orders = new ArrayList<>();
    try {
        pstmt = conn.prepareStatement("SELECT o.OrderID, c.FirstName + ' ' + c.LastName AS CustomerName, i.Name AS InstrumentName, o.OrderDate, o.TotalAmount, o.Status FROM Orders o JOIN Person c ON o.CustomerID = c.PersonID JOIN OrderItem oi ON o.OrderID = oi.OrderID JOIN Instrument i ON oi.InstrumentID = i.InstrumentID WHERE o.SellerID = ? ORDER BY o.OrderDate DESC");
        pstmt.setInt(1, sellerId);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, Object> order = new HashMap<>();
            order.put("orderId", rs.getString("OrderID"));
            order.put("customerName", rs.getString("CustomerName"));
            order.put("instrumentName", rs.getString("InstrumentName"));
            order.put("orderDate", rs.getString("OrderDate"));
            order.put("totalAmount", rs.getString("TotalAmount"));
            order.put("status", rs.getString("Status"));
            orders.add(order);
        }
        rs.close();
        pstmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Fetch Instruments for this seller (assuming SellerID in Instrument; add if not)
    List<Map<String, Object>> instruments = new ArrayList<>();
    try {
        pstmt = conn.prepareStatement("SELECT InstrumentID, Name, Description, Price, Quantity, StockLevel FROM Instrument WHERE SellerID = ? ORDER BY Name");
        pstmt.setInt(1, sellerId);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, Object> instrument = new HashMap<>();
            instrument.put("instrumentId", rs.getInt("InstrumentID"));
            instrument.put("name", rs.getString("Name"));
            instrument.put("description", rs.getString("Description"));
            instrument.put("price", rs.getDouble("Price"));
            instrument.put("quantity", rs.getInt("Quantity"));
            instrument.put("stockLevel", rs.getString("StockLevel"));
            instruments.add(instrument);
        }
        rs.close();
        pstmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Fetch RepairRequests/Inquiries for this seller's orders
    List<Map<String, Object>> inquiries = new ArrayList<>();
    try {
        pstmt = conn.prepareStatement("SELECT r.RepairRequestID, p.FirstName + ' ' + p.LastName AS CustomerName, r.IssueDescription, r.Status, r.RepairDate FROM RepairRequest r JOIN Orders o ON r.OrderID = o.OrderID JOIN Person p ON o.CustomerID = p.PersonID WHERE o.SellerID = ? ORDER BY r.RepairDate DESC");
        pstmt.setInt(1, sellerId);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, Object> inquiry = new HashMap<>();
            inquiry.put("inquiryId", rs.getString("RepairRequestID"));
            inquiry.put("customerName", rs.getString("CustomerName"));
            inquiry.put("subject", rs.getString("IssueDescription"));
            inquiry.put("date", rs.getString("RepairDate"));
            inquiry.put("status", rs.getString("Status"));
            inquiries.add(inquiry);
        }
        rs.close();
        pstmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Handle form submissions (Add Instrument, Update Profile)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String action = request.getParameter("action");
        if ("addInstrument".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            // Insert into Instrument
            try {
                pstmt = conn.prepareStatement("INSERT INTO Instrument (Name, Description, Price, Quantity, StockLevel, SellerID) VALUES (?, ?, ?, ?, 'In Stock', ?)");
                pstmt.setString(1, name);
                pstmt.setString(2, description);
                pstmt.setDouble(3, price);
                pstmt.setInt(4, quantity);
                pstmt.setInt(5, sellerId);
                pstmt.executeUpdate();
                response.sendRedirect("sellerdashboard.jsp?success=Instrument added successfully");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("sellerdashboard.jsp?error=Failed to add instrument");
            }
        } else if ("updateProfile".equals(action)) {
            String sellerNameUpdate = request.getParameter("sellerName");
            String sellerEmailUpdate = request.getParameter("sellerEmail");
            String sellerPhoneUpdate = request.getParameter("sellerPhone");
            String sellerStoreUpdate = request.getParameter("sellerStore");
            String sellerBioUpdate = request.getParameter("sellerBio");
            // Update Person and Seller
            try {
                pstmt = conn.prepareStatement("UPDATE Person SET FirstName = ?, LastName = ?, Email = ?, Phone = ? WHERE PersonID = ?");
                pstmt.setString(1, sellerNameUpdate.split(" ")[0]);  // Assume first word as FirstName
                pstmt.setString(2, sellerNameUpdate.substring(sellerNameUpdate.indexOf(" ") + 1));  // Rest as LastName
                pstmt.setString(3, sellerEmailUpdate);
                pstmt.setString(4, sellerPhoneUpdate);
                pstmt.setInt(5, sellerId);
                pstmt.executeUpdate();
                pstmt.close();

                pstmt = conn.prepareStatement("UPDATE Seller SET CompanyName = ? WHERE PersonID = ?");
                pstmt.setString(1, sellerStoreUpdate);
                pstmt.setInt(2, sellerId);
                pstmt.executeUpdate();
                response.sendRedirect("sellerdashboard.jsp?success=Profile updated successfully");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("sellerdashboard.jsp?error=Failed to update profile");
            }
        }
        // Reload page after action
        response.sendRedirect("sellerdashboard.jsp");
    }

    // Handle success/error messages
    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");

    if (conn != null) conn.close();
%>
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
            font-size: 36px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }

        .welcome-card p {
            color: var(--text-secondary);
            font-size: 16px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--primary-light);
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 14px;
            margin-top: 5px;
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
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.6s ease;
        }

        .content-card.animate-in {
            opacity: 1;
            transform: translateY(0);
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
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .card-actions {
            display: flex;
            gap: 10px;
        }

        .btn-outline {
            padding: 8px 16px;
            border: 1px solid var(--glass-border);
            background: transparent;
            color: var(--text);
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-outline:hover {
            background: var(--gradient);
            color: white;
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--glass-border);
        }

        th {
            background: var(--card-hover);
            font-weight: 600;
            color: var(--text-secondary);
        }

        td {
            color: var(--text);
        }

        .status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }

        .status-shipped {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .status-delivered {
            background: rgba(0, 123, 255, 0.2);
            color: #007bff;
        }

        .status-cancelled {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }

        .action-buttons {
            display: flex;
            gap: 5px;
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
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
            border: 1px solid #28a745;
        }

        .edit-btn:hover {
            background: #28a745;
            color: white;
        }

        .delete-btn {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
            border: 1px solid #dc3545;
        }

        .delete-btn:hover {
            background: #dc3545;
            color: white;
        }

        /* Form Styles */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: var(--text-secondary);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--glass-border);
            border-radius: 8px;
            color: var(--text);
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 2px rgba(138, 43, 226, 0.3);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 80px;
        }

        .btn-primary {
            padding: 12px 30px;
            background: var(--gradient);
            border: none;
            border-radius: 25px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            grid-column: 1 / -1;
            justify-self: center;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
        }

        /* Floating Elements */
        .floating-elements {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 1000;
        }

        .floating-btn {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
            transition: all 0.3s ease;
        }

        .floating-btn:hover {
            transform: scale(1.1);
        }

        .floating-btn i {
            font-size: 24px;
            color: white;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.open {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .header {
                justify-content: space-between;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        @keyframes animate-in {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-in {
            animation: animate-in 0.6s ease-out;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <nav id="sidebar" class="sidebar">
        <div class="logo-container">
            <div class="logo">
                <i class="fas fa-music"></i>
                Seller Dashboard
            </div>
        </div>
        <ul class="nav-links">
            <li class="nav-item">
                <a href="#overview" class="nav-link active">
                    <i class="fas fa-home"></i>
                    Overview
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
                <a href="#instruments" class="nav-link">
                    <i class="fas fa-guitar"></i>
                    Instruments
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
                <a href="#profile" class="nav-link">
                    <i class="fas fa-user"></i>
                    Profile
                </a>
            </li>
            <li class="nav-item">
                <a href="sign-in.jsp?logout=true" class="nav-link">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main id="main-content" class="main-content">
        <header class="header">
            <button id="toggle-sidebar" class="toggle-sidebar">
                <i class="fas fa-bars"></i>
            </button>
            <div class="user-menu">
                <div class="user-info">
                    <div class="user-name"><%= sellerName != null ? sellerName : "Seller" %></div>
                    <div class="user-role">Seller</div>
                </div>
                <div class="user-avatar">S</div>
            </div>
        </header>

        <!-- Welcome Card -->
        <div class="welcome-card">
            <h1>Welcome back, <%= sellerName != null ? sellerName : "Seller" %>!</h1>
            <p>Here's what's happening with your store today.</p>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">$<%= String.format("%.2f", orders.stream().mapToDouble(o -> Double.parseDouble(o.get("totalAmount").toString())).sum()) %></div>
                    <div class="stat-label">Total Sales</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value"><%= orders.size() %></div>
                    <div class="stat-label">New Orders</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value"><%= instruments.size() %></div>
                    <div class="stat-label">Instruments in Stock</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value"><%= inquiries.size() %></div>
                    <div class="stat-label">Pending Inquiries</div>
                </div>
            </div>
        </div>

        <!-- Order Management -->
        <div id="orders" class="content-card">
            <div class="card-header">
                <h2 class="card-title">Order Management</h2>
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
                        <th>Instrument</th>
                        <th>Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Map<String, Object> order : orders) {
                    %>
                    <tr>
                        <td>#<%= order.get("orderId") %></td>
                        <td><%= order.get("customerName") %></td>
                        <td><%= order.get("instrumentName") %></td>
                        <td><%= order.get("orderDate") %></td>
                        <td>$<%= order.get("totalAmount") %></td>
                        <td><span class="status status-<%= order.get("status").toString().toLowerCase() %>"><%= order.get("status") %></span></td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn" onclick="updateOrderStatus('<%= order.get("orderId") %>', 'Shipped')">
                                    <i class="fas fa-edit"></i>
                                </div>
                                <div class="action-btn delete-btn" onclick="deleteOrder('<%= order.get("orderId") %>')">
                                    <i class="fas fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Instrument List -->
        <div id="instruments" class="content-card">
            <div class="card-header">
                <h2 class="card-title">Instrument List</h2>
                <div class="card-actions">
                    <button onclick="openAddInstrumentModal()" class="btn-outline">
                        <i class="fas fa-plus"></i> Add Instrument
                    </button>
                </div>
            </div>
            <div class="table-responsive">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Stock Level</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Map<String, Object> instrument : instruments) {
                    %>
                    <tr>
                        <td>#<%= instrument.get("instrumentId") %></td>
                        <td><%= instrument.get("name") %></td>
                        <td><%= instrument.get("description") %></td>
                        <td>$<%= instrument.get("price") %></td>
                        <td><%= instrument.get("quantity") %></td>
                        <td><%= instrument.get("stockLevel") %></td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn" onclick="editInstrument(<%= instrument.get("instrumentId") %>)">
                                    <i class="fas fa-edit"></i>
                                </div>
                                <div class="action-btn delete-btn" onclick="deleteInstrument(<%= instrument.get("instrumentId") %>)">
                                    <i class="fas fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Customer Inquiries -->
        <div id="inquiries" class="content-card">
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
                    <%
                        for (Map<String, Object> inquiry : inquiries) {
                    %>
                    <tr>
                        <td>#<%= inquiry.get("inquiryId") %></td>
                        <td><%= inquiry.get("customerName") %></td>
                        <td><%= inquiry.get("subject") %></td>
                        <td><%= inquiry.get("date") %></td>
                        <td><span class="status status-<%= inquiry.get("status").toString().toLowerCase() %>"><%= inquiry.get("status") %></span></td>
                        <td>
                            <div class="action-buttons">
                                <div class="action-btn edit-btn" onclick="replyInquiry('<%= inquiry.get("inquiryId") %>')">
                                    <i class="fas fa-reply"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Profile Settings -->
        <div id="profile" class="content-card">
            <div class="card-header">
                <h2 class="card-title">Profile Settings</h2>
            </div>
            <form action="sellerdashboard.jsp" method="post" class="form-grid">
                <input type="hidden" name="action" value="updateProfile">
                <div class="form-group">
                    <label for="sellerName">Seller Name</label>
                    <input type="text" id="sellerName" name="sellerName" class="form-control" value="<%= sellerName != null ? sellerName : "Seller Name" %>">
                </div>
                <div class="form-group">
                    <label for="sellerEmail">Email</label>
                    <input type="email" id="sellerEmail" name="sellerEmail" class="form-control" value="<%= sellerEmail != null ? sellerEmail : "seller@example.com" %>">
                </div>
                <div class="form-group">
                    <label for="sellerPhone">Phone</label>
                    <input type="tel" id="sellerPhone" name="sellerPhone" class="form-control" value="+1 (555) 123-4567">
                </div>
                <div class="form-group">
                    <label for="sellerStore">Store Name</label>
                    <input type="text" id="sellerStore" name="sellerStore" class="form-control" value="Melody Mart Pro Shop">
                </div>
                <div class="form-group" style="grid-column: 1 / -1;">
                    <label for="sellerBio">Bio</label>
                    <textarea id="sellerBio" name="sellerBio" class="form-control" rows="3">Premium musical instruments seller with over 10 years of experience.</textarea>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-primary">Update Profile</button>
                </div>
            </form>
        </div>
    </main>
</div>

<!-- Add Instrument Modal -->
<div id="addInstrumentModal" class="modal" style="display: none;">
    <div class="modal-content">
        <h3>Add New Instrument</h3>
        <form action="sellerdashboard.jsp" method="post" class="form-grid">
            <input type="hidden" name="action" value="addInstrument">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" class="form-control" rows="2" required></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="number" id="price" name="price" class="form-control" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" id="quantity" name="quantity" class="form-control" min="1" required>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-primary">Add Instrument</button>
                <button type="button" onclick="closeAddInstrumentModal()" class="btn-outline">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Success/Error Messages -->
<%
    if (successMsg != null) {
%>
<div class="alert alert-success" style="position: fixed; top: 20px; right: 20px; z-index: 1000;">
    <%= successMsg %>
</div>
<%
    }
    if (errorMsg != null) {
%>
<div class="alert alert-error" style="position: fixed; top: 20px; right: 20px; z-index: 1000;">
    <%= errorMsg %>
</div>
<%
    }
%>

<!-- Floating Action Button -->
<div class="floating-elements">
    <div class="floating-btn" onclick="openAddInstrumentModal()">
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

    // Modal functions
    function openAddInstrumentModal() {
        document.getElementById('addInstrumentModal').style.display = 'flex';
    }

    function closeAddInstrumentModal() {
        document.getElementById('addInstrumentModal').style.display = 'none';
    }

    // Placeholder functions for actions
    function updateOrderStatus(orderId, status) {
        // AJAX or form submit to update status
        alert('Updating order ' + orderId + ' to ' + status);
    }

    function deleteOrder(orderId) {
        if (confirm('Delete order ' + orderId + '?')) {
            // AJAX or form submit to delete
            location.reload();
        }
    }

    function editInstrument(instrumentId) {
        alert('Editing instrument ' + instrumentId);
    }

    function deleteInstrument(instrumentId) {
        if (confirm('Delete instrument ' + instrumentId + '?')) {
            // AJAX or form submit to delete
            location.reload();
        }
    }

    function replyInquiry(inquiryId) {
        alert('Replying to inquiry ' + inquiryId);
    }

    // Auto-hide alerts
    setTimeout(() => {
        document.querySelectorAll('.alert').forEach(alert => {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        });
    }, 5000);
</script>
</body>
</html>