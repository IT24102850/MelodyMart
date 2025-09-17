<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard - Melody Mart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-attachment: fixed;
            color: #ffffff;
            font-family: 'Inter', sans-serif;
        }
        .sidebar {
            background: rgba(26, 26, 26, 0.9);
            backdrop-filter: blur(10px);
            height: 100vh;
            position: fixed;
            width: 250px;
            transition: transform 0.3s ease-in-out;
        }
        .sidebar.collapsed {
            transform: translateX(-100%);
        }
        .content {
            margin-left: 250px;
            transition: margin-left 0.3s ease-in-out;
        }
        .content.shifted {
            margin-left: 0;
        }
        .card {
            background: rgba(30, 30, 30, 0.7);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .btn-premium {
            background: linear-gradient(135deg, #8a2be2, #00e5ff);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-premium:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
        }
        .table-hover tbody tr:hover {
            background-color: rgba(138, 43, 226, 0.1);
            cursor: pointer;
        }
    </style>
</head>
<body class="antialiased">
<div class="flex">
    <!-- Sidebar -->
    <div id="sidebar" class="sidebar z-50">
        <div class="p-6">
            <h2 class="text-2xl font-bold mb-6 text-white">Seller Panel</h2>
            <ul class="space-y-4">
                <li><a href="#inventory" class="block text-white hover:text-purple-300 transition-colors">Inventory Management</a></li>
                <li><a href="#orders" class="block text-white hover:text-purple-300 transition-colors">Order Management</a></li>
                <li><a href="#inquiries" class="block text-white hover:text-purple-300 transition-colors">Customer Inquiries</a></li>
                <li><a href="#profile" class="block text-white hover:text-purple-300 transition-colors">Profile</a></li>
                <li><a href="logout.jsp" class="block text-white hover:text-purple-300 transition-colors">Logout</a></li>
            </ul>
        </div>
    </div>

    <!-- Main Content -->
    <div id="content" class="content flex-1 p-6 min-h-screen">
        <button id="toggleSidebar" class="mb-4 p-2 bg-gray-800 text-white rounded-md focus:outline-none">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path>
            </svg>
        </button>

        <!-- Welcome Section -->
        <div class="card mb-6 p-6">
            <h1 class="text-3xl font-bold mb-4">Welcome, <% out.print(session.getAttribute("sellerName") != null ? session.getAttribute("sellerName") : "Seller"); %>!</h1>
            <p class="text-gray-300">Manage your inventory, track orders, and respond to customers with ease.</p>
        </div>

        <!-- Inventory Management -->
        <div id="inventory" class="card mb-6 p-6">
            <h2 class="text-2xl font-semibold mb-4">Inventory Management</h2>
            <form class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-300">Instrument Name</label>
                    <input type="text" class="w-full p-2 bg-gray-900 border border-gray-700 rounded-md" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-300">Price ($)</label>
                    <input type="number" step="0.01" class="w-full p-2 bg-gray-900 border border-gray-700 rounded-md" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-300">Stock</label>
                    <input type="number" class="w-full p-2 bg-gray-900 border border-gray-700 rounded-md" required>
                </div>
                <button type="submit" class="btn-premium text-white px-4 py-2 rounded-md">Add Instrument</button>
            </form>
            <div class="mt-6 overflow-x-auto">
                <table class="w-full text-left">
                    <thead>
                    <tr class="border-b border-gray-700">
                        <th class="p-2">Instrument</th>
                        <th class="p-2">Price</th>
                        <th class="p-2">Stock</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="table-hover">
                    <tr>
                        <td class="p-2">Acoustic Guitar</td>
                        <td class="p-2">$299.99</td>
                        <td class="p-2">15</td>
                        <td class="p-2">
                            <button class="btn-premium text-white px-2 py-1 rounded-md">Edit</button>
                            <button class="bg-red-700 text-white px-2 py-1 rounded-md ml-2">Delete</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="p-2">Electric Drum Set</td>
                        <td class="p-2">$799.99</td>
                        <td class="p-2">8</td>
                        <td class="p-2">
                            <button class="btn-premium text-white px-2 py-1 rounded-md">Edit</button>
                            <button class="bg-red-700 text-white px-2 py-1 rounded-md ml-2">Delete</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Order Management -->
        <div id="orders" class="card mb-6 p-6">
            <h2 class="text-2xl font-semibold mb-4">Order Management</h2>
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead>
                    <tr class="border-b border-gray-700">
                        <th class="p-2">Order ID</th>
                        <th class="p-2">Customer</th>
                        <th class="p-2">Instrument</th>
                        <th class="p-2">Status</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="table-hover">
                    <tr>
                        <td class="p-2">#ORD001</td>
                        <td class="p-2">John Doe</td>
                        <td class="p-2">Acoustic Guitar</td>
                        <td class="p-2">Processing</td>
                        <td class="p-2">
                            <button class="btn-premium text-white px-2 py-1 rounded-md">Update</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="p-2">#ORD002</td>
                        <td class="p-2">Jane Smith</td>
                        <td class="p-2">Electric Drum Set</td>
                        <td class="p-2">Shipped</td>
                        <td class="p-2">
                            <button class="btn-premium text-white px-2 py-1 rounded-md">Update</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Customer Inquiries -->
        <div id="inquiries" class="card mb-6 p-6">
            <h2 class="text-2xl font-semibold mb-4">Customer Inquiries</h2>
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead>
                    <tr class="border-b border-gray-700">
                        <th class="p-2">ID</th>
                        <th class="p-2">Customer</th>
                        <th class="p-2">Message</th>
                        <th class="p-2">Status</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="table-hover">
                    <tr>
                        <td class="p-2">#INQ001</td>
                        <td class="p-2">Alex Brown</td>
                        <td class="p-2">Need help with order #ORD001</td>
                        <td class="p-2">Pending</td>
                        <td class="p-2">
                            <button class="btn-premium text-white px-2 py-1 rounded-md">Reply</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="p-2">#INQ002</td>
                        <td class="p-2">Sara Lee</td>
                        <td class="p-2">Delivery status for #ORD002</td>
                        <td class="p-2">Pending</td>
                        <td class="p-2">
                            <button class="btn-premium text-white px-2 py-1 rounded-md">Reply</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Profile -->
        <div id="profile" class="card p-6">
            <h2 class="text-2xl font-semibold mb-4">Profile</h2>
            <div class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-300">Seller Name</label>
                    <input type="text" value="<% out.print(session.getAttribute("sellerName") != null ? session.getAttribute("sellerName") : "Seller Name"); %>" class="w-full p-2 bg-gray-900 border border-gray-700 rounded-md" readonly>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-300">Email</label>
                    <input type="email" value="seller@example.com" class="w-full p-2 bg-gray-900 border border-gray-700 rounded-md" readonly>
                </div>
                <button class="btn-premium text-white px-4 py-2 rounded-md">Edit Profile</button>
            </div>
        </div>
    </div>
</div>

<script>
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    const toggleSidebar = document.getElementById('toggleSidebar');

    toggleSidebar.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
        content.classList.toggle('shifted');
    });

    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({ behavior: 'smooth' });
        });
    });
</script>
</body>
</html>