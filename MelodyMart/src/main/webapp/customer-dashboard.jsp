<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --accent-alt: #ff00c8;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --card-hover: #2a2a2a;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
            --glass-bg: rgba(30, 30, 30, 0.7);
            --glass-border: rgba(255, 255, 255, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--secondary);
            color: var(--text);
            overflow-x: hidden;
            line-height: 1.6;
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.85)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        .header {
            background: rgba(10, 10, 10, 0.95);
            backdrop-filter: blur(10px);
            padding: 15px 0;
            border-bottom: 1px solid var(--glass-border);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            text-decoration: none;
        }

        .logo i {
            margin-right: 10px;
            font-size: 32px;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .notification-btn, .logout-btn {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            cursor: pointer;
            transition: color 0.3s ease;
            position: relative;
        }

        .notification-btn:hover, .logout-btn:hover {
            color: var(--primary-light);
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--accent);
            color: var(--secondary);
            font-size: 10px;
            font-weight: 700;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Dashboard Layout */
        .dashboard {
            display: flex;
            min-height: calc(100vh - 70px);
            padding: 30px 0;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-right: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 20px;
            margin-right: 30px;
            height: fit-content;
            position: sticky;
            top: 100px;
        }

        .sidebar-menu {
            list-style: none;
        }

        .sidebar-item {
            margin-bottom: 10px;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            color: var(--text);
            text-decoration: none;
            padding: 12px 15px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .sidebar-link:hover, .sidebar-link.active {
            background: var(--gradient);
            color: white;
        }

        .sidebar-link i {
            margin-right: 12px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            flex: 1;
        }

        .welcome-banner {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text h2 {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            margin-bottom: 10px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .welcome-text p {
            color: var(--text-secondary);
        }

        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .stat-icon {
            font-size: 30px;
            margin-bottom: 15px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .dashboard-section {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 0;
            margin-bottom: 30px;
            overflow: hidden;
        }

        .section-header {
            background: rgba(138, 43, 226, 0.1);
            padding: 20px;
            border-bottom: 1px solid var(--glass-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-header h3 {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            margin: 0;
            display: flex;
            align-items: center;
        }

        .section-header h3 i {
            margin-right: 10px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .section-body {
            padding: 20px;
        }

        /* Tables */
        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            color: var(--text);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--glass-border);
        }

        th {
            background: rgba(138, 43, 226, 0.1);
            font-weight: 600;
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        /* Buttons */
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
        }

        .btn-primary:hover {
            background: var(--gradient-alt);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 14px;
        }

        /* Forms */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-secondary);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--glass-border);
            background: var(--card-bg);
            color: var(--text);
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.3);
        }

        /* Order Status */
        .order-status {
            display: flex;
            justify-content: space-between;
            margin: 20px 0;
            position: relative;
        }

        .status-step {
            text-align: center;
            position: relative;
            z-index: 1;
        }

        .status-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--card-bg);
            border: 2px solid var(--glass-border);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            transition: all 0.3s ease;
        }

        .status-step.active .status-icon {
            background: var(--gradient);
            border-color: transparent;
        }

        .status-step.completed .status-icon {
            background: var(--primary);
            border-color: transparent;
        }

        .status-step.completed .status-icon i {
            display: block;
        }

        .status-name {
            font-size: 12px;
            color: var(--text-secondary);
        }

        .status-step.active .status-name {
            color: var(--text);
            font-weight: 600;
        }

        .order-status:before {
            content: '';
            position: absolute;
            top: 20px;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--glass-border);
            z-index: 0;
        }

        /* Charts */
        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .dashboard {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                margin-right: 0;
                margin-bottom: 20px;
                position: static;
            }

            .quick-stats {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 576px) {
            .quick-stats {
                grid-template-columns: 1fr;
            }

            .header-content {
                flex-direction: column;
                gap: 15px;
            }

            .user-menu {
                width: 100%;
                justify-content: space-between;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header class="header">
    <div class="container header-content">
        <a href="index.jsp" class="logo">
            <i class="fas fa-music"></i>
            Melody Mart
        </a>

        <div class="user-menu">
            <div class="user-info">
                <div class="user-avatar">JD</div>
                <div>
                    <div>John Doe</div>
                    <div style="font-size: 12px; color: var(--text-secondary);">Premium Member</div>
                </div>
            </div>

            <button class="notification-btn">
                <i class="fas fa-bell"></i>
                <span class="notification-badge">3</span>
            </button>

            <button class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
            </button>
        </div>
    </div>
</header>

<!-- Dashboard -->
<div class="container dashboard">
    <!-- Sidebar -->
    <div class="sidebar">
        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="#overview" class="sidebar-link active">
                    <i class="fas fa-home"></i>Dashboard
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#orders" class="sidebar-link">
                    <i class="fas fa-shopping-bag"></i>Orders
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#wishlist" class="sidebar-link">
                    <i class="fas fa-heart"></i>Wishlist
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#repairs" class="sidebar-link">
                    <i class="fas fa-tools"></i>Repair Requests
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#reviews" class="sidebar-link">
                    <i class="fas fa-star"></i>Reviews
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#addresses" class="sidebar-link">
                    <i class="fas fa-map-marker-alt"></i>Addresses
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#payment" class="sidebar-link">
                    <i class="fas fa-credit-card"></i>Payment Methods
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#profile" class="sidebar-link">
                    <i class="fas fa-user"></i>Profile Settings
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <div class="welcome-text">
                <h2>Welcome back, John!</h2>
                <p>Here's what's happening with your Melody Mart account today.</p>
            </div>
            <div>
                <button class="btn btn-primary">
                    <i class="fas fa-shopping-cart"></i>Continue Shopping
                </button>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="quick-stats">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-shopping-bag"></i></div>
                <div class="stat-value">5</div>
                <div class="stat-label">Active Orders</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-tools"></i></div>
                <div class="stat-value">2</div>
                <div class="stat-label">Repair Requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-star"></i></div>
                <div class="stat-value">12</div>
                <div class="stat-label">Product Reviews</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-heart"></i></div>
                <div class="stat-value">8</div>
                <div class="stat-label">Wishlist Items</div>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="dashboard-section">
            <div class="section-header">
                <h3><i class="fas fa-history"></i>Recent Orders</h3>
                <a href="#all-orders" style="color: var(--primary-light); text-decoration: none;">View All</a>
            </div>
            <div class="section-body">
                <div class="table-responsive">
                    <table>
                        <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Items</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>#ORD-7842</td>
                            <td>Sep 15, 2025</td>
                            <td>Fender Stratocaster</td>
                            <td>$1,299.99</td>
                            <td><span style="color: #4ade80;">Delivered</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm"><i class="fas fa-eye"></i>View</button>
                                <button class="btn btn-primary btn-sm"><i class="fas fa-redo"></i>Reorder</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-7831</td>
                            <td>Sep 10, 2025</td>
                            <td>Yamaha Piano</td>
                            <td>$3,799.99</td>
                            <td><span style="color: #fbbf24;">Shipping</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm"><i class="fas fa-eye"></i>View</button>
                                <button class="btn btn-primary btn-sm"><i class="fas fa-map-marker-alt"></i>Track</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-7815</td>
                            <td>Sep 5, 2025</td>
                            <td>Guitar Strings (Pack of 5)</td>
                            <td>$49.99</td>
                            <td><span style="color: #60a5fa;">Processing</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm"><i class="fas fa-eye"></i>View</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Order Tracking -->
        <div class="dashboard-section">
            <div class="section-header">
                <h3><i class="fas fa-map-marker-alt"></i>Order Tracking #ORD-7831</h3>
            </div>
            <div class="section-body">
                <div class="order-status">
                    <div class="status-step completed">
                        <div class="status-icon">
                            <i class="fas fa-check" style="display: none;"></i>
                        </div>
                        <div class="status-name">Order Placed</div>
                    </div>
                    <div class="status-step completed">
                        <div class="status-icon">
                            <i class="fas fa-check" style="display: none;"></i>
                        </div>
                        <div class="status-name">Payment Confirmed</div>
                    </div>
                    <div class="status-step completed">
                        <div class="status-icon">
                            <i class="fas fa-check" style="display: none;"></i>
                        </div>
                        <div class="status-name">Processing</div>
                    </div>
                    <div class="status-step active">
                        <div class="status-icon">
                            <i class="fas fa-shipping-fast"></i>
                        </div>
                        <div class="status-name">Shipping</div>
                    </div>
                    <div class="status-step">
                        <div class="status-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div class="status-name">Delivery</div>
                    </div>
                </div>

                <div style="margin-top: 30px;">
                    <h4 style="margin-bottom: 15px;">Shipping Details</h4>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        <div>
                            <div class="form-group">
                                <div class="form-label">Estimated Delivery</div>
                                <div>September 18, 2025</div>
                            </div>
                            <div class="form-group">
                                <div class="form-label">Carrier</div>
                                <div>FedEx Express</div>
                            </div>
                        </div>
                        <div>
                            <div class="form-group">
                                <div class="form-label">Tracking Number</div>
                                <div>789012345678</div>
                            </div>
                            <div class="form-group">
                                <div class="form-label">Shipping Address</div>
                                <div>123 Music Street, Nashville, TN 37203</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Repair Requests -->
        <div class="dashboard-section">
            <div class="section-header">
                <h3><i class="fas fa-tools"></i>Recent Repair Requests</h3>
                <button class="btn btn-primary btn-sm">
                    <i class="fas fa-plus"></i>New Request
                </button>
            </div>
            <div class="section-body">
                <div class="table-responsive">
                    <table>
                        <thead>
                        <tr>
                            <th>Request ID</th>
                            <th>Instrument</th>
                            <th>Submitted</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>#REP-4281</td>
                            <td>Gibson Les Paul</td>
                            <td>Sep 12, 2025</td>
                            <td><span style="color: #60a5fa;">In Progress</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm"><i class="fas fa-eye"></i>View</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#REP-4265</td>
                            <td>Yamaha Trumpet</td>
                            <td>Sep 5, 2025</td>
                            <td><span style="color: #4ade80;">Completed</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm"><i class="fas fa-eye"></i>View</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Initialize charts
    document.addEventListener('DOMContentLoaded', function() {
        // Order Status Chart
        const orderCtx = document.getElementById('orderChart').getContext('2d');
        const orderChart = new Chart(orderCtx, {
            type: 'doughnut',
            data: {
                labels: ['Delivered', 'Shipping', 'Processing', 'Pending'],
                datasets: [{
                    data: [8, 3, 2, 1],
                    backgroundColor: [
                        'rgba(74, 222, 128, 0.8)',
                        'rgba(96, 165, 250, 0.8)',
                        'rgba(251, 191, 36, 0.8)',
                        'rgba(156, 163, 175, 0.8)'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            color: '#ffffff'
                        }
                    }
                }
            }
        });

        // Spending Chart
        const spendingCtx = document.getElementById('spendingChart').getContext('2d');
        const spendingChart = new Chart(spendingCtx, {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
                datasets: [{
                    label: 'Monthly Spending ($)',
                    data: [1250, 1900, 1800, 2200, 2100, 2500, 2800, 3000, 1850],
                    backgroundColor: 'rgba(138, 43, 226, 0.5)',
                    borderColor: '#8a2be2',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        labels: {
                            color: '#ffffff'
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: {
                            color: '#b3b3b3'
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: {
                            color: '#b3b3b3'
                        }
                    }
                }
            }
        });

        // Update order status steps
        document.querySelectorAll('.status-step.completed .status-icon').forEach(icon => {
            icon.innerHTML = '<i class="fas fa-check"></i>';
        });
    });
</script>
</body>
</html>