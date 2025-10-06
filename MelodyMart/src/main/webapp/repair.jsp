<%@ page import="java.sql.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // ✅ Get logged-in user ID from session (set in login servlet)
    String userID = (String) session.getAttribute("userID");

    // If session expired accidentally, redirect once to login

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Repair Requests | MelodyMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6fb;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 85%;
            margin: 40px auto;
            background: #fff;
            padding: 25px 35px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        h2 { color: #1e40af; text-align: center; }
        form {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f8fafc;
        }
        label { font-weight: 600; display: block; margin-top: 10px; }
        input[type="text"], input[type="date"], textarea {
            width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 6px; margin-top: 5px;
        }
        input[type="file"] { margin-top: 6px; }
        button {
            margin-top: 15px; padding: 10px 20px;
            background-color: #1e40af; border: none;
            color: #fff; border-radius: 6px; cursor: pointer; font-weight: 600;
        }
        button:hover { background-color: #2563eb; }
        table { width: 100%; border-collapse: collapse; margin-top: 35px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background: #1e40af; color: #fff; }
        .status { font-weight: bold; }
        .status.Submitted { color: #f59e0b; }
        .status.Approved { color: #3b82f6; }
        .status.Completed { color: #10b981; }
        .status.Rejected { color: #ef4444; }
    </style>
</head>
<body>
<div class="container">
    <h2>🛠 Submit a New Repair Request</h2>

    <!-- Repair Request Form -->
    <form action="SubmitRepairRequestServlet" method="post" enctype="multipart/form-data">
        <!-- No need to send userID — servlet reads from session -->
        <label for="orderId">Order ID (optional)</label>
        <input type="text" name="orderId" id="orderId" placeholder="Enter related order ID">

        <label for="issueDescription">Issue Description</label>
        <textarea name="issueDescription" id="issueDescription" rows="4" placeholder="Describe the issue" required></textarea>

        <label for="repairDate">Preferred Repair Date</label>
        <input type="date" name="repairDate" id="repairDate" required>

        <label for="photos">Upload Photo (optional)</label>
        <input type="file" name="photos" accept="image/*">

        <button type="submit"><i class="fas fa-paper-plane"></i> Submit Request</button>
    </form>

    <hr>
    <h2>📋 Your Repair Requests</h2>

    <%
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT RepairRequestID, IssueDescription, Status, RequestDate, RepairDate, Photos, EstimatedCost, Comment " +
                    "FROM RepairRequest WHERE UserID = ? ORDER BY RequestDate DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
    %>
    <p>No repair requests found yet.</p>
    <%
    } else {
    %>
    <table>
        <tr>
            <th>ID</th>
            <th>Description</th>
            <th>Status</th>
            <th>Request Date</th>
            <th>Repair Date</th>
            <th>Photo</th>
            <th>Cost</th>
            <th>Comment</th>
        </tr>
        <%
            while (rs.next()) {
                String status = rs.getString("Status");
                String photo = rs.getString("Photos");
        %>
        <tr>
            <td><%= rs.getString("RepairRequestID") %></td>
            <td><%= rs.getString("IssueDescription") %></td>
            <td class="status <%= status.replace(" ", "") %>"><%= status %></td>
            <td><%= rs.getTimestamp("RequestDate") %></td>
            <td><%= rs.getString("RepairDate") != null ? rs.getString("RepairDate") : "-" %></td>
            <td>
                <% if (photo != null && !photo.isEmpty()) { %>
                <img src="<%= photo %>" style="width:80px;height:60px;border-radius:6px;">
                <% } else { %>
                No Photo
                <% } %>
            </td>
            <td><%= rs.getBigDecimal("EstimatedCost") != null ? "₹" + rs.getBigDecimal("EstimatedCost") : "-" %></td>
            <td><%= rs.getString("Comment") != null ? rs.getString("Comment") : "-" %></td>
        </tr>
        <%
            }
            rs.close(); ps.close();
        %>
    </table>
    <%
            }
        } catch (SQLException e) {
            out.println("<p style='color:red;'>Database error: " + e.getMessage() + "</p>");
        }
    %>
</div>
</body>
</html>
