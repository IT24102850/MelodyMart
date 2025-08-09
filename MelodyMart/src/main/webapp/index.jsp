<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Elevate Your Sound</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon_io%20(9)/favicon.ico">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
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
        .hero-image {
            background-image: url('https://images.unsplash.com/photo-1511379936541-1b6e55863e73?q=80&w=2070&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            filter: hue-rotate(30deg) brightness(1.2);
            position: relative;
            z-index: 1;
        }
        .cta-button {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .cta-button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
        }
        .product-card {
            transition: transform 0.3s ease;
            background: #000000;
            border-radius: 0.5rem;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-card img {
            width: 100%;
            height: 120px;
            object-fit: cover;
            object-position: center;
        }
        .product-card h3 {
            font-size: 1.1rem;
            margin: 0.5rem 0;
        }
        .product-card a {
            font-size: 0.9rem;
            padding-bottom: 0.5rem;
        }
        @media (max-width: 640px) {
            .product-grid {
                grid-template-columns: 1fr;
            }
            .product-card img {
                height: auto;
            }
            .hero-image {
                height: 200px;
            }
        }
        @media (min-width: 641px) and (max-width: 1024px) {
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .hero-image {
                height: 300px;
            }
        }
        @media (min-width: 1025px) {
            .product-grid {
                grid-template-columns: repeat(4, 1fr);
            }
            .hero-image {
                height: 400px;
            }
        }
    </style>
</head>
<body class="relative">

<!-- Header Navigation -->
<header class="flex justify-between items-center p-6 z-10 relative">
    <div class="text-3xl font-bold font-['Bebas+Neue']">MelodyMart</div>
    <nav class="flex space-x-6 items-center">
        <button class="auth-button" onclick="window.location.href='index.jsp'">Home</button>
        <button class="auth-button" onclick="window.location.href='instruments.jsp'">Instruments</button>
        <button class="auth-button" onclick="window.location.href='accessories.jsp'">Accessories</button>
        <button class="auth-button" onclick="window.location.href='deals.html'">Deals</button>
        <button class="auth-button" onclick="window.location.href='contact-us.html'">Contact Us</button>
        <button class="auth-button" id="signInBtn" onclick="window.location.href='sign-in.jsp'">Sign In</button>
        <button class="auth-button" id="signUpBtn" onclick="window.location.href='sign-up.jsp'">Sign Up</button>
    </nav>
</header>

<!-- Hero Section -->
<section class="flex flex-col md:flex-row items-center justify-between p-0 md:p-0 relative z-10">
    <div class="md:w-1/2 text-center md:text-left ml-4 md:ml-8">
        <h1 class="text-6xl md:text-7xl font-bold font-['Inter'] leading-tight mb-6">
            Elevate your Sound
        </h1>
        <button class="bg-white text-black px-6 py-3 rounded-full text-lg font-semibold cta-button m1=4">
            <a href="instruments.jsp" class="text-black no-underline">Shop Now</a>
        </button>
    </div>
    <div class="md:w-[60%] h-96 mt-8 md:mt-0 hero-image"></div>
</section>

<!-- Product Category Grid -->
<section class="p-2 md:p-4 relative z-10">
    <div class="product-grid grid gap-4">
        <div class="product-card p-4 flex flex-col items-center text-center">
            <a href="instruments.jsp" class="no-underline text-white">
                <img src="./images/guitar.jpg" alt="Guitar" class="mb-2">
                <h3 class="font-semibold">New Arrivals</h3>
            </a>
            <a href="instruments.jsp" class="text-blue-300">Explore</a>
        </div>
        <div class="product-card p-4 flex flex-col items-center text-center">
            <a href="instruments.jsp" class="no-underline text-white">
                <img src="./images/keyboard.jpg" alt="Keyboard" class="mb-2">
                <h3 class="font-semibold">Best Sellers</h3>
            </a>
            <a href="instruments.jsp" class="text-blue-300">Explore</a>
        </div>
        <div class="product-card p-4 flex-col items-center text-center">
            <a href="instruments.jsp" class="no-underline text-white">
                <img src="./images/drums.jpg" alt="Drums" class="mb-2">
                <h3 class="font-semibold">Featured Brands</h3>
            </a>
            <a href="instruments.jsp" class="text-blue-300">Explore</a>
        </div>
        <div class="product-card p-4 flex flex-col items-center text-center">
            <a href="accessories.jsp" class="no-underline text-white">
                <img src="./images/accessories.jpg" alt="Accessories" class="mb-2">
                <h3 class="font-semibold">Accessories</h3>
            </a>
            <a href="accessories.jsp" class="text-blue-300">Explore</a>
        </div>
    </div>
</section>

<!-- Dynamic Welcome Message (Placeholder) -->
<c:if test="${not empty sessionScope.user}">
    <p class="text-center mt-4">Welcome, ${sessionScope.user.fullName}!</p>
</c:if>

<script>
    const dateTime = new Date().toLocaleString('en-US', {
        timeZone: 'Asia/Colombo',
        hour12: true,
        hour: '2-digit',
        minute: '2-digit',
        timeZoneName: 'short',
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
    document.body.innerHTML += `<p class="text-center mt-4">${dateTime}</p>`;
</script>
</body>
</html>