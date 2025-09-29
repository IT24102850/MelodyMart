<%@ page import="java.sql.*, com.melodymart.util.DatabaseUtil" %>
<%@ page session="true" %>

<%
    // Assume logged-in customer (set in session)
    Integer customerId = (Integer) session.getAttribute("customerId");
    if (customerId == null) {
        response.sendRedirect("sign-in.jsp");
        return;
    }
%>

<section id="cart" class="dashboard-section container mt-4">
    <div class="content-card shadow p-4 rounded">
        <div class="card-header d-flex justify-content-between align-items-center mb-3">
            <h2 class="card-title mb-0"><i class="fas fa-shopping-cart"></i> My Cart</h2>
            <a href="shop.jsp" class="btn btn-outline-secondary btn-sm">
                <i class="fas fa-store"></i> Continue Shopping
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-dark">
                <tr>
                    <th>Instrument</th>
                    <th style="width:120px;">Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                    <th style="width:150px;">Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    double grandTotal = 0.0;

                    try {
                        conn = DatabaseUtil.getConnection();
                        String sql = "SELECT c.CartID, c.Quantity, i.Name, i.Price, i.InstrumentID, i.ImageURL " +
                                "FROM Cart c JOIN Instrument i ON c.InstrumentID = i.InstrumentID " +
                                "WHERE c.CustomerID = ?";
                        ps = conn.prepareStatement(sql);
                        ps.setInt(1, customerId);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int cartId = rs.getInt("CartID");
                            int instrumentId = rs.getInt("InstrumentID");
                            int qty = rs.getInt("Quantity");
                            double price = rs.getDouble("Price");
                            double total = qty * price;
                            grandTotal += total;
                %>
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="<%= rs.getString("ImageURL") != null ? rs.getString("ImageURL") : "https://via.placeholder.com/60" %>"
                                 alt="<%= rs.getString("Name") %>"
                                 class="img-thumbnail me-2" style="width:60px; height:60px; object-fit:cover;">
                            <span><%= rs.getString("Name") %></span>
                        </div>
                    </td>
                    <td>
                        <form action="UpdateCartServlet" method="post" class="d-flex align-items-center">
                            <input type="hidden" name="cartId" value="<%= cartId %>">
                            <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                            <input type="number" name="quantity" value="<%= qty %>" min="1" class="form-control form-control-sm me-2" style="width:70px;">
                            <button type="submit" class="btn btn-sm btn-success">
                                <i class="fas fa-sync-alt"></i>
                            </button>
                        </form>
                    </td>
                    <td>$<%= String.format("%.2f", price) %></td>
                    <td class="fw-bold">$<%= String.format("%.2f", total) %></td>
                    <td>
                        <form action="RemoveFromCartServlet" method="post" style="display:inline;">
                            <input type="hidden" name="cartId" value="<%= cartId %>">
                            <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                            <input type="hidden" name="quantity" value="<%= qty %>">
                            <button type="submit" class="btn btn-sm btn-danger">
                                <i class="fas fa-trash-alt"></i> Remove
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5' class='text-danger text-center'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                        if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Cart Summary -->
        <div class="cart-summary mt-4 text-end">
            <h4 class="fw-bold">Grand Total: <span class="text-success">$<%= String.format("%.2f", grandTotal) %></span></h4>
            <div class="actions mt-3">
                <a href="checkout.jsp" class="btn btn-lg btn-primary">
                    <i class="fas fa-credit-card"></i> Proceed to Checkout
                </a>
            </div>
        </div>
    </div>
</section>
