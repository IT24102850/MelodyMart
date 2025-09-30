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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart | Melody Mart</title>
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #6c757d;
            --success: #4cc9f0;
            --danger: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
            --border: #e9ecef;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --radius: 10px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fb;
            color: var(--dark);
            line-height: 1.6;
        }

        .dashboard-section {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .content-card {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 20px;
        }

        .card-header {
            padding: 20px 25px;
            border-bottom: 1px solid var(--border);
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
        }

        .card-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .cart-container {
            display: flex;
            flex-direction: column;
            padding: 0;
        }

        .cart-items {
            padding: 20px;
        }

        .cart-item {
            display: grid;
            grid-template-columns: 100px 1fr auto auto auto;
            gap: 15px;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid var(--border);
            transition: all 0.3s ease;
        }

        .cart-item:hover {
            background-color: rgba(67, 97, 238, 0.03);
        }

        .item-image {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .item-details {
            display: flex;
            flex-direction: column;
        }

        .item-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .item-price {
            color: var(--secondary);
            font-size: 0.9rem;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .quantity-input {
            width: 60px;
            padding: 8px;
            text-align: center;
            border: 1px solid var(--border);
            border-radius: 5px;
            font-weight: 500;
        }

        .update-btn {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 12px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: background 0.2s;
        }

        .update-btn:hover {
            background: var(--primary-dark);
        }

        .item-total {
            font-weight: 600;
            font-size: 1.1rem;
            color: var(--primary);
        }

        .remove-btn {
            background: var(--danger);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 12px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: background 0.2s;
        }

        .remove-btn:hover {
            background: #e01e69;
        }

        .empty-cart {
            text-align: center;
            padding: 40px 20px;
            color: var(--secondary);
        }

        .empty-cart-icon {
            font-size: 3rem;
            margin-bottom: 15px;
            opacity: 0.5;
        }

        .empty-cart a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .empty-cart a:hover {
            text-decoration: underline;
        }

        .cart-summary {
            background: var(--light);
            padding: 25px;
            border-top: 1px solid var(--border);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 1.1rem;
        }

        .grand-total {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--primary);
            border-top: 1px dashed var(--border);
            padding-top: 15px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            display: inline-block;
        }

        .btn-secondary {
            background: white;
            color: var(--secondary);
            border: 1px solid var(--secondary);
        }

        .btn-secondary:hover {
            background: var(--secondary);
            color: white;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            border: 1px solid var(--primary);
        }

        .btn-primary:hover {
            background: var(--primary-dark);
        }

        .error-message {
            background: #ffe6e6;
            color: #d32f2f;
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #d32f2f;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .cart-item {
                grid-template-columns: 80px 1fr;
                grid-template-areas:
                    "image details"
                    "quantity actions"
                    "total total";
                gap: 10px;
                padding: 15px 10px;
            }

            .item-image {
                grid-area: image;
            }

            .item-details {
                grid-area: details;
            }

            .quantity-controls {
                grid-area: quantity;
                justify-content: flex-start;
            }

            .item-actions {
                grid-area: actions;
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }

            .item-total {
                grid-area: total;
                text-align: right;
                padding-top: 10px;
                border-top: 1px dashed var(--border);
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .dashboard-section {
                padding: 10px;
            }

            .card-header {
                padding: 15px 20px;
            }

            .cart-items {
                padding: 10px;
            }

            .cart-summary {
                padding: 15px;
            }
        }

        /* Animation for cart updates */
        @keyframes highlight {
            0% { background-color: rgba(67, 97, 238, 0.1); }
            100% { background-color: transparent; }
        }

        .updated-item {
            animation: highlight 1.5s ease;
        }
    </style>
</head>
<body>
    <section id="cart" class="dashboard-section">
        <div class="content-card">
            <div class="card-header">
                <h2 class="card-title">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.4 5.2 16.4H17M17 13V16.4M9 19C9 19.6 8.6 20 8 20C7.4 20 7 19.6 7 19C7 18.4 7.4 18 8 18C8.6 18 9 18.4 9 19ZM17 19C17 19.6 16.6 20 16 20C15.4 20 15 19.6 15 19C15 18.4 15.4 18 16 18C16.6 18 17 18.4 17 19Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    My Shopping Cart
                </h2>
            </div>

            <div class="cart-container">
                <div class="cart-items">
                    <%
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        double grandTotal = 0.0;
                        boolean hasItems = false;

                        try {
                            conn = DatabaseUtil.getConnection();
                            String sql = "SELECT c.CartID, c.Quantity, i.Name, i.Price, i.InstrumentID, i.ImageURL " +
                                    "FROM Cart c JOIN Instrument i ON c.InstrumentID = i.InstrumentID " +
                                    "WHERE c.CustomerID = ?";
                            ps = conn.prepareStatement(sql);
                            ps.setInt(1, customerId);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                                hasItems = true;
                                int cartId = rs.getInt("CartID");
                                int instrumentId = rs.getInt("InstrumentID");
                                int qty = rs.getInt("Quantity");
                                double price = rs.getDouble("Price");
                                double total = qty * price;
                                grandTotal += total;
                    %>
                    <div class="cart-item" id="cart-item-<%= cartId %>">
                        <img src="<%= (rs.getString("ImageURL") != null && !rs.getString("ImageURL").isEmpty())
                                     ? rs.getString("ImageURL")
                                     : "https://via.placeholder.com/80?text=No+Image" %>"
                             alt="<%= rs.getString("Name") %>" class="item-image">
                        <div class="item-details">
                            <div class="item-name"><%= rs.getString("Name") %></div>
                            <div class="item-price">$<%= String.format("%.2f", price) %></div>
                        </div>
                        <div class="quantity-controls">
                            <form action="UpdateCartServlet" method="post" class="quantity-form">
                                <input type="hidden" name="cartId" value="<%= cartId %>">
                                <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                                <input type="number" name="quantity" value="<%= qty %>" min="1" class="quantity-input">
                                <button type="submit" class="update-btn">Update</button>
                            </form>
                        </div>
                        <div class="item-total">$<%= String.format("%.2f", total) %></div>
                        <div class="item-actions">
                            <form action="RemoveFromCartServlet" method="post" class="remove-form">
                                <input type="hidden" name="cartId" value="<%= cartId %>">
                                <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                                <input type="hidden" name="quantity" value="<%= qty %>">
                                <button type="submit" class="remove-btn">Remove</button>
                            </form>
                        </div>
                    </div>
                    <%
                            }
                        } catch (Exception e) {
                    %>
                    <div class="error-message">
                        Error loading cart items: <%= e.getMessage() %>
                    </div>
                    <%
                        } finally {
                            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                        }

                        if (!hasItems) {
                    %>
                    <div class="empty-cart">
                        <div class="empty-cart-icon">🛒</div>
                        <h3>Your cart is empty</h3>
                        <p>Browse our collection and add some instruments to your cart!</p>
                        <p><a href="shop.jsp">Start Shopping</a></p>
                    </div>
                    <%
                        }
                    %>
                </div>

                <% if (hasItems) { %>
                <div class="cart-summary">
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span>$<%= String.format("%.2f", grandTotal) %></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping:</span>
                        <span>Calculated at checkout</span>
                    </div>
                    <div class="summary-row grand-total">
                        <span>Total:</span>
                        <span>$<%= String.format("%.2f", grandTotal) %></span>
                    </div>
                    <div class="action-buttons">
                        <a href="shop.jsp" class="btn btn-secondary">Continue Shopping</a>
                        <a href="payment-gateway.jsp" class="btn btn-primary">Proceed to Checkout</a>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <script>
        // Add animation when updating quantities
        document.addEventListener('DOMContentLoaded', function() {
            const updateForms = document.querySelectorAll('.quantity-form');

            updateForms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    const cartId = this.querySelector('input[name="cartId"]').value;
                    const cartItem = document.getElementById(`cart-item-${cartId}`);

                    // Add animation class
                    cartItem.classList.add('updated-item');

                    // Remove class after animation completes
                    setTimeout(() => {
                        cartItem.classList.remove('updated-item');
                    }, 1500);
                });
            });

            // Add confirmation for remove actions
            const removeForms = document.querySelectorAll('.remove-form');

            removeForms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    if (!confirm('Are you sure you want to remove this item from your cart?')) {
                        e.preventDefault();
                    }
                });
            });
        });
    </script>
</body>
</html>