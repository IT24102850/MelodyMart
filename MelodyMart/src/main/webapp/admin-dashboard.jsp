<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Admin Nexus</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon_io%20(9)/favicon.ico">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Orbitron:wght@400;700&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #0a0f1c, #1a2a44);
            background-size: cover;
            background-attachment: fixed;
            min-height: 100vh;
            font-family: 'Orbitron', sans-serif;
            color: #e0e7ff;
            overflow-x: hidden;
            position: relative;
        }
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('./images/1162694.jpg') no-repeat center/cover;
            opacity: 0.1;
            z-index: -1;
        }
        .dashboard-card {
            background: rgba(10, 15, 28, 0.9);
            border: 1px solid #2a4066;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5), 0 0 20px rgba(42, 64, 102, 0.3);
            backdrop-filter: blur(5px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.6), 0 0 30px rgba(42, 64, 102, 0.5);
        }
        .table-section {
            max-height: 350px;
            overflow-y: auto;
            scrollbar-width: thin;
            scrollbar-color: #4a90e2 #1a2a44;
        }
        .table-section::-webkit-scrollbar {
            width: 8px;
        }
        .table-section::-webkit-scrollbar-thumb {
            background-color: #4a90e2;
            border-radius: 4px;
        }
        .cta-button {
            background: linear-gradient(45deg, #4a90e2, #50e3c2);
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            color: #fff;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .cta-button:hover {
            transform: scale(1.1);
            box-shadow: 0 0 20px rgba(74, 144, 226, 0.7);
        }
        .notification {
            background: #ff4444;
            padding: 8px 16px;
            border-radius: 20px;
            animation: pulse 1.5s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .sidebar {
            background: linear-gradient(135deg, #0a0f1c, #1a2a44);
            width: 250px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            transition: transform 0.3s ease;
            z-index: 100;
            box-shadow: 2px 0 15px rgba(0, 0, 0, 0.5);
            overflow-y: auto;
        }
        .sidebar.collapsed {
            transform: translateX(-100%);
        }
        .sidebar-toggle {
            position: absolute;
            top: 10px;
            right: -40px;
            background: #4a90e2;
            border: none;
            padding: 8px;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            transition: background 0.3s ease;
            z-index: 101;
        }
        .sidebar-toggle:hover {
            background: #50e3c2;
        }
        .nav-item {
            padding: 12px 20px;
            color: #e0e7ff;
            font-family: 'Orbitron', sans-serif;
            transition: background 0.3s ease, color 0.3s ease;
            display: block;
        }
        .nav-item:hover, .nav-item.active {
            background: #2a4066;
            color: #50e3c2;
            border-left: 4px solid #4a90e2;
        }
        .nav-section {
            margin-bottom: 10px;
        }
        .nav-section h4 {
            padding: 8px 20px;
            font-size: 0.875rem;
            color: #a0b4d8;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .profile-toggle {
            cursor: pointer;
            padding: 10px 20px;
            margin-top: auto;
            transition: background 0.3s ease;
        }
        .profile-toggle:hover {
            background: #2a4066;
        }
        .profile-details {
            display: none;
            padding: 10px 20px;
            background: #1a2a44;
        }
        .sidebar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('./images/1162694.jpg') no-repeat center/cover;
            opacity: 0.15;
            z-index: -1;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        @media (max-width: 640px) {
            .dashboard-card {
                padding: 1rem;
            }
            .dashboard-card h2 {
                font-size: 1.5rem;
            }
            .dashboard-card p, .dashboard-card th, .dashboard-card td {
                font-size: 0.875rem;
            }
            .cta-button {
                width: 100%;
                margin: 0.5rem 0;
            }
            .table-section {
                max-height: 200px;
            }
            .sidebar {
                width: 200px;
            }
            .nav-item, .profile-toggle, .nav-section h4 {
                font-size: 0.875rem;
                padding: 10px 15px;
            }
            .profile-details {
                font-size: 0.75rem;
            }
            .cta-button {
                margin: 10px 15px;
            }
            main {
                margin-left: 0;
            }
        }
        @media (min-width: 641px) {
            .dashboard-card {
                padding: 2rem;
            }
            main {
                margin-left: 250px;
            }
        }
    </style>
</head>
<body class="relative">
<!-- Header Navigation -->
<header class="flex justify-between items-center p-6 z-10 relative">
    <div class="text-3xl font-bold font-['Bebas+Neue']">MelodyMart</div>
    <nav class="flex space-x-6 items-center">
        <a href="index.jsp" class="text-lg hover:text-blue-300">Home</a>
        <a href="instruments.jsp" class="text-lg hover:text-blue-300">Instruments</a>
        <a href="accessories.jsp" class="text-lg hover:text-blue-300">Accessories</a>
        <a href="deals.jsp" class="text-lg hover:text-blue-300">Deals</a>
        <a href="contact-us.jsp" class="text-lg hover:text-blue-300">Contact Us</a>
        <button class="auth-button" id="signInBtn">Sign In</button>
        <button class="auth-button" id="signUpBtn">Sign Up</button>
    </nav>
</header>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>
    <nav class="mt-16">
        <div class="nav-section">
            <h4>Main</h4>
            <a href="#" class="nav-item block" onclick="showTab('dashboard')">Dashboard</a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="#" class="nav-item block" onclick="showTab('users')">Users</a>
            <a href="#" class="nav-item block" onclick="showTab('products')">Products</a>
            <a href="#" class="nav-item block" onclick="showTab('orders')">Orders</a>
            <a href="#" class="nav-item block" onclick="showTab('reviews')">Reviews</a>
        </div>
        <div class="nav-section">
            <h4>Settings</h4>
            <a href="#" class="nav-item block" onclick="showTab('settings')">Settings</a>
        </div>
    </nav>
    <div class="profile-toggle" onclick="toggleProfile()">
        <span>Admin Profile</span>
    </div>
    <div class="profile-details" id="profileDetails">
        <p><strong>Name:</strong> <%= request.getSession().getAttribute("adminName") != null ? request.getSession().getAttribute("adminName") : "Admin User" %></p>
        <p><strong>Email:</strong> <%= request.getSession().getAttribute("adminEmail") != null ? request.getSession().getAttribute("adminEmail") : "admin@melodymart.com" %></p>
        <p><strong>Role:</strong> <%= request.getSession().getAttribute("adminRole") != null ? request.getSession().getAttribute("adminRole") : "Super Admin" %></p>
    </div>
    <button class="cta-button mt-4" onclick="logout()">Exit Nexus</button>
</div>

<!-- Main Content -->
<main class="p-4 md:p-6 relative z-10 transition-margin duration-300">
    <div class="max-w-6xl mx-auto">
        <div class="dashboard-card p-4 md:p-6">
            <!-- Tab Content -->
            <div id="dashboard" class="tab-content active">
                <h2 class="text-3xl md:text-4xl font-bold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-cyan-300">Admin Nexus</h2>
                <div class="mb-6">
                    <p class="notification inline-block">2 New Orders Pending!</p>
                </div>
            </div>

            <div id="users" class="tab-content">
                <h2 class="text-3xl md:text-4xl font-bold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-cyan-300">User Management</h2>
                <div class="table-section">
                    <table class="w-full text-left">
                        <thead class="bg-gray-800">
                        <tr>
                            <th class="p-3 border-b border-gray-600">ID</th>
                            <th class="p-3 border-b border-gray-600">Name</th>
                            <th class="p-3 border-b border-gray-600">Email</th>
                            <th class="p-3 border-b border-gray-600">Role</th>
                            <th class="p-3 border-b border-gray-600">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="hover:bg-gray-700 transition-colors">
                            <td class="p-3 border-b border-gray-600">1</td>
                            <td class="p-3 border-b border-gray-600">John Doe</td>
                            <td class="p-3 border-b border-gray-600">john.doe@example.com</td>
                            <td class="p-3 border-b border-gray-600">Customer</td>
                            <td class="p-3 border-b border-gray-600"><button class="cta-button text-xs">Edit</button></td>
                        </tr>
                        <tr class="hover:bg-gray-700 transition-colors">
                            <td class="p-3 border-b border-gray-600">2</td>
                            <td class="p-3 border-b border-gray-600">Jane Smith</td>
                            <td class="p-3 border-b border-gray-600">jane.smith@example.com</td>
                            <td class="p-3 border-b border-gray-600">Admin</td>
                            <td class="p-3 border-b border-gray-600"><button class="cta-button text-xs">Edit</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <button class="cta-button mt-4">Add New User</button>
            </div>

            <div id="products" class="tab-content">
                <h2 class="text-3xl md:text-4xl font-bold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-cyan-300">Product Management</h2>
                <div class="table-section">
                    <table class="w-full text-left">
                        <thead class="bg-gray-800">
                        <tr>
                            <th class="p-3 border-b border-gray-600">ID</th>
                            <th class="p-3 border-b border-gray-600">Name</th>
                            <th class="p-3 border-b border-gray-600">Price</th>
                            <th class="p-3 border-b border-gray-600">Category</th>
                            <th class="p-3 border-b border-gray-600">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="hover:bg-gray-700 transition-colors">
                            <td class="p-3 border-b border-gray-600">1</td>
                            <td class="p-3 border-b border-gray-600">Acoustic Guitar</td>
                            <td class="p-3 border-b border-gray-600">$299.99</td>
                            <td class="p-3 border-b border-gray-600">Instruments</td>
                            <td class="p-3 border-b border-gray-600"><button class="cta-button text-xs">Edit</button></td>
                        </tr>
                        <tr class="hover:bg-gray-700 transition-colors">
                            <td class="p-3 border-b border-gray-600">2</td>
                            <td class="p-3 border-b border-gray-600">Guitar Strings</td>
                            <td class="p-3 border-b border-gray-600">$9.99</td>
                            <td class="p-3 border-b border-gray-600">Accessories</td>
                            <td class="p-3 border-b border-gray-600"><button class="cta-button text-xs">Edit</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <button class="cta-button mt-4">Add New Product</button>
            </div>

            <div id="orders" class="tab-content">
                <h2 class="text-3xl md:text-4xl font-bold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-cyan-300">Order Management</h2>
                <div class="table-section">
                    <table class="w-full text-left">
                        <thead class="bg-gray-800">
                        <tr>
                            <th class="p-3 border-b border-gray-600">Order ID</th>
                            <th class="p-3 border-b border-gray-600">User</th>
                            <th class="p-3 border-b border-gray-600">Item</th>
                            <th class="p-3 border-b border-gray-600">Status</th>
                            <th class="p-3 border-b border-gray-600">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="hover:bg-gray-700 transition-colors">
                            <td class="p-3 border-b border-gray-600">1234</td>
                            <td class="p-3 border-b border-gray-600">John Doe</td>
                            <td class="p-3 border-b border-gray-600">Acoustic Guitar</td>
                            <td class="p-3 border-b border-gray-600">Delivered</td>
                            <td class="p-3 border-b border-gray-600"><button class="cta-button text-xs">Update</button></td>
                        </tr>
                        <tr class="hover:bg-gray-700 transition-colors">
                            <td class="p-3 border-b border-gray-600">1235</td>
                            <td class="p-3 border-b border-gray-600">Jane Smith</td>
                            <td class="p-3 border-b border-gray-600">Drum Sticks</td>
                            <td class="p-3 border-b border-gray-600">Shipped</td>
                            <td class="p-3 border-b border-gray-600"><button class="cta-button text-xs">Update</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <button class="cta-button mt-4">View All Orders</button>
            </div>

            <div id="reviews" class="tab-content">
                <h2 class="text-3xl md:text-4xl font-bold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-cyan-300">Review Management</h2>
                <div class="table-section">
                    <table class="w-full text-left">
                        <thead class="bg-gray-800">
                        <tr>
                            <th class="p-3 border-b border-gray-600">ID</th>
                            <th class="p-3 border-b border-gray-600">User</th>
                            <th class="p-3 border-b border-gray-600">Product</th>
                            <th class="p-3 border-b border-gray-600">Rating</th>
                            <th class="p-3 border-b border-gray-600">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="hover:bg-gray-700 transition-colors">
                            <td class="p-3 border-b border-gray-600">1</td>
                            <td class="p-3 border-b border-gray-600">John Doe</td>
                            <td class="p-3 border-b border-gray-600">Acoustic Guitar</td>
                            <td class="p-3 border-b border-gray-600">4.5/5</td>
                            <td class="p-3 border-b border-gray-600"><button class="cta-button text-xs">Approve</button></td>
                        </tr>
                        <tr class="hover:bg-gray-700 transition-colors">
                            <td class="p-3 border-b border-gray-600">2</td>
                            <td class="p-3 border-b border-gray-600">Jane Smith</td>
                            <td class="p-3 border-b border-gray-600">Guitar Strings</td>
                            <td class="p-3 border-b border-gray-600">4.0/5</td>
                            <td class="p-3 border-b border-gray-600"><button class="cta-button text-xs">Approve</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <button class="cta-button mt-4">View All Reviews</button>
            </div>

            <div id="settings" class="tab-content">
                <h2 class="text-3xl md:text-4xl font-bold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-cyan-300">Settings</h2>
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm md:text-base text-blue-300">Theme</label>
                        <select class="w-full p-2 bg-gray-800 border border-gray-600 rounded-lg text-white focus:outline-none">
                            <option>Dark</option>
                            <option>Light</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm md:text-base text-blue-300">Notifications</label>
                        <input type="checkbox" class="mr-2" checked> Enable Notifications
                    </div>
                </div>
                <button class="cta-button mt-4">Save Settings</button>
            </div>

            <!-- Logout Button -->
            <button class="bg-red-600 text-white px-6 py-3 rounded-full text-base font-semibold cta-button mt-6" onclick="logout()">Exit Nexus</button>
        </div>
    </div>
</main>

<script>
    // Toggle Sidebar
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('collapsed');
    }

    // Toggle Profile Details
    function toggleProfile() {
        const profileDetails = document.getElementById('profileDetails');
        profileDetails.style.display = profileDetails.style.display === 'block' ? 'none' : 'block';
    }

    // Logout Function
    function logout() {
        if(confirm('Are you sure you want to logout?')) {
            window.location.href = 'LogoutServlet'; // Replace with your logout servlet URL
        }
    }

    // Highlight active page and show corresponding tab
    function showTab(tabId) {
        document.querySelectorAll('.tab-content').forEach(tab => {
            tab.classList.remove('active');
        });
        document.getElementById(tabId).classList.add('active');
        document.querySelectorAll('.nav-item').forEach(item => {
            item.classList.remove('active');
            if (item.getAttribute('onclick').includes(tabId)) {
                item.classList.add('active');
            }
        });
    }

    // Display current date/time
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
    document.body.innerHTML += `<p class="text-center mt-4 text-sm md:text-base text-gray-400">${dateTime}</p>`;

    // Adjust main content margin based on window size
    window.addEventListener('resize', () => {
        const width = window.innerWidth;
        document.querySelector('main').style.marginLeft = width > 640 ? '250px' : '0';
        const sidebar = document.getElementById('sidebar');
        if (width <= 640) sidebar.classList.add('collapsed');
        else sidebar.classList.remove('collapsed');
    });
    // Initial check
    if (window.innerWidth <= 640) {
        document.getElementById('sidebar').classList.add('collapsed');
    }
</script>
</body>
</html>