<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Management - MelodyMart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Payment Management</h2>

    <%
        Connection con = null;
        PreparedStatement ps = null;
        Statement st = null;
        ResultSet rs = null;

        String action = request.getParameter("action");
        String paymentId = request.getParameter("paymentId");

        try {
            con = DBConnection.getConnection();

            // --- Update or Return Payment ---
            if (action != null && paymentId != null) {
                String sql = "";
                if ("update".equals(action)) {
                    sql = "UPDATE Payment SET TransactionStatus='Completed' WHERE PaymentID=?";
                } else if ("return".equals(action)) {
                    sql = "UPDATE Payment SET TransactionStatus='Returned' WHERE PaymentID=?";
                }

                if (!sql.isEmpty()) {
                    ps = con.prepareStatement(sql);
                    ps.setString(1, paymentId);
                    ps.executeUpdate();
                    out.println("<div class='alert alert-success text-center'>Payment " + paymentId +
                            ("update".equals(action) ? " marked as Completed." : " marked as Returned.") + "</div>");
                }
            }

            // --- Fetch all payment records with method & customer details ---
            String query = "SELECT p.PaymentID, p.OrderID, p.PaymentDate, m.MethodName, p.TransactionStatus, " +
                    "c.CustomerName, c.Email, c.Phone " +
                    "FROM Payment p " +
                    "JOIN PaymentMethod m ON p.MethodID = m.MethodID " +
                    "JOIN [Order] o ON p.OrderID = o.OrderID " +
                    "JOIN Customer c ON o.CustomerID = c.CustomerID " +
                    "ORDER BY p.PaymentDate DESC";

            st = con.createStatement();
            rs = st.executeQuery(query);
    %>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>Payment ID</th>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Payment Date</th>
            <th>Method</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("PaymentID") %></td>
            <td><%= rs.getString("OrderID") %></td>
            <td><%= rs.getString("CustomerName") %></td>
            <td><%= rs.getString("Email") %></td>
            <td><%= rs.getString("Phone") %></td>
            <td><%= rs.getDate("PaymentDate") %></td>
            <td><%= rs.getString("MethodName") %></td>
            <td><%= rs.getString("TransactionStatus") %></td>
            <td>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="paymentId" value="<%= rs.getString("PaymentID") %>">
                    <input type="hidden" name="action" value="update">
                    <button type="submit" class="btn btn-warning btn-sm">Mark Completed</button>
                </form>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="paymentId" value="<%= rs.getString("PaymentID") %>">
                    <input type="hidden" name="action" value="return">
                    <button type="submit" class="btn btn-danger btn-sm">Return</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <%
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
        } finally {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    %>
</div>

</body>
</html>
