<%@ page import="java.sql.*" %>
<%@ page import="com.melodymart.util.DatabaseUtil" %>

<!-- Manufacturer Dashboard: Stock Availability Coordination -->
<section id="manufacturer-stock" class="dashboard-section">
    <div class="content-card">
        <div class="card-header">
            <h2 class="card-title">Manufacturer Stock Management</h2>
            <div class="card-actions">
                <!-- Add New Stock Button -->
                <button class="btn btn-primary" onclick="openModal('addStockModal')">
                    <i class="fas fa-plus"></i> Add New Stock Entry
                </button>
            </div>
        </div>

        <!-- Stock Table -->
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Stock ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Status</th>
                    <th>Last Updated</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        conn = DatabaseUtil.getConnection();
                        String sql = "SELECT InstrumentID, Name, Quantity, StockLevel FROM Instrument";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            String stockLevel = rs.getString("StockLevel");
                %>
                <tr>
                    <td><%= rs.getInt("InstrumentID") %></td>
                    <td><%= rs.getString("Name") %></td>
                    <td><%= rs.getInt("Quantity") %></td>
                    <td><%= stockLevel %></td>
                    <td><%= new java.util.Date() %></td>
                    <td>
                        <!-- Update button -->
                        <button class="btn btn-sm btn-primary"
                                onclick="openEditModal(<%= rs.getInt("InstrumentID") %>,
                                        '<%= rs.getString("Name") %>',
                                    <%= rs.getInt("Quantity") %>,
                                        '<%= stockLevel %>')">Update</button>

                        <!-- Delete form -->
                        <form action="${pageContext.request.contextPath}/DeleteInstrumentServlet"
                              method="post" style="display:inline;"
                              onsubmit="return confirm('Mark this stock as unavailable?');">
                            <input type="hidden" name="instrumentId" value="<%= rs.getInt("InstrumentID") %>">
                            <button type="submit" class="btn btn-sm btn-secondary">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</section>

<!-- Add Stock Modal -->
<div class="modal" id="addStockModal" style="display:none;">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('addStockModal')">&times;</button>
        <h2>Add New Stock Entry</h2>
        <form action="${pageContext.request.contextPath}/AddStockServlet" method="post">
            <label>Product Name:</label>
            <input type="text" name="name" required><br>

            <label>Quantity:</label>
            <input type="number" name="quantity" required><br>

            <label>Stock Level:</label>
            <select name="stockLevel">
                <option value="In Stock">In Stock</option>
                <option value="Low Stock">Low Stock</option>
                <option value="Out of Stock">Out of Stock</option>
            </select><br>

            <button type="submit" class="btn btn-primary">Save</button>
        </form>
    </div>
</div>

<!-- Edit Stock Modal -->
<div class="modal" id="editStockModal" style="display:none;">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('editStockModal')">&times;</button>
        <h2>Edit Stock</h2>
        <form action="${pageContext.request.contextPath}/UpdateStockServlet" method="post">
            <input type="hidden" id="editInstrumentId" name="instrumentId">

            <label>Product Name:</label>
            <input type="text" id="editName" name="name" required><br>

            <label>Quantity:</label>
            <input type="number" id="editQuantity" name="quantity" required><br>

            <label>Stock Level:</label>
            <select id="editStockLevel" name="stockLevel">
                <option value="In Stock">In Stock</option>
                <option value="Low Stock">Low Stock</option>
                <option value="Out of Stock">Out of Stock</option>
            </select><br>

            <button type="submit" class="btn btn-primary">Update</button>
        </form>
    </div>
</div>

<script>
    function openEditModal(id, name, quantity, stockLevel) {
        document.getElementById("editInstrumentId").value = id;
        document.getElementById("editName").value = name;
        document.getElementById("editQuantity").value = quantity;
        document.getElementById("editStockLevel").value = stockLevel;
        document.getElementById("editStockModal").style.display = "flex";
    }

    function closeModal(id) {
        document.getElementById(id).style.display = "none";
    }
</script>
