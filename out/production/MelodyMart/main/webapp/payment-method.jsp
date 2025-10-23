<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%
    // Get parameters from request
    String quantityStr = request.getParameter("quantity");
    String subtotalStr = request.getParameter("subtotal");
    String shippingStr = request.getParameter("shipping");
    String totalAmountStr = request.getParameter("totalAmount");
    String productName = request.getParameter("productName");
    String productImage = request.getParameter("productImage");
    String productBrand = request.getParameter("productBrand");
    String productModel = request.getParameter("productModel");
    String customerId = request.getParameter("customerId");

    // Set default values
    int quantity = 1;
    double subtotal = 0.00;
    double shipping = 300.00;
    double totalAmount = 0.00;

    try {
        if (quantityStr != null) quantity = Integer.parseInt(quantityStr);
        if (subtotalStr != null) subtotal = Double.parseDouble(subtotalStr);
        if (shippingStr != null) shipping = Double.parseDouble(shippingStr);
        if (totalAmountStr != null) totalAmount = Double.parseDouble(totalAmountStr);
    } catch (NumberFormatException e) {
        e.printStackTrace();
    }

    // Fallback defaults
    if (subtotal == 0) subtotal = 700.00;
    if (totalAmount == 0) totalAmount = 1000.00;
    if (productName == null) productName = "Musical Instrument";
    if (productImage == null) productImage = "";
    if (customerId == null) customerId = "C001"; // Placeholder; not used in query due to schema mismatch

    // Generate or retrieve OrderID
    String orderId = null;
    String errorMessage = null;
    try (Connection conn = DBConnection.getConnection()) {
        // Generate new OrderID in format ORDxxx
        String sql = "SELECT 'ORD' + RIGHT('000' + CAST(ISNULL(MAX(CAST(SUBSTRING(OrderID, 4, 3) AS INT)), 0) + 1 AS NVARCHAR(3)), 3) AS NextOrderID FROM OrderNow";
        Statement stmt = conn.createStatement();
        ResultSet rsOrder = stmt.executeQuery(sql);
        if (rsOrder.next()) {
            orderId = rsOrder.getString("NextOrderID");
        }
        rsOrder.close();
        stmt.close();

        // Insert new order into OrderNow
        String insertOrderQuery = "INSERT INTO OrderNow (OrderID, TotalAmount, Status, CreatedAt) VALUES (?, ?, 'Pending', GETDATE())";
        PreparedStatement psInsert = conn.prepareStatement(insertOrderQuery);
        psInsert.setString(1, orderId);
        psInsert.setDouble(2, totalAmount);
        psInsert.executeUpdate();
        psInsert.close();
    } catch (SQLException e) {
        e.printStackTrace();
        errorMessage = "Database error: " + e.getMessage();
        orderId = null; // Avoid fallback to prevent invalid OrderID
    }

    // If orderId is null, display error to user
    if (orderId == null) {
        errorMessage = errorMessage != null ? errorMessage : "Unable to generate Order ID. Please try again.";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Method | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --light: #f8f9fa;
            --dark: #212529;
            --border: #e9ecef;
            --success: #28a745;
            --visa: #1a1f71;
            --mastercard: #eb001b;
            --amex: #2e77bc;
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
            padding: 20px;
        }

        .payment-container {
            max-width: 1000px;
            margin: 20px auto;
            padding: 20px;
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 30px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: var(--primary);
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 500;
            grid-column: 1 / -1;
        }

        .payment-methods {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            padding: 30px;
        }

        .section-title {
            font-size: 1.5rem;
            margin-bottom: 25px;
            color: var(--dark);
            padding-bottom: 15px;
            border-bottom: 2px solid var(--primary);
        }

        .payment-option {
            border: 2px solid var(--border);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-option:hover {
            border-color: var(--primary);
            background: #f8f9ff;
        }

        .payment-option.selected {
            border-color: var(--primary);
            background: #f0f4ff;
        }

        .payment-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 10px;
        }

        .payment-icon {
            width: 40px;
            height: 40px;
            background: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .payment-title {
            font-weight: 600;
            font-size: 1.1rem;
        }

        .payment-description {
            color: #666;
            font-size: 0.9rem;
            margin-left: 55px;
        }

        .card-details {
            margin-top: 20px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            display: none;
        }

        .card-details.active {
            display: block;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
        }

        .form-input {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        .card-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .card-type-selector {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            margin-bottom: 20px;
        }

        .card-type-option {
            border: 2px solid var(--border);
            border-radius: 8px;
            padding: 12px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .card-type-option:hover {
            border-color: var(--primary);
        }

        .card-type-option.selected {
            border-color: var(--primary);
            background: #f0f4ff;
        }

        .card-type-icon {
            width: 40px;
            height: 25px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 0.8rem;
            margin: 0 auto 5px;
        }

        .card-type-icon.visa { background: var(--visa); }
        .card-type-icon.mastercard { background: var(--mastercard); }
        .card-type-icon.amex { background: var(--amex); }

        .card-type-name {
            font-size: 0.9rem;
            font-weight: 600;
        }

        .order-summary-sidebar {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            padding: 25px;
            height: fit-content;
        }

        .order-item-preview {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border);
        }

        .item-preview-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            background: #f0f0f0;
        }

        .item-preview-details {
            flex: 1;
        }

        .item-preview-name {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .item-preview-quantity {
            color: #666;
            font-size: 0.9rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid var(--border);
        }

        .summary-row.total {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary);
            border-bottom: none;
            margin-top: 10px;
            padding-top: 15px;
            border-top: 2px solid var(--border);
        }

        .pay-now-btn {
            width: 100%;
            padding: 16px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .pay-now-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        .pay-now-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }

        .error-message {
            color: #dc3545;
            background: #f8d7da;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
            display: none;
        }

        .security-notice {
            background: #e7f3ff;
            border: 1px solid #b3d9ff;
            border-radius: 8px;
            padding: 15px;
            margin-top: 20px;
            font-size: 0.9rem;
            color: #0066cc;
        }

        .security-notice i {
            color: #0066cc;
            margin-right: 8px;
        }

        @media (max-width: 768px) {
            .payment-container {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .card-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="payment-container">
    <a href="customerlanding.jsp?orderId=<%= orderId != null ? orderId : "" %>" class="back-link">
        <i class="fas fa-arrow-left"></i>
        Back to Order Summary
    </a>

    <% if (errorMessage != null) { %>
    <div class="error-message" style="display: block; grid-column: 1 / -1;">
        <%= errorMessage %>
    </div>
    <% } else { %>
    <div class="payment-methods">
        <h2 class="section-title">Select Payment Method</h2>

        <div class="payment-option" onclick="selectPaymentMethod('card')">
            <div class="payment-header">
                <div class="payment-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <div class="payment-title">Credit/Debit Card</div>
            </div>
            <div class="payment-description">
                Pay securely with your Visa, Mastercard, or American Express
            </div>
        </div>

        <div class="payment-option" onclick="selectPaymentMethod('cash')">
            <div class="payment-header">
                <div class="payment-icon">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="payment-title">Cash on Delivery</div>
            </div>
            <div class="payment-description">
                Pay when you receive your order. Additional $5 delivery fee may apply.
            </div>
        </div>

        <div id="cardDetails" class="card-details">
            <div id="newCardForm">
                <div class="card-type-selector">
                    <div class="card-type-option" onclick="selectCardType('Visa')">
                        <div class="card-type-icon visa">VISA</div>
                        <div class="card-type-name">Visa</div>
                    </div>
                    <div class="card-type-option" onclick="selectCardType('Mastercard')">
                        <div class="card-type-icon mastercard">MC</div>
                        <div class="card-type-name">Mastercard</div>
                    </div>
                    <div class="card-type-option" onclick="selectCardType('Amex')">
                        <div class="card-type-icon amex">AMEX</div>
                        <div class="card-type-name">Amex</div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Card Number</label>
                    <input type="text" id="cardNumber" class="form-input" placeholder="1234 5678 9012 3456" maxlength="50"
                           oninput="formatCardNumber(this)" required>
                </div>

                <div class="card-row">
                    <div class="form-group">
                        <label class="form-label">Expiry Date</label>
                        <input type="text" id="expiryDate" class="form-input" placeholder="MM/YY" maxlength="5"
                               oninput="formatExpiryDate(this); validateExpiryDate(this)" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">CVV</label>
                        <input type="password" id="cvv" class="form-input" placeholder="123" maxlength="3"
                               oninput="this.value = this.value.replace(/\D/g, '')" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Cardholder Name</label>
                    <input type="text" id="cardholderName" class="form-input" placeholder="John Doe" required>
                </div>

                <div class="security-notice">
                    <i class="fas fa-lock"></i>
                    Your payment information is secure and encrypted. We do not store your CVV.
                </div>
            </div>
        </div>
    </div>

    <div class="order-summary-sidebar">
        <h3 style="margin-bottom: 20px;">Order Summary</h3>

        <div class="order-item-preview">
            <div class="item-preview-image" style="background: url('<%= productImage %>') center/cover; background-color: #f0f0f0;"></div>
            <div class="item-preview-details">
                <div class="item-preview-name"><%= productName %></div>
                <div class="item-preview-quantity">Order ID: <%= orderId %></div>
                <div class="item-preview-quantity">Quantity: <%= quantity %></div>
                <% if (productBrand != null && !productBrand.isEmpty()) { %>
                <div class="item-preview-quantity">Brand: <%= productBrand %></div>
                <% } %>
                <% if (productModel != null && !productModel.isEmpty()) { %>
                <div class="item-preview-quantity">Model: <%= productModel %></div>
                <% } %>
            </div>
        </div>

        <div class="summary-row">
            <span>Subtotal:</span>
            <span>$<%= String.format("%.2f", subtotal) %></span>
        </div>
        <div class="summary-row">
            <span>Shipping:</span>
            <span>$<%= String.format("%.2f", shipping) %></span>
        </div>
        <% if ("cash".equals(request.getParameter("paymentMethod"))) { %>
        <div class="summary-row">
            <span>COD Fee:</span>
            <span>$5.00</span>
        </div>
        <% } %>
        <div class="summary-row total">
            <span>Total Amount:</span>
            <span>$<%= String.format("%.2f", totalAmount) %></span>
        </div>

        <div id="errorMessage" class="error-message"></div>

        <form id="paymentForm" method="POST" action="PaymentServlet">
            <input type="hidden" name="orderId" value="<%= orderId %>">
            <input type="hidden" name="customerId" value="<%= customerId %>">
            <input type="hidden" name="totalAmount" value="<%= totalAmount %>">
            <input type="hidden" name="quantity" value="<%= quantity %>">
            <input type="hidden" name="productName" value="<%= productName %>">
            <input type="hidden" name="paymentMethod" id="hiddenPaymentMethod">
            <input type="hidden" name="cardType" id="hiddenCardType">
            <input type="hidden" name="cardNumber" id="hiddenCardNumber">
            <input type="hidden" name="expiryDate" id="hiddenExpiryDate">
            <input type="hidden" name="cvv" id="hiddenCvv">
            <input type="hidden" name="cardholderName" id="hiddenCardholderName">

            <button id="payNowBtn" class="pay-now-btn" <%= orderId == null ? "disabled" : "" %> type="submit">
                <i class="fas fa-lock"></i>
                Complete Payment - $<%= String.format("%.2f", totalAmount) %>
            </button>
        </form>

        <div class="security-notice" style="margin-top: 15px;">
            <i class="fas fa-shield-alt"></i>
            Secure SSL Encryption • 256-bit Security
        </div>
    </div>
    <% } %>
</div>

<script>
    let selectedPaymentMethod = '';
    let selectedCardType = '';

    function selectPaymentMethod(method) {
        selectedPaymentMethod = method;
        document.querySelectorAll('.payment-option').forEach(option => {
            option.classList.remove('selected');
        });
        event.currentTarget.classList.add('selected');

        const cardDetails = document.getElementById('cardDetails');
        if (method === 'card') {
            cardDetails.classList.add('active');
            validateCardForm();
        } else {
            cardDetails.classList.remove('active');
            document.getElementById('payNowBtn').disabled = false;
            // Clear card fields for cash payment
            document.getElementById('cardNumber').value = '';
            document.getElementById('expiryDate').value = '';
            document.getElementById('cvv').value = '';
            document.getElementById('cardholderName').value = '';
            document.getElementById('hiddenCardType').value = '';
            document.getElementById('hiddenCardNumber').value = '';
            document.getElementById('hiddenExpiryDate').value = '';
            document.getElementById('hiddenCvv').value = '';
            document.getElementById('hiddenCardholderName').value = '';
        }

        document.getElementById('hiddenPaymentMethod').value = selectedPaymentMethod;
    }

    function selectCardType(type) {
        selectedCardType = type;
        document.querySelectorAll('.card-type-option').forEach(option => {
            option.classList.remove('selected');
        });
        event.currentTarget.classList.add('selected');
        document.getElementById('hiddenCardType').value = selectedCardType;
        validateCardForm();
    }

    function detectCardType(cardNumber) {
        // No detection logic needed since any number is allowed
    }

    function formatCardNumber(input) {
        let value = input.value.replace(/\D/g, ''); // Keep only numbers
        if (value.length > 0) {
            // Format numbers in groups of 4 with spaces
            value = value.replace(/(\d{4})(?=\d)/g, '$1 ').trim();
        }
        input.value = value;
        document.getElementById('hiddenCardNumber').value = value; // Pass formatted value
        validateCardForm();
    }

    function formatExpiryDate(input) {
        let value = input.value.replace(/\D/g, '');
        if (value.length > 2) {
            value = value.substring(0, 2) + '/' + value.substring(2, 4);
        }
        input.value = value;
        document.getElementById('hiddenExpiryDate').value = value;
        validateCardForm();
    }

    function validateExpiryDate(input) {
        const expiryDate = input.value;
        if (expiryDate.length === 5) {
            const validation = isValidExpiryDate(expiryDate);
            if (!validation.valid) {
                input.style.borderColor = '#dc3545';
                input.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                showError(validation.message);
            } else {
                input.style.borderColor = '#28a745';
                input.style.boxShadow = '0 0 0 3px rgba(40, 167, 69, 0.1)';
            }
        } else {
            input.style.borderColor = '#e9ecef';
            input.style.boxShadow = 'none';
        }
    }

    function validateCardForm() {
        if (selectedPaymentMethod !== 'card') return;

        const cardNumber = document.getElementById('cardNumber').value;
        const expiryDate = document.getElementById('expiryDate').value;
        const cvv = document.getElementById('cvv').value;
        const cardholderName = document.getElementById('cardholderName').value;

        const expiryValidation = isValidExpiryDate(expiryDate);
        const isValid = cardNumber.trim().length > 0 && // Only check if card number is not empty
            expiryDate.length === 5 &&
            expiryValidation.valid &&
            cvv.length === 3 &&
            cardholderName.trim().length > 0 &&
            selectedCardType !== '';

        document.getElementById('payNowBtn').disabled = !isValid;
    }

    function isValidExpiryDate(expiryDate) {
        if (!expiryDate || expiryDate.length !== 5 || !/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiryDate)) {
            return { valid: false, message: 'Please enter a valid expiry date in MM/YY format (e.g., 12/25)' };
        }

        try {
            const [monthStr, yearStr] = expiryDate.split('/');
            const month = parseInt(monthStr);
            const year = parseInt(yearStr);

            if (month < 1 || month > 12) {
                return { valid: false, message: 'Month must be between 01 and 12' };
            }

            const currentDate = new Date();
            const currentYear = currentDate.getFullYear() % 100; // Last two digits (25 for 2025)
            const currentMonth = currentDate.getMonth() + 1; // October = 10
            const currentDay = currentDate.getDate(); // 23

            if (year < currentYear) {
                return { valid: false, message: 'Card has expired (year is in the past)' };
            }
            if (year === currentYear && month < currentMonth) {
                return { valid: false, message: 'Card has expired (month is in the past)' };
            }
            if (year === currentYear && month === currentMonth && currentDay > 28) {
                return { valid: false, message: 'Card expires this month, which is too soon' };
            }

            return { valid: true, message: '' };
        } catch (error) {
            return { valid: false, message: 'Invalid expiry date format' };
        }
    }

    function showError(message) {
        const errorDiv = document.getElementById('errorMessage');
        errorDiv.textContent = message;
        errorDiv.style.display = 'block';
        errorDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
        setTimeout(() => {
            errorDiv.style.display = 'none';
        }, 5000);
    }

    document.getElementById('paymentForm').addEventListener('submit', function(e) {
        if (!selectedPaymentMethod) {
            e.preventDefault();
            showError('Please select a payment method');
            return;
        }

        if (selectedPaymentMethod === 'card') {
            const cardNumber = document.getElementById('cardNumber').value;
            const expiryDate = document.getElementById('expiryDate').value;
            const cvv = document.getElementById('cvv').value;
            const cardholderName = document.getElementById('cardholderName').value;

            if (!cardNumber) {
                e.preventDefault();
                showError('Please enter a card number');
                return;
            }
            if (!expiryDate || expiryDate.length !== 5) {
                e.preventDefault();
                showError('Please enter a valid expiry date (MM/YY)');
                return;
            }
            if (!cvv || cvv.length !== 3) {
                e.preventDefault();
                showError('Please enter a valid 3-digit CVV');
                return;
            }
            if (!cardholderName) {
                e.preventDefault();
                showError('Please enter cardholder name');
                return;
            }
            if (!selectedCardType) {
                e.preventDefault();
                showError('Please select card type');
                return;
            }

            const expiryValidation = isValidExpiryDate(expiryDate);
            if (!expiryValidation.valid) {
                e.preventDefault();
                showError(expiryValidation.message);
                return;
            }
        }

        const payBtn = document.getElementById('payNowBtn');
        payBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing Payment...';
        payBtn.disabled = true;
        setTimeout(() => {
            payBtn.disabled = true;
        }, 100);
    });

    document.getElementById('cvv').addEventListener('input', function() {
        document.getElementById('hiddenCvv').value = this.value;
        validateCardForm();
    });

    document.getElementById('cardholderName').addEventListener('input', function() {
        document.getElementById('hiddenCardholderName').value = this.value;
        validateCardForm();
    });

    document.getElementById('expiryDate').addEventListener('input', function() {
        validateExpiryDate(this);
    });

    document.getElementById('expiryDate').addEventListener('blur', function() {
        const expiryDate = this.value;
        if (expiryDate.length === 5) {
            const validation = isValidExpiryDate(expiryDate);
            if (!validation.valid) {
                this.style.borderColor = '#dc3545';
                this.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                showError(validation.message);
            } else {
                this.style.borderColor = '#28a745';
                this.style.boxShadow = '0 0 0 3px rgba(40, 167, 69, 0.1)';
            }
        } else if (expiryDate.length > 0) {
            this.style.borderColor = '#dc3545';
            this.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
            showError('Please enter a valid expiry date (MM/YY)');
        } else {
            this.style.borderColor = '#e9ecef';
            this.style.boxShadow = 'none';
        }
    });

    document.getElementById('cardNumber').addEventListener('blur', function() {
        const cardNumber = this.value;
        if (cardNumber.length === 0) {
            this.style.borderColor = '#dc3545';
            this.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
            showError('Please enter a card number');
        } else {
            this.style.borderColor = '#e9ecef';
            this.style.boxShadow = 'none';
        }
    });

    document.getElementById('expiryDate').addEventListener('focus', function() {
        this.style.borderColor = '#4361ee';
        this.style.boxShadow = '0 0 0 3px rgba(67, 97, 238, 0.1)';
    });

    document.getElementById('cardNumber').addEventListener('focus', function() {
        this.style.borderColor = '#4361ee';
        this.style.boxShadow = '0 0 0 3px rgba(67, 97, 238, 0.1)';
    });

    document.addEventListener('DOMContentLoaded', function() {
        const cardFields = ['cardNumber', 'expiryDate', 'cvv', 'cardholderName'];
        cardFields.forEach(field => {
            document.getElementById(field).addEventListener('input', validateCardForm);
        });

        document.getElementById('expiryDate').setAttribute('title', 'Enter expiry date as MM/YY (e.g., 12/25). Must be a future date.');
        document.getElementById('cvv').setAttribute('title', '3-digit security code on back of your card');
    });
</script>
</body>
</html>