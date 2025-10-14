<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Seller Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #8B5CF6;
            --primary-dark: #7C3AED;
            --primary-light: #A78BFA;
            --secondary: #06D6A0;
            --accent: #FF6B6B;
            --text-dark: #1E293B;
            --text-light: #64748B;
            --bg-light: #F8FAFC;
            --bg-white: #FFFFFF;
            --shadow: 0 10px 25px rgba(139, 92, 246, 0.15);
            --shadow-light: 0 5px 15px rgba(139, 92, 246, 0.1);
            --gradient: linear-gradient(135deg, #8B5CF6 0%, #06D6A0 100%);
            --gradient-card: linear-gradient(135deg, #8B5CF6 0%, #A78BFA 100%);
            --gradient-stats: linear-gradient(135deg, #06D6A0 0%, #4CC9F0 100%);
        }

        body {
            background: linear-gradient(135deg, #F0F9FF 0%, #E1F5FE 50%, #F3E8FF 100%);
            color: var(--text-dark);
            min-height: 100vh;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                    radial-gradient(circle at 10% 20%, rgba(139, 92, 246, 0.1) 0%, transparent 20%),
                    radial-gradient(circle at 90% 80%, rgba(6, 214, 160, 0.1) 0%, transparent 20%),
                    radial-gradient(circle at 50% 50%, rgba(255, 107, 107, 0.05) 0%, transparent 20%);
            z-index: -1;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Header Styles */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            margin-bottom: 30px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 28px;
            font-weight: 700;
            color: var(--primary);
            text-shadow: 0 2px 4px rgba(139, 92, 246, 0.2);
        }

        .logo i {
            font-size: 32px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logout-btn {
            background: linear-gradient(135deg, #FF6B6B, #EF4444);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            background: linear-gradient(135deg, #EF4444, #DC2626);
        }

        .user-profile {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            cursor: pointer;
            box-shadow: var(--shadow);
            transition: transform 0.3s ease;
        }

        .user-profile:hover {
            transform: scale(1.05);
        }

        /* Dashboard Header */
        .dashboard-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }

        .dashboard-header h1 {
            font-size: 42px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .dashboard-header p {
            font-size: 18px;
            color: var(--text-light);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .welcome-message {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 20px;
            margin-top: 20px;
            box-shadow: var(--shadow-light);
            border-left: 4px solid var(--primary);
        }

        .welcome-message h3 {
            color: var(--primary);
            margin-bottom: 10px;
            font-size: 20px;
        }

        .welcome-message p {
            color: var(--text-light);
            margin: 0;
        }

        /* Section Headers */
        .section-header {
            font-size: 28px;
            color: var(--primary);
            margin: 40px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid rgba(139, 92, 246, 0.2);
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-header i {
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 25px;
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid rgba(139, 92, 246, 0.1);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(139, 92, 246, 0.2);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            background: var(--gradient-stats);
            box-shadow: 0 4px 10px rgba(6, 214, 160, 0.3);
        }

        .stat-info {
            flex: 1;
        }

        .stat-value {
            font-size: 28px;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 14px;
            color: var(--text-light);
            font-weight: 500;
        }

        .stat-change {
            font-size: 12px;
            color: var(--secondary);
            display: flex;
            align-items: center;
            gap: 5px;
            margin-top: 5px;
            font-weight: 600;
        }

        .stat-change.negative {
            color: var(--accent);
        }

        /* Cards Grid */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--bg-white);
            border-radius: 20px;
            padding: 25px;
            box-shadow: var(--shadow-light);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
            border: 1px solid rgba(139, 92, 246, 0.1);
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-card);
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(139, 92, 246, 0.2);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 22px;
            background: var(--gradient-card);
            box-shadow: 0 4px 10px rgba(139, 92, 246, 0.3);
        }

        .card-value {
            font-size: 32px;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        .card-description {
            font-size: 14px;
            color: var(--text-light);
            line-height: 1.5;
            margin-bottom: 15px;
        }

        .card-change {
            font-size: 14px;
            color: var(--secondary);
            display: flex;
            align-items: center;
            gap: 5px;
            margin-top: 10px;
            font-weight: 600;
        }

        .card-change.negative {
            color: var(--accent);
        }

        /* Enhanced Table Styles */
        .table-container {
            overflow-x: auto;
            margin-top: 20px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            background: var(--bg-white);
            padding: 0;
        }

        .instruments-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--bg-white);
            border-radius: 16px;
            overflow: hidden;
            min-width: 1000px;
        }

        .instruments-table th,
        .instruments-table td {
            padding: 16px 20px;
            text-align: left;
            border-bottom: 1px solid rgba(139, 92, 246, 0.1);
        }

        .instruments-table th {
            background: var(--gradient);
            color: white;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: sticky;
            top: 0;
        }

        .instruments-table tr {
            transition: background-color 0.2s ease;
        }

        .instruments-table tr:hover {
            background: rgba(139, 92, 246, 0.05);
        }

        .instruments-table tr:nth-child(even) {
            background: rgba(139, 92, 246, 0.02);
        }

        .instruments-table tr:nth-child(even):hover {
            background: rgba(139, 92, 246, 0.07);
        }

        .instrument-image {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid var(--primary-light);
            box-shadow: 0 2px 5px rgba(139, 92, 246, 0.2);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 0.85rem;
        }

        .btn-edit {
            background: var(--primary);
            color: white;
        }

        .btn-edit:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(139, 92, 246, 0.3);
        }

        .btn-delete {
            background: var(--accent);
            color: white;
        }

        .btn-delete:hover {
            background: #EF4444;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(239, 68, 68, 0.3);
        }

        /* Products List */
        .products-list {
            list-style: none;
            margin-top: 15px;
        }

        .product-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid rgba(139, 92, 246, 0.1);
            transition: background-color 0.2s ease;
        }

        .product-item:hover {
            background: rgba(139, 92, 246, 0.05);
            border-radius: 8px;
            padding-left: 10px;
            padding-right: 10px;
        }

        .product-item:last-child {
            border-bottom: none;
        }

        .product-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            background: rgba(139, 92, 246, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--primary);
            font-size: 20px;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-weight: 600;
            margin-bottom: 4px;
            color: var(--text-dark);
        }

        .product-sales {
            font-size: 14px;
            color: var(--text-light);
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 30px 0;
            color: var(--text-light);
            border-top: 1px solid rgba(139, 92, 246, 0.1);
            margin-top: 30px;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin: 20px 0;
        }

        .footer-links a {
            color: var(--text-light);
            text-decoration: none;
            transition: color 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .footer-links a:hover {
            color: var(--primary);
        }

        .copyright {
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .cards-grid, .stats-grid {
                grid-template-columns: 1fr;
            }

            .footer-links {
                flex-direction: column;
                gap: 10px;
            }

            .header-right {
                gap: 10px;
            }

            .logout-btn span {
                display: none;
            }

            .dashboard-header h1 {
                font-size: 32px;
            }

            .section-header {
                font-size: 24px;
            }
        }

        /* Animation for data updates */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .updating {
            animation: pulse 1s infinite;
        }

        /* Real-time indicator */
        .real-time-indicator {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 12px;
            color: var(--secondary);
            margin-left: 10px;
        }

        .pulse-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--secondary);
            animation: pulse 2s infinite;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Header with Logo and Profile -->
    <header>
        <div class="logo">
            <i class="fas fa-music"></i>
            <span>MelodyMart</span>
        </div>
        <div class="header-right">
            <button class="logout-btn" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </button>
            <div class="user-profile">
                <i class="fas fa-user"></i>
            </div>
        </div>
    </header>

    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h1>Seller Dashboard</h1>
        <p>Welcome back, <span id="sellerName">Melody Mahnaro</span>! Here's your business overview.</p>

        <div class="welcome-message">
            <h3><i class="fas fa-star"></i> Today's Performance</h3>
            <p id="welcomePerformance">You've processed <strong id="todayOrders">12</strong> orders today, generating <strong id="todayRevenue">$1,250</strong> in revenue. Keep up the great work!</p>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value" id="totalSales">$24,580</div>
                <div class="stat-label">Total Sales</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i>
                    <span>12.5% from last month</span>
                </div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value" id="totalOrders">342</div>
                <div class="stat-label">Orders</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i>
                    <span>8.2% from last month</span>
                </div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value" id="totalRevenue">$18,420</div>
                <div class="stat-label">Revenue</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i>
                    <span>5.7% from last month</span>
                </div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value" id="customerRating">4.8/5.0</div>
                <div class="stat-label">Customer Rating</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i>
                    <span>0.2 points improvement</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Navigation Cards -->
    <h2 class="section-header"><i class="fas fa-cogs"></i> Management</h2>
    <div class="cards-grid">
        <!-- Inventory Card -->
        <a href="addInstrument.jsp" class="card inventory">
            <div class="card-header">
                <div class="card-title">Inventory</div>
                <div class="card-icon">
                    <i class="fas fa-box"></i>
                </div>
            </div>
            <div class="card-value" id="productCount">148 Products</div>
            <div class="card-description">Manage your product inventory, update stock levels, and track product performance.</div>
            <div class="card-change">
                <i class="fas fa-arrow-up"></i>
                <span>12 new items this month</span>
            </div>
        </a>

        <!-- Orders Card -->
        <a href="order.jsp" class="card orders">
            <div class="card-header">
                <div class="card-title">Orders</div>
                <div class="card-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
            </div>
            <div class="card-value" id="orderCount">342 Orders</div>
            <div class="card-description">View and manage customer orders, process returns, and track order status.</div>
            <div class="card-change">
                <i class="fas fa-arrow-up"></i>
                <span>8.2% from last month</span>
            </div>
        </a>

        <!-- Deliveries Card -->
        <a href="deliveries.jsp" class="card deliveries">
            <div class="card-header">
                <div class="card-title">Deliveries</div>
                <div class="card-icon">
                    <i class="fas fa-truck"></i>
                </div>
            </div>
            <div class="card-value" id="deliveryCount">45 In Transit</div>
            <div class="card-description">Track shipments, manage delivery schedules, and update shipping status.</div>
            <div class="card-change">
                <i class="fas fa-clock"></i>
                <span>12 delayed deliveries</span>
            </div>
        </a>

        <!-- Repair Requests Card -->
        <a href="repairs.jsp" class="card repairs">
            <div class="card-header">
                <div class="card-title">Repair Requests</div>
                <div class="card-icon">
                    <i class="fas fa-tools"></i>
                </div>
            </div>
            <div class="card-value" id="repairCount">8 Active</div>
            <div class="card-description">Manage instrument repair requests, schedule appointments, and track repair status.</div>
            <div class="card-change">
                <i class="fas fa-exclamation-circle"></i>
                <span>2 high priority requests</span>
            </div>
        </a>

        <!-- Payments Card -->
        <a href="payment.jsp" class="card payments">
            <div class="card-header">
                <div class="card-title">Payments</div>
                <div class="card-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
            </div>
            <div class="card-value" id="paymentAmount">$18,420</div>
            <div class="card-description">View payment history, track transactions, and manage payout settings.</div>
            <div class="card-change">
                <i class="fas fa-arrow-up"></i>
                <span>5.7% from last month</span>
            </div>
        </a>

        <!-- Stock Management Card -->
        <a href="stock.jsp" class="card stock">
            <div class="card-header">
                <div class="card-title">Stock Management</div>
                <div class="card-icon">
                    <i class="fas fa-cubes"></i>
                </div>
            </div>
            <div class="card-value" id="lowStockCount">23 Low Stock</div>
            <div class="card-description">Monitor stock levels, set up reorder alerts, and manage suppliers.</div>
            <div class="card-change negative">
                <i class="fas fa-arrow-down"></i>
                <span>5 items out of stock</span>
            </div>
        </a>
    </div>

    <!-- Reports & Account Section -->
    <h2 class="section-header"><i class="fas fa-chart-bar"></i> Reports & Account</h2>
    <div class="cards-grid">
        <!-- Sales Reports Card -->
        <a href="reports.jsp" class="card reports">
            <div class="card-header">
                <div class="card-title">Sales Reports</div>
                <div class="card-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
            </div>
            <div class="card-value" id="reportCount">15 Reports</div>
            <div class="card-description">Generate detailed sales reports, analyze performance trends, and export data.</div>
            <div class="card-change">
                <i class="fas fa-file-export"></i>
                <span>Export latest data</span>
            </div>
        </a>

        <!-- Notifications Card -->
        <a href="notifications.jsp" class="card notifications">
            <div class="card-header">
                <div class="card-title">Notifications</div>
                <div class="card-icon">
                    <i class="fas fa-bell"></i>
                </div>
            </div>
            <div class="card-value" id="notificationCount">7 Unread</div>
            <div class="card-description">View system notifications, customer messages, and important alerts.</div>
            <div class="card-change">
                <i class="fas fa-envelope"></i>
                <span>3 new messages</span>
            </div>
        </a>

        <!-- Profile Card -->
        <a href="profile.jsp" class="card profile">
            <div class="card-header">
                <div class="card-title">Profile</div>
                <div class="card-icon">
                    <i class="fas fa-user"></i>
                </div>
            </div>
            <div class="card-value" id="profileName">Melody Mahnaro</div>
            <div class="card-description">Update your account information, change password, and manage preferences.</div>
            <div class="card-change">
                <i class="fas fa-cog"></i>
                <span>Update settings</span>
            </div>
        </a>
    </div>

    <!-- Top Products Section -->
    <h2 class="section-header"><i class="fas fa-trophy"></i> Top Products</h2>
    <div class="card">
        <div class="card-header">
            <div class="card-title">Best Selling Instruments</div>
            <div class="card-icon" style="background: var(--gradient-card);">
                <i class="fas fa-guitar"></i>
            </div>
        </div>
        <ul class="products-list">
            <li class="product-item">
                <div class="product-icon">
                    <i class="fas fa-guitar"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Acoustic Guitar</div>
                    <div class="product-sales">128 sold • $12,450 revenue</div>
                </div>
            </li>
            <li class="product-item">
                <div class="product-icon">
                    <i class="fas fa-drum"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Electronic Drum Set</div>
                    <div class="product-sales">76 sold • $9,800 revenue</div>
                </div>
            </li>
            <li class="product-item">
                <div class="product-icon">
                    <i class="fas fa-piano"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Digital Piano</div>
                    <div class="product-sales">54 sold • $8,100 revenue</div>
                </div>
            </li>
        </ul>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-links">
            <a href="#"><i class="fas fa-phone-alt"></i> Help</a>
            <a href="#"><i class="fas fa-file-contract"></i> Terms of Service</a>
            <a href="#"><i class="fas fa-shield-alt"></i> Privacy Policy</a>
        </div>
        <div class="copyright">
            &copy; 2023 MelodyMart. All rights reserved.
        </div>
    </footer>
</div>

<script>
    // Simple animation for cards on page load
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.card');
        const stats = document.querySelectorAll('.stat-card');

        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';

            setTimeout(() => {
                card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });

        stats.forEach((stat, index) => {
            stat.style.opacity = '0';
            stat.style.transform = 'translateY(20px)';

            setTimeout(() => {
                stat.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                stat.style.opacity = '1';
                stat.style.transform = 'translateY(0)';
            }, index * 100 + 300);
        });

        // Initialize real-time data updates
        initializeRealTimeUpdates();
    });

    // Logout function
    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            // Redirect to login page or perform logout action
            window.location.href = 'index.jsp';
        }
    }

    // Real-time data updates
    function initializeRealTimeUpdates() {
        // Simulate real-time data updates every 30 seconds
        setInterval(updateDashboardData, 30000);

        // Initial data fetch
        updateDashboardData();
    }

    function updateDashboardData() {
        // In a real application, this would fetch data from your server
        // For demonstration, we'll simulate data updates

        // Add updating animation
        const elementsToUpdate = [
            'totalSales', 'totalOrders', 'totalRevenue', 'customerRating',
            'productCount', 'orderCount', 'deliveryCount', 'repairCount',
            'paymentAmount', 'lowStockCount', 'reportCount', 'notificationCount',
            'todayOrders', 'todayRevenue'
        ];

        elementsToUpdate.forEach(id => {
            const element = document.getElementById(id);
            if (element) {
                element.classList.add('updating');
            }
        });

        // Simulate API call delay
        setTimeout(() => {
            // Generate random updates (in a real app, this would come from your backend)
            const randomIncrement = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;
            const randomDecimal = (min, max) => (Math.random() * (max - min) + min).toFixed(1);

            // Update stats with realistic fluctuations
            document.getElementById('totalSales').textContent = '$' + (24580 + randomIncrement(50, 200)).toLocaleString();
            document.getElementById('totalOrders').textContent = (342 + randomIncrement(1, 5));
            document.getElementById('totalRevenue').textContent = '$' + (18420 + randomIncrement(30, 150)).toLocaleString();
            document.getElementById('customerRating').textContent = randomDecimal(4.7, 4.9) + '/5.0';

            document.getElementById('productCount').textContent = (148 + randomIncrement(0, 2)) + ' Products';
            document.getElementById('orderCount').textContent = (342 + randomIncrement(1, 3)) + ' Orders';
            document.getElementById('deliveryCount').textContent = (45 + randomIncrement(-2, 3)) + ' In Transit';
            document.getElementById('repairCount').textContent = (8 + randomIncrement(-1, 1)) + ' Active';
            document.getElementById('paymentAmount').textContent = '$' + (18420 + randomIncrement(20, 100)).toLocaleString();
            document.getElementById('lowStockCount').textContent = (23 + randomIncrement(-2, 2)) + ' Low Stock';
            document.getElementById('reportCount').textContent = (15 + randomIncrement(0, 1)) + ' Reports';
            document.getElementById('notificationCount').textContent = (7 + randomIncrement(-1, 2)) + ' Unread';

            // Update today's performance
            document.getElementById('todayOrders').textContent = (12 + randomIncrement(0, 3));
            document.getElementById('todayRevenue').textContent = '$' + (1250 + randomIncrement(10, 50)).toLocaleString();

            // Remove updating animation
            elementsToUpdate.forEach(id => {
                const element = document.getElementById(id);
                if (element) {
                    element.classList.remove('updating');
                }
            });

            // Show real-time update indicator
            showUpdateIndicator();
        }, 1500);
    }

    function showUpdateIndicator() {
        // Create or update real-time indicator
        let indicator = document.querySelector('.real-time-indicator');
        if (!indicator) {
            indicator = document.createElement('div');
            indicator.className = 'real-time-indicator';
            indicator.innerHTML = '<div class="pulse-dot"></div> Live Updates';
            document.querySelector('.dashboard-header').appendChild(indicator);
        }

        // Make indicator visible for a few seconds
        indicator.style.opacity = '1';
        setTimeout(() => {
            indicator.style.opacity = '0';
            setTimeout(() => {
                if (indicator.parentNode) {
                    indicator.parentNode.removeChild(indicator);
                }
            }, 1000);
        }, 3000);
    }

    // Welcome message based on time of day
    function getWelcomeMessage() {
        const hour = new Date().getHours();
        let timeOfDay = '';

        if (hour < 12) timeOfDay = 'morning';
        else if (hour < 18) timeOfDay = 'afternoon';
        else timeOfDay = 'evening';

        return `Good ${timeOfDay}, Melody! Ready to make some beautiful music sales today?`;
    }

    // Set welcome message on page load
    document.addEventListener('DOMContentLoaded', function() {
        const welcomeElement = document.querySelector('.dashboard-header p');
        if (welcomeElement) {
            const originalText = welcomeElement.innerHTML;
            welcomeElement.innerHTML = getWelcomeMessage() + '<br>' + originalText.split('<br>')[1];
        }
    });
</script>
</body>
</html>