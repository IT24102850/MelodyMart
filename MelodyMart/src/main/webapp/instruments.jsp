<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Premium Musical Instruments</title>
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
            font-family: 'Montserrat', sans-serif;
        }

        body {
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

        /* Page Header */
        .page-header {
            margin-top: 120px;
            padding: 3rem 5%;
            text-align: center;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            margin-bottom: 1rem;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .page-subtitle {
            font-size: 1.2rem;
            color: var(--text-secondary);
            max-width: 700px;
            margin: 0 auto 2rem;
        }

        /* Filters Section */
        .filters-section {
            padding: 1rem 5%;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            margin: 2rem 5%;
        }

        .filters-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .search-bar {
            display: flex;
            align-items: center;
            background: var(--card-bg);
            border-radius: 50px;
            padding: 0.5rem 1rem;
            width: 300px;
            border: 1px solid var(--glass-border);
        }

        .search-bar input {
            background: transparent;
            border: none;
            color: var(--text);
            padding: 0.5rem;
            width: 100%;
            outline: none;
        }

        .search-bar i {
            color: var(--text-secondary);
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .search-bar i:hover {
            color: var(--primary-light);
        }

        .filter-options {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .filter-dropdown {
            position: relative;
        }

        .filter-btn {
            background: var(--card-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .filter-btn:hover {
            background: var(--card-hover);
            border-color: var(--primary-light);
        }

        /* Instruments Grid */
        .instruments-grid {
            padding: 0 5% 5rem;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .instrument-card {
            background: var(--card-bg);
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.5s ease;
            position: relative;
            opacity: 0;
            transform: translateY(50px);
            border: 1px solid var(--glass-border);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .instrument-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .instrument-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(138, 43, 226, 0.2);
        }

        .instrument-image {
            height: 250px;
            width: 100%;
            overflow: hidden;
            background: #000;
            position: relative;
        }

        .instrument-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
            transition: transform 0.5s ease;
        }

        .instrument-card:hover .instrument-image img {
            transform: scale(1.1);
        }

        .instrument-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--gradient);
            color: var(--text);
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .instrument-info {
            padding: 1.5rem;
        }

        .instrument-info h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--text);
        }

        .instrument-info p {
            color: var(--text-secondary);
            margin-bottom: 1rem;
            font-size: 0.9rem;
            line-height: 1.5;
        }

        .instrument-price {
            font-size: 1.8rem;
            font-weight: 700;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1rem;
        }

        .instrument-rating {
            display: flex;
            align-items: center;
            gap: 0.3rem;
            margin-bottom: 1rem;
        }

        .instrument-rating i {
            color: var(--accent);
            font-size: 0.9rem;
        }

        .instrument-actions {
            display: flex;
            justify-content: space-between;
        }

        .add-to-cart {
            background: var(--gradient);
            color: var(--text);
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            flex: 1;
            margin-right: 0.5rem;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .add-to-cart:before {
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

        .add-to-cart:hover {
            transform: scale(1.05);
        }

        .add-to-cart:hover:before {
            width: 100%;
        }

        .details-btn {
            background: transparent;
            color: var(--text-secondary);
            border: 1px solid var(--glass-border);
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease, transform 0.3s ease;
            flex: 1;
            margin-left: 0.5rem;
        }

        .details-btn:hover {
            background: var(--primary-light);
            color: var(--text);
            border-color: var(--primary-light);
            transform: scale(1.05);
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin: 3rem 0;
            padding: 0 5%;
        }

        .pagination-btn {
            background: var(--card-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pagination-btn:hover, .pagination-btn.active {
            background: var(--gradient);
            transform: scale(1.1);
            border-color: transparent;
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

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .instrument-card {
            animation: fadeIn 0.5s ease-out;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .instruments-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 992px) {
            .nav-links {
                display: none;
            }

            .filters-container {
                flex-direction: column;
                align-items: stretch;
            }

            .search-bar {
                width: 100%;
            }

            .filter-options {
                justify-content: center;
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2.5rem;
            }

            .instrument-card {
                max-width: 100%;
            }

            .instrument-actions {
                flex-direction: column;
                gap: 0.5rem;
            }

            .add-to-cart, .details-btn {
                margin: 0;
                width: 100%;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 2rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }

            .instrument-info h3 {
                font-size: 1.3rem;
            }

            .instrument-price {
                font-size: 1.5rem;
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
            <li><a href="instruments.jsp" class="active">Instruments</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="deals.jsp">Deals</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>

        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <button class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></button>
            <button class="cta-btn" onclick="window.location.href='instruments.jsp'">Shop Now</button>
        </div>
    </div>
</header>

<section class="page-header">
    <h1 class="page-title">Premium Musical Instruments</h1>
    <p class="page-subtitle">Discover our curated collection of high-quality instruments for musicians of all levels. From beginners to professionals, find your perfect sound.</p>
</section>

<section class="filters-section">
    <div class="filters-container">
        <div class="search-bar">
            <input type="text" placeholder="Search instruments..." id="searchInput">
            <i class="fas fa-search"></i>
        </div>

        <div class="filter-options">
            <div class="filter-dropdown">
                <button class="filter-btn">
                    <i class="fas fa-filter"></i>
                    Category
                </button>
            </div>

            <div class="filter-dropdown">
                <button class="filter-btn">
                    <i class="fas fa-dollar-sign"></i>
                    Price
                </button>
            </div>

            <div class="filter-dropdown">
                <button class="filter-btn">
                    <i class="fas fa-star"></i>
                    Rating
                </button>
            </div>

            <div class="filter-dropdown">
                <button class="filter-btn">
                    <i class="fas fa-sort-amount-down"></i>
                    Sort
                </button>
            </div>
        </div>
    </div>
</section>

<section class="instruments-grid" id="instrumentsGrid">
    <!-- Instrument 1 -->
    <div class="instrument-card">
        <div class="instrument-image">
            <img src="${pageContext.request.contextPath}/images/guitar.jpg" alt="Fender Stratocaster">
            <span class="instrument-badge">Popular</span>
        </div>
        <div class="instrument-info">
            <h3>Fender Stratocaster</h3>
            <p>The iconic electric guitar loved by professionals worldwide for its versatile tone.</p>
            <div class="instrument-price">$1,499</div>
            <div class="instrument-rating">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star-half-alt"></i>
                <span>(128)</span>
            </div>
            <div class="instrument-actions">
                <button class="add-to-cart">Add to Cart</button>
                <button class="details-btn">Details</button>
            </div>
        </div>
    </div>

    <!-- Instrument 2 -->
    <div class="instrument-card">
        <div class="instrument-image">
            <img src="${pageContext.request.contextPath}/images/piano.jpg" alt="Yamaha Grand Piano">
            <span class="instrument-badge">Premium</span>
        </div>
        <div class="instrument-info">
            <h3>Yamaha Grand Piano</h3>
            <p>Experience the rich, resonant sound of this expertly crafted grand piano.</p>
            <div class="instrument-price">$12,999</div>
            <div class="instrument-rating">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <span>(64)</span>
            </div>
            <div class="instrument-actions">
                <button class="add-to-cart">Add to Cart</button>
                <button class="details-btn">Details</button>
            </div>
        </div>
    </div>

    <!-- Instrument 3 -->
    <div class="instrument-card">
        <div class="instrument-image">
            <img src="${pageContext.request.contextPath}/images/drums.jpg" alt="Pearl Drum Set">
        </div>
        <div class="instrument-info">
            <h3>Pearl Drum Set</h3>
            <p>A professional drum kit with exceptional sound quality and durability.</p>
            <div class="instrument-price">$2,799</div>
            <div class="instrument-rating">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="far fa-star"></i>
                <span>(87)</span>
            </div>
            <div class="instrument-actions">
                <button class="add-to-cart">Add to Cart</button>
                <button class="details-btn">Details</button>
            </div>
        </div>
    </div>

    <!-- Instrument 4 -->
    <div class="instrument-card">
        <div class="instrument-image">
            <img src="${pageContext.request.contextPath}/images/saxophone.jpg" alt="Selmer Saxophone">
            <span class="instrument-badge">Sale</span>
        </div>
        <div class="instrument-info">
            <h3>Selmer Saxophone</h3>
            <p>Professional alto saxophone with rich tone and excellent intonation.</p>
            <div class="instrument-price">$3,450</div>
            <div class="instrument-rating">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star-half-alt"></i>
                <span>(42)</span>
            </div>
            <div class="instrument-actions">
                <button class="add-to-cart">Add to Cart</button>
                <button class="details-btn">Details</button>
            </div>
        </div>
    </div>

    <!-- Instrument 5 -->
    <div class="instrument-card">
        <div class="instrument-image">
            <img src="${pageContext.request.contextPath}/images/violin.jpg" alt="Stradivarius Violin">
            <span class="instrument-badge">Premium</span>
        </div>
        <div class="instrument-info">
            <h3>Stradivarius Violin</h3>
            <p>Handcrafted violin with exceptional tone quality and beautiful finish.</p>
            <div class="instrument-price">$5,200</div>
            <div class="instrument-rating">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <span>(29)</span>
            </div>
            <div class="instrument-actions">
                <button class="add-to-cart">Add to Cart</button>
                <button class="details-btn">Details</button>
            </div>
        </div>
    </div>

    <!-- Instrument 6 -->
    <div class="instrument-card">
        <div class="instrument-image">
            <img src="${pageContext.request.contextPath}/images/trumpet.jpg" alt="Bach Trumpet">
        </div>
        <div class="instrument-info">
            <h3>Bach Trumpet</h3>
            <p>Professional Bb trumpet with superior response and projection.</p>
            <div class="instrument-price">$2,350</div>
            <div class="instrument-rating">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="far fa-star"></i>
                <span>(38)</span>
            </div>
            <div class="instrument-actions">
                <button class="add-to-cart">Add to Cart</button>
                <button class="details-btn">Details</button>
            </div>
        </div>
    </div>

    <!-- Instrument 7 -->
    <div class="instrument-card">
        <div class="instrument-image">
            <img src="${pageContext.request.contextPath}/images/bass.jpg" alt="Fender Jazz Bass">
            <span class="instrument-badge">New</span>
        </div>
        <div class="instrument-info">
            <h3>Fender Jazz Bass</h3>
            <p>Iconic bass guitar known for its versatile tone and smooth playability.</p>
            <div class="instrument-price">$1,350</div>
            <div class="instrument-rating">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star-half-alt"></i>
                <span>(56)</span>
            </div>
            <div class="instrument-actions">
                <button class="add-to-cart">Add to Cart</button>
                <button class="details-btn">Details</button>
            </div>
        </div>
    </div>

    <!-- Instrument 8 -->
    <div class="instrument-card">
        <div class="instrument-image">
            <img src="${pageContext.request.contextPath}/images/flute.jpg" alt="Yamaha Flute">
        </div>
        <div class="instrument-info">
            <h3>Yamaha Flute</h3>
            <p>Professional flute with excellent intonation and responsive key action.</p>
            <div class="instrument-price">$1,850</div>
            <div class="instrument-rating">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <span>(31)</span>
            </div>
            <div class="instrument-actions">
                <button class="add-to-cart">Add to Cart</button>
                <button class="details-btn">Details</button>
            </div>
        </div>
    </div>
</section>

<div class="pagination">
    <button class="pagination-btn active">1</button>
    <button class="pagination-btn">2</button>
    <button class="pagination-btn">3</button>
    <button class="pagination-btn">4</button>
    <button class="pagination-btn">></button>
</div>

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
                    <li><a href="#">Keyboards</a></li>
                    <li><a href="#">Drums</a></li>
                    <li><a href="#">Brass Instruments</a></li>
                    <li><a href="#">Woodwinds</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Support</h3>
                <ul class="footer-links">
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Shipping & Returns</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Warranty</a></li>
                    <li><a href="#">Repair Services</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Newsletter</h3>
                <p>Subscribe to get updates on new products, special offers, and exclusive deals.</p>
                <form>
                    <input type="email" placeholder="Your email address" style="width: 100%; padding: 12px; margin-bottom: 10px; border-radius: 5px; border: 1px solid var(--glass-border); background: var(--card-bg); color: var(--text);">
                    <button class="cta-btn" style="width: 100%;">Subscribe</button>
                </form>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; 2023 Melody Mart. All rights reserved.</p>
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

    // Search functionality
    document.getElementById('searchInput').addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const cards = document.querySelectorAll('.instrument-card');

        cards.forEach(card => {
            const title = card.querySelector('h3').textContent.toLowerCase();
            const description = card.querySelector('p').textContent.toLowerCase();

            if (title.includes(searchTerm) || description.includes(searchTerm)) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    });

    // Pagination functionality
    const paginationBtns = document.querySelectorAll('.pagination-btn');
    paginationBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            paginationBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // Add to cart animation
    const addToCartBtns = document.querySelectorAll('.add-to-cart');
    addToCartBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            this.innerHTML = '<i class="fas fa-check"></i> Added';
            setTimeout(() => {
                this.innerHTML = 'Add to Cart';
            }, 2000);
        });
    });

    // Intersection Observer for animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.instrument-card').forEach((el) => {
        observer.observe(el);
    });
</script>
</body>
</html>