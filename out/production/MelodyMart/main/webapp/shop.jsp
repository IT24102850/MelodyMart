<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Shop Premium Instruments</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #3b82f6; /* Bright Blue */
            --primary-light: #60a5fa;
            --secondary: #ffffff; /* White */
            --accent: #06b6d4; /* Cyan Accent */
            --gold-accent: #f59e0b; /* Amber Gold */
            --text: #1e293b; /* Dark Blue-Gray */
            --text-secondary: #64748b; /* Medium Gray */
            --card-bg: rgba(30, 41, 59, 0.85); /* Darker glass background */
            --glass-bg: rgba(30, 41, 59, 0.8);
            --glass-border: rgba(59, 130, 246, 0.3);
            --shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background:
                    linear-gradient(135deg, rgba(224, 242, 254, 0.9), rgba(240, 249, 255, 0.9)),
                    url('https://images.unsplash.com/photo-1506157786151-b8491531f063?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: var(--text);
            overflow-x: hidden;
            line-height: 1.6;
        }

        /* Background blur overlay */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: inherit;
            filter: blur(8px) brightness(0.9);
            z-index: -1;
            transform: scale(1.1);
        }

        .container {
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            z-index: 1;
        }

        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            padding: 20px 0;
            transition: all 0.4s ease;
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border-bottom: 1px solid var(--glass-border);
        }

        header.scrolled {
            padding: 15px 0;
            box-shadow: var(--shadow);
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
            color: white;
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

        .nav-links a:hover:after {
            width: 100%;
        }

        .nav-links a:hover {
            color: var(--primary-light);
        }

        .nav-actions {
            display: flex;
            align-items: center;
        }

        .search-btn, .cart-btn {
            background: none;
            border: none;
            color: white;
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

        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(59, 130, 246, 0.4);
        }

        .section-title {
            text-align: center;
            font-family: 'Playfair Display', serif;
            font-size: 36px;
            margin: 120px 0 50px;
            position: relative;
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 1s ease, transform 1s ease;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
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

        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 30px;
            box-shadow: var(--shadow);
            color: white;
        }

        .filter-section {
            display: flex;
            gap: 20px;
            margin-bottom: 40px;
        }

        .filter-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            flex: 1;
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(5px);
        }

        .filter-card h3 {
            font-size: 18px;
            margin-bottom: 15px;
            color: white;
        }

        .filter-card select, .filter-card input {
            width: 100%;
            padding: 12px;
            margin-bottom: 10px;
            border: 1px solid var(--glass-border);
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .filter-card select:focus, .filter-card input:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
            background: rgba(255, 255, 255, 0.15);
        }

        .filter-card button {
            background: var(--gradient);
            border: none;
            padding: 12px;
            border-radius: 30px;
            color: white;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .filter-card button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.4);
        }

        .products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 80px;
        }

        .product-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.5s ease;
            position: relative;
            opacity: 0;
            transform: translateY(50px);
            border: 1px solid var(--glass-border);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(5px);
        }

        .product-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(59, 130, 246, 0.3);
            background: rgba(255, 255, 255, 0.15);
        }

        .product-img {
            height: 220px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            transition: transform 0.5s ease;
        }

        .product-card:hover .product-img {
            transform: scale(1.1);
        }

        .product-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-info {
            padding: 20px;
        }

        .product-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            color: white;
        }

        .product-price {
            color: var(--primary-light);
            font-weight: 700;
            font-size: 22px;
            margin-bottom: 15px;
        }

        .product-desc {
            color: #e2e8f0;
            font-size: 14px;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .product-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .product-actions .cta-btn {
            padding: 8px 15px;
            font-size: 14px;
            margin: 0;
        }

        .product-actions button {
            background: none;
            border: none;
            color: #cbd5e1;
            cursor: pointer;
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .product-actions button:hover {
            color: var(--primary-light);
        }

        @keyframes bounceIn {
            0% { opacity: 0; transform: scale(0.3); }
            50% { opacity: 1; transform: scale(1.05); }
            70% { transform: scale(0.9); }
            100% { transform: scale(1); }
        }

        .bounce-in {
            animation: bounceIn 1s ease-out forwards;
        }

        .floating-icons {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 0;
        }

        .floating-icon {
            position: absolute;
            font-size: 24px;
            color: rgba(59, 130, 246, 0.2);
            animation: float 6s ease-in-out infinite;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
        }

        @media (max-width: 768px) {
            .filter-section { flex-direction: column; }
            .nav-links { display: none; }
            .section-title { font-size: 32px; margin-top: 100px; }
            .product-card { margin: 0 10px; }
        }

        @media (max-width: 576px) {
            .section-title { font-size: 28px; }
            .product-card { margin: 0 5px; }
        }
    </style>
</head>
<body>
<div class="floating-icons">
    <div class="floating-icon" style="top: 10%; left: 5%; animation-delay: 0s;">🎵</div>
    <div class="floating-icon" style="top: 20%; right: 10%; animation-delay: 1s;">🎸</div>
    <div class="floating-icon" style="top: 60%; left: 8%; animation-delay: 2s;">🎹</div>
    <div class="floating-icon" style="top: 70%; right: 7%; animation-delay: 3s;">🥁</div>
    <div class="floating-icon" style="top: 40%; left: 15%; animation-delay: 4s;">🎻</div>
</div>

<header>
    <div class="container nav-container">
        <div class="logo"><i class="fas fa-music"></i> Melody Mart</div>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="shop.jsp">Shop</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>
        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <a href="cart.jsp" class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></a>
            <button class="cta-btn" onclick="window.location.href='cart.jsp'">Shop Now</button>
        </div>
    </div>
</header>

<section class="container">
    <h2 class="section-title">Explore Our Instruments</h2>
    <div class="glass-card">
        <div class="filter-section">
            <div class="filter-card">
                <h3>Filter by Category</h3>
                <select id="categoryFilter" onchange="filterProducts()">
                    <option value="">All Categories</option>
                    <%
                        String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true;";
                        String dbUser = "Hasiru";
                        String dbPass = "hasiru2004";
                        String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName(driver);
                            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT CategoryID, Name FROM Category");
                            while (rs.next()) {
                                out.println("<option value=\"" + rs.getInt("CategoryID") + "\">" + rs.getString("Name") + "</option>");
                            }
                        } catch (Exception e) {
                            out.println("<option>Error loading categories</option>");
                        } finally {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </select>
                <button onclick="filterProducts()">Apply Filter</button>
            </div>
            <div class="filter-card">
                <h3>Search Instruments</h3>
                <input type="text" id="searchInput" placeholder="Enter name or description..." onkeyup="filterProducts()">
            </div>
        </div>
        <div class="products" id="productList">
            <%
                try {
                    Class.forName(driver);
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                    String sql = "SELECT i.InstrumentID, i.Name, i.Description, i.Model, i.Color, i.Price, i.ImageURL, i.Quantity, i.StockLevel, " +
                            "b.Name AS BrandName, m.Name AS ManufacturerName " +
                            "FROM Instrument i " +
                            "LEFT JOIN Brand b ON i.BrandID = b.BrandID " +
                            "LEFT JOIN Manufacturer m ON i.ManufacturerID = m.ManufacturerID";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);
                    while (rs.next()) {
                        String imageUrl = rs.getString("ImageURL");
                        if (imageUrl == null || imageUrl.isEmpty()) imageUrl = "https://via.placeholder.com/300x220?text=No+Image";
            %>

            <div class="product-card bounce-in">
                <div class="product-img">
                    <img src="<%= imageUrl %>" alt="<%= rs.getString("Name") %>">
                </div>
                <div class="product-info">
                    <h3 class="product-title"><%= rs.getString("Name") %></h3>
                    <div class="product-price">$<%= String.format("%.2f", rs.getDouble("Price")) %></div>
                    <p class="product-desc"><%= rs.getString("Description") != null ? rs.getString("Description") : "No description available" %></p>
                    <div class="product-actions">
                        <!-- ✅ Updated Add to Cart button -->
                        <form action="addToCart.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="instrumentId" value="<%= rs.getInt("InstrumentID") %>">
                            <button type="submit" class="cta-btn">Add to Cart</button>
                        </form>

                        <button class="cta-btn" onclick="window.location.href='order-now.jsp'">Order Now</button>
                        <button><i class="far fa-heart"></i></button>
                    </div>
                </div>
            </div>

            <%
                    }
                } catch (Exception e) {
                    out.println("<p class='error'>Error loading products: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div>
    </div>
</section>

<script>
    // Add floating icons dynamically
    function addFloatingIcons() {
        const icons = ['🎵', '🎸', '🎹', '🥁', '🎻', '🎺', '🎼', '📯'];
        const container = document.querySelector('.floating-icons');

        for (let i = 0; i < 15; i++) {
            const icon = document.createElement('div');
            icon.className = 'floating-icon';
            icon.textContent = icons[Math.floor(Math.random() * icons.length)];
            icon.style.left = Math.random() * 100 + '%';
            icon.style.top = Math.random() * 100 + '%';
            icon.style.animationDelay = Math.random() * 5 + 's';
            icon.style.fontSize = (Math.random() * 20 + 16) + 'px';
            container.appendChild(icon);
        }
    }

    window.addEventListener('scroll', () => {
        const header = document.querySelector('header');
        if (window.scrollY > 50) header.classList.add('scrolled');
        else header.classList.remove('scrolled');
    });

    function filterProducts() {
        const category = document.getElementById('categoryFilter').value;
        const search = document.getElementById('searchInput').value.toLowerCase();
        const products = document.querySelectorAll('.product-card');

        products.forEach(product => {
            const name = product.querySelector('.product-title').textContent.toLowerCase();
            const desc = product.querySelector('.product-desc').textContent.toLowerCase();
            const catMatch = !category || product.getAttribute('data-category') === category;
            const searchMatch = !search || name.includes(search) || desc.includes(search);

            if (catMatch && searchMatch) product.style.display = 'block';
            else product.style.display = 'none';
        });
    }

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) entry.target.classList.add('visible');
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.product-card').forEach(el => observer.observe(el));

    // Initialize floating icons
    addFloatingIcons();
</script>
</body>
</html>