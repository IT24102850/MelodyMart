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
    <title>My Orders | MelodyMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f1f5f9; margin: 0; color: #1e293b; }
        .container { max-width: 1100px; margin: 40px auto; background: #fff; border-radius: 12px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; margin-bottom: 20px; padding-bottom: 10px; }
        .header h1 { color: #2563eb; }
        .back-btn { background: #64748b; color: white; border: none; border-radius: 8px; padding: 10px 20px; font-weight: 600; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; }
        .back-btn:hover { background: #475569; transform: translateY(-2px); }

        .alert { padding: 12px; border-radius: 6px; margin-bottom: 20px; color: white; font-weight: 500; }
        .alert-success { background: #10b981; } .alert-error { background: #ef4444; }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #e2e8f0; text-align: left; font-size: 15px; vertical-align: middle; }
        th { background: #2563eb; color: white; }
        tr:nth-child(even) { background: #f9fafb; }
        tr:hover { background: #e0f2fe; }

        .status { padding: 6px 10px; border-radius: 6px; font-weight: 600; font-size: 13px; text-transform: uppercase; }
        .status-Pending { background: #fef3c7; color: #b45309; }
        .status-Confirmed { background: #dcfce7; color: #166534; }
        .status-Shipped { background: #dbeafe; color: #1e40af; }
        .status-Cancelled { background: #fee2e2; color: #dc2626; }

        .action-btn { border: none; border-radius: 6px; padding: 6px 12px; font-size: 14px; cursor: pointer; color: white; }
        .edit-btn { background: #f59e0b; } .cancel-btn { background: #dc2626; }
        .edit-btn:hover { background: #d97706; } .cancel-btn:hover { background: #b91c1c; }

        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5); justify-content: center; align-items: center; z-index: 1000; }
        .modal-content { background: #fff; padding: 25px; border-radius: 10px; max-width: 500px; width: 90%; }
        label { font-weight: 600; }
        input[type="text"], textarea { width: 100%; padding: 8px; border: 1px solid #cbd5e1; border-radius: 6px; margin-bottom: 12px; font-size: 14px; }
        button.save-btn { background: #2563eb; color: white; border: none; border-radius: 8px; padding: 10px 20px; cursor: pointer; font-weight: 600; }
        button.save-btn:hover { background: #1d4ed8; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>My Orders</h1>
        <a href="customerlanding.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <% if (successMessage != null) { %>
    <div class="alert alert-success"><%= successMessage %></div>
    <% } else if (errorMessage != null) { %>
    <div class="alert alert-error"><%= errorMessage %></div>
    <% } %>

    <table>
        <tr>
            <th>Order ID</th>
            <th>Date</th>
            <th>Total (LKR)</th>
            <th>Status</th>
            <th>Address</th>
            <th>Actions</th>
        </tr>

        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT * FROM OrderNow WHERE CustomerName IN " +
                        "(SELECT CONCAT(FirstName, ' ', LastName) FROM Person WHERE PersonID = ?) " +
                        "ORDER BY CreatedAt DESC";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, userID);
                ResultSet rs = ps.executeQuery();
                boolean hasOrders = false;

                while (rs.next()) {
                    hasOrders = true;
                    String orderId = rs.getString("OrderID");
                    String date = rs.getString("CreatedAt");
                    double total = rs.getDouble("TotalAmount");
                    String status = rs.getString("Status");
                    String address = rs.getString("Address") + ", " + rs.getString("City");
                    String phone = rs.getString("PhoneNumber");
                    String statusClass = "status-" + status.replace(" ", "");
        %>
        <tr>
            <td><%= orderId %></td>
            <td><%= date %></td>
            <td>LKR <%= String.format("%.2f", total) %></td>
            <td><span class="status <%= statusClass %>"><%= status %></span></td>
            <td><%= address %></td>
            <td>
                <% if (!"Cancelled".equalsIgnoreCase(status)) { %>
                <% if ("Pending".equalsIgnoreCase(status)) { %>
                <button class="action-btn edit-btn" onclick="openEditModal('<%= orderId %>', '<%= address %>', '<%= phone %>')">
                    <i class="fas fa-edit"></i> Update
                </button>
                <form action="CancelOrderServlet" method="post" style="display:inline;"
                      onsubmit="return confirm('Are you sure you want to cancel this order?');">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <button type="submit" class="action-btn cancel-btn">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </form>
                <% } else { %>
                <em>No actions</em>
                <% } %>
                <% } else { %>
                <em>Cancelled</em>
                <% } %>
            </td>
        </tr>
        <%
            }
            if (!hasOrders) {
        %>
        <tr>
            <td colspan="6" style="text-align:center; color:#64748b; padding:30px;">
                <i class="fas fa-box-open" style="font-size:48px; color:#cbd5e1; display:block; margin-bottom:10px;"></i>
                You haven’t placed any orders yet.
            </td>
        </tr>
        <%
                }
                rs.close(); ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </table>
</div>

<!-- === Edit Modal (Update Address & Phone) === -->
<div class="modal" id="editModal">
    <div class="modal-content">
        <h3>Update Order Details</h3>
        <form id="editForm" action="UpdateOrderServlet" method="post">
            <input type="hidden" name="orderId" id="editOrderId">
            <label>Delivery Address:</label>
            <textarea name="address" id="editAddress" rows="3" required></textarea>

            <label>Contact Number:</label>
            <input type="text" name="phone" id="editPhone" maxlength="15" required>

            <div style="display: flex; gap: 10px; margin-top: 10px;">
                <button type="submit" class="save-btn" style="flex:1;"><i class="fas fa-save"></i> Save Changes</button>
                <button type="button" onclick="closeModal()" style="background:#64748b; color:white; flex:1; border:none; border-radius:8px; padding:10px; font-weight:600;">
                    <i class="fas fa-times"></i> Cancel
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function openEditModal(orderId, address, phone) {
        document.getElementById("editOrderId").value = orderId;
        document.getElementById("editAddress").value = address;
        document.getElementById("editPhone").value = phone;
        document.getElementById("editModal").style.display = "flex";
    }
    function closeModal() {
        document.getElementById("editModal").style.display = "none";
    }
    window.onclick = function(e) {
        const modal = document.getElementById("editModal");
        if (e.target === modal) closeModal();
    }
</script>
</body>
</html>
