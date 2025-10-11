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

        body {
            background: linear-gradient(135deg, #f0f9ff 0%, #e1f5fe 100%);
            color: #333;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
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
            color: #1e40af;
        }

        .logo i {
            font-size: 32px;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logout-btn {
            background: linear-gradient(135deg, #ef4444, #dc2626);
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
            background: linear-gradient(135deg, #dc2626, #b91c1c);
        }

        .user-profile {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3b82f6, #1e40af);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Dashboard Header */
        .dashboard-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .dashboard-header h1 {
            font-size: 36px;
            color: #1e40af;
            margin-bottom: 10px;
        }

        .dashboard-header p {
            font-size: 18px;
            color: #64748b;
        }

        /* Section Headers */
        .section-header {
            font-size: 24px;
            color: #1e40af;
            margin: 40px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
        }

        /* Cards Grid */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            background: #f8fafc;
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
            color: #475569;
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
        }

        .dashboard .card-icon {
            background: linear-gradient(135deg, #10b981, #059669);
        }

        .inventory .card-icon {
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
        }

        .orders .card-icon {
            background: linear-gradient(135deg, #f59e0b, #d97706);
        }

        .deliveries .card-icon {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
        }

        .repairs .card-icon {
            background: linear-gradient(135deg, #ec4899, #db2777);
        }

        .payments .card-icon {
            background: linear-gradient(135deg, #06b6d4, #0891b2);
        }

        .stock .card-icon {
            background: linear-gradient(135deg, #84cc16, #65a30d);
        }

        .reports .card-icon {
            background: linear-gradient(135deg, #f97316, #ea580c);
        }

        .notifications .card-icon {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
        }

        .profile .card-icon {
            background: linear-gradient(135deg, #64748b, #475569);
        }

        .card-value {
            font-size: 32px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 10px;
        }

        .card-description {
            font-size: 14px;
            color: #64748b;
            line-height: 1.5;
        }

        .card-change {
            font-size: 14px;
            color: #10b981;
            display: flex;
            align-items: center;
            gap: 5px;
            margin-top: 10px;
        }

        .card-change.negative {
            color: #ef4444;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
        }

        .stat-info {
            flex: 1;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
            color: #1e293b;
        }

        .stat-label {
            font-size: 14px;
            color: #64748b;
        }

        /* Products List */
        .products-list {
            list-style: none;
            margin-top: 15px;
        }

        .product-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .product-item:last-child {
            border-bottom: none;
        }

        .product-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: #e0f2fe;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: #0369a1;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-weight: 500;
            margin-bottom: 4px;
        }

        .product-sales {
            font-size: 14px;
            color: #64748b;
        }

        /* Ratings */
        .rating-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .rating-item:last-child {
            border-bottom: none;
        }

        .rating-stars {
            color: #f59e0b;
            margin-right: 15px;
        }

        .rating-text {
            font-weight: 500;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 30px 0;
            color: #64748b;
            border-top: 1px solid #e2e8f0;
            margin-top: 30px;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin: 20px 0;
        }

        .footer-links a {
            color: #475569;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: #1e40af;
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

            .logout-btn {
                padding: 8px 15px;
                font-size: 14px;
            }

            .logout-btn span {
                display: none;
            }
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
        <p>Welcome back, Melody Mahnaro</p>
    </div>

    <!-- Quick Stats -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #10b981, #059669);">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value">$24,580</div>
                <div class="stat-label">Total Sales</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #3b82f6, #1d4ed8);">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value">342</div>
                <div class="stat-label">Orders</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #f59e0b, #d97706);">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value">$18,420</div>
                <div class="stat-label">Revenue</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #ec4899, #db2777);">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-info">
                <div class="stat-value">4.8/5.0</div>
                <div class="stat-label">Customer Rating</div>
            </div>
        </div>
    </div>

    <!-- Main Navigation Cards -->
    <h2 class="section-header">Management</h2>
    <div class="cards-grid">
        <!-- Inventory Card -->
        <a href="addInstrument.jsp" class="card inventory">
            <div class="card-header">
                <div class="card-title">Inventory</div>
                <div class="card-icon">
                    <i class="fas fa-box"></i>
                </div>
            </div>
            <div class="card-value">148 Products</div>
            <div class="card-description">Manage your product inventory, update stock levels, and track product performance.</div>
            <div class="card-change">
                <i class="fas fa-arrow-up"></i>
                <span>12 new items this month</span>
            </div>
        </a>

        <!-- Orders Card -->
        <a href="orders.jsp" class="card orders">
            <div class="card-header">
                <div class="card-title">Orders</div>
                <div class="card-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
            </div>
            <div class="card-value">342 Orders</div>
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
            <div class="card-value">45 In Transit</div>
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
            <div class="card-value">8 Active</div>
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
            <div class="card-value">$18,420</div>
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
            <div class="card-value">23 Low Stock</div>
            <div class="card-description">Monitor stock levels, set up reorder alerts, and manage suppliers.</div>
            <div class="card-change negative">
                <i class="fas fa-arrow-down"></i>
                <span>5 items out of stock</span>
            </div>
        </a>
    </div>

    <!-- Reports & Account Section -->
    <h2 class="section-header">Reports & Account</h2>
    <div class="cards-grid">
        <!-- Sales Reports Card -->
        <a href="reports.jsp" class="card reports">
            <div class="card-header">
                <div class="card-title">Sales Reports</div>
                <div class="card-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
            </div>
            <div class="card-value">15 Reports</div>
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
            <div class="card-value">7 Unread</div>
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
            <div class="card-value">Melody Mahnaro</div>
            <div class="card-description">Update your account information, change password, and manage preferences.</div>
            <div class="card-change">
                <i class="fas fa-cog"></i>
                <span>Update settings</span>
            </div>
        </a>
    </div>

    <!-- Top Products Section -->
    <h2 class="section-header">Top Products</h2>
    <div class="card">
        <div class="card-header">
            <div class="card-title">Best Selling Instruments</div>
            <div class="card-icon" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);">
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

        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';

            setTimeout(() => {
                card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });

    // Logout function
    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            // Redirect to login page or perform logout action
            window.location.href = 'index.jsp';
        }
    }
</script>
</body>
</html>