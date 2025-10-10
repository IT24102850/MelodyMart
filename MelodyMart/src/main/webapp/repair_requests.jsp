<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Repair Requests | Melody Mart</title>
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
            padding: 20px;
            padding-top: calc(var(--header-height) + 20px);
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

        /* Content Cards */
        .content-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
            opacity: 0;
            transform: translateY(30px);
            animation: fadeIn 0.5s ease forwards;
        }

        .content-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .content-card:hover {
            background: rgba(59, 130, 246, 0.05);
            box-shadow: 0 12px 32px rgba(59, 130, 246, 0.2);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            font-weight: 600;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .card-actions {
            display: flex;
            gap: 10px;
        }

        /* Tables */
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th, .data-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--glass-border);
        }

        .data-table th {
            font-weight: 600;
            font-size: 14px;
            color: var(--text);
            opacity: 0.7;
        }

        .data-table tbody tr {
            transition: all 0.3s ease;
        }

        .data-table tbody tr:hover {
            background: rgba(59, 130, 246, 0.05);
        }

        /* Buttons */
        .btn {
            padding: 8px 16px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: var(--gradient);
            color: #ffffff;
        }

        .btn-primary:hover {
            background: var(--primary);
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .btn-danger {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid #ef4444;
            color: #ef4444;
        }

        .btn-danger:hover {
            background: #ef4444;
            color: #ffffff;
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 12px;
        }

        /* Status Badges */
        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }

        .status-approved {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .status-cancelled {
            background: rgba(239, 68, 68, 0.2);
            color: #ef4444;
        }

        /* Photos */
        .photo-gallery {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .photo-gallery img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            border: 1px solid var(--glass-border);
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .photo-gallery img:hover {
            transform: scale(1.05);
        }

        /* Search and Filter */
        .search-filter {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-box input {
            padding-left: 40px;
            width: 100%;
            padding: 12px 15px;
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            color: var(--text);
            font-family: 'Montserrat', sans-serif;
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text);
            opacity: 0.7;
        }

        .filter-select {
            min-width: 150px;
            padding: 12px 15px;
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            color: var(--text);
            font-family: 'Montserrat', sans-serif;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
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
        }

        @media (max-width: 768px) {
            .search-filter {
                flex-direction: column;
            }

            .search-box, .filter-select {
                min-width: 100%;
            }

            .data-table {
                font-size: 14px;
            }

            .data-table th, .data-table td {
                padding: 8px;
            }

            .photo-gallery img {
                width: 60px;
                height: 60px;
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

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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
            <a href="repair_requests.jsp" class="menu-item active">
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
            <h1 class="page-title">Repair Requests</h1>
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

        <div class="content-card">
            <div class="card-header">
                <h2 class="card-title">Repair Requests</h2>
                <div class="card-actions">
                    <button class="btn btn-primary" onclick="refreshRequests()">Refresh</button>
                </div>
            </div>
            <div class="search-filter">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" class="form-control" placeholder="Search by description or order ID" oninput="searchRequests(this.value)">
                </div>
                <select class="filter-select" onchange="filterRequests(this.value)">
                    <option value="">All Statuses</option>
                    <option value="pending">Pending</option>
                    <option value="approved">Approved</option>
                    <option value="cancelled">Cancelled</option>
                </select>
                <button class="btn btn-secondary" onclick="resetFilters()">Reset Filters</button>
            </div>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Request ID</th>
                        <th>Order ID</th>
                        <th>Description</th>
                        <th>Photos</th>
                        <th>Status</th>
                        <th>Approved</th>
                        <th>Comment</th>
                        <th>Estimated Cost</th>
                        <th>Repair Date</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>#REQ-001</td>
                        <td>#ORD-7842</td>
                        <td>Guitar string replacement needed</td>
                        <td>
                            <div class="photo-gallery">
                                <img src="https://via.placeholder.com/80" alt="Guitar damage">
                                <img src="https://via.placeholder.com/80" alt="Guitar damage">
                            </div>
                        </td>
                        <td><span class="status-badge status-pending">Pending</span></td>
                        <td>No</td>
                        <td>Awaiting review</td>
                        <td>$50.00</td>
                        <td>Oct 15, 2025</td>
                        <td>
                            <button class="btn btn-sm btn-primary" onclick="approveRequest('REQ-001')">Approve</button>
                            <button class="btn btn-sm btn-danger" onclick="cancelRequest('REQ-001')">Cancel</button>
                        </td>
                    </tr>
                    <tr>
                        <td>#REQ-002</td>
                        <td>#ORD-7839</td>
                        <td>Piano key sticking issue</td>
                        <td>
                            <div class="photo-gallery">
                                <img src="https://via.placeholder.com/80" alt="Piano damage">
                            </div>
                        </td>
                        <td><span class="status-badge status-approved">Approved</span></td>
                        <td>Yes</td>
                        <td>Scheduled for repair</td>
                        <td>$120.00</td>
                        <td>Oct 12, 2025</td>
                        <td>
                            <button class="btn btn-sm btn-danger" onclick="cancelRequest('REQ-002')">Cancel</button>
                        </td>
                    </tr>
                    <tr>
                        <td>#REQ-003</td>
                        <td>#ORD-7835</td>
                        <td>Amplifier not powering on</td>
                        <td>
                            <div class="photo-gallery">
                                <img src="https://via.placeholder.com/80" alt="Amplifier damage">
                                <img src="https://via.placeholder.com/80" alt="Amplifier damage">
                            </div>
                        </td>
                        <td><span class="status-badge status-cancelled">Cancelled</span></td>
                        <td>No</td>
                        <td>Customer withdrew request</td>
                        <td>$0.00</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // Sidebar toggle for mobile
    document.getElementById('menuToggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
    });

    // Highlight active menu item
    document.querySelectorAll('.menu-item').forEach(item => {
        if (item.getAttribute('href') === 'repair_requests.jsp') {
            item.classList.add('active');
        }
    });

    // Logout confirmation
    function confirmLogout() {
        return confirm('Are you sure you want to logout?');
    }

    // Placeholder functions for actions
    function searchRequests(query) {
        // Implement search logic (e.g., filter table rows by description or order ID)
        console.log('Searching repair requests:', query);
        // Example: Use AJAX to query server or filter table client-side
    }

    function filterRequests(status) {
        // Implement filter logic (e.g., filter table rows by status)
        console.log('Filtering repair requests by status:', status);
        // Example: Use AJAX to query server or filter table client-side
    }

    function resetFilters() {
        // Implement reset logic (e.g., clear search and filters)
        console.log('Resetting filters');
        document.querySelector('.search-box input').value = '';
        document.querySelector('.filter-select').value = '';
        // Example: Reload table data
    }

    function approveRequest(requestId) {
        if (confirm('Are you sure you want to approve this repair request?')) {
            // Implement approve logic (e.g., call ApproveRepairServlet)
            console.log('Approving repair request:', requestId);
            // Example: Send AJAX request to servlet
            // fetch('ApproveRepairServlet?requestId=' + requestId, { method: 'POST' })
            //     .then(response => response.json())
            //     .then(data => alert(data.message))
            //     .catch(error => alert('Error approving request'));
        }
    }

    function cancelRequest(requestId) {
        if (confirm('Are you sure you want to cancel this repair request?')) {
            // Implement cancel logic (e.g., call CancelRepairServlet)
            console.log('Cancelling repair request:', requestId);
            // Example: Send AJAX request to servlet
            // fetch('CancelRepairServlet?requestId=' + requestId, { method: 'POST' })
            //     .then(response => response.json())
            //     .then(data => alert(data.message))
            //     .catch(error => alert('Error cancelling request'));
        }
    }

    function refreshRequests() {
        // Implement refresh logic (e.g., reload table data from server)
        console.log('Refreshing repair requests');
        // Example: Fetch updated data via AJAX
    }

    // Intersection Observer for animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.content-card').forEach((el) => {
        observer.observe(el);
    });
</script>
</body>
</html>