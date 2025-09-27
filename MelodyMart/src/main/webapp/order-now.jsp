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
        /* Your existing CSS styles here */
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

        /* Your existing CSS styles... */

        .error-message {
            background: rgba(220, 53, 69, 0.2);
            border: 1px solid var(--danger);
            color: #ff6b6b;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .success-message {
            background: rgba(40, 167, 69, 0.2);
            border: 1px solid var(--success);
            color: #28a745;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
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
            <div class="section-title">
                <i class="fas fa-user"></i> Personal Information
            </div>

            <div class="form-group">
                <label class="form-label" for="customerName">Full Name</label>
                <div class="input-with-icon">
                    <input type="text" class="form-control" id="customerName" name="customerName"
                           placeholder="Enter your full name" value="${param.customerName}" required>
                    <i class="fas fa-user input-icon"></i>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="phoneNumber">Phone Number</label>
                <div class="input-with-icon">
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber"
                           placeholder="Enter your phone number" value="${param.phoneNumber}" required>
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
                <label class="form-label" for="district">District</label>
                <select class="form-select" id="district" name="district" required>
                    <option value="">Select District</option>
                    <!-- Districts will be populated dynamically -->
                </select>
            </div>

            <div class="form-group">
                <label class="form-label" for="city">City</label>
                <select class="form-select" id="city" name="city" required>
                    <option value="">Select City</option>
                    <!-- Cities will be populated dynamically -->
                </select>
            </div>

            <div class="form-group">
                <label class="form-label" for="address">Full Address</label>
                <div class="input-with-icon">
                    <input type="text" class="form-control" id="address" name="address"
                           placeholder="Enter your full address (street, building, etc.)"
                           value="${param.address}" required>
                    <i class="fas fa-home input-icon"></i>
                </div>
            </div>

            <!-- Delivery Label -->
            <div class="form-group">
                <label class="form-label">Delivery Label</label>
                <div class="radio-group">
                    <label class="radio-label">
                        <input type="radio" name="deliveryLabel" value="HOME"
                            <%= "HOME".equals(request.getParameter("deliveryLabel")) || request.getParameter("deliveryLabel") == null ? "checked" : "" %>>
                        <span class="radio-custom"></span>
                        <span class="radio-text">Home</span>
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="deliveryLabel" value="OFFICE"
                            <%= "OFFICE".equals(request.getParameter("deliveryLabel")) ? "checked" : "" %>>
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
    // Your existing JavaScript code with form validation and dynamic dropdowns
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

    // Initialize form with previously selected values
    document.addEventListener('DOMContentLoaded', function() {
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
    });

    // Province change event
    provinceSelect.addEventListener('change', function() {
        const selectedProvince = this.value;
        populateDistricts(selectedProvince);
    });

    // District change event
    districtSelect.addEventListener('change', function() {
        const selectedDistrict = this.value;
        populateCities(selectedDistrict);
    });

    function populateDistricts(province) {
        districtSelect.innerHTML = '<option value="">Select District</option>';
        citySelect.innerHTML = '<option value="">Select City</option>';
        districtSelect.disabled = true;
        citySelect.disabled = true;

        if (province) {
            districtSelect.disabled = false;
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
        citySelect.disabled = true;

        if (district) {
            citySelect.disabled = false;
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

    // Form submission
    orderForm.addEventListener('submit', function(e) {
        if (!validateForm()) {
            e.preventDefault();
            return;
        }

        // Show loading state
        submitBtn.innerHTML = '<span class="loading"></span> Processing...';
        submitBtn.disabled = true;
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