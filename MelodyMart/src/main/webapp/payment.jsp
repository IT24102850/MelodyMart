<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*, main.java.com.melodymart.util.DBConnection" %>

<%
    // --- Session and Role Check ---
    String userRole = (String) session.getAttribute("userRole");
    boolean isSeller = "seller".equalsIgnoreCase(userRole);
    boolean isCustomer = "customer".equalsIgnoreCase(userRole);
    String customerId = (String) session.getAttribute("customerId");

    List<Map<String, Object>> payments = (List<Map<String, Object>>) request.getAttribute("payments");
    String status = (String) request.getAttribute("status");
    String msg = (String) request.getAttribute("msg");

    // --- If servlet didn’t preload, load directly from DB ---
    if (payments == null || payments.isEmpty()) {
        payments = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql;
            PreparedStatement ps;

            if (isSeller) {
                sql = "SELECT p.PaymentID, p.OrderID, o.TotalAmount, p.MethodID, p.TransactionStatus, p.PaymentDate "
                        + "FROM Payment p JOIN OrderNow o ON p.OrderID = o.OrderID ORDER BY p.PaymentDate DESC";
                ps = conn.prepareStatement(sql);
            } else {
                sql = "SELECT p.PaymentID, p.OrderID, o.TotalAmount, p.MethodID, p.TransactionStatus, p.PaymentDate "
                        + "FROM Payment p "
                        + "JOIN OrderNow o ON p.OrderID = o.OrderID "
                        + "JOIN Person per ON CONCAT(per.FirstName, ' ', per.LastName) = o.CustomerName "
                        + "WHERE per.PersonID = ? ORDER BY p.PaymentDate DESC";
                ps = conn.prepareStatement(sql);
                ps.setString(1, customerId);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("paymentId", rs.getString("PaymentID"));
                row.put("orderId", rs.getString("OrderID"));
                row.put("totalAmount", rs.getDouble("TotalAmount"));
                row.put("methodId", rs.getString("MethodID"));
                row.put("transactionStatus", rs.getString("TransactionStatus"));
                row.put("paymentDate", rs.getTimestamp("PaymentDate"));
                payments.add(row);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Management | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2563eb;
            --secondary: #f8fafc;
            --text: #1e293b;
            --card-bg: #ffffff;
            --border: #e2e8f0;
            --success: #10b981;
            --warning: #f59e0b;
            --error: #ef4444;
            --info: #3b82f6;
            --shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background: var(--secondary); color: var(--text); padding: 20px; }
        .payment-dashboard { max-width: 1200px; margin: 0 auto; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .header h1 { font-size: 24px; color: var(--primary); display: flex; align-items: center; gap: 10px; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; color: white; background: var(--primary); margin: 5px; display: inline-flex; align-items: center; gap: 5px; }
        .alert { padding: 15px; margin-bottom: 20px; border-radius: 5px; display: flex; align-items: center; gap: 10px; }
        .alert-success { background: rgba(16,185,129,0.1); border: 1px solid var(--success); color: var(--success); }
        .alert-error { background: rgba(239,68,68,0.1); border: 1px solid var(--error); color: var(--error); }
        .alert-info { background: rgba(59,130,246,0.1); border: 1px solid var(--info); color: var(--info); }
        .table-container { background: var(--card-bg); padding: 20px; border-radius: 10px; box-shadow: var(--shadow); }
        .empty-state { text-align: center; padding: 40px; color: var(--text); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid var(--border); }
        th { background: var(--primary); color: white; font-size: 14px; text-transform: uppercase; }
        .status-select { padding: 5px; border-radius: 5px; border: 1px solid var(--border); }
        .action-buttons { display: flex; gap: 8px; }
        .action-buttons button { padding: 6px 12px; border: none; border-radius: 5px; cursor: pointer; display: inline-flex; align-items: center; gap: 5px; font-size: 13px; }
        .btn-delete { background: var(--error); color: white; }
        .btn-return { background: #f97316; color: white; }
        .status-badge { padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: bold; text-transform: capitalize; }
        .status-completed { background: rgba(16,185,129,0.1); color: var(--success); }
        .status-pending { background: rgba(245,158,11,0.1); color: var(--warning); }
        .status-failed { background: rgba(239,68,68,0.1); color: var(--error); }
        .status-returned { background: rgba(59,130,246,0.1); color: var(--info); }
        .method-badge { padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: bold; background: rgba(59,130,246,0.1); color: var(--info); }
    </style>
</head>
<body>
<div class="payment-dashboard">
    <div class="header">
        <h1><i class="fas fa-credit-card"></i> Payment Management</h1>
        <% if (isSeller) { %>
        <a href="sellerdashboard.jsp" class="btn"><i class="fas fa-arrow-left"></i> Back to Seller Dashboard</a>
        <% } else if (isCustomer) { %>
        <a href="customerlanding.jsp" class="btn"><i class="fas fa-arrow-left"></i> Back to Customer Dashboard</a>
        <% } %>
    </div>

    <% if (status != null && msg != null && !msg.trim().isEmpty()) { %>
    <div class="alert <%= "success".equalsIgnoreCase(status) ? "alert-success" : "error".equalsIgnoreCase(status) ? "alert-error" : "alert-info" %>">
        <i class="fas <%= "success".equalsIgnoreCase(status) ? "fa-check-circle" : "error".equalsIgnoreCase(status) ? "fa-exclamation-circle" : "fa-info-circle" %>"></i>
        <%= msg %>
    </div>
    <% } %>

    <div class="table-container">
        <% if (payments.isEmpty()) { %>
        <div class="empty-state">
            <i class="fas fa-credit-card fa-3x" style="color:#cbd5e1; margin-bottom:15px;"></i>
            <h3>No Payments Found</h3>
            <p>No payment records are available.</p>
        </div>
        <% } else { %>
        <table>
            <thead>
            <tr>
                <th>Payment ID</th>
                <th>Order ID</th>
                <th>Amount</th>
                <th>Payment Method</th>
                <th>Status</th>
                <th>Payment Date</th>
                <% if (isSeller) { %><th>Actions</th><% } %>
            </tr>
            </thead>
            <tbody>
            <% for (Map<String, Object> payment : payments) {
                String paymentStatus = (String) payment.get("transactionStatus");
                String methodId = (String) payment.get("methodId");
                String methodName = getMethodName(methodId);
            %>
            <tr>
                <td><strong><%= payment.get("paymentId") %></strong></td>
                <td><%= payment.get("orderId") %></td>
                <td>$<%= String.format("%.2f", payment.get("totalAmount")) %></td>
                <td><span class="method-badge"><%= methodName %></span></td>

                <td>
                    <% if (isSeller) { %>
                    <form action="PaymentManagementServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="paymentId" value="<%= payment.get("paymentId") %>">
                        <select name="status" class="status-select" onchange="this.form.submit()">
                            <option value="Completed" <%= "Completed".equalsIgnoreCase(paymentStatus) ? "selected" : "" %>>Completed</option>
                            <option value="Pending" <%= "Pending".equalsIgnoreCase(paymentStatus) ? "selected" : "" %>>Pending</option>
                            <option value="Failed" <%= "Failed".equalsIgnoreCase(paymentStatus) ? "selected" : "" %>>Failed</option>
                            <option value="Returned" <%= "Returned".equalsIgnoreCase(paymentStatus) ? "selected" : "" %>>Returned</option>
                        </select>
                    </form>
                    <% } else { %>
                    <span class="status-badge status-<%= paymentStatus.toLowerCase() %>"><%= paymentStatus %></span>
                    <% } %>
                </td>

                <td><%= payment.get("paymentDate") != null ? payment.get("paymentDate") : "N/A" %></td>

                <% if (isSeller) { %>
                <td class="action-buttons">
                    <form action="PaymentManagementServlet" method="post" style="display:inline;"
                          onsubmit="return confirm('Delete payment <%= payment.get("paymentId") %>?')">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="paymentId" value="<%= payment.get("paymentId") %>">
                        <button type="submit" class="btn-delete"><i class="fas fa-trash"></i> Delete</button>
                    </form>

                    <form action="PaymentManagementServlet" method="post" style="display:inline;"
                          onsubmit="return confirm('Refund payment <%= payment.get("paymentId") %>?')">
                        <input type="hidden" name="action" value="return">
                        <input type="hidden" name="paymentId" value="<%= payment.get("paymentId") %>">
                        <button type="submit" class="btn-return"><i class="fas fa-undo"></i> Return</button>
                    </form>
                </td>
                <% } %>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>
</body>
</html>

<%!
    // Helper method to map method IDs to readable names
    private String getMethodName(String methodId) {
        if (methodId == null) return "Unknown";
        switch (methodId) {
            case "PM001": return "Credit Card";
            case "PM002": return "Cash on Delivery";
            case "PM003": return "Debit Card";
            case "PM004": return "Bank Transfer";
            case "PM005": return "Gift Card";
            default: return methodId;
        }
    }
%>
