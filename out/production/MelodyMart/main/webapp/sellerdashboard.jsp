<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Seller Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2563eb;
            --secondary: #f8fafc;
            --text: #1e293b;
            --card-bg: #ffffff;
            --border: #e2e8f0;
            --success: #10b981;
            --warning: #f59e0b;
            --error: #ef4444;
            --info: #3b82f6;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: var(--secondary);
            color: var(--text);
            min-height: 100vh;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header Styles */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            margin-bottom: 30px;
            border-bottom: 2px solid var(--border);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 28px;
            font-weight: 700;
            color: var(--primary);
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
            gap: 20px;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: var(--error);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: #dc2626;
            transform: translateY(-2px);
        }

        .user-profile {
            width: 45px;
            height: 45px;
            background: var(--gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }

        /* Dashboard Header */
        .dashboard-header {
            margin-bottom: 30px;
        }

        .dashboard-header h1 {
            font-size: 36px;
            color: var(--text);
            margin-bottom: 10px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .dashboard-header p {
            font-size: 18px;
            color: #64748b;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 30px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            border-left: 5px solid var(--primary);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        .stat-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: white;
        }

        .inventory .stat-icon { background: var(--info); }
        .payments .stat-icon { background: var(--success); }
        .orders .stat-icon { background: var(--primary); }
        .stock .stat-icon { background: var(--warning); }
        .deliveries .stat-icon { background: var(--info); }
        .repairs .stat-icon { background: var(--error); }

        .stat-trend {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 14px;
            font-weight: 600;
        }

        .trend-up { color: var(--success); }
        .trend-down { color: var(--error); }
        .trend-neutral { color: var(--warning); }

        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 8px;
        }

        .stat-title {
            font-size: 16px;
            color: #64748b;
            margin-bottom: 12px;
        }

        .stat-description {
            font-size: 14px;
            color: #94a3b8;
            line-height: 1.5;
        }

        /* Section Headers */
        .section-header {
            font-size: 24px;
            font-weight: 600;
            color: var(--text);
            margin: 40px 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border);
        }

        /* Cards Grid */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: 12px;
            box-shadow: var(--shadow);
            transition: transform 0.3s ease;
            cursor: pointer;
            border: 1px solid var(--border);
        }

        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }

        .card i {
            font-size: 24px;
            color: var(--primary);
            margin-bottom: 15px;
        }

        .card h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--text);
        }

        .card p {
            font-size: 14px;
            color: #64748b;
            line-height: 1.5;
        }

        /* Top Products Section */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .product-card {
            background: var(--card-bg);
            padding: 20px;
            border-radius: 12px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
        }

        .product-header {
            display: flex;
            justify-content: between;
            align-items: start;
            margin-bottom: 15px;
        }

        .product-name {
            font-weight: 600;
            color: var(--text);
        }

        .product-sales {
            background: var(--success);
            color: white;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
        }

        .product-price {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .product-stock {
            font-size: 14px;
            color: #64748b;
        }

        .stock-low { color: var(--error); }
        .stock-good { color: var(--success); }

        /* Footer */
        footer {
            text-align: center;
            padding: 30px 0;
            margin-top: 50px;
            border-top: 1px solid var(--border);
            color: #64748b;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .cards-grid {
                grid-template-columns: 1fr;
            }

            header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .dashboard-header h1 {
                font-size: 28px;
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

    <div class="dashboard-header">
        <h1>Seller Dashboard</h1>
        <p>Welcome back, <%= session.getAttribute("userName") %></p>
    </div>

    <!-- Quick Stats -->
    <div class="stats-grid">
        <div class="stat-card inventory">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-guitar"></i>
                </div>
                <div class="stat-trend trend-up">
                    <i class="fas fa-arrow-up"></i>
                    12 new items this month
                </div>
            </div>
            <div class="stat-number">148 Products</div>
            <div class="stat-title">Inventory</div>
            <div class="stat-description">Manage your product inventory, update stock levels, and track product performance.</div>
        </div>

        <div class="stat-card payments">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <div class="stat-trend trend-up">
                    <i class="fas fa-arrow-up"></i>
                    5.7% from last month
                </div>
            </div>
            <div class="stat-number">$18,420</div>
            <div class="stat-title">Payments</div>
            <div class="stat-description">View payment history, track transactions, and manage payout settings.</div>
        </div>

        <div class="stat-card orders">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="stat-trend trend-up">
                    <i class="fas fa-arrow-up"></i>
                    8.2% from last month
                </div>
            </div>
            <div class="stat-number">342 Orders</div>
            <div class="stat-title">Orders</div>
            <div class="stat-description">View and manage customer orders, process returns, and track order status.</div>
        </div>

        <div class="stat-card stock">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-boxes"></i>
                </div>
                <div class="stat-trend trend-down">
                    <i class="fas fa-arrow-down"></i>
                    5 items out of stock
                </div>
            </div>
            <div class="stat-number">23 Low Stock</div>
            <div class="stat-title">Stock Management</div>
            <div class="stat-description">Monitor stock levels, set up reorder alerts, and manage suppliers.</div>
        </div>

        <div class="stat-card deliveries">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-shipping-fast"></i>
                </div>
                <div class="stat-trend trend-neutral">
                    <i class="fas fa-circle"></i>
                    12 delayed deliveries
                </div>
            </div>
            <div class="stat-number">45 In Transit</div>
            <div class="stat-title">Deliveries</div>
            <div class="stat-description">Track shipments, manage delivery schedules, and update shipping status.</div>
        </div>

        <div class="stat-card repairs">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-tools"></i>
                </div>
                <div class="stat-trend trend-neutral">
                    <i class="fas fa-circle"></i>
                    2 high priority requests
                </div>
            </div>
            <div class="stat-number">8 Active</div>
            <div class="stat-title">Repair Requests</div>
            <div class="stat-description">Manage instrument repair requests, schedule appointments, and track repair status.</div>
        </div>
    </div>

    <!-- Management Section -->
    <h2 class="section-header">Management</h2>
    <div class="cards-grid">
        <div class="card" onclick="navigateTo('inventory.jsp')">
            <i class="fas fa-warehouse"></i>
            <h3>Inventory Management</h3>
            <p>Add new products, update stock levels, and manage your product catalog</p>
        </div>
        <div class="card" onclick="navigateTo('orders.jsp')">
            <i class="fas fa-clipboard-list"></i>
            <h3>Order Management</h3>
            <p>Process orders, handle returns, and track order fulfillment</p>
        </div>
        <div class="card" onclick="navigateTo('PaymentManagementServlet')">
            <i class="fas fa-money-bill-wave"></i>
            <h3>Payment Tracking</h3>
            <p>Monitor transactions, manage payouts, and view financial reports</p>
        </div>
        <div class="card" onclick="navigateTo('deliveries.jsp')">
            <i class="fas fa-truck"></i>
            <h3>Delivery Management</h3>
            <p>Track shipments, update delivery status, and manage logistics</p>
        </div>
    </div>

    <!-- Reports & Account Section -->
    <h2 class="section-header">Reports & Account</h2>
    <div class="cards-grid">
        <div class="card" onclick="navigateTo('reports.jsp')">
            <i class="fas fa-chart-bar"></i>
            <h3>Sales Reports</h3>
            <p>Generate detailed sales reports and performance analytics</p>
        </div>
        <div class="card" onclick="navigateTo('analytics.jsp')">
            <i class="fas fa-chart-line"></i>
            <h3>Performance Analytics</h3>
            <p>View business insights and performance metrics</p>
        </div>
        <div class="card" onclick="navigateTo('account.jsp')">
            <i class="fas fa-user-cog"></i>
            <h3>Account Settings</h3>
            <p>Update your profile, preferences, and business information</p>
        </div>
        <div class="card" onclick="navigateTo('support.jsp')">
            <i class="fas fa-headset"></i>
            <h3>Seller Support</h3>
            <p>Get help, contact support, and access resources</p>
        </div>
    </div>

    <!-- Top Products Section -->
    <h2 class="section-header">Top Products</h2>
    <div class="products-grid">
        <div class="product-card">
            <div class="product-header">
                <div class="product-name">Electric Guitar</div>
                <div class="product-sales">45 sales</div>
            </div>
            <div class="product-price">$450.00</div>
            <div class="product-stock stock-good">In Stock: 28</div>
        </div>
        <div class="product-card">
            <div class="product-header">
                <div class="product-name">Digital Piano</div>
                <div class="product-sales">32 sales</div>
            </div>
            <div class="product-price">$899.99</div>
            <div class="product-stock stock-good">In Stock: 15</div>
        </div>
        <div class="product-card">
            <div class="product-header">
                <div class="product-name">Violin Set</div>
                <div class="product-sales">28 sales</div>
            </div>
            <div class="product-price">$299.50</div>
            <div class="product-stock stock-low">Low Stock: 3</div>
        </div>
        <div class="product-card">
            <div class="product-header">
                <div class="product-name">Drum Kit</div>
                <div class="product-sales">21 sales</div>
            </div>
            <div class="product-price">$1,200.00</div>
            <div class="product-stock stock-good">In Stock: 12</div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 MelodyMart. All rights reserved. | Seller Dashboard</p>
    </footer>
</div>

<script>
    // Simple animation for cards on page load
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.card, .stat-card');
        const products = document.querySelectorAll('.product-card');

        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';

            setTimeout(() => {
                card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });

        products.forEach((product, index) => {
            product.style.opacity = '0';
            product.style.transform = 'translateY(20px)';

            setTimeout(() => {
                product.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                product.style.opacity = '1';
                product.style.transform = 'translateY(0)';
            }, (cards.length + index) * 100);
        });
    });

    // Navigation function
    function navigateTo(page) {
        window.location.href = page;
    }

    // Logout function
    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = 'logout.jsp';
        }
    }

    // Pass role from server-side to client-side safely
    var userRole = "<%= session.getAttribute("userRole") != null ? session.getAttribute("userRole") : "unknown" %>";
    console.log("sellerdashboard.jsp - Current role: " + userRole + ", Session ID: " + "<%= session.getId() %>");
</script>
</body>
</html>