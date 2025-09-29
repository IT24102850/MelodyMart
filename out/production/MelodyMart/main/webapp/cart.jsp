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

<style>
    :root {
        --primary: #8a2be2;
        --primary-light: #9b45f0;
        --secondary: #0a0a0a;
        --accent: #00e5ff;
        --text: #ffffff;
        --text-secondary: #b3b3b3;
        --card-bg: #1a1a1a;
        --card-hover: #2a2a2a;
        --glass-bg: rgba(30, 30, 30, 0.7);
        --glass-border: rgba(255, 255, 255, 0.1);
        --gradient: linear-gradient(135deg, var(--primary), var(--accent));
    }

    .content-card {
        background: var(--card-bg);
        border: 1px solid var(--glass-border);
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .content-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
    }

    .table-dark th {
        background: var(--glass-bg);
        color: var(--text-secondary);
        font-weight: 600;
    }

    .table-hover tbody tr:hover {
        background-color: var(--card-hover);
        transition: background-color 0.3s ease;
    }

    .img-thumbnail {
        border: none;
        background: transparent;
    }

    .quantity-control {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .quantity-btn {
        width: 30px;
        height: 30px;
        border: 1px solid var(--glass-border);
        background: var(--card-bg);
        color: var(--text);
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.3s ease;
    }

    .quantity-btn:hover {
        background: rgba(138, 43, 226, 0.1);
        color: var(--primary-light);
    }

    .btn-custom {
        padding: 8px 15px;
        border-radius: 5px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn-primary {
        background: var(--gradient);
        color: var(--text);
    }

    .btn-primary:hover {
        background: linear-gradient(135deg, var(--accent-alt), var(--primary));
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
    }

    .btn-outline-secondary {
        border-color: var(--primary-light);
        color: var(--primary-light);
    }

    .btn-outline-secondary:hover {
        background: rgba(138, 43, 226, 0.1);
        color: var(--primary-light);
    }

    .btn-danger {
        background-color: #dc3545;
        color: var(--text);
    }

    .btn-danger:hover {
        background-color: #c82333;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
    }

    .cart-summary {
        background: var(--glass-bg);
        padding: 15px;
        border-radius: 10px;
        border: 1px solid var(--glass-border);
    }

    .cart-summary .text-success {
        color: #28a745 !important;
    }

    .notification {
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 15px;
        display: none;
        animation: fadeIn 0.5s ease;
    }

    .notification.success {
        background: rgba(40, 167, 69, 0.2);
        border: 1px solid rgba(40, 167, 69, 0.5);
        color: #28a745;
    }

    .notification.error {
        background: rgba(220, 53, 69, 0.2);
        border: 1px solid rgba(220, 53, 69, 0.5);
        color: #dc3545;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    @media (max-width: 768px) {
        .table-responsive {
            overflow-x: auto;
        }

        .table {
            min-width: 600px;
        }

        .table td, .table th {
            white-space: nowrap;
        }

        .quantity-control {
            flex-direction: column;
            gap: 10px;
        }

        .btn-lg {
            width: 100%;
            margin-top: 10px;
        }
    }
</style>

<section id="cart" class="dashboard-section container mt-4">
    <div class="content-card shadow p-4 rounded">
        <div class="card-header d-flex justify-content-between align-items-center mb-3">
            <h2 class="card-title mb-0" style="font-family: 'Playfair Display', serif; font-size: 24px; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                <i class="fas fa-shopping-cart"></i> My Cart
            </h2>
            <a href="shop.jsp" class="btn btn-outline-secondary btn-sm" data-bs-toggle="tooltip" title="Back to Shop">
                <i class="fas fa-store"></i> Continue Shopping
            </a>
        </div>

        <!-- Notifications -->
        <div class="notification success" id="successNotification"></div>
        <div class="notification error" id="errorNotification"></div>

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

                        if (!rs.isBeforeFirst()) {
                            out.println("<tr><td colspan='5' class='text-center text-secondary'>Your cart is empty.</td></tr>");
                        } else {
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
                            <span style="font-size: 16px; color: var(--text);"><%= rs.getString("Name") %></span>
                        </div>
                    </td>
                    <td>
                        <div class="quantity-control">
                            <form action="UpdateCartServlet" method="post" class="d-flex align-items-center" id="updateForm_<%= cartId %>">
                                <input type="hidden" name="cartId" value="<%= cartId %>">
                                <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                                <button type="button" class="quantity-btn" onclick="updateQuantity('<%= cartId %>', -1)">-</button>
                                <input type="number" name="quantity" value="<%= qty %>" min="1" class="form-control form-control-sm text-center" style="width:70px;" id="quantity_<%= cartId %>">
                                <button type="button" class="quantity-btn" onclick="updateQuantity('<%= cartId %>', 1)">+</button>
                                <button type="submit" class="btn btn-sm btn-success ms-2" id="updateBtn_<%= cartId %>" data-bs-toggle="tooltip" title="Update Quantity">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </form>
                        </div>
                    </td>
                    <td style="font-size: 16px; color: var(--text);">$<%= String.format("%.2f", price) %></td>
                    <td class="fw-bold" style="font-size: 16px; color: var(--text);">$<%= String.format("%.2f", total) %></td>
                    <td>
                        <form action="RemoveFromCartServlet" method="post" style="display:inline;" id="removeForm_<%= cartId %>">
                            <input type="hidden" name="cartId" value="<%= cartId %>">
                            <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                            <input type="hidden" name="quantity" value="<%= qty %>">
                            <button type="submit" class="btn btn-sm btn-danger" id="removeBtn_<%= cartId %>" data-bs-toggle="tooltip" title="Remove Item">
                                <i class="fas fa-trash-alt"></i> Remove
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                            }
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
            <h4 class="fw-bold" style="font-size: 20px; color: var(--text);">Grand Total: <span class="text-success">$<%= String.format("%.2f", grandTotal) %></span></h4>
            <div class="actions mt-3">
                <a href="checkout.jsp" class="btn btn-lg btn-primary" <%= grandTotal == 0.0 ? "disabled" : "" %> data-bs-toggle="tooltip" title="Proceed to Payment">
                    <i class="fas fa-credit-card"></i> Proceed to Checkout
                </a>
            </div>
        </div>
    </div>
</section>

<script>
    // Enable Bootstrap tooltips
    document.addEventListener('DOMContentLoaded', function() {
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Check for URL parameters for feedback
        const urlParams = new URLSearchParams(window.location.search);
        const status = urlParams.get('status');
        const message = urlParams.get('message');
        if (status === 'success') {
            showNotification('successNotification', message || 'Cart updated successfully!');
        } else if (status === 'error') {
            showNotification('errorNotification', message || 'Error updating cart. Please try again.');
        }
    });

    function updateQuantity(cartId, change) {
        const quantityInput = document.getElementById(`quantity_${cartId}`);
        let qty = parseInt(quantityInput.value);
        qty = Math.max(1, qty + change); // Ensure quantity doesn't go below 1
        quantityInput.value = qty;
        submitForm(`updateForm_${cartId}`, cartId, 'update');
    }

    function submitForm(formId, cartId, action) {
        const form = document.getElementById(formId);
        const button = document.getElementById(`${action}Btn_${cartId}`);
        const originalText = button.innerHTML;
        button.innerHTML = `<i class="fas fa-spinner fa-spin"></i>`;
        button.disabled = true;

        fetch(form.action, {
            method: form.method,
            body: new FormData(form)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showNotification('successNotification', data.message);
                    if (action === 'update') {
                        location.reload(); // Reload to reflect updated total
                    } else if (action === 'remove') {
                        document.querySelector(`#${formId}`).closest('tr').remove();
                        updateGrandTotal(data.grandTotal);
                    }
                } else {
                    showNotification('errorNotification', data.message);
                }
            })
            .catch(error => {
                showNotification('errorNotification', `Error: ${error.message}`);
            })
            .finally(() => {
                button.innerHTML = originalText;
                button.disabled = false;
            });
    }

    function showNotification(notificationId, message) {
        const notification = document.getElementById(notificationId);
        notification.textContent = message;
        notification.style.display = 'block';
        setTimeout(() => {
            notification.style.display = 'none';
        }, 3000);
    }

    function updateGrandTotal(newTotal) {
        const grandTotalElement = document.querySelector('.cart-summary .text-success');
        grandTotalElement.textContent = `$${parseFloat(newTotal).toFixed(2)}`;
        if (newTotal === 0.0) {
            document.querySelector('.btn-primary').disabled = true;
        }
    }
</script>