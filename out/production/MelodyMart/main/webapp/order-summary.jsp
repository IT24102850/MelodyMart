
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
<%
    // ✅ Ensure customer is logged in
    String customerId = (String) session.getAttribute("customerId");
    String customerName = (String) session.getAttribute("userName");
    if (customerId == null) {
        response.sendRedirect("sign-in.jsp");
        return;
    }

    // ✅ Retrieve Customer Details
    String fullName = "", email = "", phone = "", street = "", city = "", state = "", country = "";
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT FirstName, LastName, Email, Phone, Street, City, State, Country FROM Person WHERE PersonID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, customerId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            fullName = (rs.getString("FirstName") != null ? rs.getString("FirstName") : "") + " " + (rs.getString("LastName") != null ? rs.getString("LastName") : "");
            email = rs.getString("Email");
            phone = rs.getString("Phone");
            street = rs.getString("Street");
            city = rs.getString("City");
            state = rs.getString("State");
            country = rs.getString("Country");
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        out.println("<pre style='color:red;'>Customer lookup error: " + e.getMessage() + "</pre>");
        e.printStackTrace();
        return;
    }

    // ✅ Calculate totals
    double subtotal = 0.0;
    double shipping = 300.00;
    double total = 0.0;

    try {
        String subStr = request.getParameter("subtotal");
        String totalStr = request.getParameter("total");
        if (subStr != null && !subStr.isEmpty()) {
            subtotal = Double.parseDouble(subStr);
        } else if (totalStr != null && !totalStr.isEmpty()) {
            subtotal = Double.parseDouble(totalStr) - shipping;
        }
    } catch (Exception e) {
        subtotal = 0.0;
        out.println("<pre style='color:red;'>Error calculating totals: " + e.getMessage() + "</pre>");
        e.printStackTrace();
    }

    total = subtotal + shipping;

    // ✅ Save order to ordernow table on form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (fullName.isEmpty() || phone.isEmpty() || state.isEmpty() || city.isEmpty() || street.isEmpty() || total <= 0) {
            response.sendRedirect("orderSummary.jsp?status=fail&error=invalidData");
        } else {
            try (Connection conn = DBConnection.getConnection()) {
                String orderId = "ORD" + System.currentTimeMillis(); // Generate a unique OrderID
                String sql = "INSERT INTO ordernow (OrderID, CustomerName, PhoneNumber, Province, District, City, Address, DeliveryLabel, TotalAmount, Status, CreatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, orderId);
                ps.setString(2, fullName.trim());
                ps.setString(3, phone.trim());
                ps.setString(4, state.trim());
                ps.setString(5, "NULL");
                ps.setString(6, city.trim());
                ps.setString(7, street.trim());
                ps.setString(8, "HOME");
                ps.setDouble(9, total);
                ps.setString(10, "Pending");
                ps.setTimestamp(11, new java.sql.Timestamp(System.currentTimeMillis()));
                int rowsAffected = ps.executeUpdate();
                ps.close();

                if (rowsAffected > 0) {
                    response.sendRedirect("PlaceOrderServlet?status=success&orderId=" + orderId + "&amount=" + total);
                } else {
                    response.sendRedirect("orderSummary.jsp?status=fail&error=insertFailed");
                }
            } catch (SQLException e) {
                out.println("<pre style='color:red;'>Order save error: " + e.getMessage() + "</pre>");
                e.printStackTrace();
                response.sendRedirect("orderSummary.jsp?status=fail&error=sqlError");
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary | MelodyMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8fafc;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 700px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #3a56d4;
            margin-bottom: 30px;
        }
        .section {
            margin-bottom: 30px;
        }
        .section h2 {
            color: #3a56d4;
            border-bottom: 2px solid #e5e7eb;
            padding-bottom: 6px;
            margin-bottom: 10px;
        }
        .info p {
            margin: 5px 0;
            font-size: 15px;
        }
        .total-box {
            background: #f3f4f6;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            font-size: 1.1rem;
            color: #333;
        }
        .total-box p {
            margin: 8px 0;
        }
        .total-box strong {
            color: #3a56d4;
            font-size: 1.2rem;
        }
        .confirm-btn {
            display: block;
            width: 100%;
            background: #3a56d4;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 25px;
        }
        .confirm-btn:hover {
            background: #2e46b9;
        }
        .success-msg {
            background: #e0f7ec;
            color: #0d6832;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
        }
        .error-msg {
            background: #fee2e2;
            color: #dc2626;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Order Summary</h1>

    <%-- ✅ Optional success or error message from servlet --%>
    <%
        String status = request.getParameter("status");
        if ("success".equals(status)) {
    %>
    <div class="success-msg">
        <i class="fas fa-check-circle"></i> Your order was placed successfully!
    </div>
    <% } else if ("fail".equals(status)) {
        String error = request.getParameter("error");
        String errorMsg = "Order placement failed. Please try again.";
        if ("sqlError".equals(error)) errorMsg = "Database error occurred. Please try again later.";
        else if ("insertFailed".equals(error)) errorMsg = "Failed to save order. Please try again.";
        else if ("invalidData".equals(error)) errorMsg = "Invalid data provided. Please check your details.";
    %>
    <div class="error-msg">
        <i class="fas fa-exclamation-triangle"></i> <%= errorMsg %>
    </div>
    <% } %>

    <!-- ✅ Customer Info -->
    <div class="section">
        <h2>Customer Details</h2>
        <div class="info">
            <p><strong>Name:</strong> <%= fullName %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Phone:</strong> <%= phone %></p>
            <p><strong>Address:</strong> <%= street %>, <%= city %>, <%= state %>, <%= country %></p>
        </div>
    </div>

    <!-- ✅ Total Summary -->
    <div class="section">
        <h2>Order Total</h2>
        <div class="total-box">
            <p>Subtotal: $<%= String.format("%.2f", subtotal) %></p>
            <p>Shipping: $<%= String.format("%.2f", shipping) %></p>
            <p><strong>Total: $<%= String.format("%.2f", total) %></strong></p>
        </div>
    </div>

    <!-- ✅ Confirm Order Button -->
    <form action="PlaceOrderServlet" method="post">
        <input type="hidden" name="total" value="<%= total %>">
        <button type="submit" class="confirm-btn">
            <i class="fas fa-check-circle"></i> Confirm and Place Order
        </button>
    </form>
</div>
</body>
</html>
```