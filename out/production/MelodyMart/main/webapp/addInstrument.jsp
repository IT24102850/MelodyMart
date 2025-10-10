<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Auto-generate next Instrument ID (I001, I002, ...)
    String nextInstrumentId = "I001";
    try (Connection conn = DBConnection.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery("SELECT MAX(InstrumentID) FROM Instrument")) {
        if (rs.next() && rs.getString(1) != null) {
            String lastId = rs.getString(1);
            int num = Integer.parseInt(lastId.substring(1)); // remove 'I'
            nextInstrumentId = String.format("I%03d", num + 1);
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error generating Instrument ID: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Instrument | MelodyMart</title>
</head>
<body>
<h2>Add a New Instrument</h2>

<form action="SaveInstrument" method="post" enctype="multipart/form-data">

    <!-- Hidden, system-generated Instrument ID -->
    <input type="hidden" name="instrumentId" value="<%= nextInstrumentId %>">

    <p><strong>Instrument ID:</strong> <%= nextInstrumentId %></p>

    <input type="text" name="name" placeholder="Instrument Name" required><br>
    <textarea name="description" placeholder="Description"></textarea><br>
    <input type="text" name="brandId" placeholder="Brand ID (e.g. B001)" required><br>
    <input type="text" name="manufacturerId" placeholder="Manufacturer ID (e.g. M001)" required><br>
    <input type="text" name="model" placeholder="Model"><br>
    <input type="text" name="color" placeholder="Color"><br>
    <input type="number" step="0.01" name="price" placeholder="Price" required><br>
    <input type="number" name="quantity" placeholder="Quantity" required><br>
    <input type="text" name="warranty" placeholder="Warranty"><br>
    <textarea name="specifications" placeholder="Specifications"></textarea><br>

    <!-- Multiple image uploads -->
    <input type="file" name="images" accept="image/*" multiple required><br>

    <button type="submit">Add Instrument</button>
</form>
</body>
</html>
