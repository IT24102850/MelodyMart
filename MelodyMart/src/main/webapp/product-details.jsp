<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
<%
    String instrumentId = request.getParameter("instrumentId");
    if (instrumentId == null || instrumentId.isEmpty()) {
        response.sendRedirect("shop.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String name = "";
    String description = "";
    String brandID = "";
    String model = "";
    String color = "";
    double price = 0;
    String specifications = "";
    String warranty = "";
    int quantity = 0;
    String stockLevel = "";
    String manufacturerID = "";
    String imageURL = "";

    try {
        conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Instrument WHERE InstrumentID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, instrumentId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("Name");
            description = rs.getString("Description");
            brandID = rs.getString("BrandID");
            model = rs.getString("Model");
            color = rs.getString("Color");
            price = rs.getDouble("Price");
            specifications = rs.getString("Specifications");
            warranty = rs.getString("Warranty");
            quantity = rs.getInt("Quantity");
            stockLevel = rs.getString("StockLevel");
            manufacturerID = rs.getString("ManufacturerID");
            imageURL = rs.getString("ImageURL");
        } else {
            response.sendRedirect("shop.jsp?error=Product not found");
            return;
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("shop.jsp?error=Database error");
        return;
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= name %> | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        /* Include all your existing CSS styles */
        /* Add product details specific styles */
        .product-details-container {
            max-width: 1200px;
            margin: 120px auto 60px;
            padding: 0 20px;
        }

        .product-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            background: var(--glass-bg);
            border-radius: var(--border-radius);
            padding: 40px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
        }

        .product-image {
            border-radius: var(--border-radius);
            overflow: hidden;
            background: var(--gradient-soft);
        }

        .product-image img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }

        .product-info h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: var(--text);
        }

        .product-meta {
            margin-bottom: 30px;
        }

        .product-price {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 20px;
        }

        .product-specs {
            margin: 30px 0;
        }

        .spec-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid var(--glass-border);
        }

        .spec-label {
            font-weight: 600;
            color: var(--text-secondary);
        }

        .spec-value {
            color: var(--text);
        }

        .stock-status {
            padding: 10px 15px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 20px;
        }

        .in-stock {
            background: #4caf50;
            color: white;
        }

        .low-stock {
            background: var(--accent-alt);
            color: white;
        }

        .out-of-stock {
            background: #f44336;
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            flex: 2;
            justify-content: center;
        }

        .btn-secondary {
            background: var(--card-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            flex: 1;
            justify-content: center;
        }

        .btn-primary:hover, .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: var(--text);
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .back-link:hover {
            color: var(--primary-light);
        }
    </style>
</head>
<body>
<!-- Header (same as shop.jsp) -->
<header>
    <div class="container nav-container">
        <div class="logo">
            <i class="fas fa-music"></i>
            Melody Mart
        </div>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="shop.jsp">Shop</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a></li>
        </ul>
        <div class="nav-actions">
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i></button>
                <div class="dropdown">
                    <a href="sign-in.jsp" class="dropdown-item">Sign In</a>
                    <a href="sign-up.jsp" class="dropdown-item">Sign Up</a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Product Details -->
<div class="product-details-container">
    <a href="shop.jsp" class="back-link">
        <i class="fas fa-arrow-left"></i>
        Back to Shop
    </a>

    <div class="product-details">
        <div class="product-image">
            <%
                if (imageURL != null && !imageURL.trim().isEmpty()) {
            %>
            <img src="<%= imageURL %>" alt="<%= name %>">
            <%
            } else {
            %>
            <img src="https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="<%= name %>">
            <%
                }
            %>
        </div>

        <div class="product-info">
            <h1><%= name %></h1>

            <div class="product-meta">
                <div class="product-rating">
                    <div class="rating-stars">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="rating-count">(42 reviews)</span>
                </div>

                <%
                    String stockClass = "in-stock";
                    String stockText = "In Stock";
                    if (quantity == 0) {
                        stockClass = "out-of-stock";
                        stockText = "Out of Stock";
                    } else if (quantity < 5) {
                        stockClass = "low-stock";
                        stockText = "Low Stock - Only " + quantity + " left";
                    }
                %>
                <div class="stock-status <%= stockClass %>">
                    <%= stockText %>
                </div>
            </div>

            <div class="product-price">$<%= String.format("%.2f", price) %></div>

            <p class="product-desc"><%= description != null ? description : "No description available." %></p>

            <div class="product-specs">
                <div class="spec-item">
                    <span class="spec-label">Brand:</span>
                    <span class="spec-value"><%= brandID %></span>
                </div>
                <div class="spec-item">
                    <span class="spec-label">Model:</span>
                    <span class="spec-value"><%= model != null ? model : "N/A" %></span>
                </div>
                <div class="spec-item">
                    <span class="spec-label">Color:</span>
                    <span class="spec-value"><%= color != null ? color : "N/A" %></span>
                </div>
                <div class="spec-item">
                    <span class="spec-label">Warranty:</span>
                    <span class="spec-value"><%= warranty != null ? warranty : "N/A" %></span>
                </div>
                <div class="spec-item">
                    <span class="spec-label">Manufacturer:</span>
                    <span class="spec-value"><%= manufacturerID %></span>
                </div>
            </div>

            <% if (specifications != null && !specifications.trim().isEmpty()) { %>
            <div class="product-specs">
                <h3>Specifications</h3>
                <p><%= specifications %></p>
            </div>
            <% } %>

            <div class="action-buttons">
                <form method="post" action="CartServlet" class="add-to-cart-form">
                    <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
                    <input type="hidden" name="action" value="add">
                    <button type="submit" class="btn-primary" <%= quantity == 0 ? "disabled" : "" %>>
                        <i class="fas fa-shopping-cart"></i>
                        Add to Cart
                    </button>
                </form>

                <button class="btn-secondary wishlist-btn">
                    <i class="far fa-heart"></i>
                    Wishlist
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Footer (same as shop.jsp) -->
<footer>
    <!-- Your existing footer content -->
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

    // Add to cart form submission feedback
    const addToCartForm = document.querySelector('.add-to-cart-form');
    if (addToCartForm) {
        addToCartForm.addEventListener('submit', function(e) {
            const button = this.querySelector('.btn-primary');
            const originalText = button.innerHTML;

            // Visual feedback
            button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding...';
            button.disabled = true;

            // Revert after 2 seconds if still on page
            setTimeout(() => {
                button.innerHTML = originalText;
                button.disabled = false;
            }, 2000);
        });
    }

    // Wishlist toggle
    const wishlistBtn = document.querySelector('.wishlist-btn');
    if (wishlistBtn) {
        wishlistBtn.addEventListener('click', () => {
            const icon = wishlistBtn.querySelector('i');
            if (icon.classList.contains('far')) {
                icon.classList.remove('far');
                icon.classList.add('fas');
                icon.style.color = 'var(--accent-alt)';
            } else {
                icon.classList.remove('fas');
                icon.classList.add('far');
                icon.style.color = '';
            }
        });
    }
</script>
</body>
</html>