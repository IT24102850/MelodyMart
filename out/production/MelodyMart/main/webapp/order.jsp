<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Order Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --glass-bg: rgba(30, 30, 30, 0.7);
            --glass-border: rgba(255, 255, 255, 0.1);
        }
        body { font-family: 'Montserrat', sans-serif; background: var(--secondary); color: var(--text); padding: 100px 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .glass-card { background: var(--glass-bg); backdrop-filter: blur(10px); border: 1px solid var(--glass-border); border-radius: 15px; padding: 30px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2); }
        h2 { font-family: 'Playfair Display', serif; font-size: 32px; color: var(--primary-light); margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid var(--glass-border); }
        th { background: var(--card-bg); }
        .cta-btn { background: var(--primary); color: var(--text); border: none; padding: 10px 20px; border-radius: 30px; cursor: pointer; transition: background 0.3s ease; }
        .cta-btn:hover { background: var(--accent); }
    </style>
</head>
<body>
<div class="container">
    <div class="glass-card">
        <h2>Order Details</h2>
        <table>
            <tr>
                <th>Instrument</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
            <%
                int instrumentId = Integer.parseInt(request.getParameter("instrumentId"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = 1; // Default quantity, can be modified later
                double total = price * quantity;

                // Insert into OrderItem (assuming OrderID is managed by a servlet or session)
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true;";
                    String dbUser = "Hasiru";
                    String dbPass = "hasiru2004";
                    String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
                    Class.forName(driver);
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

                    String insertSql = "INSERT INTO OrderItem (OrderID, InstrumentID, Quantity, Price) VALUES (?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(insertSql);
                    // Assume OrderID is from session or a new order
                    int orderId = (int) (Math.random() * 1000); // Temporary, replace with actual OrderID logic
                    pstmt.setInt(1, orderId);
                    pstmt.setInt(2, instrumentId);
                    pstmt.setInt(3, quantity);
                    pstmt.setDouble(4, price);
                    pstmt.executeUpdate();
            %>
            <tr>
                <td><%= name %></td>
                <td>$<%= String.format("%.2f", price) %></td>
                <td><%= quantity %></td>
                <td>$<%= String.format("%.2f", total) %></td>
                <td><form action="CheckoutServlet" method="post"><input type="hidden" name="orderId" value="<%= orderId %>"><button type="submit" class="cta-btn">Checkout</button></form></td>
            </tr>
            <%
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>Error processing order: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
        <a href="shop.jsp" class="cta-btn">Continue Shopping</a>
    </div>
</div>
</body>
</html>