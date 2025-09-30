<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
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
            background-image:
                    radial-gradient(circle at 20% 80%, rgba(138, 43, 226, 0.1) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, rgba(0, 229, 255, 0.1) 0%, transparent 50%);
        }

        .payment-container {
            width: 100%;
            max-width: 480px;
            margin: 0 auto;
        }

        .payment-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 40px 35px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: hidden;
        }

        .payment-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient);
        }

        .payment-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .payment-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 8px;
        }

        .payment-header p {
            color: var(--text-secondary);
            font-size: 14px;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 24px;
            position: relative;
        }

        .form-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--text);
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control, .form-select {
            width: 100%;
            padding: 16px 18px;
            border: 1px solid var(--glass-border);
            background: rgba(10, 10, 10, 0.8);
            color: var(--text);
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.2);
            background: rgba(10, 10, 10, 0.9);
            transform: translateY(-2px);
        }

        .form-control::placeholder {
            color: var(--text-secondary);
            opacity: 0.7;
        }

        .input-icon {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 16px;
        }

        .btn-pay {
            width: 100%;
            background: var(--gradient);
            color: white;
            border: none;
            padding: 18px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            z-index: 1;
            margin-top: 10px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
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
            box-shadow: 0 12px 25px rgba(138, 43, 226, 0.4);
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
            margin-top: 25px;
            color: var(--text-secondary);
            font-size: 13px;
            padding: 15px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            border: 1px solid var(--glass-border);
        }

        .security-notice i {
            color: var(--accent);
            font-size: 16px;
        }

        .message {
            margin-top: 20px;
            padding: 18px;
            border-radius: 12px;
            text-align: center;
            font-weight: 600;
            display: none;
            animation: slideIn 0.5s ease-out;
        }

        .success-msg {
            background: rgba(0, 204, 102, 0.15);
            border: 1px solid var(--success);
            color: var(--success);
        }

        .error-msg {
            background: rgba(255, 51, 102, 0.15);
            border: 1px solid var(--error);
            color: var(--error);
        }

        .redirect-msg {
            background: rgba(138, 43, 226, 0.15);
            border: 1px solid var(--primary);
            color: var(--primary-light);
        }

        .payment-methods {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 10px;
        }

        .payment-method {
            padding: 14px;
            border: 2px solid var(--glass-border);
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: rgba(10, 10, 10, 0.6);
            font-weight: 600;
            font-size: 14px;
        }

        .payment-method:hover {
            border-color: var(--primary-light);
            background: rgba(138, 43, 226, 0.1);
            transform: translateY(-2px);
        }

        .payment-method.selected {
            border-color: var(--primary-light);
            background: rgba(138, 43, 226, 0.15);
            color: var(--primary-light);
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
            font-size: 18px;
            color: rgba(138, 43, 226, 0.08);
            animation: float 8s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes successPulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
            margin-right: 10px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        @media (max-width: 576px) {
            .payment-card {
                padding: 30px 25px;
            }

            .payment-header h2 {
                font-size: 28px;
            }

            .payment-methods {
                grid-template-columns: 1fr;
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

        <!-- Payment Form -->
        <form id="paymentForm" action="payment-gateway.jsp" method="post">
            <div class="form-group">
                <label class="form-label">Order ID</label>
                <input type="number" class="form-control" name="orderId" placeholder="Enter Order ID" required>
                <i class="fas fa-receipt input-icon"></i>
            </div>

            <div class="form-group">
                <label class="form-label">Amount ($)</label>
                <input type="text" class="form-control" name="amount" placeholder="0.00" required>
                <i class="fas fa-dollar-sign input-icon"></i>
            </div>

            <div class="form-group">
                <label class="form-label">Payment Method</label>
                <div class="payment-methods">
                    <div class="payment-method" data-value="Visa">Visa</div>
                    <div class="payment-method" data-value="MasterCard">MasterCard</div>
                    <div class="payment-method" data-value="Amex">Amex</div>
                    <div class="payment-method" data-value="PayPal">PayPal</div>
                </div>
                <select class="form-select" name="paymentMethod" required style="display: none;">
                    <option value="Visa">Visa</option>
                    <option value="MasterCard">MasterCard</option>
                    <option value="Amex">Amex</option>
                    <option value="PayPal">PayPal</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label">CVV</label>
                <input type="text" class="form-control" name="cvv" placeholder="123" maxlength="3" required>
                <i class="fas fa-lock input-icon"></i>
            </div>

            <button type="submit" class="btn-pay" id="submitBtn">
                <i class="fas fa-lock"></i> Pay Now
            </button>

            <div class="security-notice">
                <i class="fas fa-shield-alt"></i>
                <span>Your payment information is secure and encrypted</span>
            </div>
        </form>

        <%
            // Handle form submission
            String orderId = request.getParameter("orderId");
            String amount = request.getParameter("amount");
            String paymentMethod = request.getParameter("paymentMethod");
            String cvv = request.getParameter("cvv");

            if(orderId != null && amount != null && paymentMethod != null && cvv != null){
                Connection conn = null;
                PreparedStatement ps = null;

                try {
                    conn = DBConnection.getConnection();

                    // Generate unique transaction ID
                    String txnId = "TXN" + (new java.util.Random().nextInt(9000) + 1000);

                    String sql = "INSERT INTO Payment (OrderID, PaymentDate, Amount, PaymentMethod, TransactionID, CVV, Status) VALUES (?,?,?,?,?,?,?)";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(orderId));
                    ps.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis()));
                    ps.setDouble(3, Double.parseDouble(amount));
                    ps.setString(4, paymentMethod);
                    ps.setString(5, txnId);
                    ps.setInt(6, Integer.parseInt(cvv));
                    ps.setString(7, "Paid"); // Set status as Paid for successful payment

                    int rows = ps.executeUpdate();
                    if(rows > 0){
                        // Show success message
                        out.println("<div class='success-msg' style='display: block;'>");
                        out.println("<i class='fas fa-check-circle'></i> Payment Successful!<br>");
                        out.println("<small>Transaction ID: " + txnId + "</small>");
                        out.println("</div>");

                        // Show redirect message
                        out.println("<div class='redirect-msg' style='display: block; margin-top: 15px;'>");
                        out.println("<i class='fas fa-redo'></i> Redirecting to dashboard...");
                        out.println("</div>");

                        // JavaScript redirect after 3 seconds
                        out.println("<script>");
                        out.println("setTimeout(function() {");
                        out.println("   window.location.href = 'customerlanding.jsp';");
                        out.println("}, 3000);");
                        out.println("</script>");
                    } else {
                        out.println("<div class='error-msg' style='display: block;'>");
                        out.println("<i class='fas fa-exclamation-circle'></i> Payment failed. Please try again.");
                        out.println("</div>");
                    }
                } catch (Exception e) {
                    out.println("<div class='error-msg' style='display: block;'>");
                    out.println("<i class='fas fa-exclamation-triangle'></i> Error: " + e.getMessage());
                    out.println("</div>");
                } finally {
                    if(ps != null) try { ps.close(); } catch (Exception ignored) {}
                    if(conn != null) try { conn.close(); } catch (Exception ignored) {}
                }
            }
        %>

        <div class="floating-icons">
            <i class="floating-icon" style="top: 15%; left: 8%; animation-delay: 0s;">💳</i>
            <i class="floating-icon" style="top: 25%; right: 12%; animation-delay: 2s;">💰</i>
            <i class="floating-icon" style="top: 75%; left: 12%; animation-delay: 4s;">🔒</i>
            <i class="floating-icon" style="top: 65%; right: 8%; animation-delay: 6s;">⚡</i>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const paymentMethods = document.querySelectorAll('.payment-method');
        const paymentSelect = document.querySelector('select[name="paymentMethod"]');
        const form = document.getElementById('paymentForm');
        const submitBtn = document.getElementById('submitBtn');

        // Payment method selection
        paymentMethods.forEach(method => {
            method.addEventListener('click', function() {
                paymentMethods.forEach(m => m.classList.remove('selected'));
                this.classList.add('selected');
                paymentSelect.value = this.getAttribute('data-value');
            });
        });

        // Auto-select first payment method
        if (paymentMethods.length > 0) {
            paymentMethods[0].click();
        }

        // Form submission loading state
        form.addEventListener('submit', function() {
            submitBtn.innerHTML = '<span class="loading"></span> Processing...';
            submitBtn.disabled = true;

            // Add success animation to the button
            submitBtn.style.animation = 'successPulse 0.6s ease-in-out';
        });

        // Amount input formatting
        const amountInput = document.querySelector('input[name="amount"]');
        amountInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/[^\d.]/g, '');
            if ((value.match(/\./g) || []).length > 1) {
                value = value.substring(0, value.lastIndexOf('.'));
            }
            e.target.value = value;
        });

        // CVV input restriction
        const cvvInput = document.querySelector('input[name="cvv"]');
        cvvInput.addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '').substring(0, 3);
        });

        // Add floating icons
        function addFloatingIcons() {
            const icons = ['💳', '💰', '🔒', '⚡', '🎵', '💎', '🌟', '📊'];
            const container = document.querySelector('.floating-icons');

            for (let i = 0; i < 12; i++) {
                const icon = document.createElement('div');
                icon.className = 'floating-icon';
                icon.textContent = icons[Math.floor(Math.random() * icons.length)];
                icon.style.left = Math.random() * 100 + '%';
                icon.style.top = Math.random() * 100 + '%';
                icon.style.animationDelay = Math.random() * 8 + 's';
                icon.style.fontSize = (Math.random() * 12 + 14) + 'px';
                container.appendChild(icon);
            }
        }

        addFloatingIcons();

        // Check if we have a success message and animate it
        const successMsg = document.querySelector('.success-msg');
        if (successMsg && successMsg.style.display === 'block') {
            successMsg.style.animation = 'successPulse 2s ease-in-out infinite';
        }
    });
</script>
</body>
</html>