<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
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
        }

        .container {
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header & Navigation */
        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            padding: 20px 0;
            transition: all 0.4s ease;
        }

        header.scrolled {
            background: rgba(10, 10, 10, 0.95);
            padding: 15px 0;
            backdrop-filter: blur(10px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.5);
        }

        .nav-container {
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
        }

        .logo i {
            margin-right: 10px;
            font-size: 32px;
        }

        .nav-links {
            display: flex;
            list-style: none;
        }

        .nav-links li {
            margin: 0 15px;
        }

        .nav-links a {
            color: var(--text);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
            position: relative;
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--gradient);
            transition: width 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--primary-light);
        }

        .nav-links a:hover:after {
            width: 100%;
        }

        .nav-actions {
            display: flex;
            align-items: center;
        }

        .search-btn, .cart-btn {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            margin-left: 20px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .search-btn:hover, .cart-btn:hover {
            color: var(--primary-light);
        }

        .cta-btn {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-left: 20px;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .cta-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background: var(--gradient-alt);
            transition: all 0.4s ease;
            z-index: -1;
        }

        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
        }

        .cta-btn:hover:before {
            width: 100%;
        }

        /* User Dropdown */
        .user-menu {
            position: relative;
            margin-left: 20px;
        }

        .user-btn {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .user-btn:hover {
            color: var(--primary-light);
        }

        .dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 10px;
            width: 150px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(10px);
            transition: opacity 0.3s ease, transform 0.3s ease, visibility 0.3s;
            z-index: 1000;
        }

        .user-menu:hover .dropdown {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-item {
            display: block;
            padding: 10px 15px;
            color: var(--text);
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s ease, color 0.3s ease;
            cursor: pointer;
        }

        .dropdown-item:hover {
            background: var(--card-hover);
            color: var(--primary-light);
        }

        /* Dashboard Hero Section */
        .dashboard-hero {
            height: 70vh;
            position: relative;
            overflow: hidden;
            padding-top: 120px;
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .dashboard-hero-content {
            max-width: 800px;
            padding: 0 20px;
        }

        .dashboard-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 60px;
            font-weight: 800;
            margin-bottom: 20px;
            line-height: 1.2;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
        }

        .dashboard-hero p {
            font-size: 20px;
            color: var(--text-secondary);
            margin-bottom: 30px;
        }

        .customer-name {
            color: var(--accent);
            font-weight: 700;
        }

        /* Dashboard Stats */
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 50px 0;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
            opacity: 0;
            transform: translateY(30px);
        }

        .stat-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .stat-icon {
            font-size: 40px;
            color: var(--primary-light);
            margin-bottom: 15px;
        }

        .stat-number {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 10px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 16px;
        }

        /* Section Title */
        .section-title {
            text-align: center;
            font-family: 'Playfair Display', serif;
            font-size: 36px;
            margin: 80px 0 50px;
            position: relative;
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 1s ease, transform 1s ease;
        }

        .section-title.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--gradient);
        }

        /* Dashboard Sections */
        .dashboard-section {
            margin-bottom: 80px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }

        .dashboard-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
            opacity: 0;
            transform: translateY(30px);
        }

        .dashboard-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .dashboard-card h3 {
            font-size: 20px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .dashboard-card h3 i {
            margin-right: 10px;
            color: var(--primary-light);
        }

        .dashboard-card p {
            color: var(--text-secondary);
            margin-bottom: 20px;
        }

        .dashboard-card .cta-btn {
            width: 100%;
            text-align: center;
            padding: 10px;
            font-size: 14px;
        }

        /* Recent Orders */
        .orders-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: var(--card-bg);
            border-radius: 10px;
            overflow: hidden;
        }

        .orders-table th, .orders-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--glass-border);
        }

        .orders-table th {
            background: rgba(138, 43, 226, 0.1);
            font-weight: 600;
        }

        .orders-table tr:last-child td {
            border-bottom: none;
        }

        .order-status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-delivered {
            background: rgba(0, 229, 255, 0.2);
            color: var(--accent);
        }

        .status-pending {
            background: rgba(255, 200, 0, 0.2);
            color: #ffc800;
        }

        .status-shipped {
            background: rgba(138, 43, 226, 0.2);
            color: var(--primary-light);
        }

        /* Footer */
        footer {
            background: #0a0a0a;
            padding: 80px 0 30px;
            border-top: 1px solid var(--glass-border);
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 50px;
        }

        .footer-column h3 {
            font-size: 18px;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-column h3:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 2px;
            background: var(--gradient);
        }

        .footer-column p {
            color: var(--text-secondary);
            margin-bottom: 20px;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 12px;
        }

        .footer-links a {
            color: var(--text-secondary);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--primary-light);
        }

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--card-bg);
            color: var(--text);
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: var(--gradient);
            transform: translateY(-3px);
        }

        .copyright {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid #1e1e1e;
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .dashboard-hero h1 {
                font-size: 45px;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .dashboard-hero {
                padding-top: 100px;
                height: 60vh;
            }

            .dashboard-hero h1 {
                font-size: 36px;
            }

            .dashboard-hero p {
                font-size: 18px;
            }

            .section-title {
                font-size: 32px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .orders-table {
                display: block;
                overflow-x: auto;
            }

            .user-menu:hover .dropdown {
                display: none;
            }

            .user-btn {
                font-size: 16px;
            }

            .dropdown {
                width: 120px;
                right: -10px;
            }
        }

        @media (max-width: 576px) {
            .dashboard-hero h1 {
                font-size: 32px;
            }

            .dashboard-hero p {
                font-size: 16px;
            }

            .cta-btn {
                padding: 10px 20px;
            }

            .section-title {
                font-size: 28px;
            }

            .stat-card {
                padding: 20px;
            }

            .stat-number {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
<!-- Header & Navigation -->
<header>
    <div class="container nav-container">
        <div class="logo">
            <i class="fas fa-music"></i>
            Melody Mart
        </div>

        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="shop.jsp">Shop</a></li>
            <li><a href="customerdashboard.jsp">Customer Dashboard</a></li>
            <li><a href="order.jsp">My Orders</a></li>
            <li><a href="repair.jsp">My Repair Requests</a></li>
            <li><a href="wishlist.jsp">Wishlist</a></li>
            <li><a href="profile.jsp">Profile</a></li>
        </ul>

        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <button class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></button>
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i> Customer</button>
                <div class="dropdown">
                    <a href="profile.jsp" class="dropdown-item">My Profile</a>
                    <a href="order.jsp" class="dropdown-item">My Orders</a>
                    <a href="repair.jsp" class="dropdown-item"  >My Repair Requests</a>
                    <a href="wishlist.jsp" class="dropdown-item">Wishlist</a>
                    <a href="settings.jsp" class="dropdown-item">Settings</a>
                    <a href="index.jsp" class="dropdown-item">Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Dashboard Hero Section -->
<section class="dashboard-hero">
    <div class="dashboard-hero-content">
        <h1>Welcome Back, <span class="customer-name">Customer</span>!</h1>
        <p>Your musical journey continues with Melody Mart. Explore your dashboard to manage orders, track shipments, and discover new instruments.</p>
        <div class="slide-btns">
            <button class="cta-btn" onclick="window.location.href='shop.jsp'">Continue Shopping</button>
            <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);" onclick="window.location.href='orders.jsp'">View Orders</button>
        </div>
    </div>
</section>

<!-- Dashboard Stats -->
<section class="container">
    <div class="dashboard-stats">
        <div class="stat-card">
            <i class="fas fa-shopping-bag stat-icon"></i>
            <div class="stat-number">12</div>
            <div class="stat-label">Total Orders</div>
        </div>
        <div class="stat-card">
            <i class="fas fa-heart stat-icon"></i>
            <div class="stat-number">8</div>
            <div class="stat-label">Wishlist Items</div>
        </div>
        <div class="stat-card">
            <i class="fas fa-truck stat-icon"></i>
            <div class="stat-number">2</div>
            <div class="stat-label">Pending Deliveries</div>
        </div>
        <div class="stat-card">
            <i class="fas fa-star stat-icon"></i>
            <div class="stat-number">4.8</div>
            <div class="stat-label">Average Rating</div>
        </div>
    </div>
</section>

<!-- Recent Orders Section -->
<section class="container dashboard-section">
    <h2 class="section-title">Recent Orders</h2>
    <div class="dashboard-card">
        <table class="orders-table">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Product</th>
                <th>Date</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>#MM2025001</td>
                <td>Professional Electric Guitar</td>
                <td>Jan 15, 2025</td>
                <td>$1,299.99</td>
                <td><span class="order-status status-delivered">Delivered</span></td>
                <td><a href="#" style="color: var(--primary-light);">View Details</a></td>
            </tr>
            <tr>
                <td>#MM2025002</td>
                <td>Studio Headphones</td>
                <td>Jan 18, 2025</td>
                <td>$249.99</td>
                <td><span class="order-status status-shipped">Shipped</span></td>
                <td><a href="#" style="color: var(--primary-light);">Track Order</a></td>
            </tr>
            <tr>
                <td>#MM2025003</td>
                <td>Guitar Strings Set</td>
                <td>Jan 20, 2025</td>
                <td>$29.99</td>
                <td><span class="order-status status-pending">Processing</span></td>
                <td><a href="#" style="color: var(--primary-light);">View Details</a></td>
            </tr>
            </tbody>
        </table>
        <button class="cta-btn" style="margin-top: 20px;" onclick="window.location.href='orders.jsp'">View All Orders</button>
    </div>
</section>

<!-- Quick Actions Section -->
<section class="container dashboard-section">
    <h2 class="section-title">Quick Actions</h2>
    <div class="dashboard-grid">
        <div class="dashboard-card">
            <h3><i class="fas fa-shopping-cart"></i> Continue Shopping</h3>
            <p>Browse our latest collection of musical instruments and accessories.</p>
            <button class="cta-btn" onclick="window.location.href='shop.jsp'">Shop Now</button>
        </div>
        <div class="dashboard-card">
            <h3><i class="fas fa-heart"></i> Your Wishlist</h3>
            <p>View and manage your saved items for future purchases.</p>
            <button class="cta-btn" onclick="window.location.href='wishlist.jsp'">View Wishlist</button>
        </div>
        <div class="dashboard-card">
            <h3><i class="fas fa-user-edit"></i> Update Profile</h3>
            <p>Keep your personal information and preferences up to date.</p>
            <button class="cta-btn" onclick="window.location.href='profile.jsp'">Edit Profile</button>
        </div>
        <div class="dashboard-card">
            <h3><i class="fas fa-headphones"></i> Support Center</h3>
            <p>Need help? Contact our customer support team for assistance.</p>
            <button class="cta-btn" onclick="window.location.href='support.jsp'">Get Help</button>
        </div>
    </div>
</section>

<!-- Recommended Products Section -->
<section class="container dashboard-section">
    <h2 class="section-title">Recommended For You</h2>
    <div class="dashboard-grid">
        <div class="dashboard-card">
            <h3><i class="fas fa-guitar"></i> Guitar Accessories</h3>
            <p>Based on your recent purchase, you might like these guitar accessories.</p>
            <button class="cta-btn" onclick="window.location.href='shop.jsp?category=guitar-accessories'">Explore</button>
        </div>
        <div class="dashboard-card">
            <h3><i class="fas fa-drum"></i> Percussion Instruments</h3>
            <p>Check out our new arrivals in the percussion category.</p>
            <button class="cta-btn" onclick="window.location.href='shop.jsp?category=percussion'">Discover</button>
        </div>
        <div class="dashboard-card">
            <h3><i class="fas fa-music"></i> Sheet Music</h3>
            <p>Find the perfect sheet music for your favorite songs and genres.</p>
            <button class="cta-btn" onclick="window.location.href='shop.jsp?category=sheet-music'">Browse</button>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-column">
                <h3>Melody Mart</h3>
                <p>Your premier destination for high-quality musical instruments and professional audio equipment.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <div class="footer-column">
                <h3>Shop</h3>
                <ul class="footer-links">
                    <li><a href="#">Guitars</a></li>
                    <li><a href="#">Drums & Percussion</a></li>
                    <li><a href="#">Pianos & Keyboards</a></li>
                    <li><a href="#">Recording Equipment</a></li>
                    <li><a href="#">Accessories</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Customer Service</h3>
                <ul class="footer-links">
                    <li><a href="#">My Account</a></li>
                    <li><a href="#">Order Tracking</a></li>
                    <li><a href="#">Returns & Exchanges</a></li>
                    <li><a href="#">Shipping Information</a></li>
                    <li><a href="#">FAQ</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Newsletter</h3>
                <p>Subscribe to our newsletter for the latest products and exclusive offers.</p>
                <form>
                    <input type="email" placeholder="Your Email" style="width: 100%; padding: 12px; margin-bottom: 10px; border-radius: 5px; border: none; background: var(--card-bg); color: var(--text);">
                    <button class="cta-btn" style="width: 100%;">Subscribe</button>
                </form>
            </div>
        </div>

        <div class="copyright">
            &copy; 2025 Melody Mart. All rights reserved.
        </div>
    </div>
</footer>

<script>
    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // Get customer name from URL parameter or use default
    function getCustomerName() {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get('name') || 'Customer';
    }

    // Update customer name in the dashboard
    function updateCustomerName() {
        const customerName = getCustomerName();
        document.querySelectorAll('.customer-name').forEach(el => {
            el.textContent = customerName;
        });
        document.querySelector('.user-btn').innerHTML = `<i class="fas fa-user"></i> ${customerName}`;
    }

    // Intersection Observer for animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.section-title, .stat-card, .dashboard-card').forEach((el) => {
        observer.observe(el);
    });

    // Initialize dashboard
    document.addEventListener('DOMContentLoaded', function() {
        updateCustomerName();

        // Add sample data for demonstration
        const stats = document.querySelectorAll('.stat-number');
        if (stats.length > 0) {
            // Animate stat numbers
            stats.forEach(stat => {
                const target = parseInt(stat.textContent);
                let current = 0;
                const increment = target / 50;

                const updateStat = () => {
                    if (current < target) {
                        current += increment;
                        stat.textContent = Math.round(current);
                        setTimeout(updateStat, 30);
                    } else {
                        stat.textContent = target;
                    }
                };

                setTimeout(updateStat, 500);
            });
        }
    });
</script>
</body>
</html>