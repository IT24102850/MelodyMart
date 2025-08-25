<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Sign In</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon_io%20(9)/favicon.ico">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            background: url('./images/1162694.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
            color: #FFFFFF;
            overflow-x: hidden;
        }
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }
        .input-field {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: border-color 0.3s ease;
        }
        .input-field:focus {
            border-color: rgba(255, 255, 255, 0.5);
        }
        /* Toggle Switch Styles */
        .toggle-switch {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 10px 0;
        }
        .toggle-switch label {
            margin: 0;
            font-size: 0.9rem;
            color: #d1d5db;
        }
        .toggle-input {
            display: none;
        }
        .toggle-slider {
            position: relative;
            width: 60px;
            height: 34px;
            background-color: #4b5563;
            border-radius: 34px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .toggle-slider:before {
            content: "";
            position: absolute;
            width: 26px;
            height: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            border-radius: 50%;
            transition: transform 0.3s;
        }
        .toggle-input:checked + .toggle-slider {
            background-color: #10b981;
        }
        .toggle-input:checked + .toggle-slider:before {
            transform: translateX(26px);
        }
    </style>
</head>
<body class="relative">
<div class="overlay"></div>

<!-- Navbar without Sign In / Sign Up buttons -->
<div class="flex justify-between items-center p-4 bg-gray-900 bg-opacity-80 relative z-10">
    <div>
        <a href="index.jsp" class="text-2xl font-bold text-white">MelodyMart</a>
    </div>
    <div class="flex space-x-4">
        <a href="index.jsp" class="text-white hover:text-gray-300">Home</a>
        <a href="instruments.jsp" class="text-white hover:text-gray-300">Instruments</a>
        <a href="accessories.jsp" class="text-white hover:text-gray-300">Accessories</a>
        <a href="deals.jsp" class="text-white hover:text-gray-300">Deals</a>
        <a href="contact.jsp" class="text-white hover:text-gray-300">Contact Us</a>
    </div>
    <div class="ml-4">
        <input type="text" placeholder="Search instruments..." class="w-full md:w-48 p-2 rounded-full input-field text-white focus:outline-none" aria-label="Search instruments">
    </div>
</div>

<!-- Main Content -->
<main class="p-4 md:p-6 relative z-10 flex justify-center items-center min-h-[calc(100vh-80px)]">
    <div class="w-full max-w-md bg-gray-900 bg-opacity-90 p-6 rounded-lg shadow-lg">
        <h1 class="text-3xl md:text-4xl font-bold text-center mb-6">Sign In to MelodyMart</h1>
        <!-- Display error message from query parameter -->
        <c:if test="${not empty param.error}">
            <p class="text-red-500 text-center mb-4" role="alert" aria-live="assertive"><c:out value="${param.error}" /></p>
        </c:if>
        <c:if test="${not empty param.success}">
            <p class="text-green-500 text-center mb-4" role="alert" aria-live="assertive"><c:out value="${param.success}" /></p>
        </c:if>
        <p class="text-center text-sm text-gray-300 mb-4">Sign in to access your dashboard based on your role.</p>
        <form id="signinForm" action="/melodymart/login" method="post" class="space-y-4" novalidate>
            <!-- Email -->
            <div>
                <label for="email" class="block text-sm md:text-base font-semibold text-gray-300">Email Address</label>
                <input type="email" id="email" name="email" value="${param.email}" required class="w-full p-2 md:p-3 rounded-full input-field text-white focus:outline-none" placeholder="Enter your email" aria-required="true" aria-describedby="email-error">
                <p id="email-error" class="text-red-500 text-sm hidden" role="alert">Please enter a valid email address.</p>
            </div>
            <!-- Password -->
            <div>
                <label for="password" class="block text-sm md:text-base font-semibold text-gray-300">Password</label>
                <input type="password" id="password" name="password" required minlength="8" class="w-full p-2 md:p-3 rounded-full input-field text-white focus:outline-none" placeholder="Enter your password" aria-required="true" aria-describedby="password-error">
                <p id="password-error" class="text-red-500 text-sm hidden" role="alert">Password must be at least 8 characters long.</p>
            </div>
            <!-- Role Toggle Switch -->
            <div>
                <label class="block text-sm md:text-base font-semibold text-gray-300 mb-2">Select Role</label>
                <div class="toggle-switch" id="roleToggle">
                    <input type="radio" name="role" id="roleCustomer" value="customer" class="toggle-input" checked>
                    <label for="roleCustomer" class="toggle-slider"></label>
                    <label for="roleCustomer" class="ml-2">Customer</label>

                    <input type="radio" name="role" id="roleSeller" value="seller" class="toggle-input">
                    <label for="roleSeller" class="toggle-slider"></label>
                    <label for="roleSeller" class="ml-2">Seller</label>

                    <input type="radio" name="role" id="roleAdmin" value="admin" class="toggle-input">
                    <label for="roleAdmin" class="toggle-slider"></label>
                    <label for="roleAdmin" class="ml-2">Admin</label>

                    <input type="radio" name="role" id="roleManufacturer" value="manufacturer" class="toggle-input">
                    <label for="roleManufacturer" class="toggle-slider"></label>
                    <label for="roleManufacturer" class="ml-2">Manufacturer</label>
                </div>
                <input type="hidden" name="selectedRole" id="selectedRole" value="customer">
            </div>
            <!-- Remember Me -->
            <div>
                <label class="flex items-center space-x-2">
                    <input type="checkbox" id="remember" name="remember" class="h-4 w-4 text-gray-600 focus:ring-gray-500 border-gray-300 rounded">
                    <span class="text-sm md:text-base text-gray-300">Remember Me</span>
                </label>
            </div>
            <!-- Submit Button -->
            <button type="submit" class="w-full px-4 py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition-colors">Sign In</button>
        </form>
        <p class="text-center text-sm md:text-base text-gray-300 mt-4">Don't have an account? <a href="sign-up.jsp" class="text-blue-300 hover:underline">Sign Up</a></p>
        <p class="text-center text-sm md:text-base text-gray-300 mt-2"><a href="forgot-password.jsp" class="text-blue-300 hover:underline">Forgot Password?</a></p>
    </div>
</main>

<!-- Script -->
<script>
    document.getElementById('signinForm').addEventListener('submit', function(event) {
        event.preventDefault();
        let isValid = true;

        // Reset error messages
        document.querySelectorAll('.text-red-500').forEach(error => error.classList.add('hidden'));

        // Email validation
        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            document.getElementById('email-error').classList.remove('hidden');
            isValid = false;
        }

        // Password validation
        const password = document.getElementById('password').value;
        if (!password) {
            document.getElementById('password-error').textContent = 'Please enter your password.';
            document.getElementById('password-error').classList.remove('hidden');
            isValid = false;
        } else if (password.length < 8) {
            document.getElementById('password-error').textContent = 'Password must be at least 8 characters long.';
            document.getElementById('password-error').classList.remove('hidden');
            isValid = false;
        }

        if (isValid) {
            // Set the selected role to the hidden input
            const selectedRole = document.querySelector('input[name="role"]:checked').value;
            document.getElementById('selectedRole').value = selectedRole;
            this.submit(); // Submit the form to the servlet
        } else {
            const firstInvalid = document.querySelector('.text-red-500:not(.hidden)').previousElementSibling.querySelector('input');
            if (firstInvalid) firstInvalid.focus();
        }
    });

    // Update the hidden input when the toggle switch changes
    document.querySelectorAll('input[name="role"]').forEach(radio => {
        radio.addEventListener('change', function() {
            document.getElementById('selectedRole').value = this.value;
        });
    });
</script>
</body>
</html>