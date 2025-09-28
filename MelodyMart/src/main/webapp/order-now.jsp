<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Your Order | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --primary-dark: #6a1cb0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --accent-alt: #ff00c8;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --text-light: #e0e0e0;
            --card-bg: #1a1a1a;
            --card-hover: #2a2a2a;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
            --glass-bg: rgba(30, 30, 30, 0.7);
            --glass-border: rgba(255, 255, 255, 0.1);
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --radius-lg: 16px;
            --radius-md: 12px;
            --radius-sm: 8px;
            --shadow: 0 10px 40px rgba(0, 0, 0, 0.4);
            --shadow-hover: 0 15px 50px rgba(138, 43, 226, 0.3);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 50%, #16213e 100%);
            color: var(--text);
            min-height: 100vh;
            line-height: 1.6;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 30px;
            max-width: 1300px;
            width: 100%;
            margin: 0 auto;
        }

        /* Order Form Container */
        .order-form-container {
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            padding: 40px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .order-form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient);
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.8rem;
            font-weight: 800;
            margin-bottom: 8px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            line-height: 1.2;
            text-align: center;
        }

        .page-subtitle {
            color: var(--text-light);
            margin-bottom: 35px;
            font-size: 1.1rem;
            font-weight: 400;
            text-align: center;
            opacity: 0.9;
        }

        /* Form Sections */
        .form-section {
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0 0 25px 0;
            color: var(--primary-light);
            display: flex;
            align-items: center;
            gap: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .section-title i {
            font-size: 1.3rem;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(138, 43, 226, 0.1);
            border-radius: 50%;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            margin-bottom: 12px;
            font-weight: 600;
            color: var(--text-light);
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label .required {
            color: var(--danger);
            font-size: 1.2rem;
        }

        .input-with-icon {
            position: relative;
        }

        .form-control, .form-select {
            width: 100%;
            padding: 18px 20px;
            border-radius: var(--radius-md);
            border: 2px solid var(--glass-border);
            background: rgba(25, 25, 25, 0.8);
            color: var(--text);
            font-size: 1rem;
            transition: var(--transition);
            font-family: 'Montserrat', sans-serif;
        }

        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 4px rgba(138, 43, 226, 0.2);
            transform: translateY(-2px);
            background: rgba(30, 30, 30, 0.9);
        }

        .form-control::placeholder {
            color: var(--text-secondary);
        }

        .input-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 1.1rem;
        }

        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%239b45f0' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 20px center;
            background-size: 18px;
        }

        .radio-group {
            display: flex;
            gap: 15px;
            margin-top: 8px;
        }

        .radio-label {
            display: flex;
            align-items: center;
            cursor: pointer;
            padding: 18px 20px;
            border: 2px solid var(--glass-border);
            border-radius: var(--radius-md);
            transition: var(--transition);
            flex: 1;
            background: rgba(25, 25, 25, 0.8);
        }

        .radio-label:hover {
            border-color: var(--primary-light);
            transform: translateY(-2px);
            background: rgba(30, 30, 30, 0.9);
        }

        .radio-label input[type="radio"] {
            display: none;
        }

        .radio-label input[type="radio"]:checked + .radio-custom {
            background-color: var(--primary-light);
            border-color: var(--primary-light);
        }

        .radio-label input[type="radio"]:checked + .radio-custom:after {
            content: '';
            display: block;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: white;
            margin: 3px;
        }

        .radio-label input[type="radio"]:checked ~ .radio-text {
            color: var(--primary-light);
        }

        .radio-custom {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 2px solid var(--text-secondary);
            margin-right: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
            flex-shrink: 0;
        }

        .radio-text {
            font-weight: 500;
            transition: color 0.3s ease;
            font-size: 1rem;
        }

        /* Submit Button */
        .submit-btn {
            width: 100%;
            padding: 20px;
            border: none;
            border-radius: var(--radius-md);
            background: var(--gradient);
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            position: relative;
            overflow: hidden;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        /* Order Summary */
        .order-summary {
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            padding: 35px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
            height: fit-content;
            position: sticky;
            top: 20px;
            backdrop-filter: blur(10px);
        }

        .summary-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 25px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
        }

        .product-item {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 1px solid var(--glass-border);
        }

        .product-image {
            width: 80px;
            height: 80px;
            border-radius: var(--radius-md);
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 2rem;
            color: white;
            flex-shrink: 0;
        }

        .product-details {
            flex: 1;
        }

        .product-name {
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1.1rem;
            color: var(--text-light);
        }

        .product-price {
            color: var(--primary-light);
            font-weight: 700;
            font-size: 1.3rem;
        }

        .summary-line {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding: 10px 0;
            color: var(--text);
        }

        .summary-line .label {
            color: var(--text-secondary);
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-weight: 700;
            font-size: 1.4rem;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid var(--glass-border);
            color: var(--accent);
        }

        .secure-notice {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 25px;
            color: var(--text-light);
            font-size: 0.95rem;
            gap: 10px;
            padding: 18px;
            background: rgba(40, 167, 69, 0.1);
            border-radius: var(--radius-md);
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .secure-notice i {
            color: var(--success);
            font-size: 1.2rem;
        }

        /* Notifications */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 20px 25px;
            border-radius: var(--radius-md);
            background: var(--success);
            color: white;
            font-weight: 600;
            box-shadow: var(--shadow);
            transform: translateX(150%);
            transition: transform 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .notification.show {
            transform: translateX(0);
        }

        .error-message, .success-message {
            padding: 20px;
            border-radius: var(--radius-md);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            font-weight: 500;
            animation: slideIn 0.5s ease-out;
            border-left: 4px solid;
        }

        .error-message {
            background: rgba(220, 53, 69, 0.15);
            border-left-color: var(--danger);
            color: #ff6b6b;
        }

        .success-message {
            background: rgba(40, 167, 69, 0.15);
            border-left-color: var(--success);
            color: #28a745;
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        /* Animations */
        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .container {
                grid-template-columns: 1fr;
                gap: 25px;
            }

            .order-summary {
                position: static;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .order-form-container, .order-summary {
                padding: 30px;
            }

            .page-title {
                font-size: 2.2rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .radio-group {
                flex-direction: column;
                gap: 12px;
            }

            .section-title {
                font-size: 1.3rem;
            }
        }

        @media (max-width: 480px) {
            .order-form-container, .order-summary {
                padding: 25px 20px;
            }

            .page-title {
                font-size: 1.8rem;
            }

            .form-control, .form-select {
                padding: 16px;
            }

            .submit-btn {
                padding: 18px;
                font-size: 1rem;
            }
        }

        /* Enhanced Form Elements */
        .form-group {
            position: relative;
        }

        .form-group:focus-within .form-label {
            color: var(--primary-light);
        }

        /* Hover Effects */
        .order-form-container, .order-summary {
            transition: var(--transition);
        }

        .order-form-container:hover, .order-summary:hover {
            transform: translateY(-5px);
        }

        /* Selection Styling */
        ::selection {
            background: rgba(138, 43, 226, 0.3);
            color: white;
        }

        /* Scrollbar Styling */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--card-bg);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--primary-light);
        }
    </style>
</head>
<body>

<!-- Notification -->
<div class="notification" id="notification">
    <i class="fas fa-check-circle"></i> Order submitted successfully!
</div>

<div class="container">
    <!-- Order Form -->
    <div class="order-form-container">
        <h1 class="page-title">Complete Your Order</h1>
        <p class="page-subtitle">Please provide your delivery information to proceed with payment</p>

        <!-- Error/Success Messages -->
        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            if (error != null) {
        %>
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i>
            <%= error %>
        </div>
        <% } %>

        <% if (success != null && success.equals("true")) { %>
        <div class="success-message">
            <i class="fas fa-check-circle"></i>
            Order placed successfully! Thank you for your purchase.
        </div>
        <% } %>

        <form id="orderForm" action="${pageContext.request.contextPath}/CreateOrderServlet" method="post">
            <!-- Personal Information -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-user"></i> Personal Information
                </h3>

                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="customerName">
                            <i class="fas fa-user-circle"></i> Full Name <span class="required">*</span>
                        </label>
                        <div class="input-with-icon">
                            <input type="text" class="form-control" id="customerName" name="customerName"
                                   placeholder="Enter your full name" value="${param.customerName}" required>
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="phoneNumber">
                            <i class="fas fa-phone"></i> Phone Number <span class="required">*</span>
                        </label>
                        <div class="input-with-icon">
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber"
                                   placeholder="Enter your phone number" value="${param.phoneNumber}" required>
                            <i class="fas fa-mobile-alt input-icon"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Delivery Address -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-map-marker-alt"></i> Delivery Address
                </h3>

                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="province">
                            <i class="fas fa-globe-asia"></i> Province <span class="required">*</span>
                        </label>
                        <select class="form-select" id="province" name="province" required>
                            <option value="">Select Province</option>
                            <option value="Western" <%= "Western".equals(request.getParameter("province")) ? "selected" : "" %>>Western</option>
                            <option value="Central" <%= "Central".equals(request.getParameter("province")) ? "selected" : "" %>>Central</option>
                            <option value="Southern" <%= "Southern".equals(request.getParameter("province")) ? "selected" : "" %>>Southern</option>
                            <option value="Northern" <%= "Northern".equals(request.getParameter("province")) ? "selected" : "" %>>Northern</option>
                            <option value="Eastern" <%= "Eastern".equals(request.getParameter("province")) ? "selected" : "" %>>Eastern</option>
                            <option value="North Western" <%= "North Western".equals(request.getParameter("province")) ? "selected" : "" %>>North Western</option>
                            <option value="North Central" <%= "North Central".equals(request.getParameter("province")) ? "selected" : "" %>>North Central</option>
                            <option value="Uva" <%= "Uva".equals(request.getParameter("province")) ? "selected" : "" %>>Uva</option>
                            <option value="Sabaragamuwa" <%= "Sabaragamuwa".equals(request.getParameter("province")) ? "selected" : "" %>>Sabaragamuwa</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="district">
                            <i class="fas fa-map"></i> District <span class="required">*</span>
                        </label>
                        <select class="form-select" id="district" name="district" required>
                            <option value="">Select District</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="city">
                            <i class="fas fa-city"></i> City <span class="required">*</span>
                        </label>
                        <select class="form-select" id="city" name="city" required>
                            <option value="">Select City</option>
                        </select>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label" for="address">
                            <i class="fas fa-home"></i> Full Address <span class="required">*</span>
                        </label>
                        <div class="input-with-icon">
                            <input type="text" class="form-control" id="address" name="address"
                                   placeholder="Enter your full address (street, building, etc.)"
                                   value="${param.address}" required>
                            <i class="fas fa-map-pin input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label">
                            <i class="fas fa-tag"></i> Delivery Label <span class="required">*</span>
                        </label>
                        <div class="radio-group">
                            <label class="radio-label">
                                <input type="radio" name="deliveryLabel" value="HOME"
                                    <%= "HOME".equals(request.getParameter("deliveryLabel")) || request.getParameter("deliveryLabel") == null ? "checked" : "" %>>
                                <span class="radio-custom"></span>
                                <span class="radio-text"><i class="fas fa-home"></i> Home</span>
                            </label>
                            <label class="radio-label">
                                <input type="radio" name="deliveryLabel" value="OFFICE"
                                    <%= "OFFICE".equals(request.getParameter("deliveryLabel")) ? "checked" : "" %>>
                                <span class="radio-custom"></span>
                                <span class="radio-text"><i class="fas fa-building"></i> Office</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <input type="hidden" name="totalAmount" value="27539">

            <button type="submit" class="submit-btn" id="submitBtn">
                <i class="fas fa-lock"></i> Proceed to Pay LKR 27,539
            </button>
        </form>
    </div>

    <!-- Order Summary -->
    <div class="order-summary">
        <h2 class="summary-title">Order Summary</h2>

        <div class="product-item">
            <div class="product-image">
                <i class="fas fa-guitar"></i>
            </div>
            <div class="product-details">
                <div class="product-name">Professional Electric Guitar</div>
                <div class="product-price">LKR 27,539</div>
            </div>
        </div>

        <div class="summary-line">
            <span class="label">Subtotal</span>
            <span>LKR 27,539</span>
        </div>

        <div class="summary-line">
            <span class="label">Shipping</span>
            <span>FREE</span>
        </div>

        <div class="summary-line">
            <span class="label">Tax</span>
            <span>Included</span>
        </div>

        <div class="summary-total">
            <span>Total</span>
            <span>LKR 27,539</span>
        </div>

        <div class="secure-notice">
            <i class="fas fa-shield-alt"></i> Your payment information is secure and encrypted
        </div>
    </div>
</div>

<script>
    // Your existing JavaScript code with enhanced animations
    const provinceDistricts = {
        'Western': ['Colombo', 'Gampaha', 'Kalutara'],
        'Central': ['Kandy', 'Matale', 'Nuwara Eliya'],
        'Southern': ['Galle', 'Matara', 'Hambantota'],
        'Northern': ['Jaffna', 'Kilinochchi', 'Mannar', 'Mullaitivu', 'Vavuniya'],
        'Eastern': ['Batticaloa', 'Ampara', 'Trincomalee'],
        'North Western': ['Kurunegala', 'Puttalam'],
        'North Central': ['Anuradhapura', 'Polonnaruwa'],
        'Uva': ['Badulla', 'Monaragala'],
        'Sabaragamuwa': ['Ratnapura', 'Kegalle']
    };

    const districtCities = {
        'Colombo': ['Colombo 1', 'Colombo 2', 'Colombo 3', 'Colombo 4', 'Colombo 5', 'Colombo 6', 'Colombo 7', 'Colombo 8', 'Colombo 9', 'Colombo 10', 'Colombo 11', 'Colombo 12', 'Colombo 13', 'Colombo 14', 'Colombo 15'],
        'Gampaha': ['Negombo', 'Katunayake', 'Seeduwa', 'Ja-Ela', 'Wattala', 'Kelaniya', 'Ragama', 'Gampaha', 'Mirigama', 'Minuwangoda', 'Veyangoda'],
        'Kalutara': ['Kalutara', 'Panadura', 'Horana', 'Bandaragama', 'Matugama', 'Agalawatta'],
        'Kandy': ['Kandy', 'Peradeniya', 'Kadugannawa', 'Gampola', 'Nawalapitiya', 'Wattegama'],
        'Matale': ['Matale', 'Dambulla', 'Sigiriya'],
        'Nuwara Eliya': ['Nuwara Eliya', 'Hatton', 'Talawakele'],
        'Galle': ['Galle', 'Ambalangoda', 'Hikkaduwa', 'Elpitiya'],
        'Matara': ['Matara', 'Weligama', 'Dikwella', 'Hakmana'],
        'Hambantota': ['Hambantota', 'Tangalle', 'Tissamaharama'],
        'Jaffna': ['Jaffna', 'Chavakachcheri', 'Point Pedro'],
        'Kilinochchi': ['Kilinochchi'],
        'Mannar': ['Mannar'],
        'Mullaitivu': ['Mullaitivu'],
        'Vavuniya': ['Vavuniya'],
        'Batticaloa': ['Batticaloa', 'Valaichchenai'],
        'Ampara': ['Ampara', 'Kalmunai'],
        'Trincomalee': ['Trincomalee'],
        'Kurunegala': ['Kurunegala', 'Kuliyapitiya', 'Nikaweratiya'],
        'Puttalam': ['Puttalam', 'Chilaw'],
        'Anuradhapura': ['Anuradhapura'],
        'Polonnaruwa': ['Polonnaruwa'],
        'Badulla': ['Badulla', 'Bandarawela', 'Haputale'],
        'Monaragala': ['Monaragala'],
        'Ratnapura': ['Ratnapura', 'Balangoda'],
        'Kegalle': ['Kegalle', 'Mawanella']
    };

    document.addEventListener('DOMContentLoaded', function() {
        const provinceSelect = document.getElementById('province');
        const districtSelect = document.getElementById('district');
        const citySelect = document.getElementById('city');
        const orderForm = document.getElementById('orderForm');
        const submitBtn = document.getElementById('submitBtn');
        const notification = document.getElementById('notification');

        // Initialize form with previously selected values
        const savedProvince = '<%= request.getParameter("province") != null ? request.getParameter("province") : "" %>';
        const savedDistrict = '<%= request.getParameter("district") != null ? request.getParameter("district") : "" %>';
        const savedCity = '<%= request.getParameter("city") != null ? request.getParameter("city") : "" %>';

        if (savedProvince) {
            provinceSelect.value = savedProvince;
            populateDistricts(savedProvince);

            if (savedDistrict) {
                setTimeout(() => {
                    districtSelect.value = savedDistrict;
                    populateCities(savedDistrict);

                    if (savedCity) {
                        setTimeout(() => {
                            citySelect.value = savedCity;
                        }, 100);
                    }
                }, 100);
            }
        }

        // Enhanced event listeners with animations
        provinceSelect.addEventListener('change', function() {
            animateSelectChange(this);
            populateDistricts(this.value);
        });

        districtSelect.addEventListener('change', function() {
            animateSelectChange(this);
            populateCities(this.value);
        });

        citySelect.addEventListener('change', function() {
            animateSelectChange(this);
        });

        // Form submission with enhanced feedback
        orderForm.addEventListener('submit', function(e) {
            if (!validateForm()) {
                e.preventDefault();
                return;
            }

            // Enhanced loading state
            submitBtn.innerHTML = '<span class="loading"></span> Processing Your Order...';
            submitBtn.disabled = true;
            submitBtn.style.opacity = '0.8';
        });

        // Enhanced input interactions
        document.querySelectorAll('.form-control, .form-select').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'translateY(-2px)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'translateY(0)';
            });
        });

        function animateSelectChange(select) {
            select.style.transform = 'scale(0.98)';
            setTimeout(() => {
                select.style.transform = 'scale(1)';
            }, 150);
        }

        function populateDistricts(province) {
            districtSelect.innerHTML = '<option value="">Select District</option>';
            citySelect.innerHTML = '<option value="">Select City</option>';

            if (province) {
                const districts = provinceDistricts[province];
                if (districts) {
                    districts.forEach(district => {
                        const option = document.createElement('option');
                        option.value = district;
                        option.textContent = district;
                        districtSelect.appendChild(option);
                    });
                }
            }
        }

        function populateCities(district) {
            citySelect.innerHTML = '<option value="">Select City</option>';

            if (district) {
                const cities = districtCities[district];
                if (cities) {
                    cities.forEach(city => {
                        const option = document.createElement('option');
                        option.value = city;
                        option.textContent = city;
                        citySelect.appendChild(option);
                    });
                }
            }
        }

        function validateForm() {
            const customerName = document.getElementById('customerName').value.trim();
            const phoneNumber = document.getElementById('phoneNumber').value.trim();
            const province = document.getElementById('province').value;
            const district = document.getElementById('district').value;
            const city = document.getElementById('city').value;
            const address = document.getElementById('address').value.trim();

            // Enhanced validation with visual feedback
            const inputs = [
                { element: document.getElementById('customerName'), valid: customerName },
                { element: document.getElementById('phoneNumber'), valid: phoneNumber && /^\d{10}$/.test(phoneNumber) },
                { element: document.getElementById('province'), valid: province },
                { element: document.getElementById('district'), valid: district },
                { element: document.getElementById('city'), valid: city },
                { element: document.getElementById('address'), valid: address }
            ];

            let isValid = true;

            inputs.forEach(input => {
                if (!input.valid) {
                    input.element.style.borderColor = 'var(--danger)';
                    input.element.style.animation = 'shake 0.5s ease-in-out';
                    isValid = false;

                    setTimeout(() => {
                        input.element.style.animation = '';
                    }, 500);
                } else {
                    input.element.style.borderColor = 'var(--glass-border)';
                }
            });

            if (!isValid) {
                // Scroll to first error
                const firstError = inputs.find(input => !input.valid);
                firstError.element.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }

            return isValid;
        }

        // Enhanced phone number validation
        document.getElementById('phoneNumber').addEventListener('input', function(e) {
            this.value = this.value.replace(/\D/g, '').slice(0, 10);

            // Visual feedback for valid/invalid input
            if (this.value.length === 10) {
                this.style.borderColor = 'var(--success)';
            } else {
                this.style.borderColor = 'var(--glass-border)';
            }
        });

        // Add shake animation for errors
        const style = document.createElement('style');
        style.textContent = `
            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }
        `;
        document.head.appendChild(style);
    });
</script>

</body>
</html>