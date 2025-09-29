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
        /* --- your existing CSS unchanged --- */
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
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Montserrat', sans-serif; background: var(--secondary); color: var(--text); overflow-x: hidden; line-height: 1.6; }
        .container { width: 100%; max-width: 1400px; margin: 0 auto; padding: 0 20px; }
        header { position: fixed; top: 0; left: 0; width: 100%; z-index: 1000; padding: 20px 0; transition: all 0.4s ease; }
        header.scrolled { background: rgba(10, 10, 10, 0.95); padding: 15px 0; backdrop-filter: blur(10px); box-shadow: 0 5px 20px rgba(0, 0, 0, 0.5); }
        .nav-container { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-family: 'Playfair Display', serif; font-size: 28px; font-weight: 800; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; display: flex; align-items: center; }
        .logo i { margin-right: 10px; font-size: 32px; }
        .nav-links { display: flex; list-style: none; }
        .nav-links li { margin: 0 15px; }
        .nav-links a { color: var(--text); text-decoration: none; font-weight: 500; transition: color 0.3s ease; position: relative; }
        .nav-links a:after { content: ''; position: absolute; bottom: -5px; left: 0; width: 0; height: 2px; background: var(--gradient); transition: width 0.3s ease; }
        .nav-links a:hover:after { width: 100%; }
        .nav-links a:hover { color: var(--primary-light); }
        .nav-actions { display: flex; align-items: center; }
        .search-btn, .cart-btn { background: none; border: none; color: var(--text); font-size: 18px; margin-left: 20px; cursor: pointer; transition: color 0.3s ease; }
        .search-btn:hover, .cart-btn:hover { color: var(--primary-light); }
        .cta-btn { background: var(--gradient); color: white; border: none; padding: 12px 25px; border-radius: 30px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; margin-left: 20px; position: relative; overflow: hidden; z-index: 1; }
        .cta-btn:before { content: ''; position: absolute; top: 0; left: 0; width: 0; height: 100%; background: var(--gradient-alt); transition: all 0.4s ease; z-index: -1; }
        .cta-btn:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4); }
        .cta-btn:hover:before { width: 100%; }
        .section-title { text-align: center; font-family: 'Playfair Display', serif; font-size: 36px; margin: 80px 0 50px; position: relative; opacity: 0; transform: translateY(30px); transition: opacity 1s ease, transform 1s ease; }
        .section-title.visible { opacity: 1; transform: translateY(0); }
        .section-title:after { content: ''; position: absolute; bottom: -15px; left: 50%; transform: translateX(-50%); width: 80px; height: 3px; background: var(--gradient); }
        .glass-card { background: var(--glass-bg); backdrop-filter: blur(10px); border: 1px solid var(--glass-border); border-radius: 15px; padding: 30px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2); }
        .filter-section { display: flex; gap: 20px; margin-bottom: 40px; }
        .filter-card { background: var(--card-bg); padding: 15px; border-radius: 10px; flex: 1; }
        .filter-card h3 { font-size: 18px; margin-bottom: 10px; }
        .filter-card select, .filter-card input { width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid var(--glass-border); background: var(--secondary); color: var(--text); border-radius: 5px; }
        .filter-card button { background: var(--gradient); border: none; padding: 10px; border-radius: 30px; color: white; width: 100%; cursor: pointer; transition: background 0.3s ease; }
        .filter-card button:hover { background: var(--gradient-alt); }
        .products { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; margin-bottom: 80px; }
        .product-card { background: var(--card-bg); border-radius: 15px; overflow: hidden; transition: all 0.5s ease; position: relative; opacity: 0; transform: translateY(50px); border: 1px solid var(--glass-border); box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3); }
        .product-card.visible { opacity: 1; transform: translateY(0); }
        .product-card:hover { transform: translateY(-10px); box-shadow: 0 15px 30px rgba(138, 43, 226, 0.2); }
        .product-img { height: 220px; width: 100%; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; transition: transform 0.5s ease; }
        .product-card:hover .product-img { transform: scale(1.1); }
        .product-img img { width: 100%; height: 100%; object-fit: cover; }
        .product-info { padding: 20px; }
        .product-title { font-size: 18px; font-weight: 600; margin-bottom: 10px; }
        .product-price { color: var(--primary-light); font-weight: 700; font-size: 22px; margin-bottom: 15px; }
        .product-desc { color: var(--text-secondary); font-size: 14px; margin-bottom: 20px; }
        .product-actions { display: flex; justify-content: space-between; }
        .product-actions .cta-btn { padding: 8px 15px; font-size: 14px; }
        .product-actions button { background: none; border: none; color: var(--text-secondary); cursor: pointer; font-size: 18px; transition: color 0.3s ease; }
        .product-actions button:hover { color: var(--primary-light); }
        @keyframes bounceIn { 0% { opacity: 0; transform: scale(0.3); } 50% { opacity: 1; transform: scale(1.05); } 70% { transform: scale(0.9); } 100% { transform: scale(1); } }
        .bounce-in { animation: bounceIn 1s ease-out forwards; }
        @media (max-width: 768px) {
            .filter-section { flex-direction: column; }
            .nav-links { display: none; }
            .section-title { font-size: 32px; }
            .product-card { margin: 0 10px; }
        }
        @media (max-width: 576px) {
            .section-title { font-size: 28px; }
            .product-card { margin: 0 5px; }
        }
    </style>
</head>
<body>
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
</script>
</body>
</html>
