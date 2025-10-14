<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get order details from request attributes
    Integer orderId = (Integer) request.getAttribute("orderId");
    Double amount = (Double) request.getAttribute("amount");
    String orderStatus = (String) request.getAttribute("orderStatus");

    // If no order details, set defaults
    if (orderId == null) orderId = 0;
    if (amount == null) amount = 0.0;
%>
<html>
<head>
    <title>Payment Gateway | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        <!-- Existing styles remain the same -->
    </style>
</head>
<body>
<div class="payment-container">
    <div class="payment-card">
        <!-- Existing payment-header, order-info, etc. remain the same -->
        <div class="payment-header">
            <h2>Payment Gateway</h2>
            <p>Complete your purchase securely</p>
        </div>

        <div class="order-info">
            <!-- Existing order-info items remain the same -->
        </div>

        <form id="paymentForm" action="${pageContext.request.contextPath}/PaymentServlet" method="post">
            <!-- Existing form fields remain the same -->
        </form>

        <!-- Display Messages from Servlet -->
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                String messageClass = message.contains("✅") ? "success-msg" : "error-msg";
        %>
        <div class="message <%= messageClass %>">
            <%= message %>
        </div>
        <%
            }
        %>
    </div>
</div>

<script>
    // Pass JSP values to JavaScript safely
    var orderId = <%= orderId %>;
    var amount = <%= amount %>;

    document.addEventListener('DOMContentLoaded', function() {
        const paymentMethods = document.querySelectorAll('.payment-method');
        const paymentMethodInput = document.getElementById('paymentMethod');
        const creditCardDetails = document.getElementById('creditCardDetails');
        const paypalDetails = document.getElementById('paypalDetails');
        const submitBtn = document.getElementById('submitBtn');
        const form = document.getElementById('paymentForm');

        // Only enable payment if order is selected
        if (orderId === 0) {
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-exclamation-circle"></i> Please select an order first';
        }

        // Payment method selection
        paymentMethods.forEach(method => {
            method.addEventListener('click', function() {
                if (orderId === 0) return;

                paymentMethods.forEach(m => m.classList.remove('selected'));
                this.classList.add('selected');

                const selectedMethod = this.getAttribute('data-method');
                paymentMethodInput.value = selectedMethod;

                if (selectedMethod === 'CreditCard') {
                    creditCardDetails.classList.add('active');
                    paypalDetails.classList.remove('active');
                    updateButtonText('Pay with Credit Card');
                    enableFormFields('cardNumber', 'expiryDate', 'cvv', 'cardName');
                    disableFormFields('paypalEmail');
                } else if (selectedMethod === 'PayPal') {
                    paypalDetails.classList.add('active');
                    creditCardDetails.classList.remove('active');
                    updateButtonText('Continue to PayPal');
                    enableFormFields('paypalEmail');
                    disableFormFields('cardNumber', 'expiryDate', 'cvv', 'cardName');
                }

                submitBtn.disabled = false;
            });
        });

        function updateButtonText(text) {
            submitBtn.innerHTML = `<i class="fas fa-lock"></i> ${text}`;
        }

        function enableFormFields(...fieldNames) {
            fieldNames.forEach(fieldName => {
                const field = document.querySelector(`[name="${fieldName}"]`);
                if (field) {
                    field.required = true;
                    field.disabled = false;
                }
            });
        }

        function disableFormFields(...fieldNames) {
            fieldNames.forEach(fieldName => {
                const field = document.querySelector(`[name="${fieldName}"]`);
                if (field) {
                    field.required = false;
                    field.disabled = true;
                    field.value = '';
                }
            });
        }

        form.addEventListener('submit', function(e) {
            if (orderId === 0) {
                e.preventDefault();
                alert('Please select an order first');
                return;
            }

            if (!validateForm()) {
                e.preventDefault();
                return;
            }

            submitBtn.innerHTML = '<span class="loading"></span> Processing...';
            submitBtn.disabled = true;
        });

        const cardNumberInput = document.querySelector('input[name="cardNumber"]');
        if (cardNumberInput) {
            cardNumberInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 0) {
                    value = value.match(new RegExp('.{1,4}', 'g')).join(' ');
                }
                e.target.value = value;
            });
        }

        const expiryInput = document.querySelector('input[name="expiryDate"]');
        if (expiryInput) {
            expiryInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 2) {
                    value = value.substring(0, 2) + '/' + value.substring(2, 4);
                }
                e.target.value = value;
            });
        }

        const cvvInput = document.querySelector('input[name="cvv"]');
        if (cvvInput) {
            cvvInput.addEventListener('input', function(e) {
                e.target.value = e.target.value.replace(/\D/g, '').substring(0, 3);
            });
        }

        function validateForm() {
            const selectedMethod = paymentMethodInput.value;

            if (!selectedMethod) {
                alert('Please select a payment method');
                return false;
            }

            if (selectedMethod === 'CreditCard') {
                const cardNumber = document.querySelector('input[name="cardNumber"]').value.replace(/\s/g, '');
                const expiry = document.querySelector('input[name="expiryDate"]').value;
                const cvv = document.querySelector('input[name="cvv"]').value;
                const cardName = document.querySelector('input[name="cardName"]').value;

                if (!validateCardNumber(cardNumber)) {
                    alert('Please enter a valid card number');
                    return false;
                }

                if (!validateExpiryDate(expiry)) {
                    alert('Please enter a valid expiry date (MM/YY)');
                    return false;
                }

                if (cvv.length < 3) {
                    alert('Please enter a valid CVV');
                    return false;
                }

                if (!cardName.trim()) {
                    alert('Please enter card holder name');
                    return false;
                }
            } else if (selectedMethod === 'PayPal') {
                const paypalEmail = document.querySelector('input[name="paypalEmail"]').value;
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                if (!emailRegex.test(paypalEmail)) {
                    alert('Please enter a valid PayPal email address');
                    return false;
                }
            }

            return true;
        }

        function validateCardNumber(cardNumber) {
            return cardNumber.length >= 13 && cardNumber.length <= 19;
        }

        function validateExpiryDate(expiry) {
            const regex = /^(0[1-9]|1[0-2])\/([0-9]{2})$/;
            if (!regex.test(expiry)) return false;

            const [month, year] = expiry.split('/');
            const now = new Date();
            const currentYear = now.getFullYear() % 100;
            const currentMonth = now.getMonth() + 1;

            return parseInt(year) > currentYear ||
                (parseInt(year) === currentYear && parseInt(month) >= currentMonth);
        }
    });
</script>
</body>
</html>