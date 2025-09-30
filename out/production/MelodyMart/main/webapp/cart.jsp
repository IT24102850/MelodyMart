<%@ page import="java.sql.*, com.melodymart.util.DatabaseUtil" %>
<%@ page session="true" %>

<%
    // Ensure user is logged in
    Integer customerId = (Integer) session.getAttribute("customerId");
    if (customerId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<section id="cart" class="dashboard-section">
    <div class="content-card">
        <div class="card-header">
            <h2 class="card-title">🛒 My Cart</h2>
        </div>

        <div class="table-responsive">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Image</th>
                    <th>Instrument</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                    <th>Actions</th>
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

                        boolean hasItems = false;

                        while (rs.next()) {
                            hasItems = true;
                            int cartId = rs.getInt("CartID");
                            int instrumentId = rs.getInt("InstrumentID");
                            int qty = rs.getInt("Quantity");
                            double price = rs.getDouble("Price");
                            double total = qty * price;
                            grandTotal += total;
                %>
                <tr>
                    <td>
                        <img src="<%= (rs.getString("ImageURL") != null && !rs.getString("ImageURL").isEmpty())
                                     ? rs.getString("ImageURL")
                                     : "https://via.placeholder.com/60" %>"
                             alt="<%= rs.getString("Name") %>"
                             style="width:60px; height:60px; border-radius:5px; object-fit:cover;">
                    </td>
                    <td><%= rs.getString("Name") %></td>
                    <td>
                        <form action="UpdateCartServlet" method="post" style="display:inline-flex; align-items:center;">
                            <input type="hidden" name="cartId" value="<%= cartId %>">
                            <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                            <input type="number" name="quantity" value="<%= qty %>" min="1" style="width:70px; text-align:center;">
                            <button type="submit" class="btn btn-sm btn-primary" style="margin-left:5px;">Update</button>
                        </form>
                    </td>
                    <td>$<%= price %></td>
                    <td>$<%= total %></td>
                    <td>
                        <form action="RemoveFromCartServlet" method="post" style="display:inline;">
                            <input type="hidden" name="cartId" value="<%= cartId %>">
                            <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                            <input type="hidden" name="quantity" value="<%= qty %>">
                            <button type="submit" class="btn btn-sm btn-danger">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                    }

                    if (!hasItems) {
                %>
                <tr>
                    <td colspan="6" style="text-align:center; color:gray;">Your cart is empty. <a href="shop.jsp">Go Shopping</a></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                        if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                    }
                %>
                </tbody>
            </table>
        </div>

        <div class="cart-summary" style="margin-top:20px; text-align:right;">
            <h3>Grand Total: $<%= grandTotal %></h3>
            <div class="actions" style="margin-top:15px;">
                <a href="shop.jsp" class="btn btn-secondary">Continue Shopping</a>
                <% if (grandTotal > 0) { %>
                <a href="checkout.jsp" class="btn btn-primary">Proceed to Checkout</a>
                <% } %>
            </div>
        </div>
    </div>
</section>
