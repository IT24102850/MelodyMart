<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fb;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 700px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            color: #3a56d4;
            margin-bottom: 10px;
        }
        p {
            color: #444;
            font-size: 1.1rem;
            margin-bottom: 10px;
        }
        .success-icon {
            color: #10b981;
            font-size: 80px;
            margin-bottom: 15px;
        }
        .fail-icon {
            color: #e11d48;
            font-size: 80px;
            margin-bottom: 15px;
        }
        .btn {
            display: inline-block;
            background: #3a56d4;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            margin: 15px 10px;
        }
        .btn:hover {
            background: #2e46b9;
        }
        table {
            margin: 25px auto;
            border-collapse: collapse;
            font-size: 1rem;
        }
        td {
            padding: 6px 12px;
        }
        .amount {
            color: #3a56d4;
            font-weight: bold;
        }
    </style>
</head>
<body>
<%
    // ✅ Read parameters passed from PlaceOrderServlet
    String orderId = request.getParameter("orderId");
    String amount = request.getParameter("amount");
    String status = request.getParameter("status");

    // Default values if not provided
    if (status == null && orderId != null) {
        status = "success";
    }
%>

<div class="container">
    <%
        if ("success".equalsIgnoreCase(status)) {
    %>
    <div class="success-icon"><i class="fas fa-check-circle"></i></div>
    <h1>Order Placed Successfully!</h1>
    <p>Thank you for your purchase 🎵</p>

    <table>
        <tr><td><strong>Order ID:</strong></td><td><%= orderId != null ? orderId : "N/A" %></td></tr>
        <tr><td><strong>Total Amount:</strong></td><td class="amount">$<%= amount != null ? amount : "0.00" %></td></tr>
        <tr><td><strong>Status:</strong></td><td>Pending</td></tr>
    </table>

    <a href="payment-method.jsp?orderId=<%= orderId %>&amount=<%= amount %>" class="btn">
        <i class="fas fa-credit-card"></i> Proceed to Payment
    </a>
    <a href="orders.jsp" class="btn">
        <i class="fas fa-box"></i> View My Orders
    </a>

    <%
    } else {
    %>
    <div class="fail-icon"><i class="fas fa-times-circle"></i></div>
    <h1>Order Failed!</h1>
    <p>Something went wrong while processing your order. Please try again.</p>
    <a href="order-summary.jsp" class="btn">Go Back</a>
    <%
        }
    %>
</div>
</body>
</html>
