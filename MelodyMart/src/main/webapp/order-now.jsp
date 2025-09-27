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
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
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
            padding: 20px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-image: linear-gradient(rgba(10, 10, 10, 0.9), rgba(10, 10, 10, 0.9)),
            url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-position: center;
        }

        .container {
            display: flex;
            max-width: 1200px;
            width: 100%;
            gap: 30px;
        }

        .order-form-container {
            flex: 1;
            background: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            border: 1px solid var(--glass-border);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5);
        }

        .order-summary {
            flex: 0 0 350px;
            background: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            border: 1px solid var(--glass-border);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5);
            height: fit-content;
            position: sticky;
            top: 20px;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 5px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .page-subtitle {
            color: var(--text-secondary);
            margin-bottom: 30px;
            font-size: 16px;
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            margin: 25px 0 15px;
            color: var(--primary-light);
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            font-size: 18px;
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
            padding: 14px 15px;
            border-radius: 8px;
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.2);
        }

        .form-select {
            width: 100%;
            padding: 14px 15px;
            border-radius: 8px;
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            font-size: 15px;
            transition: all 0.3s ease;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%238a2be2' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 16px;
        }

        .form-select:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.2);
        }

        .radio-group {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }

        .radio-label {
            display: flex;
            align-items: center;
            cursor: pointer;
            padding: 12px 20px;
            border: 1px solid var(--glass-border);
            border-radius: 8px;
            transition: all 0.3s ease;
            flex: 1;
        }

        .radio-label:hover {
            border-color: var(--primary-light);
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
            width: 16px;
            height: 16px;
            border-radius: 50%;
            border: 2px solid var(--text-secondary);
            margin-right: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .radio-text {
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .submit-btn {
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 10px;
            background: var(--gradient);
            color: white;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        .summary-title {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
        }

        .product-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--glass-border);
        }

        .product-image {
            width: 70px;
            height: 70px;
            border-radius: 8px;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 24px;
            color: white;
        }

        .product-details {
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

        .summary-line {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 8px 0;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-weight: 700;
            font-size: 18px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid var(--glass-border);
            color: var(--accent);
        }

        .secure-notice {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .secure-notice i {
            color: var(--success);
            margin-right: 8px;
        }

        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 8px;
            background: var(--success);
            color: white;
            font-weight: 500;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transform: translateX(150%);
            transition: transform 0.3s ease;
            z-index: 1000;
        }

        .notification.show {
            transform: translateX(0);
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

        /* Responsive Design */
        @media (max-width: 992px) {
            .container {
                flex-direction: column;
            }

            .order-summary {
                flex: 1;
                margin-top: 30px;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 10px;
            }

            .order-form-container, .order-summary {
                padding: 20px;
            }

            .page-title {
                font-size: 28px;
            }

            .radio-group {
                flex-direction: column;
                gap: 10px;
            }
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

        <form id="orderForm" action="${pageContext.request.contextPath}/CreateOrderServlet" method="post">
            <!-- Personal Information -->
            <div class="section-title">
                <i class="fas fa-user"></i> Personal Information
            </div>

            <div class="form-group">
                <label class="form-label" for="customerName">Full Name</label>
                <div class="input-with-icon">
                    <input type="text" class="form-control" id="customerName" name="customerName" placeholder="Enter your full name" required>
                    <i class="fas fa-user input-icon"></i>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="phoneNumber">Phone Number</label>
                <div class="input-with-icon">
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Enter your phone number" required>
                    <i class="fas fa-phone input-icon"></i>
                </div>
            </div>

            <!-- Delivery Address -->
            <div class="section-title">
                <i class="fas fa-map-marker-alt"></i> Delivery Address
            </div>

            <div class="form-group">
                <label class="form-label" for="province">Province</label>
                <select class="form-select" id="province" name="province" required>
                    <option value="">Select Province</option>
                    <option value="Western">Western</option>
                    <option value="Central">Central</option>
                    <option value="Southern">Southern</option>
                    <option value="Northern">Northern</option>
                    <option value="Eastern">Eastern</option>
                    <option value="North Western">North Western</option>
                    <option value="North Central">North Central</option>
                    <option value="Uva">Uva</option>
                    <option value="Sabaragamuwa">Sabaragamuwa</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label" for="district">District</label>
                <select class="form-select" id="district" name="district" required disabled>
                    <option value="">Select District</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label" for="city">City</label>
                <select class="form-select" id="city" name="city" required disabled>
                    <option value="">Select City</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label" for="address">Full Address</label>
                <div class="input-with-icon">
                    <input type="text" class="form-control" id="address" name="address" placeholder="Enter your full address (street, building, etc.)" required>
                    <i class="fas fa-home input-icon"></i>
                </div>
            </div>

            <!-- Delivery Label -->
            <div class="form-group">
                <label class="form-label">Delivery Label</label>
                <div class="radio-group">
                    <label class="radio-label">
                        <input type="radio" name="deliveryLabel" value="HOME" checked>
                        <span class="radio-custom"></span>
                        <span class="radio-text">Home</span>
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="deliveryLabel" value="OFFICE">
                        <span class="radio-custom"></span>
                        <span class="radio-text">Office</span>
                    </label>
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
            <span>Subtotal</span>
            <span>LKR 27,539</span>
        </div>

        <div class="summary-line">
            <span>Shipping</span>
            <span>LKR 0</span>
        </div>

        <div class="summary-line">
            <span>Tax</span>
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
    // Province to District mapping
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

    // District to City mapping
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

    // DOM elements
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');
    const citySelect = document.getElementById('city');
    const orderForm = document.getElementById('orderForm');
    const submitBtn = document.getElementById('submitBtn');
    const notification = document.getElementById('notification');

    // Province change event
    provinceSelect.addEventListener('change', function() {
        const selectedProvince = this.value;

        // Reset district and city
        districtSelect.innerHTML = '<option value="">Select District</option>';
        citySelect.innerHTML = '<option value="">Select City</option>';
        districtSelect.disabled = true;
        citySelect.disabled = true;

        if (selectedProvince) {
            districtSelect.disabled = false;
            const districts = provinceDistricts[selectedProvince];

            districts.forEach(district => {
                const option = document.createElement('option');
                option.value = district;
                option.textContent = district;
                districtSelect.appendChild(option);
            });
        }
    });

    // District change event
    districtSelect.addEventListener('change', function() {
        const selectedDistrict = this.value;

        // Reset city
        citySelect.innerHTML = '<option value="">Select City</option>';
        citySelect.disabled = true;

        if (selectedDistrict) {
            citySelect.disabled = false;
            const cities = districtCities[selectedDistrict];

            if (cities) {
                cities.forEach(city => {
                    const option = document.createElement('option');
                    option.value = city;
                    option.textContent = city;
                    citySelect.appendChild(option);
                });
            }
        }
    });

    // Form submission
    orderForm.addEventListener('submit', function(e) {
        e.preventDefault();

        // Validate form
        if (!validateForm()) {
            return;
        }

        // Show loading state
        submitBtn.innerHTML = '<span class="loading"></span> Processing...';
        submitBtn.disabled = true;

        // Simulate form submission (replace with actual submission)
        setTimeout(() => {
            // Show success notification
            notification.classList.add('show');

            // Reset button
            submitBtn.innerHTML = '<i class="fas fa-lock"></i> Proceed to Pay LKR 27,539';
            submitBtn.disabled = false;

            // Hide notification after 3 seconds
            setTimeout(() => {
                notification.classList.remove('show');

                // Submit the form (in a real scenario)
                // orderForm.submit();
            }, 3000);
        }, 2000);
    });

    // Form validation
    function validateForm() {
        const customerName = document.getElementById('customerName').value.trim();
        const phoneNumber = document.getElementById('phoneNumber').value.trim();
        const province = document.getElementById('province').value;
        const district = document.getElementById('district').value;
        const city = document.getElementById('city').value;
        const address = document.getElementById('address').value.trim();

        // Basic validation
        if (!customerName) {
            alert('Please enter your full name');
            return false;
        }

        if (!phoneNumber || !/^\d{10}$/.test(phoneNumber)) {
            alert('Please enter a valid 10-digit phone number');
            return false;
        }

        if (!province) {
            alert('Please select a province');
            return false;
        }

        if (!district) {
            alert('Please select a district');
            return false;
        }

        if (!city) {
            alert('Please select a city');
            return false;
        }

        if (!address) {
            alert('Please enter your full address');
            return false;
        }

        return true;
    }

    // Input validation for phone number
    document.getElementById('phoneNumber').addEventListener('input', function(e) {
        this.value = this.value.replace(/\D/g, '').slice(0, 10);
    });
</script>

</body>
</html>