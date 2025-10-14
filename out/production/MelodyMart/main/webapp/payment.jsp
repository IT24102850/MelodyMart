<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.melodymart.servlet.PaymentManagementServlet" %>
<%
    String userRole = (String) session.getAttribute("userRole");
    boolean isSeller = "seller".equals(userRole);
    boolean isCustomer = "customer".equals(userRole);
    String customerId = (String) session.getAttribute("customerId");
    System.out.println("payment.jsp - User Role: " + userRole + ", Is Seller: " + isSeller + ", Is Customer: " + isCustomer + ", Customer ID: " + customerId + ", Session ID: " + session.getId());

    List<Map<String, Object>> payments = (List<Map<String, Object>>) request.getAttribute("payments");
    String status = (String) request.getAttribute("status");
    String msg = (String) request.getAttribute("msg");

    if (payments == null) payments = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Management | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --primary: #2563eb; --secondary: #f8fafc; --text: #1e293b; --card-bg: #ffffff; --border: #e2e8f0; --success: #10b981; --warning: #f59e0b; --error: #ef4444; --info: #3b82f6; --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background: var(--secondary); color: var(--text); padding: 20px; }
        .payment-dashboard { max-width: 1200px; margin: 0 auto; }
        .header { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .header h1 { font-size: 24px; color: var(--primary); }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; color: white; background: var(--primary); margin: 5px; }
        .alert { padding: 15px; margin-bottom: 20px; border-radius: 5px; display: flex; gap: 10px; }
        .alert-success { background: rgba(16, 185, 129, 0.1); border: 1px solid var(--success); color: var(--success); }
        .alert-error { background: rgba(239, 68, 68, 0.1); border: 1px solid var(--error); color: var(--error); }
        .alert-info { background: rgba(59, 130, 246, 0.1); border: 1px solid var(--info); color: var(--info); }
        .table-container { background: var(--card-bg); padding: 20px; border-radius: 8px; box-shadow: var(--shadow); }
        .empty-state { text-align: center; padding: 40px; color: var(--text); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid var(--border); }
        th { background: var(--primary); color: white; }
        .status-select { padding: 5px; border-radius: 5px; border: 1px solid var(--border); }
        .action-buttons button { padding: 5px 10px; border: none; border-radius: 5px; cursor: pointer; }
        .btn-update { background: var(--info); color: white; }
        .btn-delete { background: var(--error); color: white; }
        .order-now-btn { background: var(--success); color: white; }
        .debug-info { background: #fff3cd; border: 1px solid #ffeaa7; padding: 10px; margin-top: 20px; border-radius: 5px; font-size: 12px; }
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

    <% if (status != null && msg != null) { %>
    <div class="alert <%= "success".equals(status) ? "alert-success" : "error".equals(status) ? "alert-error" : "alert-info" %>">
        <i class="fas <%= "success".equals(status) ? "fa-check-circle" : "error".equals(status) ? "fa-exclamation-circle" : "fa-info-circle" %>"></i>
        <%= msg %>
    </div>
    <% } %>

    <div class="table-container">
        <% if (payments.isEmpty()) { %>
        <div class="empty-state">
            <i class="fas fa-credit-card"></i>
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
                <th>Transaction ID</th>
                <th>Status</th>
                <th>Payment Date</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Map<String, Object> payment : payments) {
                boolean isCustomerPayment = isCustomer && customerId != null && payment.get("orderId") != null &&
                        PaymentManagementServlet.isOrderBelongsToCustomer(customerId, payment.get("orderId").toString());
                if (isCustomer && !isCustomerPayment) continue; // Only show customer's payments
            %>
            <tr>
                <td>#<%= payment.get("paymentId") %></td>
                <td>#<%= payment.get("orderId") %></td>
                <td>$<%= String.format("%.2f", payment.get("amount")) %></td>
                <td><%= payment.get("paymentMethod") != null ? payment.get("paymentMethod") : "N/A" %></td>
                <td><%= payment.get("transactionId") != null ? payment.get("transactionId") : "N/A" %></td>
                <td>
                    <% if (isSeller) { %>
                    <form action="UpdatePaymentServlet" method="post" style="display: inline;">
                        <input type="hidden" name="paymentId" value="<%= payment.get("paymentId") %>">
                        <select name="status" onchange="this.form.submit()"
                                class="status-select status-<%= ((String) payment.get("status")).toLowerCase() %>">
                            <option value="Pending" <%= "Pending".equals(payment.get("status")) ? "selected" : "" %>>Pending</option>
                            <option value="Success" <%= "Success".equals(payment.get("status")) ? "selected" : "" %>>Paid</option>
                            <option value="Canceled" <%= "Canceled".equals(payment.get("status")) ? "selected" : "" %>>Canceled</option>
                        </select>
                    </form>
                    <% } else { %>
                    <%= payment.get("status") %>
                    <% } %>
                </td>
                <td><%= payment.get("paymentDate") != null ? new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(payment.get("paymentDate")) : "N/A" %></td>
                <td class="action-buttons">
                    <% if (isSeller) { %>
                    <form action="DeletePaymentServlet" method="post" style="display: inline;"
                          onsubmit="return confirm('Are you sure you want to delete this payment?')">
                        <input type="hidden" name="paymentId" value="<%= payment.get("paymentId") %>">
                        <button type="submit" class="btn-delete"><i class="fas fa-trash"></i> Delete</button>
                    </form>
                    <% } %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>

    <% if (isCustomer) { %>
    <div style="text-align: center; margin-top: 20px;">
        <a href="javascript:void(0)" class="btn order-now-btn" onclick="orderNow()">Order Now</a>
    </div>
    <% } %>

    <div class="debug-info">
        <strong>Debug Info:</strong><br>
        User Role: <%= userRole != null ? userRole : "Not set" %><br>
        Is Seller: <%= isSeller %><br>
        Is Customer: <%= isCustomer %><br>
        Customer ID: <%= customerId != null ? customerId : "Not set" %><br>
        Session ID: <%= session.getId() %><br>
        Payments Count: <%= payments.size() %>
    </div>
</div>

<script>
    function orderNow() {
        var orderId = "O" + Math.floor(Math.random() * 1000).toString().padStart(3, '0'); // Dummy order ID
        var amount = 10000.00; // Dummy amount (replace with cart total)
        window.location.href = "paymentform.jsp?orderId=" + orderId + "&amount=" + amount;
    }
</script>
</body>
</html>