<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Sign In</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon.ico">
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
<!-- Navbar -->
<div class="flex justify-between items-center p-4 bg-gray-900 bg-opacity-80">
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
        <input type="text" placeholder="Search instruments..." class="w-full md:w-48 p-2 rounded-full search-bar text-white focus:outline-none" aria-label="Search instruments">
    </div>
</div>

<!-- Main Content -->
<main class="p-4 md:p-6 relative z-10 flex justify-center items-center min-h-[calc(100vh-80px)]">
    <div class="w-full max-w-md bg-gray-900 bg-opacity-90 p-6 rounded-lg shadow-lg">
        <h1 class="text-3xl md:text-4xl font-bold text-center mb-6">Sign In to MelodyMart</h1>
        <c:if test="${not empty errorMessage}">
            <p class="text-red-500 text-center mb-4"><c:out value="${errorMessage}"/></p>
        </c:if>
        <form id="signinForm" action="LoginServlet" method="post" class="space-y-4" novalidate>
            <div>
                <label for="email" class="block text-sm md:text-base font-semibold text-gray-300">Email Address</label>
                <input type="email" id="email" name="email" value="${param.email}" required class="w-full p-2 md:p-3 rounded-full search-bar text-white focus:outline-none" placeholder="Enter your email" aria-required="true" aria-describedby="email-error">
                <p id="email-error" class="text-red-500 text-sm hidden">Please enter a valid email address.</p>
            </div>
            <div>
                <label for="password" class="block text-sm md:text-base font-semibold text-gray-300">Password</label>
                <input type="password" id="password" name="password" required minlength="8" class="w-full p-2 md:p-3 rounded-full search-bar text-white focus:outline-none" placeholder="Enter your password" aria-required="true" aria-describedby="password-error">
                <p id="password-error" class="text-red-500 text-sm hidden">Please enter your password.</p>
            </div>
            <div>
                <label class="flex items-center space-x-2">
                    <input type="checkbox" id="remember" name="remember" class="h-4 w-4 text-gray-600 focus:ring-gray-500 border-gray-300 rounded">
                    <span class="text-sm md:text-base text-gray-300">Remember Me</span>
                </label>
            </div>
            <button type="submit" class="w-full px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 transition-colors add-to-cart">Sign In</button>
        </form>
        <p class="text-center text-sm md:text-base text-gray-300 mt-4">Don't have an account? <a href="sign-up.jsp" class="text-blue-300 hover:underline">Sign Up</a></p>
        <p class="text-center text-sm md:text-base text-gray-300 mt-2"><a href="forgot-password.jsp" class="text-blue-300 hover:underline">Forgot Password?</a></p>
    </div>
</main>

<script>
    document.getElementById('signinForm').addEventListener('submit', function(event) {
        event.preventDefault();
        let isValid = true;

        document.querySelectorAll('.text-red-500').forEach(error => error.classList.add('hidden'));

        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            document.getElementById('email-error').classList.remove('hidden');
            isValid = false;
        }

        const password = document.getElementById('password').value;
        if (!password) {
            document.getElementById('password-error').classList.remove('hidden');
            isValid = false;
        }

        if (isValid) {
            this.submit();
        }
    });
</script>
</body>
</html>