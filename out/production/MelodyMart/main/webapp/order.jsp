<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart - Melody Mart</title>
    <style>
        body { font-family: Arial, sans-serif; background: #0a0a0a; color: #fff; padding: 20px; }
        h2 { color: #8a2be2; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th, td { padding: 12px; border-bottom: 1px solid #444; text-align: left; }
        th { background: #1a1a1a; }
        tr:hover { background: #222; }
        img { width: 80px; height: 60px; object-fit: cover; border-radius: 8px; }
        .total { font-weight: bold; font-size: 18px; color: #8a2be2; text-align: right; }
        .cta-btn { background: linear-gradient(135deg, #8a2be2, #00e5ff); color: white;
            padding: 12px 25px; border: none; border-radius: 30px; cursor: pointer;
            font-weight: bold; }
        .cta-btn:hover { opacity: 0.9; }
        .error { color: red; text-align: center; }
        .empty-cart { text-align: center; color: #ccc; }
        .remove-btn { background: #ff4d4d; color: white; padding: 8px 15px; border: none;
            border-radius: 20px; cursor: pointer; }
        .remove-btn:hover { background: #cc0000; }
        .form-group { margin: 15px 0; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input, .form-group select { width: 100%; padding: 8px; border-radius: 5px; border: 1px solid #444; background: #1a1a1a; color: #fff; }
        .continue-shopping { color: #00e5ff; text-decoration: none; }
        .continue-shopping:hover { text-decoration: underline; }
    </style>
</head>
<body>
<h2>Your Cart Items</h2>

<%
    // Database connection parameters
    String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true;";
    String dbUser = "Hasiru";
    String dbPass = "hasiru2004";
    String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    double total = 0.0;
    boolean hasItems = false;
    boolean stockError = false;

    try {
        // Get customer ID from session
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Class.forName(driver);
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        // Query to fetch cart items with instrument details and stock check
        String sql = "SELECT c.CartID, c.Quantity, i.InstrumentID, i.Name, i.Price, i.Description, i.ImageURL, " +
                "i.Quantity AS StockQuantity, (i.Price * c.Quantity) AS SubTotal " +
                "FROM Cart c " +
                "JOIN Instrument i ON c.InstrumentID = i.InstrumentID " +
                "WHERE c.CustomerID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, customerId);
        rs = pstmt.executeQuery();
%>

<table>
    <tr>
        <th>Image</th>
        <th>Instrument</th>
        <th>Description</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Subtotal</th>
        <th>Action</th>
    </tr>
    <%
        while (rs.next()) {
            int cartQuantity = rs.getInt("Quantity");
            int stockQuantity = rs.getInt("StockQuantity");
            if (cartQuantity > stockQuantity) {
                stockError = true;
                continue; // Skip item if out of stock
            }
            hasItems = true;
            total += rs.getDouble("SubTotal");

            String imageUrl = rs.getString("ImageURL");
            if (imageUrl == null || imageUrl.isEmpty()) {
                imageUrl = "https://via.placeholder.com/80x60?text=No+Image";
            }
    %>
    <tr>
        <td><img src="<%= imageUrl %>" alt="<%= rs.getString("Name") %>"></td>
        <td><%= rs.getString("Name") %></td>
        <td><%= rs.getString("Description") != null ? rs.getString("Description") : "No description" %></td>
        <td>$<%= String.format("%.2f", rs.getDouble("Price")) %></td>
        <td><%= cartQuantity %></td>
        <td>$<%= String.format("%.2f", rs.getDouble("SubTotal")) %></td>
        <td>
            <form action="removeFromCart.jsp" method="post">
                <input type="hidden" name="cartId" value="<%= rs.getInt("CartID") %>">
                <button type="submit" class="remove-btn">Remove</button>
            </form>
        </td>
    </tr>
    <% } %>
</table>

<%
    if (stockError) {
%>
<p class="error">Some items are out of stock or unavailable. Please remove them or try again later.</p>
<%
} else if (hasItems) {
%>
<p class="total">Total: $<%= String.format("%.2f", total) %></p>

<div>
    <h3>Shipping and Payment Details</h3>
    <form action="checkout.jsp" method="post">
        <div class="form-group">
            <label for="street">Street:</label>
            <input type="text" id="street" name="street" required>
        </div>
        <div class="form-group">
            <label for="city">City:</label>
            <input type="text" id="city" name="city" required>
        </div>
        <div class="form-group">
            <label for="paymentMethod">Payment Method:</label>
            <select id="paymentMethod" name="paymentMethod" required>
                <option value="card">Card</option>
                <option value="bankTransferSLIP">Bank Transfer SLIP</option>
                <option value="cashOnDelivery">Cash on Delivery</option>
            </select>
        </div>
        <button type="submit" class="cta-btn">Place Order</button>
    </form>
    <a href="shop.jsp" class="continue-shopping">Continue Shopping</a>
</div>
<%
} else {
%>
<p class="empty-cart">Your cart is empty.</p>
<a href="shop.jsp" class="continue-shopping">Continue Shopping</a>
<%
    }
} catch (ClassNotFoundException e) {
%>
<p class="error">Error: Database driver not found. Please contact support.</p>
<%
} catch (SQLException e) {
%>
<p class="error">Error loading cart: <%= e.getMessage() %></p>
<%
} catch (Exception e) {
%>
<p class="error">Unexpected error: <%= e.getMessage() %></p>
<%
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

</body>
</html>