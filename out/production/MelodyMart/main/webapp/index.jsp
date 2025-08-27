<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Home</title>
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
            margin: 0; /* Ensure no default margin pushes content down */
            padding: 0; /* Ensure no default padding affects layout */
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
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('https://images.unsplash.com/photo-1510915361894-db8b60106cb1?q=80&w=2070&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            height: 60vh;
        }
        .card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background-color: #1F2937;
            border-radius: 8px;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }
        .clean-grid {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }
    </style>
</head>
<body class="relative">
<!-- Navbar (fixed at the very top) -->
<nav class="flex justify-between items-center p-4 bg-gray-900 bg-opacity-80 fixed w-full z-50 top-0"> <!-- Added top-0 to ensure it starts at the top edge -->
    <div>
        <a href="index.jsp" class="text-3xl font-bold text-white font-bebas-neue">MelodyMart</a>
    </div>
    <div class="flex space-x-6">
        <a href="index.jsp" class="text-white hover:text-gray-300 text-lg">Home</a>
        <a href="instruments.jsp" class="text-white hover:text-gray-300 text-lg">Instruments</a>
        <a href="accessories.jsp" class="text-white hover:text-gray-300 text-lg">Accessories</a>
        <a href="deals.jsp" class="text-white hover:text-gray-300 text-lg">Deals</a>
        <a href="contact.jsp" class="text-white hover:text-gray-300 text-lg">Contact</a>
    </div>
    <div class="flex items-center space-x-4">
        <input type="text" placeholder="Search instruments..." class="w-64 p-2 rounded-full search-bar text-white focus:outline-none text-lg" aria-label="Search instruments">
        <a href="sign-in.jsp" class="text-white hover:text-gray-300 text-lg">Sign In</a>
        <a href="sign-up.jsp" class="text-white hover:text-gray-300 text-lg">Sign Up</a>
    </div>
</nav>

<!-- Hero Section (adjusted for fixed nav at top) -->
<section class="hero flex items-center justify-center text-center text-white mt-16"> <!-- Reduced mt-20 to mt-16 to match nav height -->
    <div>
        <h1 class="text-5xl md:text-6xl font-bold mb-4">Welcome to MelodyMart</h1>
        <p class="text-xl md:text-2xl mb-6">Your Premier Destination for Musical Instruments</p>
        <a href="#explore-instruments" class="px-6 py-3 bg-gray-500 text-white rounded-lg hover:bg-gray-600 add-to-cart text-lg">Explore Now</a>
    </div>
</section>

<!-- Featured Instruments -->
<section class="py-12 px-4 md:px-12 bg-gray-900 bg-opacity-80" id="explore-instruments">
    <h2 class="text-4xl font-bold text-center mb-8">Discover Our Instruments</h2>
    <div class="clean-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <div class="card p-4 text-center">
            <img src="https://images.unsplash.com/photo-1517694712202-14dd672e453e?q=80&w=1932&auto=format&fit=crop" alt="Acoustic Guitar" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">Acoustic Guitar</h3>
            <p class="mt-2 text-gray-300">$299.99</p>
            <a href="product.jsp?id=1" class="mt-4 inline-block px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 add-to-cart">View Details</a>
        </div>
        <div class="card p-4 text-center">
            <img src="https://images.unsplash.com/photo-1506784928022-8b12b3e5b0a7?q=80&w=1974&auto=format&fit=crop" alt="Electric Guitar" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">Electric Guitar</h3>
            <p class="mt-2 text-gray-300">$499.99</p>
            <a href="product.jsp?id=2" class="mt-4 inline-block px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 add-to-cart">View Details</a>
        </div>
        <div class="card p-4 text-center">
            <img src="https://images.unsplash.com/photo-1519638389952-0a4a7f2b4e9e?q=80&w=2070&auto=format&fit=crop" alt="Keyboard" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">Keyboard</h3>
            <p class="mt-2 text-gray-300">$399.99</p>
            <a href="product.jsp?id=3" class="mt-4 inline-block px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 add-to-cart">View Details</a>
        </div>
        <div class="card p-4 text-center">
            <img src="https://images.unsplash.com/photo-1516474177716-89f4e675e075?q=80&w=1935&auto=format&fit=crop" alt="Drum Kit" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">Drum Kit</h3>
            <p class="mt-2 text-gray-300">$799.99</p>
            <a href="product.jsp?id=4" class="mt-4 inline-block px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 add-to-cart">View Details</a>
        </div>
        <div class="card p-4 text-center">
            <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1974&auto=format&fit=crop" alt="Piano" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">Piano</h3>
            <p class="mt-2 text-gray-300">$1299.99</p>
            <a href="product.jsp?id=5" class="mt-4 inline-block px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 add-to-cart">View Details</a>
        </div>
        <div class="card p-4 text-center">
            <img src="https://images.unsplash.com/photo-1593996219700-113e3b64f348?q=80&w=1974&auto=format&fit=crop" alt="Violin" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">Violin</h3>
            <p class="mt-2 text-gray-300">$349.99</p>
            <a href="product.jsp?id=6" class="mt-4 inline-block px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 add-to-cart">View Details</a>
        </div>
        <div class="card p-4 text-center">
            <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1974&auto=format&fit=crop" alt="Saxophone" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">Saxophone</h3>
            <p class="mt-2 text-gray-300">$599.99</p>
            <a href="product.jsp?id=7" class="mt-4 inline-block px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 add-to-cart">View Details</a>
        </div>
        <div class="card p-4 text-center">
            <img src="https://images.unsplash.com/photo-1600585154526-990d71c4c1e9?q=80&w=1974&auto=format&fit=crop" alt="Trumpet" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">Trumpet</h3>
            <p class="mt-2 text-gray-300">$449.99</p>
            <a href="product.jsp?id=8" class="mt-4 inline-block px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 add-to-cart">View Details</a>
        </div>
    </div>
</section>

<!-- Deals Section -->
<section class="py-12 px-4 md:px-12 bg-gray-900 bg-opacity-80">
    <h2 class="text-4xl font-bold text-center mb-8">Exclusive Deals</h2>
    <div class="clean-grid grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="card p-4">
            <img src="https://images.unsplash.com/photo-1504805572947-34fad45aed93?q=80&w=1974&auto=format&fit=crop" alt="Deal 1" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">25% Off Acoustic Guitars</h3>
            <p class="mt-2 text-gray-300">Limited stock. Ends September 5, 2025.</p>
            <p class="mt-2 text-green-400 font-bold">Save $75</p>
            <a href="deals.jsp?deal=guitars" class="mt-4 inline-block px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700">Shop Now</a>
        </div>
        <div class="card p-4">
            <img src="https://images.unsplash.com/photo-1516474177716-89f4e675e075?q=80&w=1974&auto=format&fit=crop" alt="Deal 2" class="w-full h-48 object-cover rounded-t-lg">
            <h3 class="text-xl font-semibold mt-4">20% Off Keyboards</h3>
            <p class="mt-2 text-gray-300">Perfect for beginners. Offer ends August 31, 2025.</p>
            <p class="mt-2 text-green-400 font-bold">Save $80</p>
            <a href="deals.jsp?deal=keyboards" class="mt-4 inline-block px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700">Shop Now</a>
        </div>
    </div>
</section>

<!-- Testimonials -->
<section class="py-12 px-4 md:px-12 bg-gray-900 bg-opacity-80">
    <h2 class="text-4xl font-bold text-center mb-8">Customer Reviews</h2>
    <div class="clean-grid grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="card p-4">
            <p class="italic text-gray-300">"Excellent service and top-notch instruments!"</p>
            <p class="mt-4 font-semibold">- Maria S., Canada</p>
        </div>
        <div class="card p-4">
            <p class="italic text-gray-300">"Fast delivery and great quality drums."</p>
            <p class="mt-4 font-semibold">- Ravi P., India</p>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-900 p-6 text-center text-gray-300">
    <div class="mb-4">
        <h3 class="text-xl font-bold">MelodyMart</h3>
        <p>Contact us: support@melodymart.com | +1-800-555-1234</p>
    </div>
    <div class="flex justify-center space-x-4">
        <a href="#" class="hover:text-white">Facebook</a>
        <a href="#" class="hover:text-white">Twitter</a>
        <a href="#" class="hover:text-white">Instagram</a>
    </div>
    <p class="mt-4">&copy; 2025 MelodyMart. All rights reserved.</p>
</footer>
</body>
</html>