<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary - Melody Mart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background: radial-gradient(circle at center, rgba(20, 20, 20, 0.9), rgba(0, 0, 0, 0.9)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-attachment: fixed;
            color: #ffffff;
            font-family: 'Montserrat', sans-serif;
            overflow-x: hidden;
            position: relative;
        }
        .container {
            max-width: 900px;
            margin: 20px auto;
            padding: 15px;
        }
        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 700;
            text-align: center;
            position: relative;
            margin-bottom: 20px;
            color: #e0e0e0;
        }
        .section-title:after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 2px;
            background: linear-gradient(90deg, #8a2be2, #00e5ff);
            border-radius: 1px;
        }
        .accordion {
            background: rgba(30, 30, 30, 0.95);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            margin-bottom: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .accordion-header {
            padding: 12px 15px;
            font-weight: 600;
            cursor: pointer;
            background: linear-gradient(90deg, #2d2d2d, #3d3d3d);
            transition: background 0.3s ease;
        }
        .accordion-header:hover {
            background: linear-gradient(90deg, #3d3d3d, #4d4d4d);
        }
        .accordion-content {
            padding: 15px;
            display: none;
            background: rgba(25, 25, 25, 0.9);
        }
        .accordion-content.active {
            display: block;
        }
        .product-card {
            perspective: 1000px;
            margin: 10px 0;
            transition: transform 0.6s;
        }
        .product-card-inner {
            position: relative;
            width: 100%;
            text-align: center;
            transition: transform 0.6s;
            transform-style: preserve-3d;
        }
        .product-card:hover .product-card-inner {
            transform: rotateY(180deg);
        }
        .product-card-front, .product-card-back {
            position: absolute;
            width: 100%;
            backface-visibility: hidden;
            border-radius: 10px;
            padding: 10px;
            background: rgba(40, 40, 40, 0.9);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .product-card-back {
            transform: rotateY(180deg);
            background: linear-gradient(135deg, #2d2d2d, #404040);
            color: #d0d0d0;
        }
        .btn-premium {
            background: linear-gradient(135deg, #8a2be2, #00e5ff);
            padding: 8px 16px;
            border-radius: 20px;
            border: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .btn-premium:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.4);
        }
        .btn-premium:before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.5s ease, height 0.5s ease;
        }
        .btn-premium:hover:before {
            width: 200px;
            height: 200px;
        }
        .input-field {
            background: rgba(20, 20, 20, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 6px;
            padding: 8px;
            transition: border-color 0.3s ease;
        }
        .input-field:focus {
            border-color: #00e5ff;
            outline: none;
        }
        .note {
            position: absolute;
            font-size: 24px;
            opacity: 0.7;
            animation: float 10s infinite;
        }
        @keyframes float {
            0% { transform: translateY(0) rotate(0deg); opacity: 0.7; }
            50% { transform: translateY(-30px) rotate(360deg); opacity: 1; }
            100% { transform: translateY(0) rotate(0deg); opacity: 0.7; }
        }
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            .accordion-content {
                padding: 10px;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
</head>
<body class="antialiased relative">
<!-- Animated Musical Notes -->
<div id="note-container" class="absolute inset-0 pointer-events-none z-0"></div>

<!-- Main Content -->
<div class="container relative z-10">
    <h2 class="section-title">Order Summary</h2>

    <!-- Delivery Information (Accordion) -->
    <div class="accordion">
        <div class="accordion-header" onclick="toggleAccordion('delivery')">Delivery Information</div>
        <div id="delivery-content" class="accordion-content">
            <form class="grid grid-cols-1 md:grid-cols-2 gap-3">
                <div>
                    <label class="block text-sm font-medium text-gray-400">Full Name</label>
                    <input type="text" value="<% out.print(session.getAttribute("customerName") != null ? session.getAttribute("customerName") : "John Doe"); %>" class="input-field w-full" readonly>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-400">Phone Number</label>
                    <input type="tel" value="+94 123 456 789" class="input-field w-full" readonly>
                </div>
                <div class="md:col-span-2">
                    <label class="block text-sm font-medium text-gray-400">Address</label>
                    <input type="text" value="Building 12, High St, Colombo 03" class="input-field w-full" readonly>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-400">Province</label>
                    <input type="text" value="Western Province" class="input-field w-full" readonly>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-400">City</label>
                    <input type="text" value="Colombo" class="input-field w-full" readonly>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-400">Delivery Label</label>
                    <input type="text" value="HOME" class="input-field w-full" readonly>
                </div>
                <div class="md:col-span-2">
                    <button type="button" class="btn-premium w-full">Edit Delivery</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Order Details (Accordion) -->
    <div class="accordion">
        <div class="accordion-header" onclick="toggleAccordion('order')">Order Details</div>
        <div id="order-content" class="accordion-content">
            <div class="space-y-3">
                <div class="flex justify-between items-center text-gray-300">
                    <span>Package 1 of 1</span>
                    <span class="text-cyan-400">Shipped by: Melody Mart</span>
                </div>
                <div class="product-card">
                    <div class="product-card-inner">
                        <div class="product-card-front">
                            <h4 class="text-lg font-medium">Professional Electric Guitar</h4>
                            <p class="text-gray-500">Premium crafted with exceptional tone</p>
                            <p class="text-green-400">Rs. 1,299.99 <span class="text-gray-500 line-through">Rs. 1,499.99</span> (-13%)</p>
                            <p class="text-gray-400">Qty: 1</p>
                        </div>
                        <div class="product-card-back">
                            <p class="text-sm">Crafted with premium wood and advanced pickups for studio and stage use.</p>
                            <p class="text-gray-400">Warranty: 2 Years | Weight: 3.5kg</p>
                        </div>
                    </div>
                </div>
                <div class="flex justify-between items-center text-gray-300">
                    <span>Delivery Option: Standard</span>
                    <span class="text-cyan-400">Rs. 199</span>
                </div>
                <p class="text-gray-400">Guaranteed by <span id="deliveryDate"></span></p>
            </div>
        </div>
    </div>

    <!-- Order Summary (Accordion) -->
    <div class="accordion">
        <div class="accordion-header" onclick="toggleAccordion('summary')">Order Summary</div>
        <div id="summary-content" class="accordion-content">
            <div class="space-y-3">
                <div class="flex justify-between text-gray-300">
                    <span>Items Total (1 Item)</span>
                    <span class="text-white">Rs. 1,299.99</span>
                </div>
                <div class="flex justify-between text-gray-300">
                    <span>Delivery Fee</span>
                    <span class="text-white">Rs. 199</span>
                </div>
                <div class="flex justify-between font-bold text-lg border-t border-gray-700 pt-3">
                    <span>Total</span>
                    <span class="text-cyan-400">Rs. 1,498.99 (VAT included)</span>
                </div>
                <button class="btn-premium w-full mt-4">Proceed to Pay</button>
            </div>
        </div>
    </div>

    <!-- Subscription Prompt -->
    <div class="card mt-6 p-4 text-center">
        <h3 class="text-lg font-semibold mb-3">Stay in Tune with Melody Mart</h3>
        <p class="text-gray-400 mb-3">Subscribe for exclusive offers and new arrivals.</p>
        <form class="flex justify-center">
            <input type="email" placeholder="Enter your email" class="input-field w-56 mr-2" required>
            <button type="submit" class="btn-premium">Subscribe</button>
        </form>
    </div>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script>
    // Accordion Toggle
    function toggleAccordion(id) {
        const content = document.getElementById(`${id}-content`);
        if (content.classList.contains('active')) {
            content.classList.remove('active');
        } else {
            document.querySelectorAll('.accordion-content').forEach(c => c.classList.remove('active'));
            content.classList.add('active');
        }
    }
    // Initial Open
    document.getElementById('delivery-content').classList.add('active');

    // Animated Musical Notes
    function createNotes() {
        const container = document.getElementById('note-container');
        const notes = ['🎸', '🎹', '🥁', '🎻', '🎵'];
        for (let i = 0; i < 10; i++) {
            const note = document.createElement('div');
            note.className = 'note';
            note.innerHTML = notes[Math.floor(Math.random() * notes.length)];
            note.style.left = `${Math.random() * 100}vw`;
            note.style.top = `${Math.random() * 100}vh`;
            note.style.animationDelay = `${Math.random() * 5}s`;
            container.appendChild(note);
        }
    }
    createNotes();

    // Dynamic Delivery Date
    const today = new Date('2025-09-17T10:05:00+0530');
    const deliveryStart = new Date(today.setDate(today.getDate() + 2)).toLocaleDateString('en-US', { day: 'numeric', month: 'short', year: 'numeric' });
    const deliveryEnd = new Date(today.setDate(today.getDate() + 4)).toLocaleDateString('en-US', { day: 'numeric', month: 'short', year: 'numeric' });
    document.getElementById('deliveryDate').textContent = `${deliveryStart} - ${deliveryEnd}`;
</script>
</body>
</html>