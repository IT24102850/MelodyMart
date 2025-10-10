<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1e40af;
            --background: #eff6ff;
            --text: #1f2937;
            --card-bg: #ffffff;
            --glass-border: rgba(59, 130, 246, 0.2);
            --gradient: linear-gradient(135deg, var(--primary), #3b82f6);
            --shadow: 0 8px 24px rgba(59, 130, 246, 0.15);
            --border-radius: 15px;
            --sidebar-width: 280px;
            --header-height: 70px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--background);
            color: var(--text);
            line-height: 1.6;
            padding: 20px;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--card-bg);
            border-right: 1px solid var(--glass-border);
            height: 100vh;
            position: fixed;
            overflow-y: auto;
            transition: all 0.3s ease;
            z-index: 1000;
            box-shadow: var(--shadow);
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid var(--glass-border);
            text-align: center;
        }

        .sidebar-logo {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .sidebar-logo i {
            margin-right: 10px;
            font-size: 32px;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: var(--text);
            text-decoration: none;
            background: rgba(59, 130, 246, 0.05);
            border-radius: 5px;
            margin: 5px 10px;
            transition: all 0.3s ease;
        }

        .menu-item:hover, .menu-item.active {
            background: var(--primary);
            color: #ffffff;
        }

        .menu-item i {
            margin-right: 12px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
        }

        .dashboard-header {
            background: var(--card-bg);
            border-bottom: 1px solid var(--glass-border);
            padding: 0 20px;
            height: var(--header-height);
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            top: 0;
            right: 0;
            left: var(--sidebar-width);
            z-index: 900;
            box-shadow: var(--shadow);
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .notification-btn, .user-menu-btn {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            cursor: pointer;
            position: relative;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .notification-btn:hover, .user-menu-btn:hover {
            background: var(--primary);
            color: #ffffff;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #3b82f6;
            color: #ffffff;
            font-size: 10px;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .nav-container {
            max-width: 800px;
            margin: 100px auto 0;
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 30px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
        }

        .nav-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 20px;
            text-align: center;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-list {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 10px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: var(--text);
            text-decoration: none;
            background: rgba(59, 130, 246, 0.05);
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: var(--primary);
            color: #ffffff;
        }

        .nav-link i {
            margin-right: 12px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                width: 260px;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .dashboard-header {
                left: 0;
            }

            .menu-toggle {
                display: block;
            }

            .nav-container {
                margin: 80px 20px 0;
            }
        }

        @media (max-width: 768px) {
            .nav-container {
                padding: 20px;
            }
        }

        /* Toggle button for mobile */
        .menu-toggle {
            display: none;
            background: none;
            border: none;
            color: var(--text);
            font-size: 24px;
            cursor: pointer;
            margin-right: 15px;
        }

        @media (max-width: 992px) {
            .menu-toggle {
                display: block;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <i class="fas fa-music"></i>
                Melody Mart
            </div>
            <small>Seller Dashboard</small>
        </div>

        <div class="sidebar-menu">
            <a href="dashboard_overview.jsp" class="menu-item">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard Overview</span>
            </a>
            <a href="inventory_management.jsp" class="menu-item">
                <i class="fas fa-box"></i>
                <span>Inventory Management</span>
            </a>
            <a href="order_management.jsp" class="menu-item">
                <i class="fas fa-shopping-cart"></i>
                <span>Order Management</span>
            </a>
            <a href="delivery_coordination.jsp" class="menu-item">
                <i class="fas fa-truck"></i>
                <span>Delivery Coordination</span>
            </a>
            <a href="repair_requests.jsp" class="menu-item">
                <i class="fas fa-tools"></i>
                <span>Repair Requests</span>
            </a>
            <a href="payment_management.jsp" class="menu-item">
                <i class="fas fa-credit-card"></i>
                <span>Payment Management</span>
            </a>
            <a href="stock_management.jsp" class="menu-item">
                <i class="fas fa-cubes"></i>
                <span>Stock Management</span>
            </a>
            <a href="sales_reports.jsp" class="menu-item">
                <i class="fas fa-chart-bar"></i>
                <span>Sales Reports</span>
            </a>
            <a href="notifications.jsp" class="menu-item">
                <i class="fas fa-bell"></i>
                <span>Notifications</span>
            </a>
            <a href="profile_settings.jsp" class="menu-item">
                <i class="fas fa-user"></i>
                <span>Profile Settings</span>
            </a>
            <a href="index.jsp?action=logout" class="menu-item" onclick="return confirmLogout()">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <header class="dashboard-header">
            <button class="menu-toggle" id="menuToggle">
                <i class="fas fa-bars"></i>
            </button>
            <h1 class="page-title">Seller Dashboard</h1>
            <div class="header-actions">
                <button class="notification-btn">
                    <i class="fas fa-bell"></i>
                    <span class="notification-badge">3</span>
                </button>
                <button class="user-menu-btn">
                    <i class="fas fa-user-circle"></i>
                </button>
            </div>
        </header>

        <div class="nav-container">
            <h1 class="nav-title">Seller Dashboard Navigation</h1>
            <ul class="nav-list">
                <li class="nav-item">
                    <a href="dashboard_overview.jsp" class="nav-link">
                        <i class="fas fa-chart-line"></i>
                        Dashboard Overview
                    </a>
                </li>
                <li class="nav-item">
                    <a href="inventory_management.jsp" class="nav-link">
                        <i class="fas fa-box"></i>
                        Inventory Management
                    </a>
                </li>
                <li class="nav-item">
                    <a href="order_management.jsp" class="nav-link">
                        <i class="fas fa-shopping-cart"></i>
                        Order Management
                    </a>
                </li>
                <li class="nav-item">
                    <a href="delivery_coordination.jsp" class="nav-link">
                        <i class="fas fa-truck"></i>
                        Delivery Coordination
                    </a>
                </li>
                <li class="nav-item">
                    <a href="repair_requests.jsp" class="nav-link">
                        <i class="fas fa-tools"></i>
                        Repair Requests
                    </a>
                </li>
                <li class="nav-item">
                    <a href="payment_management.jsp" class="nav-link">
                        <i class="fas fa-credit-card"></i>
                        Payment Management
                    </a>
                </li>
                <li class="nav-item">
                    <a href="stock_management.jsp" class="nav-link">
                        <i class="fas fa-cubes"></i>
                        Stock Management
                    </a>
                </li>
                <li class="nav-item">
                    <a href="sales_reports.jsp" class="nav-link">
                        <i class="fas fa-chart-bar"></i>
                        Sales Reports
                    </a>
                </li>
                <li class="nav-item">
                    <a href="notifications.jsp" class="nav-link">
                        <i class="fas fa-bell"></i>
                        Notifications
                    </a>
                </li>
                <li class="nav-item">
                    <a href="profile_settings.jsp" class="nav-link">
                        <i class="fas fa-user"></i>
                        Profile Settings
                    </a>
                </li>
                <li class="nav-item">
                    <a href="index.jsp?action=logout" class="nav-link" onclick="return confirmLogout()">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<script>
    // Sidebar toggle for mobile
    document.getElementById('menuToggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
    });

    // Highlight active menu item based on current page
    const currentPage = window.location.pathname.split('/').pop();
    document.querySelectorAll('.menu-item, .nav-link').forEach(item => {
        if (item.getAttribute('href') === currentPage) {
            item.classList.add('active');
        }
    });

    // Logout confirmation
    function confirmLogout() {
        return confirm('Are you sure you want to logout?');
    }
</script>
</body>
</html>