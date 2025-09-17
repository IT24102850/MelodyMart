<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Checkout | Melody Mart</title>
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
            --success: #00ff8c;
            --warning: #ffcc00;
            --error: #ff3860;
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
            overflow-x: hidden;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: linear-gradient(rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.85)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-attachment: fixed;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        header {
            background: rgba(10, 10, 10, 0.95);
            padding: 20px 0;
            backdrop-filter: blur(10px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.5);
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
        }

        .logo i {
            margin-right: 10px;
            font-size: 32px;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px 0;
        }

        .page-title {
            text-align: center;
            font-family: 'Playfair Display', serif;
            font-size: 36px;
            margin-bottom: 40px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .checkout-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

        @media (max-width: 968px) {
            .checkout-container {
                grid-template-columns: 1fr;
            }
        }

        /* Payment Cards */
        .payment-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .payment-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(138, 43, 226, 0.2);
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            margin-right: 15px;
        }

        .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 700;
        }

        /* Forms */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-secondary);
        }

        .form-control {
            width: 100%;
            padding: 15px;
            background: var(--secondary);
            border: 1px solid var(--glass-border);
            border-radius: 10px;
            color: var(--text);
            font-family: 'Montserrat', sans-serif;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.3);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        /* Payment Methods */
        .payment-methods {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-bottom: 20px;
        }

        .payment-method {
            background: var(--secondary);
            border: 1px solid var(--glass-border);
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-method:hover {
            border-color: var(--primary-light);
            transform: translateY(-3px);
        }

        .payment-method.active {
            border-color: var(--primary-light);
            background: rgba(138, 43, 226, 0.1);
            transform: translateY(-3px);
        }

        .payment-method i {
            font-size: 24px;
            margin-bottom: 8px;
            color: var(--primary-light);
        }

        .payment-method.active i {
            color: var(--accent);
        }

        /* Order Summary */
        .order-summary {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 20px;
            font-weight: 700;
            margin: 20px 0;
            padding-top: 15px;
            border-top: 1px solid var(--glass-border);
        }

        .product-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .product-image {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 24px;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .product-price {
            color: var(--primary-light);
            font-weight: 700;
        }

        /* Buttons */
        .btn {
            display: inline-block;
            padding: 15px 25px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            border: none;
            font-family: 'Montserrat', sans-serif;
            width: 100%;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn-primary:before {
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

        .btn-primary:hover:before {
            width: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--primary-light);
            color: var(--text);
            margin-top: 15px;
        }

        .btn-outline:hover {
            background: var(--primary-light);
            color: white;
        }

        /* Security Badge */
        .security-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .security-badge i {
            color: var(--success);
            margin-right: 10px;
            font-size: 18px;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-in {
            animation: fadeIn 0.6s ease forwards;
        }

        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }

        /* Footer */
        footer {
            background: #0a0a0a;
            padding: 40px 0 20px;
            border-top: 1px solid var(--glass-border);
            margin-top: auto;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 30px;
        }

        .copyright {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #1e1e1e;
            color: var(--text-secondary);
            font-size: 14px;
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <div class="container nav-container">
        <div class="logo">
            <i class="fas fa-music"></i>
            Melody Mart
        </div>
    </div>
</header>

<!-- Main Content -->
<main class="main-content">
    <div class="container">
        <h1 class="page-title animate-in">Secure Checkout</h1>

        <div class="checkout-container">
            <!-- Payment Method Section -->
            <div class="payment-card animate-in delay-1">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-credit-card"></i>
                    </div>
                    <h2 class="card-title">Payment Method</h2>
                </div>

                <div class="payment-methods">
                    <div class="payment-method active">
                        <i class="fab fa-cc-visa"></i>
                        <div>Visa</div>
                    </div>
                    <div class="payment-method">
                        <i class="fab fa-cc-mastercard"></i>
                        <div>Mastercard</div>
                    </div>
                    <div class="payment-method">
                        <i class="fab fa-cc-amex"></i>
                        <div>Amex</div>
                    </div>
                    <div class="payment-method">
                        <i class="fab fa-paypal"></i>
                        <div>PayPal</div>
                    </div>
                </div>

                <form id="payment-form">
                    <div class="form-group">
                        <label for="cardNumber">Card Number</label>
                        <input type="text" id="cardNumber" class="form-control" placeholder="1234 5678 9012 3456" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="expiryDate">Expiry Date</label>
                            <input type="text" id="expiryDate" class="form-control" placeholder="MM/YY" required>
                        </div>

                        <div class="form-group">
                            <label for="cvv">CVV</label>
                            <input type="text" id="cvv" class="form-control" placeholder="123" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="cardName">Name on Card</label>
                        <input type="text" id="cardName" class="form-control" placeholder="John Doe" required>
                    </div>

                    <div class="form-group">
                        <label for="country">Country</label>
                        <select id="country" class="form-control" required>
                            <option value="">Select Country</option>
                            <option value="US">United States</option>
                            <option value="CA">Canada</option>
                            <option value="UK">United Kingdom</option>
                            <option value="AU">Australia</option>
                            <option value="DE">Germany</option>
                            <option value="FR">France</option>
                            <option value="SL">Sri Lanka</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="zipCode">ZIP / Postal Code</label>
                        <input type="text" id="zipCode" class="form-control" placeholder="12345" required>
                    </div>

                    <div class="security-badge">
                        <i class="fas fa-lock"></i>
                        <span>Your payment details are securely encrypted</span>
                    </div>
                </form>
            </div>

            <!-- Order Summary Section -->
            <div class="order-summary animate-in delay-2">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-receipt"></i>
                    </div>
                    <h2 class="card-title">Order Summary</h2>
                </div>

                <div class="product-item">
                    <div class="product-image">
                        <i class="fas fa-guitar"></i>
                    </div>
                    <div class="product-info">
                        <div class="product-name">Professional Electric Guitar</div>
                        <div class="product-price">$1,299.99</div>
                    </div>
                </div>

                <div class="product-item">
                    <div class="product-image">
                        <i class="fas fa-drum"></i>
                    </div>
                    <div class="product-info">
                        <div class="product-name">Premium Drum Set</div>
                        <div class="product-price">$2,499.99</div>
                    </div>
                </div>

                <div class="summary-item">
                    <span>Subtotal</span>
                    <span>$3,799.98</span>
                </div>

                <div class="summary-item">
                    <span>Shipping</span>
                    <span>FREE</span>
                </div>

                <div class="summary-item">
                    <span>Tax</span>
                    <span>$265.99</span>
                </div>

                <div class="summary-total">
                    <span>Total</span>
                    <span>$4,065.97</span>
                </div>

                <button class="btn btn-primary" id="pay-now-btn">
                    <i class="fas fa-lock"></i> Pay Now
                </button>

                <button class="btn btn-outline">
                    <i class="fas fa-arrow-left"></i> Continue Shopping
                </button>

                <div class="security-badge">
                    <i class="fas fa-shield-alt"></i>
                    <span>30-day money-back guarantee</span>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-column">
                <h3>Melody Mart</h3>
                <p>Your premier destination for high-quality musical instruments and professional audio equipment.</p>
            </div>

            <div class="footer-column">
                <h3>Contact Info</h3>
                <p>Email: support@melodymart.com</p>
                <p>Phone: +1 (555) 123-4567</p>
                <p>Address: 123 Music Street, Melody City</p>
            </div>

            <div class="footer-column">
                <h3>Security</h3>
                <p>All transactions are secure and encrypted. We never store your payment details.</p>
            </div>
        </div>

        <div class="copyright">
            &copy; 2025 Melody Mart. All rights reserved.
        </div>
    </div>
</footer>

<script>
    // Payment method selection
    const paymentMethods = document.querySelectorAll('.payment-method');
    paymentMethods.forEach(method => {
        method.addEventListener('click', () => {
            paymentMethods.forEach(m => m.classList.remove('active'));
            method.classList.add('active');
        });
    });

    // Form validation and submission
    document.getElementById('pay-now-btn').addEventListener('click', function(e) {
        e.preventDefault();

        // Simple validation
        const cardNumber = document.getElementById('cardNumber').value;
        const expiryDate = document.getElementById('expiryDate').value;
        const cvv = document.getElementById('cvv').value;
        const cardName = document.getElementById('cardName').value;
        const country = document.getElementById('country').value;
        const zipCode = document.getElementById('zipCode').value;

        if (!cardNumber || !expiryDate || !cvv || !cardName || !country || !zipCode) {
            alert('Please fill in all required fields');
            return;
        }

        // Simulate payment processing
        this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
        this.disabled = true;

        // Simulate API call
        setTimeout(() => {
            alert('Payment successful! Thank you for your purchase.');
            this.innerHTML = '<i class="fas fa-check"></i> Payment Successful';
            this.style.background = 'var(--success)';
        }, 2000);
    });

    // Input formatting
    document.getElementById('cardNumber').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 0) {
            value = value.match(new RegExp('.{1,4}', 'g')).join(' ');
        }
        e.target.value = value;
    });

    document.getElementById('expiryDate').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 2) {
            value = value.substring(0, 2) + '/' + value.substring(2, 4);
        }
        e.target.value = value;
    });
</script>
</body>
</html>