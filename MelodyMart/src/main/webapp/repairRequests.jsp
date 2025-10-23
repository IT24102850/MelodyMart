<%@ page import="java.sql.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Repair Requests | MelodyMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f9fafb; margin: 0; padding: 0; }
        .container { max-width: 1100px; margin: 40px auto; background: white; border-radius: 12px; padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        h1 { text-align: center; color: #1e3a8a; }
        table { width: 100%; border-collapse: collapse; margin-top: 25px; }
        th, td { border: 1px solid #e2e8f0; padding: 10px; text-align: left; }
        th { background-color: #2563eb; color: white; }
        tr:nth-child(even) { background-color: #f9fafb; }
        tr:hover { background-color: #e0f2fe; }
        input, textarea { width: 100%; padding: 6px; border: 1px solid #cbd5e1; border-radius: 5px; }
        button { border: none; border-radius: 6px; padding: 8px 12px; cursor: pointer; font-weight: 600; color: white; }
        .approve-btn { background-color: #16a34a; }
        .reject-btn { background-color: #dc2626; }
        .approve-btn:hover { background-color: #15803d; }
        .reject-btn:hover { background-color: #b91c1c; }
        .back-btn { background-color: #6b7280; margin-bottom: 20px; display: block; margin-left: auto; margin-right: auto; width: 150px; }
        .back-btn:hover { background-color: #4b5563; }
        img { width: 70px; height: 70px; object-fit: cover; border-radius: 8px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Manage Repair Requests</h1>
    <button onclick="window.location.href='sellerdashboard.jsp'" class="back-btn">← Back to Dashboard</button>
    <table>
        <tr>
            <th>Request ID</th>
            <th>Order ID</th>
            <th>Issue Description</th>
            <th>Photo</th>
            <th>Current Status</th>
            <th>Comment</th>
            <th>Estimated Cost (₹)</th>
            <th>Repair Date</th>
            <th>Actions</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT * FROM RepairRequest WHERE Status = 'Submitted' ORDER BY RepairRequestID DESC";
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
        %>
        <form action="UpdateRepairStatusServlet" method="post">
            <tr>
                <td><input type="hidden" name="repairRequestID" value="<%= rs.getString("RepairRequestID") %>"><%= rs.getString("RepairRequestID") %></td>
                <td><%= rs.getString("OrderID") %></td>
                <td><%= rs.getString("IssueDescription") %></td>
                <td>
                    <% if (rs.getString("Photos") != null && !rs.getString("Photos").isEmpty()) { %>
                    <a href="<%= rs.getString("Photos") %>" target="_blank">
                        <img src="<%= rs.getString("Photos") %>" alt="Repair Photo">
                    </a>
                    <% } else { %>
                    <span style="color:gray;">No Photo</span>
                    <% } %>
                </td>
                <td><%= rs.getString("Status") %></td>
                <td><textarea name="comment" rows="2"><%= rs.getString("Comment") == null ? "" : rs.getString("Comment") %></textarea></td>
                <td><input type="number" name="estimatedCost" step="0.01" value="<%= rs.getString("EstimatedCost") == null ? "0.00" : rs.getString("EstimatedCost") %>"></td>
                <td><input type="date" name="repairDate" value="<%= rs.getDate("RepairDate") != null ? rs.getDate("RepairDate") : "" %>"></td>
                <td>
                    <button type="submit" name="action" value="Approve" class="approve-btn">Approve</button>
                    <button type="submit" name="action" value="Reject" class="reject-btn">Reject</button>
                </td>
            </tr>
        </form>
        <%
            }
            if (!hasData) {
        %>
        <tr><td colspan="9" style="text-align:center; color:gray;">No submitted repair requests found.</td></tr>
        <% }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        %>
    </table>
</div>
</body>
</html>