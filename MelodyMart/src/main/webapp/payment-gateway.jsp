<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Payment Gateway</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            background: #fff;
            padding: 30px;
            width: 450px;
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
            color: #2a5298;
        }
        .btn-custom {
            background: #2a5298;
            color: #fff;
            border-radius: 12px;
            padding: 10px;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background: #1e3c72;
            color: #fff;
            transform: scale(1.02);
        }
        .form-control, .form-select {
            border-radius: 10px;
        }
        .success-msg {
            color: green;
            font-weight: bold;
            margin-top: 20px;
            text-align: center;
        }
        .error-msg {
            color: red;
            font-weight: bold;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="card">
    <h2>Mock Payment Gateway</h2>

    <!-- Payment Form -->
    <form action="payment-gateway.jsp" method="post">
        <div class="mb-3">
            <label class="form-label">Order ID</label>
            <input type="number" class="form-control" name="orderId" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Amount</label>
            <input type="text" class="form-control" name="amount" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Payment Method</label>
            <select class="form-select" name="paymentMethod" required>
                <option value="Visa">Visa</option>
                <option value="MasterCard">MasterCard</option>
                <option value="Amex">Amex</option>
                <option value="PayPal">PayPal</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">CVV</label>
            <input type="text" class="form-control" name="cvv" maxlength="3" required>
        </div>

        <button type="submit" class="btn btn-custom w-100">Pay Now</button>
    </form>

    <%
        // Handle form submission
        String orderId = request.getParameter("orderId");
        String amount = request.getParameter("amount");
        String paymentMethod = request.getParameter("paymentMethod");
        String cvv = request.getParameter("cvv");

        if(orderId != null && amount != null && paymentMethod != null && cvv != null){
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                conn = DBConnection.getConnection();

                // Generate unique transaction ID
                String txnId = "TXN" + (new java.util.Random().nextInt(9000) + 1000);

                String sql = "INSERT INTO Payment (OrderID, PaymentDate, Amount, PaymentMethod, TransactionID, CVV, Status) VALUES (?,?,?,?,?,?,?)";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(orderId));
                ps.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis()));
                ps.setDouble(3, Double.parseDouble(amount));
                ps.setString(4, paymentMethod);
                ps.setString(5, txnId);
                ps.setInt(6, Integer.parseInt(cvv));
                ps.setString(7, "Pending");

                int rows = ps.executeUpdate();
                if(rows > 0){
                    out.println("<p class='success-msg'>✅ Payment saved successfully!<br>Transaction ID: " + txnId + "</p>");
                } else {
                    out.println("<p class='error-msg'>❌ Payment failed.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='error-msg'>Error: " + e.getMessage() + "</p>");
            } finally {
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            }
        }
    %>
</div>
</body>
</html>
