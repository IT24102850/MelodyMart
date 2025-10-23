<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Ensure seller is logged in
    String sellerId = (String) session.getAttribute("sellerId");
    String sellerName = (String) session.getAttribute("userName");
    if (sellerId == null) {
        response.sendRedirect(request.getContextPath() + "/sign-in.jsp");
        return;
    }

    // Retrieve feedback messages from session
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");

    // Remove them to prevent reappearing
    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Management | MelodyMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f1f5f9; margin: 0; color: #1e293b; }
        .container { max-width: 1200px; margin: 40px auto; background: #fff; border-radius: 12px;
            padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0;
            margin-bottom: 20px; padding-bottom: 10px; }
        .header h1 { color: #2563eb; margin: 0; }
        .back-btn { background: #64748b; color: white; border: none; border-radius: 8px;
            padding: 10px 20px; font-weight: 600; cursor: pointer; text-decoration: none;
            display: inline-flex; align-items: center; gap: 8px; }
        .back-btn:hover { background: #475569; transform: translateY(-2px); }

        .alert { padding: 12px; border-radius: 6px; margin-bottom: 20px; color: white; font-weight: 500; }
        .alert-success { background: #10b981; }
        .alert-error { background: #ef4444; }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #e2e8f0; text-align: left; font-size: 15px; vertical-align: middle; }
        th { background: #2563eb; color: white; }
        tr:nth-child(even) { background: #f9fafb; }
        tr:hover { background: #e0f2fe; }

        .status { padding: 6px 10px; border-radius: 6px; font-weight: 600; font-size: 13px; text-transform: uppercase; }
        .status-Pending { background: #fef3c7; color: #b45309; }
        .status-Processing { background: #dbeafe; color: #1e40af; }
        .status-Shipped { background: #bfdbfe; color: #1d4ed8; }
        .status-Delivered { background: #dcfce7; color: #166534; }
        .status-Cancelled { background: #fee2e2; color: #dc2626; }

        .action-btn { border: none; border-radius: 6px; padding: 6px 12px; font-size: 14px; cursor: pointer; color: white; }
        .update-btn { background: #2563eb; }
        .cancel-btn { background: #dc2626; }
        .update-btn:hover { background: #1d4ed8; }
        .cancel-btn:hover { background: #b91c1c; }

        .fade-out { animation: fadeOut 4s forwards; }
        @keyframes fadeOut {
            0% { opacity: 1; }
            80% { opacity: 1; }
            100% { opacity: 0; display: none; }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Order Management</h1>
        <a href="<%= request.getContextPath() %>/sellerdashboard.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <% if (successMessage != null) { %>
    <div class="alert alert-success fade-out"><%= successMessage %></div>
    <% } else if (errorMessage != null) { %>
    <div class="alert alert-error fade-out"><%= errorMessage %></div>
    <% } %>

    <table>
        <tr>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Phone</th>
            <th>City</th>
            <th>Address</th>
            <th>Total (LKR)</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>

        <%
            boolean hasOrders = false;

            try (Connection conn = DBConnection.getConnection()) {
                if (conn != null) {
                    String sql = "SELECT * FROM OrderNow ORDER BY CreatedAt DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        hasOrders = true;
                        String orderId = rs.getString("OrderID");
                        String customer = rs.getString("CustomerName");
                        String phone = rs.getString("PhoneNumber");
                        String city = rs.getString("City");
                        String address = rs.getString("Address");
                        double total = rs.getDouble("TotalAmount");
                        String status = rs.getString("Status");
                        String created = rs.getString("CreatedAt");
                        String statusClass = "status-" + status.replace(" ", "");
        %>
        <tr>
            <td><%= orderId %></td>
            <td><%= customer %></td>
            <td><%= phone %></td>
            <td><%= city %></td>
            <td><%= address %></td>
            <td>LKR <%= String.format("%.2f", total) %></td>
            <td><span class="status <%= statusClass %>"><%= status %></span></td>
            <td><%= created %></td>
            <td>
                <% if (!"Cancelled".equalsIgnoreCase(status) && !"Delivered".equalsIgnoreCase(status)) { %>
                <!-- Update Order -->
                <form action="<%= request.getContextPath() %>/UpdateOrderStatusServlet"
                      method="post" style="display:inline;">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <select name="status" required style="padding:4px; border-radius:4px;">
                        <option value="Pending" <%= "Pending".equals(status) ? "selected" : "" %>>Pending</option>
                        <option value="Processing" <%= "Processing".equals(status) ? "selected" : "" %>>Processing</option>
                        <option value="Shipped" <%= "Shipped".equals(status) ? "selected" : "" %>>Shipped</option>
                        <option value="Delivered" <%= "Delivered".equals(status) ? "selected" : "" %>>Delivered</option>
                    </select>
                    <button type="submit" class="action-btn update-btn"><i class="fas fa-sync"></i> Update</button>
                </form>

                <!-- Reject Order -->
                <form action="<%= request.getContextPath() %>/SellerRejectOrderServlet"
                      method="post" style="display:inline;"
                      onsubmit="return confirm('Reject this order?');">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <button type="submit" class="action-btn cancel-btn"><i class="fas fa-times"></i> Reject</button>
                </form>
                <% } else { %>
                <em>-</em>
                <% } %>
            </td>
        </tr>
        <%
                    }
                    rs.close();
                    ps.close();
                } else {
                    out.println("<tr><td colspan='9' style='text-align:center; color:red;'>Database connection failed.</td></tr>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<tr><td colspan='9' style='text-align:center; color:red;'>Error: " + e.getMessage() + "</td></tr>");
            }

            if (!hasOrders) {
        %>
        <tr>
            <td colspan="9" style="text-align:center; color:#64748b; padding:30px;">
                <i class="fas fa-box" style="font-size:48px; color:#cbd5e1; display:block; margin-bottom:10px;"></i>
                No orders found.
            </td>
        </tr>
        <% } %>
    </table>
</div>

<script>
    // Automatically fade out success/error alerts after 4 seconds
    window.addEventListener('DOMContentLoaded', () => {
        const alerts = document.querySelectorAll('.fade-out');
        setTimeout(() => {
            alerts.forEach(a => a.style.display = 'none');
        }, 4000);
    });
</script>
</body>
</html>
