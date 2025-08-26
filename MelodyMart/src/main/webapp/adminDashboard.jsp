<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Admin Dashboard</title>
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

        .glass-effect {
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar {
            transition: transform 0.3s ease-in-out;
            background: rgba(0, 0, 0, 0.9);
            backdrop-filter: blur(15px);
        }

        .sidebar-hidden {
            transform: translateX(-100%);
        }

        .admin-card {
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .admin-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 255, 255, 0.1);
        }

        .action-button {
            transition: all 0.3s ease;
        }

        .action-button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.3);
        }

        .nav-link {
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }

        .nav-link:hover {
            background: rgba(59, 130, 246, 0.2);
            border-left: 3px solid #3B82F6;
            transform: translateX(5px);
        }

        .performance-card {
            background: linear-gradient(135deg, rgba(59, 130, 246, 0.2), rgba(147, 51, 234, 0.2));
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: transform 0.3s ease;
        }

        .performance-card:hover {
            transform: scale(1.02);
        }

        .table-row {
            background: rgba(255, 255, 255, 0.05);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            transition: background 0.3s ease;
        }

        .table-row:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .section-divider {
            border-image: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent) 1;
        }

        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                z-index: 40;
                height: 100vh;
            }
        }
    </style>
</head>
<body class="relative">

<!-- Header Navigation -->
<header class="glass-effect p-6 z-30 relative">
    <div class="flex justify-between items-center">
        <div class="flex items-center space-x-4">
            <button id="sidebarToggle" class="md:hidden text-white hover:text-blue-300 transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                </svg>
            </button>
            <div class="text-3xl font-bold font-['Bebas+Neue'] text-white">MelodyMart Admin</div>
        </div>
        <div class="flex items-center space-x-4">
            <span class="text-blue-300">Welcome, Admin</span>
            <button onclick="window.location.href='index.jsp'" class="px-4 py-2 bg-blue-600 hover:bg-blue-700 rounded-lg transition-all duration-300 hover:scale-105">
                Back to Site
            </button>
            <button onclick="window.location.href='logout.jsp'" class="px-4 py-2 bg-red-600 hover:bg-red-700 rounded-lg transition-all duration-300 hover:scale-105">
                Logout
            </button>
        </div>
    </div>
</header>

<!-- Main Content -->
<div class="flex min-h-screen relative">
    <!-- Sidebar -->
    <aside id="sidebar" class="w-64 sidebar shadow-2xl z-20">
        <div class="p-6">
            <h2 class="text-xl font-semibold mb-6 text-blue-300 font-['Bebas+Neue']">Dashboard Navigation</h2>
            <ul class="space-y-2">
                <li><a href="#users" class="nav-link block py-3 px-4 rounded-lg text-white hover:text-blue-300">👥 User Management</a></li>
                <li><a href="#listings" class="nav-link block py-3 px-4 rounded-lg text-white hover:text-blue-300">📋 Listing Moderation</a></li>
                <li><a href="#feedback" class="nav-link block py-3 px-4 rounded-lg text-white hover:text-blue-300">💬 Feedback Moderation</a></li>
                <li><a href="#performance" class="nav-link block py-3 px-4 rounded-lg text-white hover:text-blue-300">📊 System Performance</a></li>
                <li><a href="#reports" class="nav-link block py-3 px-4 rounded-lg text-white hover:text-blue-300">📈 Reports</a></li>
            </ul>
        </div>
    </aside>

    <!-- Main Dashboard -->
    <main class="flex-1 p-6 ml-0 md:ml-0 transition-all duration-300">
        <!-- User Management -->
        <section id="users" class="mb-12">
            <h2 class="text-3xl font-bold mb-6 text-white font-['Bebas+Neue']">User Management</h2>
            <div class="admin-card p-6 rounded-xl">
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                        <tr class="border-b border-gray-600">
                            <th class="p-4 text-left text-blue-300 font-semibold">User ID</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Username</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Email</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Status</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="table-row">
                            <td class="p-4 text-white">001</td>
                            <td class="p-4 text-white">john_doe</td>
                            <td class="p-4 text-white">john@example.com</td>
                            <td class="p-4">
                                <span class="px-3 py-1 bg-green-600 text-white rounded-full text-sm">Active</span>
                            </td>
                            <td class="p-4 space-x-2">
                                <button onclick="approveUser(1)" class="action-button bg-green-600 hover:bg-green-700 text-white px-3 py-2 rounded-lg text-sm">
                                    ✓ Approve
                                </button>
                                <button onclick="deleteUser(1)" class="action-button bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded-lg text-sm">
                                    ✕ Delete
                                </button>
                            </td>
                        </tr>
                        <tr class="table-row">
                            <td class="p-4 text-white">002</td>
                            <td class="p-4 text-white">music_lover</td>
                            <td class="p-4 text-white">lover@example.com</td>
                            <td class="p-4">
                                <span class="px-3 py-1 bg-yellow-600 text-white rounded-full text-sm">Pending</span>
                            </td>
                            <td class="p-4 space-x-2">
                                <button onclick="approveUser(2)" class="action-button bg-green-600 hover:bg-green-700 text-white px-3 py-2 rounded-lg text-sm">
                                    ✓ Approve
                                </button>
                                <button onclick="deleteUser(2)" class="action-button bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded-lg text-sm">
                                    ✕ Delete
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <hr class="section-divider mb-12">

        <!-- Listing Moderation -->
        <section id="listings" class="mb-12">
            <h2 class="text-3xl font-bold mb-6 text-white font-['Bebas+Neue']">Listing Moderation</h2>
            <div class="admin-card p-6 rounded-xl">
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                        <tr class="border-b border-gray-600">
                            <th class="p-4 text-left text-blue-300 font-semibold">Listing ID</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Title</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Seller</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Price</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Status</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="table-row">
                            <td class="p-4 text-white">L101</td>
                            <td class="p-4 text-white">Yamaha Acoustic Guitar</td>
                            <td class="p-4 text-white">john_doe</td>
                            <td class="p-4 text-green-400 font-semibold">$299</td>
                            <td class="p-4">
                                <span class="px-3 py-1 bg-yellow-600 text-white rounded-full text-sm">Pending</span>
                            </td>
                            <td class="p-4 space-x-2">
                                <button onclick="approveListing(101)" class="action-button bg-green-600 hover:bg-green-700 text-white px-3 py-2 rounded-lg text-sm">
                                    ✓ Approve
                                </button>
                                <button onclick="deleteListing(101)" class="action-button bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded-lg text-sm">
                                    ✕ Delete
                                </button>
                            </td>
                        </tr>
                        <tr class="table-row">
                            <td class="p-4 text-white">L102</td>
                            <td class="p-4 text-white">Roland Electric Keyboard</td>
                            <td class="p-4 text-white">music_lover</td>
                            <td class="p-4 text-green-400 font-semibold">$599</td>
                            <td class="p-4">
                                <span class="px-3 py-1 bg-green-600 text-white rounded-full text-sm">Approved</span>
                            </td>
                            <td class="p-4 space-x-2">
                                <button onclick="viewListing(102)" class="action-button bg-blue-600 hover:bg-blue-700 text-white px-3 py-2 rounded-lg text-sm">
                                    👁 View
                                </button>
                                <button onclick="deleteListing(102)" class="action-button bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded-lg text-sm">
                                    ✕ Delete
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <hr class="section-divider mb-12">

        <!-- Feedback Moderation -->
        <section id="feedback" class="mb-12">
            <h2 class="text-3xl font-bold mb-6 text-white font-['Bebas+Neue']">Feedback Moderation</h2>
            <div class="admin-card p-6 rounded-xl">
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                        <tr class="border-b border-gray-600">
                            <th class="p-4 text-left text-blue-300 font-semibold">Feedback ID</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">User</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Product</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Rating</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Comment</th>
                            <th class="p-4 text-left text-blue-300 font-semibold">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="table-row">
                            <td class="p-4 text-white">F201</td>
                            <td class="p-4 text-white">john_doe</td>
                            <td class="p-4 text-white">Yamaha Guitar</td>
                            <td class="p-4">
                                <div class="flex text-yellow-400">★★★★★</div>
                            </td>
                            <td class="p-4 text-white max-w-xs truncate">Amazing sound quality and build!</td>
                            <td class="p-4 space-x-2">
                                <button onclick="approveFeedback(201)" class="action-button bg-green-600 hover:bg-green-700 text-white px-3 py-2 rounded-lg text-sm">
                                    ✓ Approve
                                </button>
                                <button onclick="deleteFeedback(201)" class="action-button bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded-lg text-sm">
                                    ✕ Delete
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <hr class="section-divider mb-12">

        <!-- System Performance -->
        <section id="performance" class="mb-12">
            <h2 class="text-3xl font-bold mb-6 text-white font-['Bebas+Neue']">System Performance</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                <div class="performance-card p-6 rounded-xl text-center">
                    <h3 class="text-lg font-semibold text-blue-300 mb-2">System Uptime</h3>
                    <p class="text-3xl font-bold text-green-400">99.9%</p>
                    <p class="text-sm text-gray-300 mt-2">Last 30 days</p>
                </div>
                <div class="performance-card p-6 rounded-xl text-center">
                    <h3 class="text-lg font-semibold text-blue-300 mb-2">Active Users</h3>
                    <p class="text-3xl font-bold text-blue-400">1,234</p>
                    <p class="text-sm text-gray-300 mt-2">Currently online</p>
                </div>
                <div class="performance-card p-6 rounded-xl text-center">
                    <h3 class="text-lg font-semibold text-blue-300 mb-2">Server Load</h3>
                    <p class="text-3xl font-bold text-yellow-400">45%</p>
                    <p class="text-sm text-gray-300 mt-2">CPU Usage</p>
                </div>
                <div class="performance-card p-6 rounded-xl text-center">
                    <h3 class="text-lg font-semibold text-blue-300 mb-2">Total Sales</h3>
                    <p class="text-3xl font-bold text-purple-400">$45.2K</p>
                    <p class="text-sm text-gray-300 mt-2">This month</p>
                </div>
            </div>
        </section>

        <hr class="section-divider mb-12">

        <!-- Reports -->
        <section id="reports">
            <h2 class="text-3xl font-bold mb-6 text-white font-['Bebas+Neue']">Generate Reports</h2>
            <div class="admin-card p-6 rounded-xl">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <button onclick="generateSalesReport()" class="action-button bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 text-white px-6 py-4 rounded-xl text-lg font-semibold">
                        📊 Sales Report
                    </button>
                    <button onclick="generateUserReport()" class="action-button bg-gradient-to-r from-green-600 to-blue-600 hover:from-green-700 hover:to-blue-700 text-white px-6 py-4 rounded-xl text-lg font-semibold">
                        👥 User Report
                    </button>
                    <button onclick="generatePerformanceReport()" class="action-button bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white px-6 py-4 rounded-xl text-lg font-semibold">
                        ⚡ Performance Report
                    </button>
                </div>
            </div>
        </section>
    </main>
</div>

<script>
    // Sidebar toggle functionality
    document.getElementById('sidebarToggle').addEventListener('click', function() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('sidebar-hidden');
    });

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Enhanced JavaScript functions for actions
    function approveUser(id) {
        showNotification(`Approving user with ID: ${id}`, 'success');
        // Add server-side logic to approve user
    }

    function deleteUser(id) {
        if (confirm(`Are you sure you want to delete user with ID: ${id}?`)) {
            showNotification(`Deleting user with ID: ${id}`, 'error');
            // Add server-side logic to delete user
        }
    }

    function approveListing(id) {
        showNotification(`Approving listing with ID: ${id}`, 'success');
        // Add server-side logic to approve listing
    }

    function deleteListing(id) {
        if (confirm(`Are you sure you want to delete listing with ID: ${id}?`)) {
            showNotification(`Deleting listing with ID: ${id}`, 'error');
            // Add server-side logic to delete listing
        }
    }

    function viewListing(id) {
        showNotification(`Opening listing details for ID: ${id}`, 'info');
        // Add logic to view listing details
    }

    function approveFeedback(id) {
        showNotification(`Approving feedback with ID: ${id}`, 'success');
        // Add server-side logic to approve feedback
    }

    function deleteFeedback(id) {
        if (confirm(`Are you sure you want to delete feedback with ID: ${id}?`)) {
            showNotification(`Deleting feedback with ID: ${id}`, 'error');
            // Add server-side logic to delete feedback
        }
    }

    function generateSalesReport() {
        showNotification("Generating sales report...", 'info');
        // Add server-side logic to generate sales report
    }

    function generateUserReport() {
        showNotification("Generating user report...", 'info');
        // Add server-side logic to generate user report
    }

    function generatePerformanceReport() {
        showNotification("Generating performance report...", 'info');
        // Add server-side logic to generate performance report
    }

    // Enhanced notification system
    function showNotification(message, type) {
        const notification = document.createElement('div');
        notification.className = `fixed top-4 right-4 px-6 py-3 rounded-lg text-white z-50 transform transition-all duration-300 translate-x-full`;

        switch(type) {
            case 'success':
                notification.classList.add('bg-green-600');
                break;
            case 'error':
                notification.classList.add('bg-red-600');
                break;
            case 'info':
                notification.classList.add('bg-blue-600');
                break;
            default:
                notification.classList.add('bg-gray-600');
        }

        notification.textContent = message;
        document.body.appendChild(notification);

        // Trigger animation
        setTimeout(() => {
            notification.classList.remove('translate-x-full');
        }, 100);

        // Remove after 3 seconds
        setTimeout(() => {
            notification.classList.add('translate-x-full');
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        }, 3000);
    }

    // Add current date and time like in index.jsp
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

    const timeDisplay = document.createElement('div');
    timeDisplay.className = 'fixed bottom-4 right-4 glass-effect px-4 py-2 rounded-lg text-sm text-blue-300';
    timeDisplay.textContent = dateTime;
    document.body.appendChild(timeDisplay);
</script>
</body>
</html>