<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Premium Brands</title>
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

        /* Brands Section */
        .brands-section {
            padding: 2rem 5% 5rem;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: var(--text);
            position: relative;
            display: inline-block;
            padding-left: 1rem;
            border-left: 4px solid var(--accent);
        }

        .brands-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }

        .brand-card {
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

        .brand-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .brand-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(138, 43, 226, 0.2);
        }

        .brand-image {
            height: 180px;
            width: 100%;
            overflow: hidden;
            background: #000;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .brand-image img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            transition: transform 0.5s ease;
        }

        .brand-card:hover .brand-image img {
            transform: scale(1.1);
        }

        .brand-content {
            padding: 1.5rem;
            text-align: center;
        }

        .brand-title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--text);
        }

        .brand-description {
            color: var(--text-secondary);
            margin-bottom: 1rem;
            line-height: 1.5;
            font-size: 0.9rem;
        }

        .brand-specialty {
            display: inline-block;
            background: var(--gradient);
            color: var(--text);
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .brand-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 1rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .brand-stats span {
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        /* Featured Brands */
        .featured-brands {
            padding: 2rem 5% 5rem;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            margin: 2rem 5%;
        }

        .featured-brands-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .featured-brand-card {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
            cursor: pointer;
        }

        .featured-brand-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .featured-brand-logo {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--primary-light);
            transition: color 0.3s ease;
        }

        .featured-brand-card:hover .featured-brand-logo {
            color: var(--accent);
        }

        .featured-brand-name {
            font-weight: 600;
            color: var(--text);
            text-align: center;
        }

        /* Brand Categories */
        .brand-categories {
            padding: 2rem 5% 5rem;
        }

        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
        }

        .category-item {
            text-align: center;
            padding: 2rem;
            border-radius: 10px;
            background: var(--card-bg);
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
            cursor: pointer;
        }

        .category-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .category-icon {
            font-size: 2.5rem;
            color: var(--primary-light);
            margin-bottom: 1rem;
            transition: color 0.3s ease;
        }

        .category-item:hover .category-icon {
            color: var(--accent);
        }

        .category-title {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: var(--text);
        }

        .category-count {
            color: var(--text-secondary);
            font-size: 0.9rem;
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

        .brand-card, .featured-brand-card, .category-item {
            animation: fadeIn 0.5s ease-out;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .brands-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
        }

        @media (max-width: 992px) {
            .nav-links {
                display: none;
            }

            .featured-brands-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2.5rem;
            }

            .brand-card {
                max-width: 100%;
            }

            .categories-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 2rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }

            .brand-title {
                font-size: 1.3rem;
            }

            .featured-brands-grid {
                grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
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
            <li><a href="instruments.jsp">Instruments</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp" class="active">Brands</a></li>
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
    <h1 class="page-title">Premium Brands</h1>
    <p class="page-subtitle">Discover the world's finest musical instrument brands trusted by professionals and enthusiasts worldwide.</p>
</section>

<section class="brands-section">
    <h2 class="section-title">Featured Brands</h2>
    <div class="brands-grid">
        <!-- Brand 1 -->
        <div class="brand-card">
            <div class="brand-image">
                <img src="${pageContext.request.contextPath}/images/fender-logo.png" alt="Fender">
            </div>
            <div class="brand-content">
                <span class="brand-specialty">Guitars</span>
                <h3 class="brand-title">Fender</h3>
                <p class="brand-description">American iconic brand known for Stratocaster and Telecaster guitars, loved by musicians worldwide.</p>
                <div class="brand-stats">
                    <span><i class="fas fa-guitar"></i> 45 Products</span>
                    <span><i class="fas fa-star"></i> 4.9 Rating</span>
                </div>
            </div>
        </div>

        <!-- Brand 2 -->
        <div class="brand-card">
            <div class="brand-image">
                <img src="${pageContext.request.contextPath}/images/yamaha-logo.png" alt="Yamaha">
            </div>
            <div class="brand-content">
                <span class="brand-specialty">Multiple</span>
                <h3 class="brand-title">Yamaha</h3>
                <p class="brand-description">Japanese manufacturer offering everything from grand pianos to professional audio equipment.</p>
                <div class="brand-stats">
                    <span><i class="fas fa-music"></i> 89 Products</span>
                    <span><i class="fas fa-star"></i> 4.8 Rating</span>
                </div>
            </div>
        </div>

        <!-- Brand 3 -->
        <div class="brand-card">
            <div class="brand-image">
                <img src="${pageContext.request.contextPath}/images/gibson-logo.png" alt="Gibson">
            </div>
            <div class="brand-content">
                <span class="brand-specialty">Guitars</span>
                <h3 class="brand-title">Gibson</h3>
                <p class="brand-description">Legendary American brand famous for Les Paul and SG models, setting standards since 1902.</p>
                <div class="brand-stats">
                    <span><i class="fas fa-guitar"></i> 32 Products</span>
                    <span><i class="fas fa-star"></i> 4.9 Rating</span>
                </div>
            </div>
        </div>

        <!-- Brand 4 -->
        <div class="brand-card">
            <div class="brand-image">
                <img src="${pageContext.request.contextPath}/images/roland-logo.png" alt="Roland">
            </div>
            <div class="brand-content">
                <span class="brand-specialty">Electronics</span>
                <h3 class="brand-title">Roland</h3>
                <p class="brand-description">Innovative electronic musical instruments, equipment, and software for modern musicians.</p>
                <div class="brand-stats">
                    <span><i class="fas fa-keyboard"></i> 67 Products</span>
                    <span><i class="fas fa-star"></i> 4.7 Rating</span>
                </div>
            </div>
        </div>

        <!-- Brand 5 -->
        <div class="brand-card">
            <div class="brand-image">
                <img src="${pageContext.request.contextPath}/images/pearl-logo.png" alt="Pearl">
            </div>
            <div class="brand-content">
                <span class="brand-specialty">Drums</span>
                <h3 class="brand-title">Pearl</h3>
                <p class="brand-description">World-renowned drum manufacturer offering professional kits and percussion instruments.</p>
                <div class="brand-stats">
                    <span><i class="fas fa-drum"></i> 28 Products</span>
                    <span><i class="fas fa-star"></i> 4.8 Rating</span>
                </div>
            </div>
        </div>

        <!-- Brand 6 -->
        <div class="brand-card">
            <div class="brand-image">
                <img src="${pageContext.request.contextPath}/images/kawai-logo.png" alt="Kawai">
            </div>
            <div class="brand-content">
                <span class="brand-specialty">Pianos</span>
                <h3 class="brand-title">Kawai</h3>
                <p class="brand-description">Japanese piano manufacturer known for exceptional craftsmanship and rich tonal quality.</p>
                <div class="brand-stats">
                    <span><i class="fas fa-piano"></i> 23 Products</span>
                    <span><i class="fas fa-star"></i> 4.9 Rating</span>
                </div>
            </div>
        </div>

        <!-- Brand 7 -->
        <div class="brand-card">
            <div class="brand-image">
                <img src="${pageContext.request.contextPath}/images/selmer-logo.png" alt="Selmer">
            </div>
            <div class="brand-content">
                <span class="brand-specialty">Woodwinds</span>
                <h3 class="brand-title">Selmer</h3>
                <p class="brand-description">French manufacturer of professional-grade saxophones and clarinets since 1885.</p>
                <div class="brand-stats">
                    <span><i class="fas fa-saxophone"></i> 18 Products</span>
                    <span><i class="fas fa-star"></i> 4.8 Rating</span>
                </div>
            </div>
        </div>

        <!-- Brand 8 -->
        <div class="brand-card">
            <div class="brand-image">
                <img src="${pageContext.request.contextPath}/images/shure-logo.png" alt="Shure">
            </div>
            <div class="brand-content">
                <span class="brand-specialty">Audio</span>
                <h3 class="brand-title">Shure</h3>
                <p class="brand-description">American audio equipment manufacturer famous for microphones and monitoring systems.</p>
                <div class="brand-stats">
                    <span><i class="fas fa-microphone"></i> 42 Products</span>
                    <span><i class="fas fa-star"></i> 4.7 Rating</span>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="featured-brands">
    <h2 class="section-title">All Brands</h2>
    <div class="featured-brands-grid">
        <div class="featured-brand-card" onclick="filterByBrand('fender')">
            <i class="fab fa-spotify featured-brand-logo"></i>
            <span class="featured-brand-name">Fender</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('yamaha')">
            <i class="fab fa-itunes-note featured-brand-logo"></i>
            <span class="featured-brand-name">Yamaha</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('gibson')">
            <i class="fas fa-guitar featured-brand-logo"></i>
            <span class="featured-brand-name">Gibson</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('roland')">
            <i class="fas fa-keyboard featured-brand-logo"></i>
            <span class="featured-brand-name">Roland</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('pearl')">
            <i class="fas fa-drum featured-brand-logo"></i>
            <span class="featured-brand-name">Pearl</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('kawai')">
            <i class="fas fa-piano featured-brand-logo"></i>
            <span class="featured-brand-name">Kawai</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('selmer')">
            <i class="fas fa-saxophone featured-brand-logo"></i>
            <span class="featured-brand-name">Selmer</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('shure')">
            <i class="fas fa-microphone featured-brand-logo"></i>
            <span class="featured-brand-name">Shure</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('martin')">
            <i class="fas fa-guitar featured-brand-logo"></i>
            <span class="featured-brand-name">Martin</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('taylor')">
            <i class="fas fa-guitar featured-brand-logo"></i>
            <span class="featured-brand-name">Taylor</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('steinway')">
            <i class="fas fa-piano featured-brand-logo"></i>
            <span class="featured-brand-name">Steinway</span>
        </div>
        <div class="featured-brand-card" onclick="filterByBrand('zildjian')">
            <i class="fas fa-drum featured-brand-logo"></i>
            <span class="featured-brand-name">Zildjian</span>
        </div>
    </div>
</section>

<section class="brand-categories">
    <h2 class="section-title">Browse by Instrument Type</h2>
    <div class="categories-grid">
        <div class="category-item" onclick="filterByCategory('guitars')">
            <i class="fas fa-guitar category-icon"></i>
            <h3 class="category-title">Guitar Brands</h3>
            <div class="category-count">12 Brands</div>
        </div>
        <div class="category-item" onclick="filterByCategory('pianos')">
            <i class="fas fa-piano category-icon"></i>
            <h3 class="category-title">Piano Brands</h3>
            <div class="category-count">8 Brands</div>
        </div>
        <div class="category-item" onclick="filterByCategory('drums')">
            <i class="fas fa-drum category-icon"></i>
            <h3 class="category-title">Drum Brands</h3>
            <div class="category-count">9 Brands</div>
        </div>
        <div class="category-item" onclick="filterByCategory('woodwind')">
            <i class="fas fa-saxophone category-icon"></i>
            <h3 class="category-title">Woodwind Brands</h3>
            <div class="category-count">7 Brands</div>
        </div>
        <div class="category-item" onclick="filterByCategory('brass')">
            <i class="fas fa-trumpet category-icon"></i>
            <h3 class="category-title">Brass Brands</h3>
            <div class="category-count">6 Brands</div>
        </div>
        <div class="category-item" onclick="filterByCategory('audio')">
            <i class="fas fa-microphone category-icon"></i>
            <h3 class="category-title">Audio Brands</h3>
            <div class="category-count">15 Brands</div>
        </div>
    </div>
</section>

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
                <h3>Brands</h3>
                <ul class="footer-links">
                    <li><a href="#">Fender</a></li>
                    <li><a href="#">Yamaha</a></li>
                    <li><a href="#">Gibson</a></li>
                    <li><a href="#">Roland</a></li>
                    <li><a href="#">All Brands</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Support</h3>
                <ul class="footer-links">
                    <li><a href="contact.jsp">Contact Us</a></li>
                    <li><a href="#">Shipping & Returns</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Warranty</a></li>
                    <li><a href="#">Repair Services</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Newsletter</h3>
                <p>Subscribe to get updates on new brands, products, and exclusive offers.</p>
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

    // Filter functions
    function filterByBrand(brand) {
        alert(`Filtering by ${brand.charAt(0).toUpperCase() + brand.slice(1)} brand!`);
        // In real implementation, this would filter the products
        // window.location.href = `instruments.jsp?brand=${brand}`;
    }

    function filterByCategory(category) {
        alert(`Filtering by ${category.charAt(0).toUpperCase() + category.slice(1)} category!`);
        // In real implementation, this would filter the brands
        // window.location.href = `brands.jsp?category=${category}`;
    }

    // Intersection Observer for animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.brand-card, .featured-brand-card, .category-item').forEach((el) => {
        observer.observe(el);
    });

    // Add click functionality to brand cards
    document.querySelectorAll('.brand-card').forEach(card => {
        card.addEventListener('click', function() {
            const brand = this.querySelector('.brand-title').textContent;
            alert(`Viewing ${brand} products!`);
            // In real implementation, this would redirect to the brand page
            // window.location.href = `instruments.jsp?brand=${encodeURIComponent(brand)}`;
        });
    });
</script>
</body>
</html>