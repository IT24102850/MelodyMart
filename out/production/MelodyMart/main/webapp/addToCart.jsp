<%@ page import="java.sql.*" %>
<%
    String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true;";
    String dbUser = "Hasiru";
    String dbPass = "hasiru2004";
    String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    String instrumentId = request.getParameter("instrumentId");
    Integer customerId = (Integer) session.getAttribute("customerId");

    String message = "";

    out.println("DEBUG → CustomerID: " + customerId + ", InstrumentID: " + instrumentId + "<br>");

    if (customerId == null) {
        message = "Please log in first to add items to your cart.";
    } else if (instrumentId == null || instrumentId.isEmpty()) {
        message = "Invalid instrument selected.";
    } else {
        Connection conn = null;
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            // check if already in cart
            String checkSql = "SELECT Quantity FROM Cart WHERE CustomerID=? AND InstrumentID=?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, customerId);
            checkPs.setInt(2, Integer.parseInt(instrumentId));
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                String updateSql = "UPDATE Cart SET Quantity = Quantity + 1, AddedDate = CURRENT_TIMESTAMP WHERE CustomerID=? AND InstrumentID=?";
                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setInt(1, customerId);
                updatePs.setInt(2, Integer.parseInt(instrumentId));
                int rows = updatePs.executeUpdate();
                message = "Updated rows: " + rows;
                updatePs.close();
            } else {
                String insertSql = "INSERT INTO Cart (InstrumentID, CustomerID, Quantity, AddedDate) VALUES (?, ?, 1, CURRENT_TIMESTAMP)";
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setInt(1, Integer.parseInt(instrumentId));
                insertPs.setInt(2, customerId);
                int rows = insertPs.executeUpdate();
                message = "Inserted rows: " + rows;
                insertPs.close();
            }

            rs.close();
            checkPs.close();

        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            if (conn != null) conn.close();
        }
    }
%>
<script>
    alert("<%= message %>");
    window.location.href = "shop.jsp";
</script>
