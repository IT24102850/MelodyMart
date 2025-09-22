<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Shop Premium Instruments</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        /* [CSS remains unchanged, copy the original CSS block here] */
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
            <button class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></button>
            <button class="cta-btn" onclick="window.location.href='shop.jsp'">Shop Now</button>
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
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName(driver);
                            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                            pstmt = conn.prepareStatement("SELECT CategoryID, Name FROM Category");
                            rs = pstmt.executeQuery();
                            while (rs.next()) {
                                out.println("<option value=\"" + rs.getInt("CategoryID") + "\">" + rs.getString("Name") + "</option>");
                            }
                        } catch (Exception e) {
                            out.println("<option>Error loading categories</option>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
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
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        String imageUrl = rs.getString("ImageURL");
                        if (imageUrl == null || imageUrl.isEmpty()) imageUrl = "https://via.placeholder.com/300x220?text=No+Image";
            %>
            <div class="product-card bounce-in" data-category="<%= rs.getInt("CategoryID") %>">
                <div class="product-img">
                    <img src="<%= imageUrl %>" alt="<%= rs.getString("Name") %>">
                </div>
                <div class="product-info">
                    <h3 class="product-title"><%= rs.getString("Name") %></h3>
                    <div class="product-price">$<%= String.format("%.2f", rs.getDouble("Price")) %></div>
                    <p class="product-desc"><%= rs.getString("Description") != null ? rs.getString("Description") : "No description available" %></p>
                    <form action="shop.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="instrumentId" value="<%= rs.getInt("InstrumentID") %>">
                        <button type="submit" name="addToCart" class="cta-btn">Add to Cart</button>
                    </form>
                    <button class="cta-btn" onclick="window.location.href='order.jsp'">Order Now</button>
                    <button><i class="far fa-heart"></i></button>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p class='error'>Error loading products: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }

                // Handle Add to Cart submission
                if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("addToCart") != null) {
                    int instrumentId = Integer.parseInt(request.getParameter("instrumentId"));
                    String userId = session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "guest_" + session.getId(); // Temporary user ID
                    try {
                        Class.forName(driver);
                        conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                        pstmt = conn.prepareStatement("INSERT INTO Cart (InstrumentID, UserID, Quantity, AddedDate) VALUES (?, ?, 1, ?)");
                        pstmt.setInt(1, instrumentId);
                        pstmt.setString(2, userId);
                        pstmt.setTimestamp(3, new java.sql.Timestamp(new Date().getTime()));
                        int rowsAffected = pstmt.executeUpdate();
                        if (rowsAffected > 0) {
                            out.println("<script>alert('Added to Cart Successfully!');</script>");
                        } else {
                            out.println("<script>alert('Failed to add to cart. Please try again.');</script>");
                        }
                    } catch (Exception e) {
                        out.println("<script>alert('Error adding to cart: " + e.getMessage() + "');</script>");
                    } finally {
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
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