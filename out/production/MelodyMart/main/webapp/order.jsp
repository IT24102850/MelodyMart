<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="main.java.com.melodymart.model.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management | MelodyMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
            padding: 20px;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            margin-bottom: 30px;
        }
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 28px;
            font-weight: 700;
            color: #1e40af;
            text-decoration: none;
        }
        .logo i {
            font-size: 32px;
        }
        .header-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .back-btn {
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
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
            text-decoration: none;
        }
        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
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
            width: 50px;
            height: 50px;
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
        .dashboard-header {
            text-align: center;
            margin-bottom: 40px;
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
        .content-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .card-title {
            font-size: 24px;
            font-weight: 600;
            color: #1e293b;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .btn-primary {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            background: linear-gradient(135deg, #7c3aed, #6d28d9);
        }
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
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
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
        .table-responsive {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            background: white;
            border-radius: 12px;
            overflow: hidden;
        }
        .data-table th, .data-table td {
            padding: 15px;
            border-bottom: 1px solid #f1f5f9;
        }
        .data-table th {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
            color: white;
            font-weight: 600;
            text-align: left;
        }
        .data-table tr:last-child td {
            border-bottom: none;
        }
        .data-table tr:hover {
            background-color: #f8fafc;
        }
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            color: white;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
            text-align: center;
            min-width: 90px;
        }
        .status-pending {
            background: linear-gradient(135deg, #f59e0b, #d97706);
        }
        .status-processing {
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
        }
        .status-shipped {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
        }
        .status-delivered {
            background: linear-gradient(135deg, #10b981, #059669);
        }
        .status-cancelled {
            background: linear-gradient(135deg, #ef4444, #dc2626);
        }
        .action-btns {
            display: flex;
            gap: 8px;
        }
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
            border-radius: 6px;
        }
        .btn-edit {
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            color: white;
        }
        .btn-view {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
        }
        .btn-cancel {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
        }
        .btn-delete {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 16px;
            width: 90%;
            max-width: 700px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        .close-modal {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 24px;
            cursor: pointer;
            color: #64748b;
            transition: color 0.3s;
        }
        .close-modal:hover {
            color: #1e293b;
        }
        .modal-title {
            font-size: 22px;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #475569;
        }
        .form-control, .form-select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: #8b5cf6;
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.1);
        }
        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%2364748b' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            padding-right: 40px;
        }
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 25px;
        }
        .btn-cancel {
            background: #f1f5f9;
            color: #475569;
        }
        .btn-cancel:hover {
            background: #e2e8f0;
        }
        .order-details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        .order-detail-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #f1f5f9;
        }
        .order-detail-label {
            font-weight: 500;
            color: #475569;
        }
        .order-detail-value {
            font-weight: 600;
            color: #1e293b;
        }
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
        @media (max-width: 768px) {
            .stats-grid, .order-details-grid {
                grid-template-columns: 1fr;
            }
            .footer-links {
                flex-direction: column;
                gap: 10px;
            }
            .header-right {
                gap: 10px;
            }
            .back-btn, .logout-btn {
                padding: 8px 15px;
                font-size: 14px;
            }
            .back-btn span, .logout-btn span {
                display: none;
            }
            .card-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            .action-btns {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
<%
    List<Order> orders = new ArrayList<>();
    int totalOrders = 0, pendingOrders = 0, processingOrders = 0, deliveredOrders = 0;

    String url = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true";
    String user = "Hasiru";
    String password = "hasiru2004";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(url, user, password);
        if (conn != null) {
            stmt = conn.createStatement();
            String sql = "SELECT OrderID, CustomerID, OrderDate, TotalAmount, Status, Street, PostalCode FROM OrderTable";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getString("OrderID"));
                order.setCustomerID(rs.getString("CustomerID"));
                order.setOrderDate(rs.getDate("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                order.setStreet(rs.getString("Street"));
                order.setPostalCode(rs.getString("PostalCode"));
                orders.add(order);
                totalOrders++;
                if ("Pending".equalsIgnoreCase(order.getStatus())) pendingOrders++;
                else if ("Processing".equalsIgnoreCase(order.getStatus())) processingOrders++;
                else if ("Delivered".equalsIgnoreCase(order.getStatus())) deliveredOrders++;
            }
        }
    } catch (ClassNotFoundException e) {
        out.println("<p style='color: red;'>JDBC Driver not found: " + e.getMessage() + "</p>");
    } catch (SQLException e) {
        out.println("<p style='color: red;'>Database error: " + e.getMessage() + "</p>");
    } catch (Exception e) {
        out.println("<p style='color: red;'>Unexpected error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { /* Ignore */ }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* Ignore */ }
        if (conn != null) try { conn.close(); } catch (SQLException e) { /* Ignore */ }
    }

    // Handle update request
    String orderId = request.getParameter("orderId");
    String action = request.getParameter("action");
    if ("update".equals(action) && orderId != null) {
        String status = request.getParameter("status");
        String street = request.getParameter("street");
        String postalCode = request.getParameter("postalCode");

        Connection updateConn = null;
        PreparedStatement pstmt = null;
        try {
            updateConn = DriverManager.getConnection(url, user, password);
            String updateSql = "UPDATE OrderTable SET Status = ?, Street = ?, PostalCode = ? WHERE OrderID = ?";
            pstmt = updateConn.prepareStatement(updateSql);
            pstmt.setString(1, status);
            pstmt.setString(2, street);
            pstmt.setString(3, postalCode);
            pstmt.setString(4, orderId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("order.jsp");
            } else {
                out.println("<p style='color: red;'>No order updated.</p>");
            }
        } catch (SQLException e) {
            out.println("<p style='color: red;'>Update error: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { /* Ignore */ }
            if (updateConn != null) try { updateConn.close(); } catch (SQLException e) { /* Ignore */ }
        }
    }

    // Handle delete request
    if ("delete".equals(action) && orderId != null) {
        Connection deleteConn = null;
        PreparedStatement pstmt = null;
        try {
            deleteConn = DriverManager.getConnection(url, user, password);
            String deleteSql = "DELETE FROM OrderTable WHERE OrderID = ?";
            pstmt = deleteConn.prepareStatement(deleteSql);
            pstmt.setString(1, orderId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("order.jsp");
            } else {
                out.println("<p style='color: red;'>No order deleted.</p>");
            }
        } catch (SQLException e) {
            out.println("<p style='color: red;'>Delete error: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { /* Ignore */ }
            if (deleteConn != null) try { deleteConn.close(); } catch (SQLException e) { /* Ignore */ }
        }
    }
%>
<div class="container">
    <header>
        <a href="sellerdashboard.jsp" class="logo">
            <i class="fas fa-music"></i>
            <span>MelodyMart</span>
        </a>
        <div class="header-right">
            <a href="sellerdashboard.jsp" class="back-btn">
                <i class="fas fa-arrow-left"></i>
                <span>Back to Dashboard</span>
            </a>
            <button class="logout-btn" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </button>
            <div class="user-profile">
                <i class="fas fa-user"></i>
            </div>
        </div>
    </header>
    <div class="dashboard-header">
        <h1>Order Management</h1>
        <p>Manage all customer orders here</p>
    </div>
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);">
                <i class="fas fa-shopping-bag"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value" id="totalOrders"><%= totalOrders %></div>
                <div class="stat-label">Total Orders</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #f59e0b, #d97706);">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value" id="pendingOrders"><%= pendingOrders %></div>
                <div class="stat-label">Pending</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #3b82f6, #1d4ed8);">
                <i class="fas fa-truck"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value" id="processingOrders"><%= processingOrders %></div>
                <div class="stat-label">Processing</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #10b981, #059669);">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value" id="deliveredOrders"><%= deliveredOrders %></div>
                <div class="stat-label">Delivered</div>
            </div>
        </div>
    </div>
    <div class="content-card">
        <div class="card-header">
            <h2 class="card-title">All Orders</h2>
            <div>
                <button class="btn btn-primary" onclick="exportOrders()">
                    <i class="fas fa-file-export"></i> Export Orders
                </button>
            </div>
        </div>
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer ID</th>
                    <th>Order Date</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Street</th>
                    <th>PostalCode</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="ordersTableBody">
                <% if (orders.isEmpty()) { %>
                <tr><td colspan="8" style="text-align: center; padding: 20px;">No orders found.</td></tr>
                <% } else { %>
                <% for (Order order : orders) { %>
                <tr>
                    <td><strong><%= order.getOrderID() != null ? order.getOrderID() : "N/A" %></strong></td>
                    <td><%= order.getCustomerID() != null ? order.getCustomerID() : "N/A" %></td>
                    <td><%= order.getOrderDate() != null ? order.getOrderDate() : "N/A" %></td>
                    <td style="font-weight: 600; color: #1e40af;">
                        $<%= order.getTotalAmount() != 0.0 ? String.format("%.2f", order.getTotalAmount()) : "0.00" %>
                    </td>
                    <td><span class="status-badge status-<%= order.getStatus() != null ? order.getStatus().toLowerCase() : "pending" %>">
                                <%= order.getStatus() != null ? order.getStatus() : "Pending" %>
                            </span></td>
                    <td><%= order.getStreet() != null ? order.getStreet() : "N/A" %></td>
                    <td><%= order.getPostalCode() != null ? order.getPostalCode() : "N/A" %></td>
                    <td class="action-btns">
                        <button class="btn btn-sm btn-view" onclick="viewOrderDetails('<%= order.getOrderID() != null ? order.getOrderID() : "" %>')">
                            <i class="fas fa-eye"></i> View
                        </button>
                        <button class="btn btn-sm btn-edit" onclick="editOrder('<%= order.getOrderID() != null ? order.getOrderID() : "" %>')">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <% if (!"Cancelled".equalsIgnoreCase(order.getStatus()) && !"Delivered".equalsIgnoreCase(order.getStatus())) { %>
                        <button class="btn btn-sm btn-cancel" onclick="cancelOrder('<%= order.getOrderID() != null ? order.getOrderID() : "" %>')">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <% } %>
                        <button class="btn btn-sm btn-delete" onclick="deleteOrder('<%= order.getOrderID() != null ? order.getOrderID() : "" %>')">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </td>
                </tr>
                <% } %>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <footer>
        <div class="footer-links">
            <a href="#"><i class="fas fa-phone-alt"></i> Help</a>
            <a href="#"><i class="fas fa-file-contract"></i> Terms of Service</a>
            <a href="#"><i class="fas fa-shield-alt"></i> Privacy Policy</a>
        </div>
        <div class="copyright">
            &copy; 2023 MelodyMart. All rights reserved.
        </div>
    </footer>
</div>
<div id="editOrderModal" class="modal">
    <div class="modal-content">
        <span class="close-modal" onclick="closeModal('editOrderModal')">&times;</span>
        <h2 class="modal-title">Update Order</h2>
        <form id="editOrderForm" method="post" action="order.jsp">
            <input type="hidden" name="orderId" id="editOrderId">
            <input type="hidden" name="action" value="update">
            <div class="form-group">
                <label for="editOrderStatus">Order Status</label>
                <select class="form-select" name="status" id="editOrderStatus" required>
                    <option value="Pending">Pending</option>
                    <option value="Processing">Processing</option>
                    <option value="Shipped">Shipped</option>
                    <option value="Delivered">Delivered</option>
                    <option value="Cancelled">Cancelled</option>
                </select>
            </div>
            <div class="form-group">
                <label for="editStreet">Street Address</label>
                <input type="text" class="form-control" name="street" id="editStreet" placeholder="Enter street address" required>
            </div>
            <div class="form-group">
                <label for="editPostalCode">Postal Code</label>
                <input type="text" class="form-control" name="postalCode" id="editPostalCode" placeholder="Enter postal code" required>
            </div>
            <div class="form-actions">
                <button type="button" class="btn btn-cancel" onclick="closeModal('editOrderModal')">Cancel</button>
                <button type="submit" class="btn btn-primary">Update Order</button>
            </div>
        </form>
    </div>
</div>
<div id="orderDetailsModal" class="modal">
    <div class="modal-content">
        <span class="close-modal" onclick="closeModal('orderDetailsModal')">&times;</span>
        <h2 class="modal-title">Order Details - <span id="detailsOrderId"></span></h2>
        <div class="order-details-grid">
            <div>
                <h3 style="margin-bottom: 15px; color: #1e40af;">Order Information</h3>
                <div class="order-detail-item">
                    <span class="order-detail-label">Order ID:</span>
                    <span class="order-detail-value" id="detailOrderId">-</span>
                </div>
                <div class="order-detail-item">
                    <span class="order-detail-label">Customer ID:</span>
                    <span class="order-detail-value" id="detailCustomerId">-</span>
                </div>
                <div class="order-detail-item">
                    <span class="order-detail-label">Order Date:</span>
                    <span class="order-detail-value" id="detailOrderDate">-</span>
                </div>
                <div class="order-detail-item">
                    <span class="order-detail-label">Status:</span>
                    <span class="order-detail-value" id="detailStatus">-</span>
                </div>
            </div>
            <div>
                <h3 style="margin-bottom: 15px; color: #1e40af;">Payment & Shipping</h3>
                <div class="order-detail-item">
                    <span class="order-detail-label">Total Amount:</span>
                    <span class="order-detail-value" id="detailTotalAmount">-</span>
                </div>
                <div class="order-detail-item">
                    <span class="order-detail-label">Street:</span>
                    <span class="order-detail-value" id="detailStreet">-</span>
                </div>
                <div class="order-detail-item">
                    <span class="order-detail-label">Postal Code:</span>
                    <span class="order-detail-value" id="detailPostalCode">-</span>
                </div>
            </div>
        </div>
        <div class="form-actions">
            <button type="button" class="btn btn-cancel" onclick="closeModal('orderDetailsModal')">Close</button>
            <button type="button" class="btn btn-primary" onclick="editOrder(document.getElementById('detailOrderId').textContent);">
                <i class="fas fa-edit"></i> Edit Order
            </button>
        </div>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.content-card, .stat-card');
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

    function openModal(id) {
        document.getElementById(id).style.display = "flex";
    }

    function closeModal(id) {
        document.getElementById(id).style.display = "none";
    }

    function editOrder(orderId) {
        <% for (Order order : orders) { %>
        if ('<%= order.getOrderID() != null ? order.getOrderID() : "" %>' === orderId) {
            document.getElementById('editOrderId').value = '<%= order.getOrderID() != null ? order.getOrderID() : "" %>';
            document.getElementById('editOrderStatus').value = '<%= order.getStatus() != null ? order.getStatus() : "Pending" %>';
            document.getElementById('editStreet').value = '<%= order.getStreet() != null ? order.getStreet() : "" %>';
            document.getElementById('editPostalCode').value = '<%= order.getPostalCode() != null ? order.getPostalCode() : "" %>';
            openModal('editOrderModal');
            return;
        }
        <% } %>
        console.error('Order not found:', orderId);
        Swal.fire("Error", "Order not found.", "error");
    }

    function viewOrderDetails(orderId) {
        <% for (Order order : orders) { %>
        if ('<%= order.getOrderID() != null ? order.getOrderID() : "" %>' === orderId) {
            document.getElementById('detailsOrderId').textContent = '<%= order.getOrderID() != null ? order.getOrderID() : "N/A" %>';
            document.getElementById('detailOrderId').textContent = '<%= order.getOrderID() != null ? order.getOrderID() : "N/A" %>';
            document.getElementById('detailCustomerId').textContent = '<%= order.getCustomerID() != null ? order.getCustomerID() : "N/A" %>';
            document.getElementById('detailOrderDate').textContent = '<%= order.getOrderDate() != null ? order.getOrderDate() : "N/A" %>';
            document.getElementById('detailStatus').textContent = '<%= order.getStatus() != null ? order.getStatus() : "Pending" %>';
            document.getElementById('detailTotalAmount').textContent = '$<%= order.getTotalAmount() != 0.0 ? String.format("%.2f", order.getTotalAmount()) : "0.00" %>';
            document.getElementById('detailStreet').textContent = '<%= order.getStreet() != null ? order.getStreet() : "N/A" %>';
            document.getElementById('detailPostalCode').textContent = '<%= order.getPostalCode() != null ? order.getPostalCode() : "N/A" %>';
            openModal('orderDetailsModal');
            return;
        }
        <% } %>
        console.error('Order not found:', orderId);
        Swal.fire("Error", "Order not found.", "error");
    }

    function cancelOrder(orderId) {
        Swal.fire({
            title: "Cancel Order?",
            html: "Are you sure you want to cancel order <strong>#" + orderId + "</strong>?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Yes, cancel it",
            cancelButtonText: "No, keep it",
            confirmButtonColor: "#ef4444"
        }).then((result) => {
            if (result.isConfirmed) {
                fetch('order.jsp', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'action=update&orderId=' + encodeURIComponent(orderId) + '&status=Cancelled&street=' + encodeURIComponent(document.getElementById('detailStreet').textContent) + '&postalCode=' + encodeURIComponent(document.getElementById('detailPostalCode').textContent)
                }).then(response => {
                    if (response.ok) {
                        Swal.fire("Cancelled!", "Order has been cancelled.", "success").then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire("Error", "Failed to cancel order.", "error");
                    }
                });
            }
        });
    }

    function deleteOrder(orderId) {
        Swal.fire({
            title: "Delete Order?",
            html: "Are you sure you want to permanently delete order <strong>#" + orderId + "</strong>?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Yes, delete it",
            cancelButtonText: "No, keep it",
            confirmButtonColor: "#ef4444"
        }).then((result) => {
            if (result.isConfirmed) {
                fetch('order.jsp', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'action=delete&orderId=' + encodeURIComponent(orderId)
                }).then(response => {
                    if (response.ok) {
                        Swal.fire("Deleted!", "Order has been deleted.", "success").then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire("Error", "Failed to delete order.", "error");
                    }
                });
            }
        });
    }

    function exportOrders() {
        let csvContent = "OrderID,CustomerID,OrderDate,TotalAmount,Status,Street,PostalCode\n";
        <% for (Order order : orders) { %>
        csvContent += "<%= order.getOrderID() != null ? order.getOrderID() : "" %>,<%= order.getCustomerID() != null ? order.getCustomerID() : "" %>,<%= order.getOrderDate() != null ? order.getOrderDate() : "" %>,<%= order.getTotalAmount() != 0.0 ? String.format("%.2f", order.getTotalAmount()) : "0.00" %>,<%= order.getStatus() != null ? order.getStatus() : "Pending" %>,<%= order.getStreet() != null ? order.getStreet() : "" %>,<%= order.getPostalCode() != null ? order.getPostalCode() : "" %>\n";
        <% } %>
        const blob = new Blob([csvContent], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'orders.csv';
        a.click();
        window.URL.revokeObjectURL(url);
        Swal.fire("Exported!", "Order data has been exported successfully.", "success");
    }

    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = 'index.jsp';
        }
    }

    window.onclick = function(event) {
        const modals = document.getElementsByClassName('modal');
        for (let i = 0; i < modals.length; i++) {
            if (event.target == modals[i]) {
                closeModal(modals[i].id);
            }
        }
    }
</script>
</body>
</html>