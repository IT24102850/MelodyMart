<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary - Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        /* Your existing CSS styles remain unchanged */
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
            position: relative;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header */
        header {
            background: rgba(10, 10, 10, 0.95);
            padding: 20px 0;
            backdrop-filter: blur(10px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.5);
            margin-bottom: 30px;
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
            padding: 20px 0;
        }

        .page-title {
            text-align: center;
            font-family: 'Playfair Display', serif;
            font-size: 36px;
            margin-bottom: 40px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
        }

        .page-title:after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--gradient);
            border-radius: 2px;
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

        /* Order Summary Card */
        .order-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .order-card:hover {
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

        /* Product Items */
        .product-item {
            display: flex;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--glass-border);
        }

        .product-image {
            width: 80px;
            height: 80px;
            border-radius: 10px;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .product-desc {
            color: var(--text-secondary);
            font-size: 14px;
            margin-bottom: 8px;
        }

        .product-price {
            color: var(--primary-light);
            font-weight: 700;
        }

        .product-price s {
            color: var(--text-secondary);
            font-size: 14px;
            margin-right: 10px;
        }

        /* Summary Items */
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 22px;
            font-weight: 700;
            margin: 25px 0;
            padding-top: 15px;
            border-top: 1px solid var(--glass-border);
        }

        .total-amount {
            color: var(--accent);
            font-size: 24px;
        }

        /* Payment Details - IMPROVED SECTION */
        .payment-details {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            position: relative;
            overflow: hidden;
        }

        .payment-details::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient);
        }

        .payment-method {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
            padding: 15px;
            background: rgba(40, 40, 40, 0.5);
            border-radius: 12px;
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .payment-method:hover {
            border-color: var(--primary-light);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.2);
        }

        .payment-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            margin-right: 15px;
        }

        .payment-info h3 {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .payment-info p {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Improved Form Styles */
        .form-section {
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--glass-border);
        }

        .form-section-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .form-section-title i {
            margin-right: 10px;
            color: var(--primary-light);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
        }

        .form-label i {
            margin-right: 8px;
            font-size: 14px;
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

        .form-control:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .input-with-icon {
            position: relative;
        }

        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }

        .form-hint {
            font-size: 12px;
            color: var(--text-secondary);
            margin-top: 5px;
            display: flex;
            align-items: center;
        }

        .form-hint i {
            margin-right: 5px;
        }

        .save-info {
            display: flex;
            align-items: center;
            margin: 20px 0;
        }

        .save-info input {
            margin-right: 10px;
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
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
            position: relative;
            overflow: hidden;
            z-index: 1;
            width: 100%;
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
            width: 100%;
        }

        .btn-outline:hover {
            background: var(--primary-light);
            color: white;
        }

        .btn-group {
            display: flex;
            gap: 15px;
        }

        .btn-group .btn {
            width: 50%;
        }

        /* Security Badge */
        .security-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
            color: var(--text-secondary);
            font-size: 14px;
            padding: 15px;
            background: rgba(40, 40, 40, 0.5);
            border-radius: 10px;
            border: 1px solid var(--glass-border);
        }

        .security-badge i {
            color: var(--success);
            margin-right: 10px;
            font-size: 18px;
        }

        /* Order Status */
        .order-status {
            display: flex;
            justify-content: space-between;
            margin: 25px 0;
            position: relative;
        }

        .status-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
        }

        .status-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--secondary);
            border: 2px solid var(--glass-border);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
            position: relative;
        }

        .status-icon.active {
            background: var(--gradient);
            border-color: var(--primary-light);
        }

        .status-icon.completed {
            background: var(--success);
            border-color: var(--success);
        }

        .status-label {
            font-size: 12px;
            color: var(--text-secondary);
            text-align: center;
        }

        .status-label.active {
            color: var(--accent);
            font-weight: 600;
        }

        .status-connector {
            position: absolute;
            top: 20px;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--glass-border);
            z-index: 1;
        }

        .status-connector.completed {
            background: var(--success);
        }

        /* Payment Method Selector */
        .payment-methods {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-bottom: 20px;
        }

        .payment-option {
            background: var(--secondary);
            border: 1px solid var(--glass-border);
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-option:hover {
            border-color: var(--primary-light);
            transform: translateY(-3px);
        }

        .payment-option.active {
            border-color: var(--primary-light);
            background: rgba(138, 43, 226, 0.1);
            transform: translateY(-3px);
        }

        .payment-option i {
            font-size: 24px;
            margin-bottom: 8px;
            color: var(--primary-light);
        }

        .payment-option.active i {
            color: var(--accent);
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
            margin-top: 40px;
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

        /* Quantity Controls */
        .quantity-controls {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .quantity-btn {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: var(--secondary);
            border: 1px solid var(--glass-border);
            color: var(--text);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .quantity-btn:hover {
            background: var(--primary-light);
        }

        .quantity-input {
            width: 40px;
            text-align: center;
            margin: 0 10px;
            background: transparent;
            border: none;
            color: var(--text);
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .btn-group {
                flex-direction: column;
            }

            .btn-group .btn {
                width: 100%;
            }

            .payment-methods {
                grid-template-columns: repeat(2, 1fr);
            }
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
        <h1 class="page-title animate-in">Order Summary</h1>

        <!-- Order Status -->
        <div class="order-status animate-in delay-1">
            <div class="status-connector completed" style="width: 33%;"></div>
            <div class="status-connector" style="width: 34%; left: 33%;"></div>
            <div class="status-connector" style="width: 33%; left: 67%;"></div>

            <div class="status-step">
                <div class="status-icon completed">
                    <i class="fas fa-check"></i>
                </div>
                <div class="status-label completed">Order Placed</div>
            </div>

            <div class="status-step">
                <div class="status-icon active">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="status-label active">Payment</div>
            </div>

            <div class="status-step">
                <div class="status-icon">
                    <i class="fas fa-truck"></i>
                </div>
                <div class="status-label">Delivery</div>
            </div>
        </div>

        <div class="checkout-container">
            <!-- Order Summary -->
            <div class="order-card animate-in delay-2">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-receipt"></i>
                    </div>
                    <h2 class="card-title">Order Details</h2>
                </div>

                <div id="order-items-container">
                    <!-- Order items will be dynamically inserted here -->
                </div>

                <div class="summary-item">
                    <span>Subtotal (<span id="total-items">0</span> items)</span>
                    <span id="subtotal-amount">Rs. 0.00</span>
                </div>

                <div class="summary-item">
                    <span>Delivery Fee</span>
                    <span id="delivery-fee">Rs. 199.00</span>
                </div>

                <div class="summary-item">
                    <span>Discount</span>
                    <span id="discount-amount" style="color: var(--success);">- Rs. 0.00</span>
                </div>

                <div class="summary-item">
                    <span>Tax</span>
                    <span id="tax-amount">Rs. 0.00</span>
                </div>

                <div class="summary-total">
                    <span>Total</span>
                    <span class="total-amount" id="total-amount">Rs. 0.00</span>
                </div>

                <div class="security-badge">
                    <i class="fas fa-lock"></i>
                    <span>Your order is secured with SSL encryption</span>
                </div>
            </div>

            <!-- Payment Details - IMPROVED SECTION -->
            <div class="payment-details animate-in delay-3">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-credit-card"></i>
                    </div>
                    <h2 class="card-title">Payment Details</h2>
                </div>

                <!-- Payment Method Selection -->
                <div class="form-section">
                    <h3 class="form-section-title"><i class="fas fa-credit-card"></i> Payment Method</h3>
                    <div class="payment-methods">
                        <div class="payment-option active">
                            <i class="fab fa-cc-visa"></i>
                            <div>Visa</div>
                        </div>
                        <div class="payment-option">
                            <i class="fab fa-cc-mastercard"></i>
                            <div>Mastercard</div>
                        </div>
                        <div class="payment-option">
                            <i class="fab fa-cc-amex"></i>
                            <div>Amex</div>
                        </div>
                        <div class="payment-option">
                            <i class="fab fa-paypal"></i>
                            <div>PayPal</div>
                        </div>
                    </div>
                </div>

                <!-- Card Details -->
                <div class="form-section">
                    <h3 class="form-section-title"><i class="fas fa-id-card"></i> Card Details</h3>
                    <div class="payment-method" id="current-card">
                        <div class="payment-icon">
                            <i class="fab fa-cc-visa"></i>
                        </div>
                        <div class="payment-info">
                            <h3>Visa ending in 4567</h3>
                            <p>Expires: 12/25</p>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label" for="cardNumber"><i class="fas fa-credit-card"></i> Card Number</label>
                        <div class="input-with-icon">
                            <input type="text" id="cardNumber" class="form-control" value="**** **** **** 4567" readonly>
                            <span class="input-icon"><i class="fas fa-pen"></i></span>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="expiryDate"><i class="fas fa-calendar-alt"></i> Expiry Date</label>
                            <input type="text" id="expiryDate" class="form-control" value="12/25" readonly>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="cvv"><i class="fas fa-lock"></i> CVV</label>
                            <div class="input-with-icon">
                                <input type="text" id="cvv" class="form-control" value="***" readonly>
                                <span class="input-icon"><i class="fas fa-eye"></i></span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Billing Address -->
                <div class="form-section">
                    <h3 class="form-section-title"><i class="fas fa-map-marker-alt"></i> Billing Address</h3>

                    <div class="form-group full-width">
                        <label class="form-label" for="cardName"><i class="fas fa-user"></i> Name on Card</label>
                        <input type="text" id="cardName" class="form-control" value="John Doe" readonly>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label" for="billingAddress"><i class="fas fa-home"></i> Billing Address</label>
                        <input type="text" id="billingAddress" class="form-control" value="Building 12, High St, Colombo 03" readonly>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="city"><i class="fas fa-city"></i> City</label>
                            <input type="text" id="city" class="form-control" value="Colombo" readonly>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="zipCode"><i class="fas fa-mail-bulk"></i> ZIP Code</label>
                            <input type="text" id="zipCode" class="form-control" value="00300" readonly>
                        </div>
                    </div>
                </div>

                <!-- Contact Information -->
                <div class="form-section" style="border-bottom: none;">
                    <h3 class="form-section-title"><i class="fas fa-address-book"></i> Contact Information</h3>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="email"><i class="fas fa-envelope"></i> Email Address</label>
                            <input type="email" id="email" class="form-control" value="john.doe@example.com" readonly>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="phone"><i class="fas fa-phone"></i> Phone Number</label>
                            <input type="tel" id="phone" class="form-control" value="+94 123 456 789" readonly>
                        </div>
                    </div>

                    <div class="save-info">
                        <input type="checkbox" id="savePayment" checked>
                        <label for="savePayment">Save payment information for next time</label>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="btn-group">
                    <button class="btn btn-primary" id="pay-now-btn">
                        <i class="fas fa-lock"></i> Confirm Payment
                    </button>

                    <button class="btn btn-outline" id="edit-payment-btn">
                        <i class="fas fa-edit"></i> Edit Details
                    </button>
                </div>

                <div class="security-badge">
                    <i class="fas fa-shield-alt"></i>
                    <span>All transactions are secure and encrypted with 256-bit SSL</span>
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
                <p>Phone: +94 11 234 5678</p>
                <p>Address: 123 Music Street, Colombo 03, Sri Lanka</p>
            </div>

            <div class="footer-column">
                <h3>Order Support</h3>
                <p>Need help with your order?</p>
                <p>Call us: +94 11 234 5678</p>
                <p>Email: orders@melodymart.com</p>
            </div>
        </div>

        <div class="copyright">
            &copy; 2025 Melody Mart. All rights reserved.
        </div>
    </div>
</footer>

<script>
    // Sample instrument data - This would typically come from your backend/database
    const instrumentTable = [
        {
            id: 1,
            name: "Professional Electric Guitar",
            description: "Premium crafted with exceptional tone and playability",
            originalPrice: 1499.99,
            salePrice: 1299.99,
            icon: "guitar",
            color: "Sunburst",
            category: "String"
        },
        {
            id: 2,
            name: "Premium Drum Set",
            description: "Professional 7-piece drum kit with hardware",
            originalPrice: 2699.99,
            salePrice: 2499.99,
            icon: "drum",
            size: "Standard",
            category: "Percussion"
        },
        {
            id: 3,
            name: "Digital Piano",
            description: "88-key weighted keyboard with authentic piano sound",
            originalPrice: 1899.99,
            salePrice: 1599.99,
            icon: "piano",
            color: "Black",
            category: "Keyboard"
        },
        {
            id: 4,
            name: "Violin",
            description: "Handcrafted violin with bow and case",
            originalPrice: 899.99,
            salePrice: 799.99,
            icon: "violin",
            size: "4/4",
            category: "String"
        },
        {
            id: 5,
            name: "Saxophone",
            description: "Professional alto saxophone with rich tone",
            originalPrice: 2199.99,
            salePrice: 1999.99,
            icon: "saxophone",
            color: "Gold Lacquer",
            category: "Wind"
        }
    ];

    // Cart data - This would typically come from your shopping cart
    // For demo purposes, we'll use a sample cart with some items
    let cartItems = [
        { instrumentId: 1, quantity: 1 },
        { instrumentId: 2, quantity: 1 },
        { instrumentId: 3, quantity: 2 }
    ];

    // Constants for calculations
    const DELIVERY_FEE = 199.00;
    const TAX_RATE = 0.07; // 7% tax

    // Function to calculate order totals
    function calculateOrderTotals() {
        let subtotal = 0;
        let totalDiscount = 0;
        let totalItems = 0;

        // Calculate subtotal and discounts
        cartItems.forEach(cartItem => {
            const instrument = instrumentTable.find(item => item.id === cartItem.instrumentId);
            if (instrument) {
                subtotal += instrument.salePrice * cartItem.quantity;
                totalDiscount += (instrument.originalPrice - instrument.salePrice) * cartItem.quantity;
                totalItems += cartItem.quantity;
            }
        });

        // Calculate tax and total
        const tax = subtotal * TAX_RATE;
        const total = subtotal + DELIVERY_FEE + tax;

        // Update the UI
        document.getElementById('total-items').textContent = totalItems;
        document.getElementById('subtotal-amount').textContent = `Rs. ${subtotal.toFixed(2)}`;
        document.getElementById('delivery-fee').textContent = `Rs. ${DELIVERY_FEE.toFixed(2)}`;
        document.getElementById('discount-amount').textContent = `- Rs. ${totalDiscount.toFixed(2)}`;
        document.getElementById('tax-amount').textContent = `Rs. ${tax.toFixed(2)}`;
        document.getElementById('total-amount').textContent = `Rs. ${total.toFixed(2)}`;
    }

    // Function to render order items
    function renderOrderItems() {
        const container = document.getElementById('order-items-container');
        container.innerHTML = '';

        cartItems.forEach(cartItem => {
            const instrument = instrumentTable.find(item => item.id === cartItem.instrumentId);
            if (instrument) {
                const discountPercent = Math.round((1 - (instrument.salePrice / instrument.originalPrice)) * 100);

                const itemElement = document.createElement('div');
                itemElement.className = 'product-item';
                itemElement.innerHTML = `
                    <div class="product-image">
                        <i class="fas fa-${instrument.icon}"></i>
                    </div>
                    <div class="product-info">
                        <h3 class="product-name">${instrument.name}</h3>
                        <p class="product-desc">${instrument.description}</p>
                        <div class="product-price">
                            <s>Rs. ${instrument.originalPrice.toFixed(2)}</s> Rs. ${instrument.salePrice.toFixed(2)}
                            <span style="color: var(--success); margin-left: 10px;">(-${discountPercent}%)</span>
                        </div>
                        <p class="product-meta">Qty: ${cartItem.quantity} ${instrument.color ? '| Color: ' + instrument.color : ''} ${instrument.size ? '| Size: ' + instrument.size : ''}</p>
                        <div class="quantity-controls">
                            <button class="quantity-btn decrease-btn" data-id="${instrument.id}">-</button>
                            <input type="text" class="quantity-input" value="${cartItem.quantity}" data-id="${instrument.id}" readonly>
                            <button class="quantity-btn increase-btn" data-id="${instrument.id}">+</button>
                        </div>
                    </div>
                `;
                container.appendChild(itemElement);
            }
        });

        // Add event listeners for quantity controls
        document.querySelectorAll('.increase-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const id = parseInt(this.getAttribute('data-id'));
                const cartItem = cartItems.find(item => item.instrumentId === id);
                if (cartItem) {
                    cartItem.quantity++;
                    renderOrderItems();
                    calculateOrderTotals();
                }
            });
        });

        document.querySelectorAll('.decrease-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const id = parseInt(this.getAttribute('data-id'));
                const cartItem = cartItems.find(item => item.instrumentId === id);
                if (cartItem && cartItem.quantity > 1) {
                    cartItem.quantity--;
                    renderOrderItems();
                    calculateOrderTotals();
                }
            });
        });
    }

    // Initialize the page
    document.addEventListener('DOMContentLoaded', function() {
        renderOrderItems();
        calculateOrderTotals();

        // Payment confirmation
        document.getElementById('pay-now-btn').addEventListener('click', function(e) {
            e.preventDefault();

            // Simulate payment processing
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            this.disabled = true;

            // Simulate API call
            setTimeout(() => {
                alert('Payment successful! Your order is now being processed.');
                this.innerHTML = '<i class="fas fa-check"></i> Payment Successful';
                this.style.background = 'var(--success)';

                // Update order status
                document.querySelectorAll('.status-step')[2].querySelector('.status-icon').classList.add('completed');
                document.querySelectorAll('.status-connector')[1].classList.add('completed');
                document.querySelectorAll('.status-step')[1].querySelector('.status-icon').classList.remove('active');
                document.querySelectorAll('.status-step')[1].querySelector('.status-icon').classList.add('completed');
                document.querySelectorAll('.status-step')[2].querySelector('.status-label').classList.add('active');
            }, 2000);
        });

        // Payment method selection
        const paymentOptions = document.querySelectorAll('.payment-option');
        paymentOptions.forEach(option => {
            option.addEventListener('click', () => {
                paymentOptions.forEach(o => o.classList.remove('active'));
                option.classList.add('active');

                // Update card display
                const cardType = option.querySelector('i').classList[1];
                const cardIcon = document.querySelector('#current-card .payment-icon i');
                cardIcon.className = '';
                cardIcon.classList.add('fab', cardType);

                document.querySelector('#current-card .payment-info h3').textContent =
                    option.querySelector('div').textContent + ' ending in 4567';
            });
        });

        // Edit payment details
        document.getElementById('edit-payment-btn').addEventListener('click', function(e) {
            e.preventDefault();
            alert('Edit payment feature would open a form to update payment details.');
        });

        // CVV eye icon functionality
        document.querySelector('#cvv + .input-icon').addEventListener('click', function() {
            const cvvInput = document.getElementById('cvv');
            const eyeIcon = this.querySelector('i');

            if (cvvInput.type === 'password') {
                cvvInput.type = 'text';
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            } else {
                cvvInput.type = 'password';
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            }
        });
    });
</script>
</body>
</html>