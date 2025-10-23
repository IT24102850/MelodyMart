<%@ page import="java.sql.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");
    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Repair Requests | MelodyMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f1f5f9; margin: 0; padding: 0; color: #1e293b; }
        .container { max-width: 1100px; margin: 40px auto; background: #fff; border-radius: 12px; padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1); }

        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 2px solid #e2e8f0; }
        .header h1 { color: #2563eb; margin: 0; }
        .back-btn { background: #64748b; color: white; border: none; border-radius: 8px; padding: 10px 20px;
            font-weight: 600; cursor: pointer; transition: 0.3s; text-decoration: none; display: inline-flex;
            align-items: center; gap: 8px; }
        .back-btn:hover { background: #475569; transform: translateY(-2px); }

        h2 { color: #2563eb; text-align: center; margin-top: 30px; }
        .alert { padding: 12px; border-radius: 6px; margin-bottom: 20px; color: white; font-weight: 500; }
        .alert-success { background: #10b981; } .alert-error { background: #ef4444; }

        select, input[type="file"], input[type="date"], textarea {
            width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 8px; background: #f9fafb;
            font-size: 15px; margin-bottom: 15px;
        }

        button { background: #2563eb; color: white; border: none; border-radius: 8px;
            padding: 10px 18px; font-weight: 600; cursor: pointer; transition: 0.3s; }
        button:hover { background: #1d4ed8; }

        table { width: 100%; border-collapse: collapse; margin-top: 25px; }
        th, td { border: 1px solid #e2e8f0; padding: 12px 10px; text-align: left; font-size: 15px; vertical-align: middle; }
        th { background-color: #2563eb; color: white; }
        tr:nth-child(even) { background-color: #f9fafb; }
        tr:hover { background-color: #e0f2fe; }

        .status { font-weight: 700; text-transform: uppercase; padding: 4px 8px; border-radius: 8px; font-size: 12px; }
        .status-Submitted { background: #dbeafe; color: #1d4ed8; }
        .status-Approved { background: #dcfce7; color: #16a34a; }
        .status-Completed { background: #d1fae5; color: #047857; }
        .status-InProgress { background: #fef3c7; color: #b45309; }
        .status-Cancelled { background: #fee2e2; color: #dc2626; }

        .action-btn { margin-right: 5px; border-radius: 6px; padding: 6px 12px; font-size: 14px; }
        .edit-btn { background: #f59e0b; } .cancel-btn { background: #dc2626; }
        .edit-btn:hover { background: #d97706; } .cancel-btn:hover { background: #b91c1c; }

        td img {
            width: 80px; height: 80px; object-fit: cover; border-radius: 8px;
            border: 1px solid #ccc; transition: transform 0.2s ease;
        }
        td img:hover { transform: scale(2.5); position: relative; z-index: 10; }

        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5); justify-content: center; align-items: center; z-index: 1000; }
        .modal-content { background: #fff; padding: 25px; border-radius: 10px; max-width: 500px; width: 90%; }

        .form-section { background: #f8fafc; padding: 20px; border-radius: 8px; margin-bottom: 25px; border: 1px solid #e2e8f0; }
        .form-section h3 { color: #2563eb; margin-top: 0; margin-bottom: 15px; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Repair Requests</h1>
        <a href="customerlanding.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            Back to Dashboard
        </a>
    </div>

    <% if (successMessage != null) { %>
    <div class="alert alert-success"><%= successMessage %></div>
    <% } else if (errorMessage != null) { %>
    <div class="alert alert-error"><%= errorMessage %></div>
    <% } %>

    <!-- === Submit New Repair Request === -->
    <div class="form-section">
        <h3>Submit New Repair Request</h3>
        <form action="SubmitRepairRequestServlet" method="post" enctype="multipart/form-data">
            <label>Select Order *</label>
            <select name="orderId" required>
                <option value="">-- Select your order --</option>
                <%
                    try (Connection conn = DBConnection.getConnection()) {
                        String sql = "SELECT o.OrderID, o.CreatedAt, o.TotalAmount " +
                                "FROM OrderNow o " +
                                "WHERE o.CustomerName IN ( " +
                                "  SELECT CONCAT(p.FirstName, ' ', p.LastName) FROM Person p WHERE p.PersonID = ? ) " +
                                "ORDER BY o.CreatedAt DESC";

                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, userID);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                            String orderId = rs.getString("OrderID");
                            String createdAt = rs.getString("CreatedAt");
                            double total = rs.getDouble("TotalAmount");
                %>
                <option value="<%= orderId %>">
                    <%= orderId %> – <%= createdAt %> (LKR <%= String.format("%.2f", total) %>)
                </option>
                <% } rs.close(); ps.close(); } catch (SQLException e) { e.printStackTrace(); } %>
            </select>

            <label>Issue Description *</label>
            <textarea name="issueDescription" rows="3" required placeholder="Describe the issue with your instrument..."></textarea>

            <label>Preferred Repair Date *</label>
            <input type="date" name="repairDate" required>

            <label>Upload Photo (optional)</label>
            <input type="file" name="photos" accept="image/*">

            <button type="submit"><i class="fas fa-paper-plane"></i> Submit Repair Request</button>
        </form>
    </div>

    <!-- === Repair Requests Table === -->
    <h2>Your Repair Requests</h2>

    <table>
        <tr>
            <th>Request ID</th>
            <th>Order ID</th>
            <th>Issue</th>
            <th>Photo</th>
            <th>Status</th>
            <th>Comment</th>
            <th>Estimated Cost (LKR)</th>
            <th>Repair Date</th>
            <th>Actions</th>
        </tr>

        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT * FROM RepairRequest WHERE OrderID IN (" +
                        "SELECT o.OrderID FROM OrderNow o " +
                        "WHERE o.CustomerName IN (SELECT CONCAT(p.FirstName, ' ', p.LastName) FROM Person p WHERE p.PersonID = ?)) " +
                        "ORDER BY RepairRequestID DESC";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, userID);
                ResultSet rs = ps.executeQuery();
                boolean hasData = false;

                while (rs.next()) {
                    hasData = true;
                    String reqId = rs.getString("RepairRequestID");
                    String orderId = rs.getString("OrderID");
                    String issue = rs.getString("IssueDescription");
                    String photo = rs.getString("Photos");
                    String status = rs.getString("Status");
                    String comment = rs.getString("Comment");
                    String estCost = rs.getString("EstimatedCost");
                    String repairDate = rs.getString("RepairDate");

                    if (comment == null || comment.trim().isEmpty()) comment = "No comments yet";
                    if (estCost == null) estCost = "Pending service estimate";
                    if (repairDate == null) repairDate = "Not scheduled yet";

                    String statusClass = "status-" + status.replace(" ", "");
                    String safeIssue = issue == null ? "" : issue.replace("'", "\\'");
        %>
        <tr>
            <td><%= reqId %></td>
            <td><%= orderId %></td>
            <td><%= issue %></td>
            <td>
                <% if (photo != null && !photo.isEmpty()) { %>
                <a href="<%= photo %>" target="_blank">
                    <img src="<%= photo %>" alt="Repair Photo">
                </a>
                <% } else { %>
                <span style="color:#9ca3af;">No photo</span>
                <% } %>
            </td>
            <td><span class="status <%= statusClass %>"><%= status %></span></td>
            <td><%= comment %></td>
            <td><%= estCost.equals("Pending service estimate") ? estCost : "LKR " + estCost %></td>
            <td><%= repairDate %></td>
            <td>
                <% if ("Submitted".equalsIgnoreCase(status)) { %>
                <button class="action-btn edit-btn"
                        onclick="openEditModal('<%= reqId %>', '<%= safeIssue %>')">
                    <i class="fas fa-edit"></i> Edit
                </button>
                <form action="CancelRepairRequestServlet" method="post" style="display:inline;"
                      onsubmit="return confirm('Are you sure you want to delete this repair request?');">
                    <input type="hidden" name="repairRequestID" value="<%= reqId %>">
                    <button type="submit" class="action-btn cancel-btn">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </form>
                <% } else { %>
                <em>Locked</em>
                <% } %>
            </td>
        </tr>
        <% } if (!hasData) { %>
        <tr>
            <td colspan="9" style="text-align:center;color:#64748b; padding: 30px;">
                <i class="fas fa-tools" style="font-size: 48px; margin-bottom: 10px; display: block; color: #cbd5e1;"></i>
                No repair requests yet. Submit your first request above.
            </td>
        </tr>
        <% } rs.close(); ps.close(); } catch (SQLException e) { e.printStackTrace(); } %>
    </table>
</div>

<!-- === Edit Modal === -->
<div class="modal" id="editModal">
    <div class="modal-content">
        <h3>Edit Repair Request</h3>
        <form id="editForm" action="UpdateRepairRequestServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="repairRequestID" id="editRequestID">
            <label>Issue Description</label>
            <textarea name="issueDescription" id="editIssueDescription" rows="3" required></textarea><br>
            <label>Upload New Photo (optional)</label>
            <input type="file" name="photo" accept="image/*"><br><br>
            <div style="display: flex; gap: 10px;">
                <button type="submit" style="flex: 1;">
                    <i class="fas fa-save"></i> Save Changes
                </button>
                <button type="button" onclick="closeModal()" style="background: #64748b; flex: 1;">
                    <i class="fas fa-times"></i> Cancel
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function openEditModal(reqId, issue) {
        document.getElementById("editRequestID").value = reqId;
        document.getElementById("editIssueDescription").value = issue;
        document.getElementById("editModal").style.display = "flex";
    }
    function closeModal() {
        document.getElementById("editModal").style.display = "none";
    }
    window.onclick = function(e) {
        const modal = document.getElementById("editModal");
        if (e.target === modal) closeModal();
    }
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        const repairDateInput = document.querySelector('input[name="repairDate"]');
        if (repairDateInput) repairDateInput.min = today;
    });
</script>
</body>
</html>
