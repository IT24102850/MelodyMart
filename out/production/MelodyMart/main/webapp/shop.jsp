<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MelodyMart - Shop</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .search-form { margin-bottom: 20px; }
        .filter-form { margin-bottom: 20px; }
        .instrument-card { border: 1px solid #ccc; padding: 10px; margin: 10px; width: 300px; display: inline-block; }
        .instrument-card img { max-width: 100%; height: auto; }
        .instrument-card h3 { margin: 10px 0; }
        .instrument-card p { margin: 5px 0; }
    </style>
</head>
<body>
<h1>Welcome to MelodyMart Shop</h1>

<!-- Search Form -->
<div class="search-form">
    <form method="GET" action="shop.jsp">
        <label for="search">Search by Name or Description:</label>
        <input type="text" id="search" name="search" placeholder="Enter search term...">
        <button type="submit">Search</button>
    </form>
</div>

<!-- Filter Form -->
<div class="filter-form">
    <form method="GET" action="shop.jsp">
        <label for="category">Filter by Category:</label>
        <select id="category" name="category">
            <option value="">All Categories</option>
            <%
                // JDBC Connection details
                String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true;";
                String dbUser = "Hasiru";
                String dbPass = "hasiru2004";
                String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName(driver);
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

                    // Query for categories
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT CategoryID, Name FROM Category");

                    while (rs.next()) {
                        int catId = rs.getInt("CategoryID");
                        String catName = rs.getString("Name");
                        out.println("<option value=\"" + catId + "\">" + catName + "</option>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error loading categories: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </select>
        <button type="submit">Filter</button>
    </form>
</div>

<!-- Display Instruments -->
<div class="instruments">
    <%
        // Re-establish connection for instruments query
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            // Build query
            String sql = "SELECT i.InstrumentID, i.Name, i.Description, i.Model, i.Color, i.Price, i.Specifications, i.Warranty, i.ImageURL, i.Quantity, i.StockLevel, " +
                    "b.Name AS BrandName, m.Name AS ManufacturerName " +
                    "FROM Instrument i " +
                    "LEFT JOIN Brand b ON i.BrandID = b.BrandID " +
                    "LEFT JOIN Manufacturer m ON i.ManufacturerID = m.ManufacturerID";

            // Join with InstrumentCategory if filtering by category
            String category = request.getParameter("category");
            if (category != null && !category.isEmpty()) {
                sql += " INNER JOIN InstrumentCategory ic ON i.InstrumentID = ic.InstrumentID " +
                        "WHERE ic.CategoryID = ?";
            } else {
                sql += " WHERE 1=1"; // Placeholder for search
            }

            // Add search condition
            String search = request.getParameter("search");
            if (search != null && !search.isEmpty()) {
                sql += " AND (i.Name LIKE ? OR i.Description LIKE ?)";
            }

            // Prepare statement
            PreparedStatement pstmt = conn.prepareStatement(sql);
            int paramIndex = 1;

            if (category != null && !category.isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(category));
            }

            if (search != null && !search.isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("InstrumentID");
                String name = rs.getString("Name");
                String desc = rs.getString("Description");
                String model = rs.getString("Model");
                String color = rs.getString("Color");
                double price = rs.getDouble("Price");
                String specs = rs.getString("Specifications");
                String warranty = rs.getString("Warranty");
                String imageUrl = rs.getString("ImageURL");
                int quantity = rs.getInt("Quantity");
                String stockLevel = rs.getString("StockLevel");
                String brandName = rs.getString("BrandName");
                String manufacturerName = rs.getString("ManufacturerName");

                // Display as card
                out.println("<div class=\"instrument-card\">");
                if (imageUrl != null && !imageUrl.isEmpty()) {
                    out.println("<img src=\"" + imageUrl + "\" alt=\"" + name + "\">");
                }
                out.println("<h3>" + name + "</h3>");
                out.println("<p><strong>Brand:</strong> " + (brandName != null ? brandName : "N/A") + "</p>");
                out.println("<p><strong>Manufacturer:</strong> " + (manufacturerName != null ? manufacturerName : "N/A") + "</p>");
                out.println("<p><strong>Model:</strong> " + (model != null ? model : "N/A") + "</p>");
                out.println("<p><strong>Color:</strong> " + (color != null ? color : "N/A") + "</p>");
                out.println("<p><strong>Price:</strong> $" + price + "</p>");
                out.println("<p><strong>Description:</strong> " + (desc != null ? desc : "N/A") + "</p>");
                out.println("<p><strong>Specifications:</strong> " + (specs != null ? specs : "N/A") + "</p>");
                out.println("<p><strong>Warranty:</strong> " + (warranty != null ? warranty : "N/A") + "</p>");
                out.println("<p><strong>Quantity:</strong> " + quantity + "</p>");
                out.println("<p><strong>Stock Level:</strong> " + stockLevel + "</p>");
                out.println("</div>");
            }

            if (!rs.isBeforeFirst()) { // No results
                out.println("<p>No instruments found.</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error fetching instruments: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (conn != null) conn.close();
        }
    %>
</div>
</body>
</html>