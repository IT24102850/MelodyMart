<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Repair Requests | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <style>
        body { font-family: Arial, sans-serif; background: #121212; color: #fff; margin: 20px; }
        .form-label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-control, .form-control-file {
            width: 100%; padding: 8px; border-radius: 5px; border: 1px solid #555; background: #1e1e1e; color: #fff;
        }
        .btn { padding: 8px 15px; border-radius: 5px; cursor: pointer; font-weight: bold; border: none; }
        .btn-primary { background: #8a2be2; color: #fff; }
        .btn-primary:hover { background: #9b45f0; }
        .btn-secondary { background: #444; color: #fff; }
        .data-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .data-table th, .data-table td { border: 1px solid #444; padding: 10px; text-align: left; }
        .data-table th { background: #222; }
        .img-thumbnail { border: 1px solid #444; border-radius: 5px; }
        .status-badge { padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        .status-new { background: #007bff; }
        .status-in-progress { background: #ffc107; color: #000; }
        .status-completed { background: #28a745; }
        .action-btn { background: none; border: none; color: #8a2be2; cursor: pointer; font-size: 16px; margin-right: 8px; }
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); align-items: center; justify-content: center; }
        .modal-content { background: #1e1e1e; padding: 20px; border-radius: 10px; width: 500px; position: relative; }
        .modal-close { position: absolute; top: 10px; right: 10px; background: none; border: none; font-size: 20px; color: #fff; cursor: pointer; }
    </style>
</head>
<body>

<h2>Submit New Repair Request</h2>
<form id="repairRequestForm" method="post" action="${pageContext.request.contextPath}/SubmitRepairRequestServlet" enctype="multipart/form-data">
    <div class="form-group">
        <label class="form-label">Order ID</label>
        <input type="text" class="form-control" name="orderId" placeholder="e.g., MM-7892" required>
    </div>
    <div class="form-group">
        <label class="form-label">Issue Description</label>
        <input type="text" class="form-control" name="issueDescription" placeholder="e.g., Fret buzz on high E string" required>
    </div>
    <div class="form-group">
        <label class="form-label">Upload Photos</label>
        <input type="file" class="form-control-file" name="photos" multiple accept="image/*" id="photoUpload">
        <div id="previewContainer" class="mt-2 d-flex flex-wrap"></div>
    </div>
    <div class="form-group">
        <label class="form-label">Select Repair Date</label>
        <input type="text" class="form-control" id="repairDatePicker" name="repairDate" required>
    </div>
    <button type="submit" class="btn btn-primary">Submit Request</button>
</form>

<h2 style="margin-top:40px;">Repair Requests</h2>
<table class="data-table">
    <thead>
    <tr>
        <th>Request ID</th>
        <th>Order ID</th>
        <th>Description</th>
        <th>Photos</th>
        <th>Status</th>
        <th>Approved</th>
        <th>Comment</th>
        <th>Estimated Cost</th>
        <th>Repair Date</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT RepairRequestID, OrderID, IssueDescription, Photos, Status, Approved, Comment, EstimatedCost, RepairDate FROM RepairRequest";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                String status = rs.getString("Status");
                boolean canDelete = !status.equalsIgnoreCase("In Progress") && !status.equalsIgnoreCase("Completed");
    %>
    <tr>
        <td>#RR-<%= rs.getInt("RepairRequestID") %></td>
        <td>#MM-<%= rs.getInt("OrderID") %></td>
        <td><%= rs.getString("IssueDescription") %></td>
        <td>
            <%
                String photo = rs.getString("Photos");
                if (photo != null && !photo.isEmpty()) {
                    String[] photos = photo.split(";");
                    for (String photoPath : photos) {
            %>
            <img src="<%= photoPath.replace("\\", "/") %>" class="img-thumbnail m-1"
                 style="width:80px; height:80px; object-fit:cover;" alt="Repair Photo">
            <%
                }
            } else {
            %>
            <span class="text-muted">No Photo</span>
            <%
                }
            %>
        </td>
        <td><span class="status-badge status-<%= status.toLowerCase().replace(" ", "-") %>"><%= status %></span></td>
        <td><%= rs.getBoolean("Approved") ? "Yes" : "No" %></td>
        <td><%= rs.getString("Comment") != null ? rs.getString("Comment") : "-" %></td>
        <td>$<%= rs.getBigDecimal("EstimatedCost") != null ? rs.getBigDecimal("EstimatedCost") : "0.00" %></td>
        <td><%= rs.getDate("RepairDate") %></td>
        <td>
            <button class="action-btn" title="Update Request"
                    onclick="openUpdateModal(<%= rs.getInt("RepairRequestID") %>, '<%= rs.getString("IssueDescription").replace("'", "\\'") %>', '<%= rs.getString("Comment") != null ? rs.getString("Comment").replace("'", "\\'") : "" %>', '<%= rs.getDate("RepairDate") %>')">
                <i class="fas fa-edit"></i>
            </button>
            <% if (canDelete) { %>
            <button class="action-btn" title="Delete Request" onclick="deleteRepairRequest(<%= rs.getInt("RepairRequestID") %>)">
                <i class="fas fa-trash"></i>
            </button>
            <% } %>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='10' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    %>
    </tbody>
</table>

<!-- Update Repair Request Modal -->
<div class="modal" id="updateRepairModal">
    <div class="modal-content">
        <button class="modal-close" onclick="document.getElementById('updateRepairModal').style.display='none'">&times;</button>
        <h2 class="modal-title">Update Repair Request</h2>
        <form id="updateRepairForm" method="post" action="${pageContext.request.contextPath}/UpdateRepairRequestServlet" enctype="multipart/form-data">
            <input type="hidden" name="repairRequestId" id="updateRepairRequestId">
            <div class="form-group">
                <label class="form-label">Issue Description</label>
                <input type="text" class="form-control" name="issueDescription" id="updateIssueDescription" required>
            </div>
            <div class="form-group">
                <label class="form-label">Additional Comments</label>
                <textarea class="form-control" name="additionalComment" id="updateComment" rows="4"></textarea>
            </div>
            <div class="form-group">
                <label class="form-label">Upload Additional Photos</label>
                <input type="file" class="form-control-file" name="additionalPhotos" multiple accept="image/*" id="updatePhotoUpload">
                <div id="updatePreviewContainer" class="mt-2 d-flex flex-wrap"></div>
            </div>
            <div class="form-group">
                <label class="form-label">Select Repair Date</label>
                <input type="text" class="form-control" id="updateRepairDatePicker" name="repairDate" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%;">Update Request</button>
        </form>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
    $(function() {
        $("#repairDatePicker, #updateRepairDatePicker").datepicker({
            dateFormat: "yy-mm-dd",
            minDate: 0,
            showAnim: "fadeIn"
        });
    });

    function setupPreview(inputId, previewId) {
        document.getElementById(inputId).addEventListener("change", function(event) {
            const previewContainer = document.getElementById(previewId);
            previewContainer.innerHTML = "";
            Array.from(event.target.files).forEach(file => {
                if (file.type.startsWith("image/")) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const img = document.createElement("img");
                        img.src = e.target.result;
                        img.className = "m-1 border rounded";
                        img.style.width = "100px";
                        img.style.height = "100px";
                        img.style.objectFit = "cover";
                        previewContainer.appendChild(img);
                    };
                    reader.readAsDataURL(file);
                }
            });
        });
    }
    setupPreview("photoUpload", "previewContainer");
    setupPreview("updatePhotoUpload", "updatePreviewContainer");

    function openUpdateModal(id, issue, comment, date) {
        document.getElementById("updateRepairRequestId").value = id;
        document.getElementById("updateIssueDescription").value = issue;
        document.getElementById("updateComment").value = comment;
        document.getElementById("updateRepairDatePicker").value = date;
        document.getElementById("updatePreviewContainer").innerHTML = "";
        document.getElementById("updateRepairModal").style.display = "flex";
    }

    function deleteRepairRequest(id) {
        if (confirm("Are you sure you want to delete this request?")) {
            const form = document.createElement("form");
            form.method = "POST";
            form.action = "${pageContext.request.contextPath}/DeleteRepairRequestServlet";
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = "repairRequestId";
            input.value = id;
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>

</body>
</html>
