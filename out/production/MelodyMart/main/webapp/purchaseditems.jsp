<%@ page import="java.sql.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>

<%
    String customerEmail = (String) session.getAttribute("email"); // from login session
    if (customerEmail != null) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT p.ProductName, p.Price, p.ImageURL, oi.Quantity, o.OrderDate " +
                "FROM Orders o " +
                "JOIN OrderItems oi ON o.OrderID = oi.OrderID " +
                "JOIN Product p ON oi.ProductID = p.ProductID " +
                "JOIN Customer c ON o.CustomerID = c.CustomerID " +
                "JOIN Person pe ON c.PersonID = pe.PersonID " +
                "WHERE pe.Email = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, customerEmail);
        ResultSet rs = ps.executeQuery();
%>

<div class="container">
    <h2 class="section-title">Your Purchased Instruments</h2>
    <div class="products">
        <%
            while (rs.next()) {
        %>
        <div class="product-card visible">
            <div class="product-img">
                <img src="<%= rs.getString("ImageURL") %>" alt="<%= rs.getString("ProductName") %>" style="width:100%; height:220px; object-fit:cover;">
            </div>
            <div class="product-info">
                <h3 class="product-title"><%= rs.getString("ProductName") %></h3>
                <div class="product-price">$<%= rs.getDouble("Price") %></div>
                <p class="product-desc">Quantity: <%= rs.getInt("Quantity") %></p>
                <p class="product-desc">Purchased on: <%= rs.getDate("OrderDate") %></p>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

<%
} else {
%>
<p style="text-align:center;">Please <a href="sign-in.jsp">sign in</a> to view your purchases.</p>
<%
    }
%>
