<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management | Melody Mart</title>
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
            background: rgba(10, 10, 10, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.5);
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
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            bottom: -5px;
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

        .search-btn, .cart-btn {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            margin-left: 20px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .search-btn:hover, .cart-btn:hover {
            color: var(--primary-light);
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
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
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
        }

        .user-btn:hover {
            color: var(--primary-light);
        }

        .dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 10px;
            width: 200px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(10px);
            transition: opacity 0.3s ease, transform 0.3s ease, visibility 0.3s;
            z-index: 1000;
        }

        .user-menu:hover .dropdown {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-item {
            display: block;
            padding: 10px 15px;
            color: var(--text);
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s ease, color 0.3s ease;
            cursor: pointer;
        }

        .dropdown-item:hover {
            background: var(--card-hover);
            color: var(--primary-light);
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
        }

        /* Order Table Container */
        .table-container {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 40px;
            border: 1px solid var(--glass-border);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .table-title {
            font-size: 24px;
            margin-bottom: 20px;
            color: var(--primary-light);
        }

        /* Table Styles */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .data-table th {
            background: rgba(138, 43, 226, 0.1);
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: var(--primary-light);
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
            background: rgba(255, 255, 255, 0.03);
        }

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }

        .status-processing {
            background: rgba(0, 123, 255, 0.2);
            color: #007bff;
        }

        .status-shipped {
            background: rgba(111, 66, 193, 0.2);
            color: #6f42c1;
        }

        .status-delivered {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .status-cancelled {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }

        /* Action Buttons */
        .action-btn {
            background: none;
            border: none;
            color: var(--primary-light);
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
            transition: all 0.3s ease;
            padding: 8px;
            border-radius: 50%;
        }

        .action-btn:hover {
            background: rgba(138, 43, 226, 0.1);
            transform: scale(1.1);
        }

        .action-btn.delete-btn {
            color: #ff6b6b;
        }

        .action-btn.delete-btn:hover {
            background: rgba(255, 107, 107, 0.1);
        }

        .action-btn.cancel-btn {
            color: #ffa500;
        }

        .action-btn.cancel-btn:hover {
            background: rgba(255, 165, 0, 0.1);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            z-index: 2000;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(5px);
        }

        .modal-content {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            max-width: 500px;
            width: 90%;
            position: relative;
            border: 1px solid var(--glass-border);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
            opacity: 0;
            transform: scale(0.9);
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
            font-size: 24px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .modal-close:hover {
            color: var(--primary-light);
        }

        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            margin-bottom: 20px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text);
        }

        .form-control, .form-select {
            width: 100%;
            padding: 12px 15px;
            border-radius: 8px;
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 2px rgba(138, 43, 226, 0.2);
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .stat-number {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 5px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Toast Notification */
        .toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: var(--card-bg);
            color: var(--text);
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            border-left: 4px solid var(--primary);
            z-index: 3000;
            transform: translateX(150%);
            transition: transform 0.3s ease;
        }

        .toast.show {
            transform: translateX(0);
        }

        .toast.success {
            border-left-color: #28a745;
        }

        .toast.error {
            border-left-color: #dc3545;
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

            .table-container {
                padding: 20px;
            }

            .modal-content {
                padding: 20px;
            }

            .user-menu:hover .dropdown {
                display: none;
            }

            .stats-container {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 576px) {
            body {
                padding-top: 70px;
            }

            .page-title {
                font-size: 24px;
            }

            .table-title {
                font-size: 20px;
            }

            .data-table th, .data-table td {
                padding: 10px;
                font-size: 14px;
            }

            .stats-container {
                grid-template-columns: 1fr;
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
            <li><a href="orders.jsp" style="color: var(--primary-light);">Orders</a></li>
            <li><a href="repair-requests.jsp">Repair Requests</a></li>
            <li><a href="profile.jsp">Profile</a></li>
        </ul>

        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <button class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></button>
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i> Admin</button>
                <div class="dropdown">
                    <a href="profile.jsp" class="dropdown-item"><i class="fas fa-user-circle"></i> My Profile</a>
                    <a href="orders.jsp" class="dropdown-item"><i class="fas fa-shopping-bag"></i> Order Management</a>
                    <a href="repair-requests.jsp" class="dropdown-item"><i class="fas fa-tools"></i> Repair Requests</a>
                    <a href="customers.jsp" class="dropdown-item"><i class="fas fa-users"></i> Customer Management</a>
                    <a href="settings.jsp" class="dropdown-item"><i class="fas fa-cog"></i> Settings</a>
                    <a href="index.jsp" class="dropdown-item"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">Order Management</h1>
        <button class="cta-btn" id="refreshOrdersBtn">
            <i class="fas fa-sync-alt"></i> Refresh Orders
        </button>
    </div>

    <!-- Order Statistics -->
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-number" id="totalOrders">0</div>
            <div class="stat-label">Total Orders</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="pendingOrders">0</div>
            <div class="stat-label">Pending Orders</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="processingOrders">0</div>
            <div class="stat-label">Processing Orders</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="deliveredOrders">0</div>
            <div class="stat-label">Delivered Orders</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="cancelledOrders">0</div>
            <div class="stat-label">Cancelled Orders</div>
        </div>
    </div>

    <!-- Orders Table -->
    <div class="table-container">
        <h2 class="table-title">All Orders</h2>
        <table class="data-table">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer ID</th>
                <th>Seller ID</th>
                <th>Order Date</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th>Delivery Address</th>
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
                    String sql = "SELECT OrderID, CustomerID, SellerID, OrderDate, TotalAmount, Status, DeliveryAddressID FROM Orders ORDER BY OrderDate DESC";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    int totalOrders = 0;
                    int pendingOrders = 0;
                    int processingOrders = 0;
                    int deliveredOrders = 0;
                    int cancelledOrders = 0;

                    while (rs.next()) {
                        totalOrders++;
                        String status = rs.getString("Status");
                        if ("Pending".equalsIgnoreCase(status)) pendingOrders++;
                        if ("Processing".equalsIgnoreCase(status)) processingOrders++;
                        if ("Delivered".equalsIgnoreCase(status)) deliveredOrders++;
                        if ("Cancelled".equalsIgnoreCase(status)) cancelledOrders++;
            %>
            <tr>
                <td>#<%= rs.getInt("OrderID") %></td>
                <td>#CUST-<%= rs.getInt("CustomerID") %></td>
                <td>#SELL-<%= rs.getInt("SellerID") %></td>
                <td><%= rs.getTimestamp("OrderDate") %></td>
                <td style="font-weight: 600; color: var(--accent);">$<%= rs.getBigDecimal("TotalAmount") %></td>
                <td>
                    <span class="status-badge status-<%= status.toLowerCase() %>"><%= status %></span>
                </td>
                <td>
                    <%
                        if (rs.getObject("DeliveryAddressID") != null) {
                    %>
                    #ADDR-<%= rs.getInt("DeliveryAddressID") %>
                    <%
                    } else {
                    %>
                    <span style="color: var(--text-secondary); font-style: italic;">Not set</span>
                    <%
                        }
                    %>
                </td>
                <td>
                    <button class="action-btn" title="Edit Order" onclick="openEditModal(<%= rs.getInt("OrderID") %>, '<%= status %>')">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="action-btn" title="View Details" onclick="viewOrderDetails(<%= rs.getInt("OrderID") %>)">
                        <i class="fas fa-eye"></i>
                    </button>
                    <%
                        if (!"Cancelled".equalsIgnoreCase(status) && !"Delivered".equalsIgnoreCase(status)) {
                    %>
                    <button class="action-btn cancel-btn" title="Cancel Order" onclick="cancelOrder(<%= rs.getInt("OrderID") %>)">
                        <i class="fas fa-times-circle"></i>
                    </button>
                    <%
                        }
                    %>
                    <button class="action-btn delete-btn" title="Delete Order" onclick="deleteOrder(<%= rs.getInt("OrderID") %>)">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            </tr>
            <%
                    }

                    // Store counts for JavaScript
                    out.println("<script>");
                    out.println("document.getElementById('totalOrders').textContent = '" + totalOrders + "';");
                    out.println("document.getElementById('pendingOrders').textContent = '" + pendingOrders + "';");
                    out.println("document.getElementById('processingOrders').textContent = '" + processingOrders + "';");
                    out.println("document.getElementById('deliveredOrders').textContent = '" + deliveredOrders + "';");
                    out.println("document.getElementById('cancelledOrders').textContent = '" + cancelledOrders + "';");
                    out.println("</script>");

                } catch (Exception e) {
                    out.println("<tr><td colspan='8' style='color:#ff6b6b; text-align:center; padding:20px;'>Error loading orders: " + e.getMessage() + "</td></tr>");
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

<!-- Edit Order Modal -->
<div class="modal" id="editOrderModal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('editOrderModal')">&times;</button>
        <h2 class="modal-title">Update Order Status</h2>
        <form id="editOrderForm" method="post" action="${pageContext.request.contextPath}/UpdateOrderServlet">
            <input type="hidden" name="orderId" id="editOrderId">
            <div class="form-group">
                <label class="form-label">Order Status</label>
                <select class="form-select" name="status" id="editOrderStatus" required>
                    <option value="Pending">Pending</option>
                    <option value="Processing">Processing</option>
                    <option value="Shipped">Shipped</option>
                    <option value="Delivered">Delivered</option>
                    <option value="Cancelled">Cancelled</option>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label">Delivery Address ID (Optional)</label>
                <input type="text" class="form-control" name="deliveryAddressId" id="editDeliveryAddressId" placeholder="Enter delivery address ID">
            </div>
            <button type="submit" class="cta-btn" style="width: 100%;">
                <i class="fas fa-save"></i> Update Order
            </button>
        </form>
    </div>
</div>

<!-- Order Details Modal -->
<div class="modal" id="orderDetailsModal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('orderDetailsModal')">&times;</button>
        <h2 class="modal-title">Order Details</h2>
        <div id="orderDetailsContent">
            <!-- Order details will be loaded here -->
        </div>
    </div>
</div>

<!-- Cancel Order Modal -->
<div class="modal" id="cancelOrderModal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('cancelOrderModal')">&times;</button>
        <h2 class="modal-title">Cancel Order</h2>
        <div class="form-group">
            <p>Are you sure you want to cancel order #<span id="cancelOrderId"></span>?</p>
            <p style="color: var(--text-secondary); margin-top: 10px;">This action cannot be undone.</p>
        </div>
        <div class="form-group">
            <label class="form-label">Cancellation Reason (Optional)</label>
            <textarea class="form-control" id="cancelReason" placeholder="Enter reason for cancellation" rows="3"></textarea>
        </div>
        <div style="display: flex; gap: 10px;">
            <button class="cta-btn" style="flex: 1; background: var(--secondary);" onclick="closeModal('cancelOrderModal')">No, Keep Order</button>
            <button class="cta-btn" style="flex: 1; background: linear-gradient(135deg, #ff6b6b, #ff8e53);" id="confirmCancelBtn">Yes, Cancel Order</button>
        </div>
    </div>
</div>

<!-- Toast Notification -->
<div class="toast" id="toast"></div>

<script>
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

    function openEditModal(orderId, currentStatus) {
        document.getElementById("editOrderId").value = orderId;
        document.getElementById("editOrderStatus").value = currentStatus;
        document.getElementById("editDeliveryAddressId").value = "";
        openModal("editOrderModal");
    }

    function viewOrderDetails(orderId) {
        // In a real application, you would fetch order details from the server
        // For now, we'll show a placeholder message
        document.getElementById("orderDetailsContent").innerHTML = `
            <div style="text-align: center; padding: 20px;">
                <i class="fas fa-info-circle" style="font-size: 48px; color: var(--primary-light); margin-bottom: 15px;"></i>
                <p>Order details for order #${orderId} would be displayed here.</p>
                <p style="color: var(--text-secondary); margin-top: 10px;">This feature would connect to your backend to fetch detailed order information.</p>
            </div>
        `;
        openModal("orderDetailsModal");
    }

    function cancelOrder(orderId) {
        document.getElementById("cancelOrderId").textContent = orderId;
        document.getElementById("cancelReason").value = "";

        // Set up the confirm button
        const confirmBtn = document.getElementById("confirmCancelBtn");
        confirmBtn.onclick = function() {
            processOrderCancellation(orderId);
        };

        openModal("cancelOrderModal");
    }

    function processOrderCancellation(orderId) {
        const reason = document.getElementById("cancelReason").value;
        const btn = document.getElementById("confirmCancelBtn");
        const originalText = btn.innerHTML;

        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Cancelling...';
        btn.disabled = true;

        // In a real application, you would make an AJAX request to cancel the order
        // For now, we'll simulate the process
        setTimeout(() => {
            showToast("Order #" + orderId + " has been cancelled successfully!", "success");
            closeModal('cancelOrderModal');

            // In a real application, you would update the order status in the database
            // For now, we'll just reload the page to show the updated status
            setTimeout(() => {
                location.reload();
            }, 1500);
        }, 1500);
    }

    function deleteOrder(orderId) {
        if (confirm("Are you sure you want to delete order #" + orderId + "? This action cannot be undone.")) {
            // In a real application, you would submit a form or make an AJAX request to delete the order
            showToast("Order #" + orderId + " deletion request sent.", "success");
            // Example: window.location.href = "DeleteOrderServlet?orderId=" + orderId;
        }
    }

    // Toast notification function
    function showToast(message, type) {
        const toast = document.getElementById("toast");
        toast.textContent = message;
        toast.className = "toast " + type;
        toast.classList.add("show");

        setTimeout(() => {
            toast.classList.remove("show");
        }, 3000);
    }

    // Close modal when clicking outside
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                closeModal(modal.id);
            }
        });
    });

    // Refresh orders button
    document.getElementById('refreshOrdersBtn').addEventListener('click', function() {
        const btn = this;
        const originalText = btn.innerHTML;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Refreshing...';
        btn.disabled = true;

        // Simulate refresh delay
        setTimeout(() => {
            location.reload();
        }, 1000);
    });

    // Form submission handler
    document.getElementById('editOrderForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const submitBtn = this.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
        submitBtn.disabled = true;

        // Simulate form submission
        setTimeout(() => {
            showToast("Order status updated successfully!", "success");
            closeModal('editOrderModal');
            location.reload(); // Refresh the page to show updated data
        }, 1500);
    });

    // Animate stats counters
    document.addEventListener('DOMContentLoaded', function() {
        const statElements = document.querySelectorAll('.stat-number');
        statElements.forEach(stat => {
            const target = parseInt(stat.textContent);
            let current = 0;
            const increment = target / 50;

            const updateStat = () => {
                if (current < target) {
                    current += increment;
                    stat.textContent = Math.round(current);
                    setTimeout(updateStat, 30);
                } else {
                    stat.textContent = target;
                }
            };

            setTimeout(updateStat, 500);
        });
    });
</script>

</body>
</html>