<%@ page import="java.io.*, java.sql.*, java.util.*, javax.servlet.http.*, javax.servlet.*, javax.servlet.annotation.*, javax.servlet.http.Part" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Instrument | MelodyMart</title>
    <style>
        body {
            background: #0a0a0a; color: white; font-family: Arial, sans-serif;
            padding: 20px;
        }
        h1 {
            text-align: center;
            background: linear-gradient(135deg,#8a2be2,#00e5ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        form {
            width: 70%; margin: 0 auto; background: rgba(255,255,255,0.05);
            padding: 20px; border-radius: 10px;
        }
        input, textarea {
            width: 100%; padding: 10px; margin: 5px 0;
            border-radius: 5px; border: none; background: #1a1a1a; color: white;
        }
        button {
            background: linear-gradient(135deg,#8a2be2,#00e5ff);
            border: none; padding: 10px 25px; border-radius: 20px;
            color: white; cursor: pointer; font-weight: bold;
        }
        table { width: 100%; border-collapse: collapse; margin-top: 30px; }
        th, td { padding: 10px; border-bottom: 1px solid #333; }
        tr:hover { background: rgba(255,255,255,0.05); }
        img { border-radius: 5px; margin: 3px; }
    </style>
</head>
<body>

<h1>🎵 Add New Instrument</h1>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Directory to save uploaded images
        String uploadPath = application.getRealPath("") + File.separator + "images" + File.separator + "instruments";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Collect form parameters safely
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String brandId = request.getParameter("brandId");
        String model = request.getParameter("model");
        String color = request.getParameter("color");
        String price = request.getParameter("price");
        String specifications = request.getParameter("specifications");
        String warranty = request.getParameter("warranty");
        String manufacturerId = request.getParameter("manufacturerId");

        // Prevent nulls
        if (name == null) name = "";
        if (description == null) description = "";
        if (brandId == null) brandId = "";
        if (model == null) model = "";
        if (color == null) color = "";
        if (specifications == null) specifications = "";
        if (warranty == null) warranty = "";
        if (manufacturerId == null) manufacturerId = "";

        // Handle price safely
        java.math.BigDecimal priceValue = java.math.BigDecimal.ZERO;
        try {
            if (price != null && !price.trim().isEmpty()) {
                priceValue = new java.math.BigDecimal(price);
            }
        } catch (Exception ex) {
            priceValue = java.math.BigDecimal.ZERO;
        }

        // Upload multiple images
        Collection<Part> parts = request.getParts();
        List<String> imagePaths = new ArrayList<>();

        for (Part part : parts) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String fileName = "instrument_" + System.currentTimeMillis() + "_" + part.getSubmittedFileName();
                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath);

                // Save relative path for DB
                String dbPath = "images/instruments/" + fileName;
                imagePaths.add(dbPath);
            }
        }

        String imageURLs = String.join(",", imagePaths);

        // Save to database
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();

            String sql = "INSERT INTO Instrument (Name, Description, BrandID, Model, Color, Price, " +
                    "Specifications, Warranty, ImageURLs, Quantity, StockLevel, ManufacturerID, IsActive) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 'In Stock', ?, 1)";

            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, brandId);
            ps.setString(4, model);
            ps.setString(5, color);
            ps.setBigDecimal(6, priceValue);
            ps.setString(7, specifications);
            ps.setString(8, warranty);
            ps.setString(9, imageURLs);
            ps.setString(10, manufacturerId);

            ps.executeUpdate();

            out.println("<p style='color:lightgreen;text-align:center;'>✅ Instrument added successfully!</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }
%>

<!-- 🧾 Form to add new instrument -->
<form method="post" enctype="multipart/form-data">
    <label>Instrument Name:</label>
    <input type="text" name="name" required>

    <label>Description:</label>
    <textarea name="description" required></textarea>

    <label>Brand ID:</label>
    <input type="text" name="brandId">

    <label>Model:</label>
    <input type="text" name="model">

    <label>Color:</label>
    <input type="text" name="color">

    <label>Price:</label>
    <input type="number" name="price" step="0.01">

    <label>Specifications:</label>
    <textarea name="specifications"></textarea>

    <label>Warranty:</label>
    <input type="text" name="warranty">

    <label>Manufacturer ID:</label>
    <input type="text" name="manufacturerId">

    <label>Upload Images (multiple):</label>
    <input type="file" name="images" accept="image/*" multiple>

    <br><br>
    <button type="submit">Add Instrument</button>
</form>

<hr>

<!-- 🎸 Display all instruments -->
<h2>🎸 Current Instruments</h2>
<table>
    <thead>
    <tr>
        <th>ID</th><th>Name</th><th>Brand</th><th>Price</th><th>Images</th><th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement("SELECT * FROM Instrument ORDER BY InstrumentID DESC");
            rs = ps.executeQuery();

            while (rs.next()) {
                String[] imgs = rs.getString("ImageURLs") != null ? rs.getString("ImageURLs").split(",") : new String[0];
    %>
    <tr>
        <td><%= rs.getString("InstrumentID") %></td>
        <td><%= rs.getString("Name") %></td>
        <td><%= rs.getString("BrandID") %></td>
        <td>$<%= rs.getBigDecimal("Price") %></td>
        <td>
            <% for (String img : imgs) { %>
            <img src="<%= img %>" style="width:50px;height:50px;">
            <% } %>
        </td>
        <td>
            <form method="post">
                <input type="hidden" name="deleteId" value="<%= rs.getString("InstrumentID") %>">
                <button type="submit" name="action" value="delete" style="background:#ff4444;color:white;border:none;padding:5px 10px;border-radius:5px;">Delete</button>
            </form>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='6' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    %>
    </tbody>
</table>

</body>
</html>
