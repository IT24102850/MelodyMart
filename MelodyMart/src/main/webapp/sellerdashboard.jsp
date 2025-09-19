<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Only process form if POST
    String message = null;
    String messageType = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String model = request.getParameter("model");
        String color = request.getParameter("color");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String specifications = request.getParameter("specifications");
        String warranty = request.getParameter("warranty");
        String imageURL = request.getParameter("imageURL");
        String brandIDStr = request.getParameter("brandID");

        try {
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);
            Integer brandID = (brandIDStr == null || brandIDStr.isEmpty()) ? null : Integer.parseInt(brandIDStr);

            String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true";
            String dbUser = "Hasiru";
            String dbPassword = "hasiru2004";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Optional: Validate BrandID exists
            if (brandID != null) {
                PreparedStatement checkBrand = con.prepareStatement("SELECT COUNT(*) FROM Brand WHERE BrandID = ?");
                checkBrand.setInt(1, brandID);
                ResultSet rs = checkBrand.executeQuery();
                if (rs.next() && rs.getInt(1) == 0) {
                    message = "Invalid BrandID selected.";
                    messageType = "error";
                    rs.close();
                    checkBrand.close();
                    con.close();
                } else {
                    rs.close();
                    checkBrand.close();
                }
            }

            if (message == null) { // No BrandID error
                String sql = "INSERT INTO Instrument " +
                        "(Name, Description, Model, Color, Price, Quantity, Specifications, Warranty, ImageURL, BrandID) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, description);
                ps.setString(3, model);
                ps.setString(4, color);
                ps.setDouble(5, price);
                ps.setInt(6, quantity);
                ps.setString(7, specifications);
                ps.setString(8, warranty);
                ps.setString(9, imageURL);

                if (brandID != null) {
                    ps.setInt(10, brandID);
                } else {
                    ps.setNull(10, java.sql.Types.INTEGER);
                }

                int rows = ps.executeUpdate();
                ps.close();
                con.close();

                if (rows > 0) {
                    // Redirect to avoid duplicate form submission
                    response.sendRedirect("sellerDashboard.jsp?success=1");
                    return;
                } else {
                    message = "Failed to add instrument.";
                    messageType = "error";
                }
            }

        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            messageType = "error";
            e.printStackTrace();
        }
    }

    // Display messages from redirect
    String successParam = request.getParameter("success");
    if ("1".equals(successParam)) {
        message = "Instrument added successfully!";
        messageType = "success";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard - MelodyMart</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f9; margin: 0; padding: 0; }
        header { background: #343a40; color: #fff; padding: 15px; text-align: center; }
        .dashboard { width: 80%; margin: 20px auto; }
        .form-container { background: #fff; padding: 20px; margin-top: 20px; border-radius: 8px;
            box-shadow: 0px 2px 8px rgba(0,0,0,0.2); }
        .form-container input, .form-container textarea, .form-container select {
            width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ccc; border-radius: 6px;
        }
        .form-container button {
            background: #28a745; color: #fff; padding: 10px 15px; border: none; border-radius: 6px; cursor: pointer;
        }
        .form-container button:hover { background: #218838; }
        .message { margin: 15px 0; padding: 10px; border-radius: 6px; }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>

<header>
    <h1>MelodyMart Seller Dashboard</h1>
</header>

<div class="dashboard">
    <% if (message != null) { %>
    <div class="message <%= messageType %>">
        <%= message %>
    </div>
    <% } %>

    <div class="form-container">
        <h2>Add New Instrument</h2>
        <form action="sellerDashboard.jsp" method="post">
            <input type="text" name="name" placeholder="Instrument Name" required>
            <textarea name="description" placeholder="Description" required></textarea>
            <input type="text" name="model" placeholder="Model">
            <input type="text" name="color" placeholder="Color">
            <input type="number" name="price" step="0.01" placeholder="Price" required>
            <input type="number" name="quantity" placeholder="Quantity" required>
            <input type="text" name="specifications" placeholder="Specifications">
            <input type="text" name="warranty" placeholder="Warranty">
            <input type="text" name="imageURL" placeholder="Image URL">
            <input type="number" name="brandID" placeholder="Brand ID (optional)">
            <button type="submit">Add Instrument</button>
        </form>
    </div>
</div>

</body>
</html>
