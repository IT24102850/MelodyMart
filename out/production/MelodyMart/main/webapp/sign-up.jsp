<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Sign Up</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon_io%20(9)/favicon.ico">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
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
        .search-bar {
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .search-bar:focus {
            border-color: rgba(255, 255, 255, 0.4);
        }
        .add-to-cart {
            background-color: #4B5563;
        }
        .add-to-cart:hover {
            background-color: #6B7280;
        }
    </style>
</head>
<body class="relative">
<!-- Main Content -->
<main class="p-4 md:p-6 relative z-10 flex justify-center items-center min-h-[calc(100vh-80px)]">
    <div class="w-full max-w-md bg-gray-900 bg-opacity-90 p-6 rounded-lg shadow-lg">
        <h1 class="text-3xl md:text-4xl font-bold text-center mb-6">Sign Up for MelodyMart</h1>
        <c:if test="${not empty errorMessage}">
            <p class="text-red-500 text-center mb-4"><c:out value="${errorMessage}"/></p>
        </c:if>
        <c:if test="${not empty successMessage}">
            <p class="text-green-500 text-center mb-4"><c:out value="${successMessage}"/></p>
        </c:if>
        <form id="signupForm" action="register" method="post" class="space-y-4" novalidate>
            <!-- Full Name -->
            <div>
                <label for="fullName" class="block text-sm md:text-base font-semibold text-gray-300">Full Name</label>
                <input type="text" id="fullName" name="fullName" value="${param.fullName}" required class="w-full p-2 md:p-3 rounded-full search-bar text-white focus:outline-none" placeholder="Enter your full name" aria-required="true" aria-describedby="name-error">
                <p id="name-error" class="text-red-500 text-sm hidden">Please enter your full name.</p>
            </div>
            <!-- Email -->
            <div>
                <label for="email" class="block text-sm md:text-base font-semibold text-gray-300">Email Address</label>
                <input type="email" id="email" name="email" value="${param.email}" required class="w-full p-2 md:p-3 rounded-full search-bar text-white focus:outline-none" placeholder="Enter your email" aria-required="true" aria-describedby="email-error">
                <p id="email-error" class="text-red-500 text-sm hidden">Please enter a valid email address.</p>
            </div>
            <!-- Password -->
            <div>
                <label for="password" class="block text-sm md:text-base font-semibold text-gray-300">Password</label>
                <input type="password" id="password" name="password" required minlength="8" class="w-full p-2 md:p-3 rounded-full search-bar text-white focus:outline-none" placeholder="Enter your password" aria-required="true" aria-describedby="password-error">
                <p id="password-error" class="text-red-500 text-sm hidden">Password must be at least 8 characters.</p>
            </div>
            <!-- Role -->
            <div>
                <label for="role" class="block text-sm md:text-base font-semibold text-gray-300">Role</label>
                <select id="role" name="role" required class="w-full p-2 md:p-3 rounded-full search-bar text-white focus:outline-none" aria-required="true" aria-describedby="role-error">
                    <option value="">Select your role</option>
                    <option value="customer" ${param.role == 'customer' ? 'selected' : ''}>Customer</option>
                    <option value="seller" ${param.role == 'seller' ? 'selected' : ''}>Seller</option>
                    <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                </select>
                <p id="role-error" class="text-red-500 text-sm hidden">Please select your role.</p>
            </div>
            <!-- Country -->
            <div>
                <label for="country" class="block text-sm md:text-base font-semibold text-gray-300">Country</label>
                <select id="country" name="country" required class="w-full p-2 md:p-3 rounded-full search-bar text-white focus:outline-none" aria-required="true" aria-describedby="country-error">
                    <option value="">Select your country</option>
                    <option value="US" ${param.country == 'US' ? 'selected' : ''}>United States</option>
                    <option value="CA" ${param.country == 'CA' ? 'selected' : ''}>Canada</option>
                    <option value="UK" ${param.country == 'UK' ? 'selected' : ''}>United Kingdom</option>
                    <option value="AU" ${param.country == 'AU' ? 'selected' : ''}>Australia</option>
                    <option value="IN" ${param.country == 'IN' ? 'selected' : ''}>India</option>
                    <option value="DE" ${param.country == 'DE' ? 'selected' : ''}>Germany</option>
                    <option value="FR" ${param.country == 'FR' ? 'selected' : ''}>France</option>
                    <option value="JP" ${param.country == 'JP' ? 'selected' : ''}>Japan</option>
                    <option value="CN" ${param.country == 'CN' ? 'selected' : ''}>China</option>
                    <option value="BR" ${param.country == 'BR' ? 'selected' : ''}>Brazil</option>
                    <option value="SL" ${param.country == 'SL' ? 'selected' : ''}>Sri Lanka</option>
                </select>
                <p id="country-error" class="text-red-500 text-sm hidden">Please select your country.</p>
            </div>
            <!-- Submit Button -->
            <button type="submit" class="w-full px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 transition-colors add-to-cart">Create Account</button>
        </form>
        <p class="text-center text-sm md:text-base text-gray-300 mt-4">Already have an account? <a href="sign-in.jsp" class="text-blue-300 hover:underline">Sign In</a></p>
    </div>
</main>

<script>
    // Form Validation
    document.getElementById('signupForm').addEventListener('submit', function(event) {
        event.preventDefault();
        let isValid = true;

        // Reset error messages
        document.querySelectorAll('.text-red-500').forEach(error => error.classList.add('hidden'));

        // Full Name validation
        const fullName = document.getElementById('fullName').value.trim();
        if (!fullName) {
            document.getElementById('name-error').classList.remove('hidden');
            isValid = false;
        }

        // Email validation
        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            document.getElementById('email-error').classList.remove('hidden');
            isValid = false;
        }

        // Password validation
        const password = document.getElementById('password').value;
        if (password.length < 8) {
            document.getElementById('password-error').classList.remove('hidden');
            isValid = false;
        }

        // Role validation
        const role = document.getElementById('role').value;
        if (!role) {
            document.getElementById('role-error').classList.remove('hidden');
            isValid = false;
        }

        // Country validation
        const country = document.getElementById('country').value;
        if (!country) {
            document.getElementById('country-error').classList.remove('hidden');
            isValid = false;
        }

        if (isValid) {
            this.submit(); // Submit the form to the servlet
        }
    });
</script>
</body>
</html>
