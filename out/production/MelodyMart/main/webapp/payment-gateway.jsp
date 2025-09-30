<%@ page import="java.sql.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Gateway | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --accent-alt: #ff00c8;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --card-hover: #2a2a2a;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
            --glass-bg: rgba(30, 30, 30, 0.7);
            --glass-border: rgba(255, 255, 255, 0.1);
            --success: #00cc66;
            --error: #ff3366;
            --warning: #ffaa00;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--secondary);
            color: var(--text);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            line-height: 1.6;
        }

        .payment-container {
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
        }

        .payment-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            position: relative;
            overflow: hidden;
        }

        .payment-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: var(--gradient);
        }

        .payment-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .payment-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }

        .payment-header p {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text);
        }

        .form-control {
            width: 100%;
            padding: 15px;
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 2px rgba(138, 43, 226, 0.3);
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .payment-methods {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .payment-method {
            flex: 1;
            text-align: center;
            padding: 12px;
            border: 1px solid var(--glass-border);
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: var(--card-bg);
        }

        .payment-method:hover {
            background: var(--card-hover);
        }

        .payment-method.active {
            border-color: var(--primary-light);
            background: rgba(138, 43, 226, 0.1);
        }

        .payment-method i {
            font-size: 24px;
            margin-bottom: 5px;
            color: var(--text-secondary);
        }

        .payment-method.active i {
            color: var(--primary-light);
        }

        .payment-method span {
            display: block;
            font-size: 12px;
            color: var(--text-secondary);
        }

        .payment-method.active span {
            color: var(--primary-light);
        }

        .btn-pay {
            width: 100%;
            background: var(--gradient);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            z-index: 1;
            margin-top: 10px;
        }

        .btn-pay:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background: var(--gradient-alt);
            transition: all 0.4s ease;
            z-index: -1;
        }

        .btn-pay:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
        }

        .btn-pay:hover:before {
            width: 100%;
        }

        .btn-pay:active {
            transform: translateY(0);
        }

        .security-notice {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .security-notice i {
            color: var(--accent);
        }

        .message {
            margin-top: 20px;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            font-weight: 500;
            display: none;
        }

        .success-msg {
            background: rgba(0, 204, 102, 0.1);
            border: 1px solid var(--success);
            color: var(--success);
        }

        .error-msg {
            background: rgba(255, 51, 102, 0.1);
            border: 1px solid var(--error);
            color: var(--error);
        }

        .warning-msg {
            background: rgba(255, 170, 0, 0.1);
            border: 1px solid var(--warning);
            color: var(--warning);
        }

        .transaction-details {
            margin-top: 20px;
            padding: 15px;
            background: rgba(138, 43, 226, 0.1);
            border-radius: 10px;
            border: 1px solid var(--primary-light);
            display: none;
        }

        .transaction-details h4 {
            margin-bottom: 10px;
            color: var(--primary-light);
        }

        .transaction-details p {
            margin-bottom: 5px;
            font-size: 14px;
        }

        .floating-icons {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            overflow: hidden;
            z-index: -1;
            pointer-events: none;
        }

        .floating-icon {
            position: absolute;
            font-size: 20px;
            color: rgba(138, 43, 226, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-15px) rotate(5deg); }
        }

        @media (max-width: 576px) {
            .payment-card {
                padding: 20px;
            }

            .payment-header h2 {
                font-size: 28px;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .payment-methods {
                flex-wrap: wrap;
            }

            .payment-method {
                flex: 0 0 calc(50% - 5px);
            }
        }
    </style>
</head>
<body>
<div class="payment-container">
    <div class="payment-card">
        <div class="payment-header">
            <h2>Payment Gateway</h2>
            <p>Complete your purchase securely</p>
        </div>

        <form id="paymentForm" method="post" action="PaymentServlet">
            <div class="form-group">
                <label class="form-label" for="orderId">Order ID</label>
                <input type="number" class="form-control" id="orderId" name="orderId" required>
            </div>

            <div class="form-group">
                <label class="form-label" for="amount">Amount ($)</label>
                <input type="text" class="form-control" id="amount" name="amount" required>
            </div>

            <div class="form-group">
                <label class="form-label">Payment Method</label>
                <div class="payment-methods">
                    <div class="payment-method" data-value="Visa">
                        <i class="fab fa-cc-visa"></i>
                        <span>Visa</span>
                    </div>
                    <div class="payment-method" data-value="MasterCard">
                        <i class="fab fa-cc-mastercard"></i>
                        <span>MasterCard</span>
                    </div>
                    <div class="payment-method" data-value="Amex">
                        <i class="fab fa-cc-amex"></i>
                        <span>Amex</span>
                    </div>
                    <div class="payment-method" data-value="PayPal">
                        <i class="fab fa-cc-paypal"></i>
                        <span>PayPal</span>
                    </div>
                </div>
                <input type="hidden" id="paymentMethod" name="paymentMethod" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="cardNumber">Card Number</label>
                    <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="cvv">CVV</label>
                    <input type="text" class="form-control" id="cvv" name="cvv" maxlength="3" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="expiryDate">Expiry Date</label>
                    <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY" maxlength="5" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="cardName">Name on Card</label>
                    <input type="text" class="form-control" id="cardName" placeholder="John Doe" required>
                </div>
            </div>

            <!-- Hidden fields for servlet -->
            <input type="hidden" id="transactionId" name="transactionId">
            <input type="hidden" id="status" name="status" value="Pending">

            <button type="submit" class="btn-pay">
                <i class="fas fa-lock"></i> Pay Now
            </button>

            <div class="security-notice">
                <i class="fas fa-shield-alt"></i>
                <span>Your payment information is secure and encrypted</span>
            </div>
        </form>

        <!-- Server Response Messages -->
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                boolean isSuccess = message.contains("✅") || message.contains("successfully");
        %>
        <div class="message <%= isSuccess ? "success-msg" : "error-msg" %>" style="display: block;">
            <i class="fas <%= isSuccess ? "fa-check-circle" : "fa-exclamation-circle" %>"></i>
            <%= message %>
        </div>
        <%
            }
        %>

        <div class="floating-icons">
            <i class="floating-icon" style="top: 10%; left: 5%; animation-delay: 0s;">🎵</i>
            <i class="floating-icon" style="top: 20%; right: 10%; animation-delay: 1s;">🎸</i>
            <i class="floating-icon" style="top: 70%; left: 10%; animation-delay: 2s;">🎹</i>
            <i class="floating-icon" style="top: 60%; right: 5%; animation-delay: 3s;">🎶</i>
            <i class="floating-icon" style="top: 40%; left: 15%; animation-delay: 4s;">🎼</i>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Payment method selection
        const paymentMethods = document.querySelectorAll('.payment-method');
        const paymentMethodInput = document.getElementById('paymentMethod');

        paymentMethods.forEach(method => {
            method.addEventListener('click', function() {
                paymentMethods.forEach(m => m.classList.remove('active'));
                this.classList.add('active');
                paymentMethodInput.value = this.getAttribute('data-value');
            });
        });

        // Auto-select first payment method
        if (paymentMethods.length > 0) {
            paymentMethods[0].click();
        }

        // Format card number input
        const cardNumberInput = document.getElementById('cardNumber');
        cardNumberInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            let formattedValue = '';

            for (let i = 0; i < value.length; i++) {
                if (i > 0 && i % 4 === 0) {
                    formattedValue += ' ';
                }
                formattedValue += value[i];
            }

            e.target.value = formattedValue;
        });

        // Format expiry date input
        const expiryDateInput = document.getElementById('expiryDate');
        expiryDateInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');

            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }

            e.target.value = value;
        });

        // Form validation and submission
        const paymentForm = document.getElementById('paymentForm');
        const transactionIdInput = document.getElementById('transactionId');
        const statusInput = document.getElementById('status');

        paymentForm.addEventListener('submit', function(e) {
            // Generate transaction ID
            const txnId = "TXN" + (Math.floor(Math.random() * 9000) + 1000);
            transactionIdInput.value = txnId;

            // Determine payment status (simulate 80% success rate)
            const isSuccess = Math.random() > 0.2;
            statusInput.value = isSuccess ? "Paid" : "Failed";

            // Validate card number (simple Luhn algorithm check)
            const cardNumber = cardNumberInput.value.replace(/\s/g, '');
            if (!isValidCardNumber(cardNumber)) {
                e.preventDefault();
                showValidationError('Please enter a valid card number');
                return;
            }

            // Validate expiry date
            const expiryDate = expiryDateInput.value;
            if (!isValidExpiryDate(expiryDate)) {
                e.preventDefault();
                showValidationError('Please enter a valid expiry date (MM/YY)');
                return;
            }

            // Validate CVV
            const cvv = document.getElementById('cvv').value;
            if (!/^\d{3,4}$/.test(cvv)) {
                e.preventDefault();
                showValidationError('Please enter a valid CVV (3-4 digits)');
                return;
            }

            // If all validations pass, show loading state
            const submitBtn = paymentForm.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            submitBtn.disabled = true;
        });

        // Card number validation using Luhn algorithm
        function isValidCardNumber(cardNumber) {
            if (!/^\d+$/.test(cardNumber)) return false;

            let sum = 0;
            let isEven = false;

            for (let i = cardNumber.length - 1; i >= 0; i--) {
                let digit = parseInt(cardNumber.charAt(i), 10);

                if (isEven) {
                    digit *= 2;
                    if (digit > 9) {
                        digit -= 9;
                    }
                }

                sum += digit;
                isEven = !isEven;
            }

            return (sum % 10) === 0;
        }

        // Expiry date validation
        function isValidExpiryDate(expiryDate) {
            if (!/^\d{2}\/\d{2}$/.test(expiryDate)) return false;

            const [month, year] = expiryDate.split('/').map(Number);
            const currentDate = new Date();
            const currentYear = currentDate.getFullYear() % 100;
            const currentMonth = currentDate.getMonth() + 1;

            if (month < 1 || month > 12) return false;
            if (year < currentYear || (year === currentYear && month < currentMonth)) return false;

            return true;
        }

        // Show validation error
        function showValidationError(message) {
            // Remove any existing validation message
            const existingError = document.querySelector('.warning-msg');
            if (existingError) {
                existingError.remove();
            }

            // Create and show new validation message
            const errorDiv = document.createElement('div');
            errorDiv.className = 'message warning-msg';
            errorDiv.style.display = 'block';
            errorDiv.innerHTML = `<i class="fas fa-exclamation-triangle"></i> ${message}`;

            paymentForm.insertBefore(errorDiv, paymentForm.querySelector('.security-notice'));

            // Auto-remove after 5 seconds
            setTimeout(() => {
                errorDiv.remove();
            }, 5000);
        }

        // Add floating icons dynamically
        function addFloatingIcons() {
            const icons = ['🎵', '🎸', '🎹', '🎶', '🎼', '🥁', '🎷', '🎺', '🎻', '📯'];
            const container = document.querySelector('.floating-icons');

            for (let i = 0; i < 10; i++) {
                const icon = document.createElement('div');
                icon.className = 'floating-icon';
                icon.textContent = icons[Math.floor(Math.random() * icons.length)];
                icon.style.left = Math.random() * 100 + '%';
                icon.style.top = Math.random() * 100 + '%';
                icon.style.animationDelay = Math.random() * 5 + 's';
                icon.style.fontSize = (Math.random() * 15 + 12) + 'px';
                container.appendChild(icon);
            }
        }

        addFloatingIcons();
    });
</script>
</body>
</html>