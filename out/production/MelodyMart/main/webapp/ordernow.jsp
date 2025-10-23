<%@ page import="java.sql.*, java.util.*, main.java.com.melodymart.util.DBConnection" %>
<%
    // ✅ Ensure user is logged in
    String customerId = (String) session.getAttribute("customerId");
    if (customerId == null) {
        response.sendRedirect("sign-in.jsp");
        return;
    }

    double totalAmount = 0.0;
    if (request.getParameter("total") != null) {
        try {
            totalAmount = Double.parseDouble(request.getParameter("total"));
        } catch (Exception e) {
            totalAmount = 0.0;
        }
    }

    String orderId = "O" + System.currentTimeMillis(); // simple unique ID
    Timestamp orderDate = new Timestamp(System.currentTimeMillis());
    boolean success = false;
    List<String> orderedItems = new ArrayList<>();

    try (Connection conn = DBConnection.getConnection()) {
        conn.setAutoCommit(false);

        // ✅ 1. Insert into Orders table
        String insertOrderSQL = "INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSQL)) {
            psOrder.setString(1, orderId);
            psOrder.setString(2, customerId);
            psOrder.setTimestamp(3, orderDate);
            psOrder.setDouble(4, totalAmount);
            psOrder.setString(5, "Pending");
            psOrder.executeUpdate();
        }

        // ✅ 2. Retrieve cart items and insert into OrderDetails table
        String selectCartSQL = "SELECT C.InstrumentID, C.Quantity, I.Price FROM Cart C JOIN Instrument I ON C.InstrumentID = I.InstrumentID WHERE C.CustomerID = ?";
        try (PreparedStatement psCart = conn.prepareStatement(selectCartSQL)) {
            psCart.setString(1, customerId);
            ResultSet rsCart = psCart.executeQuery();

            String insertDetailSQL = "INSERT INTO OrderDetails (OrderID, InstrumentID, Quantity, UnitPrice, Subtotal) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psDetail = conn.prepareStatement(insertDetailSQL);

            while (rsCart.next()) {
                String instrumentId = rsCart.getString("InstrumentID");
                int quantity = rsCart.getInt("Quantity");
                double price = rsCart.getDouble("Price");
                double subtotal = price * quantity;

                psDetail.setString(1, orderId);
                psDetail.setString(2, instrumentId);
                psDetail.setInt(3, quantity);
                psDetail.setDouble(4, price);
                psDetail.setDouble(5, subtotal);
                psDetail.addBatch();

                orderedItems.add(instrumentId);
            }

            psDetail.executeBatch();
            psDetail.close();
            rsCart.close();
        }

        // ✅ 3. Clear Cart
        String deleteCartSQL = "DELETE FROM Cart WHERE CustomerID = ?";
        try (PreparedStatement psDelete = conn.prepareStatement(deleteCartSQL)) {
            psDelete.setString(1, customerId);
            psDelete.executeUpdate();
        }

        // ✅ Commit all
        conn.commit();
        success = true;

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

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
            max-width: 800px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        h1 {
            color: #3a56d4;
            text-align: center;
            margin-bottom: 20px;
        }
        p {
            text-align: center;
            font-size: 16px;
            color: #444;
        }
        .order-summary {
            margin-top: 30px;
        }
        .order-summary h2 {
            color: #3a56d4;
            border-bottom: 2px solid #e5e7eb;
            padding-bottom: 8px;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        .table th, .table td {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .table th {
            background: #f3f4f6;
            color: #3a56d4;
        }
        .success-icon {
            color: #10b981;
            font-size: 80px;
            display: block;
            text-align: center;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            background: #3a56d4;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
            margin-top: 20px;
        }
        .btn:hover {
            background: #2e46b9;
        }
        .center {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        if (success) {
    %>
    <div class="success-icon"><i class="fas fa-check-circle"></i></div>
    <h1>Order Placed Successfully!</h1>
    <p>Your order has been created successfully. We’ll notify you when it ships.</p>

    <div class="order-summary">
        <h2>Order Details</h2>
        <table class="table">
            <tr><th>Order ID</th><td><%= orderId %></td></tr>
            <tr><th>Order Date</th><td><%= orderDate %></td></tr>
            <tr><th>Total Amount</th><td>$<%= String.format("%.2f", totalAmount) %></td></tr>
            <tr><th>Status</th><td>Pending</td></tr>
        </table>
    </div>

    <div class="center">
        <a href="shop.jsp" class="btn"><i class="fas fa-shopping-bag"></i> Continue Shopping</a>
        <a href="orders.jsp" class="btn"><i class="fas fa-box"></i> View My Orders</a>
    </div>
    <%
    } else {
    %>
    <h1 style="color:red;">Order Failed!</h1>
    <p>Something went wrong while processing your order. Please try again later.</p>
    <div class="center">
        <a href="cart.jsp" class="btn">Go Back to Cart</a>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
