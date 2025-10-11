<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Instrument Categories</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1e88e5;
            --primary-light: #64b5f6;
            --primary-soft: #e3f2fd;
            --secondary: #f8fdff;
            --accent: #00acc1;
            --accent-alt: #ff7043;
            --text: #1565c0;
            --text-secondary: #546e7a;
            --text-soft: #78909c;
            --card-bg: #e8f5fe;
            --card-hover: #d0e9ff;
            --gradient: linear-gradient(135deg, #4fc3f7, #29b6f6, #03a9f4);
            --gradient-alt: linear-gradient(135deg, #00acc1, #1e88e5);
            --gradient-soft: linear-gradient(135deg, #e1f5fe, #b3e5fc);
            --glass-bg: rgba(255, 255, 255, 0.85);
            --glass-border: rgba(179, 229, 252, 0.5);
            --shadow: 0 5px 20px rgba(33, 150, 243, 0.15);
            --shadow-hover: 0 10px 30px rgba(33, 150, 243, 0.25);
            --header-bg: rgba(255, 255, 255, 0.95);
            --section-bg: #e1f5fe;
            --border-radius: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.4s ease, color 0.4s ease, border-color 0.4s ease, box-shadow 0.4s ease;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: var(--gradient-soft);
            color: var(--text);
            overflow-x: hidden;
            line-height: 1.6;
            min-height: 100vh;
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
            backdrop-filter: blur(10px);
            background-color: var(--header-bg);
            box-shadow: var(--shadow);
        }

        header.scrolled {
            padding: 15px 0;
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
            padding: 8px 0;
        }

        .nav-links a.active {
            color: var(--primary-light);
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            bottom: 0;
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

        .nav-actions button {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            cursor: pointer;
            transition: color 0.3s ease;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .nav-actions button:hover {
            color: var(--primary-light);
            background: var(--primary-soft);
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
            box-shadow: var(--shadow);
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
            box-shadow: var(--shadow-hover);
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
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .user-btn:hover {
            color: var(--primary-light);
            background: var(--primary-soft);
        }

        .dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            width: 180px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(10px);
            transition: opacity 0.3s ease, transform 0.3s ease, visibility 0.3s;
            z-index: 1000;
            box-shadow: var(--shadow-hover);
            padding: 10px 0;
        }

        .user-menu:hover .dropdown {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-item {
            display: block;
            padding: 12px 20px;
            color: var(--text);
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s ease, color 0.3s ease;
            cursor: pointer;
        }

        .dropdown-item:hover {
            background: var(--primary-soft);
            color: var(--primary);
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
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease 0.5s forwards;
        }

        .page-subtitle {
            font-size: 1.2rem;
            color: var(--text-secondary);
            max-width: 700px;
            margin: 0 auto 2rem;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease 0.8s forwards;
        }

        /* Section Title */
        .section-title {
            text-align: center;
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            margin: 100px 0 60px;
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
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--gradient);
            border-radius: 2px;
        }

        /* Categories Grid */
        .categories-section {
            padding: 2rem 5% 5rem;
        }

        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 80px;
        }

        .category-card {
            height: 280px;
            border-radius: var(--border-radius);
            background: var(--glass-bg);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: all 0.4s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            opacity: 0;
            transform: translateY(50px);
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            padding: 20px;
        }

        .category-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .category-card:hover {
            background: var(--card-hover);
            transform: scale(1.05);
            box-shadow: var(--shadow-hover);
        }

        .category-icon {
            font-size: 50px;
            margin-bottom: 20px;
            color: var(--primary);
            transition: transform 0.3s ease;
        }

        .category-card:hover .category-icon {
            transform: scale(1.2);
            color: var(--accent);
        }

        .category-title {
            font-weight: 600;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .category-description {
            color: var(--text-secondary);
            font-size: 15px;
            margin-bottom: 20px;
            line-height: 1.6;
            text-align: center;
            padding: 0 15px;
        }

        .category-stats {
            display: flex;
            justify-content: space-between;
            color: var(--text-secondary);
            font-size: 0.9rem;
            width: 100%;
            padding: 0 20px;
            margin-top: 15px;
        }

        /* Brands Section */
        .brands-section {
            padding: 2rem 5% 5rem;
            background: var(--glass-bg);
            margin: 2rem 5%;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
        }

        .brands-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .brand-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s ease;
            box-shadow: var(--shadow);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .brand-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .brand-logo {
            font-size: 2.5rem;
            color: var(--primary-light);
            margin-bottom: 1rem;
        }

        /* Features */
        .why-categories {
            padding: 2rem 5% 5rem;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
        }

        .feature-item {
            text-align: center;
            padding: 30px 20px;
            border-radius: var(--border-radius);
            background: var(--glass-bg);
            transition: all 0.3s ease;
            opacity: 0;
            transform: translateY(30px);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
        }

        .feature-item.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .feature-item:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .feature-icon {
            font-size: 50px;
            color: var(--primary);
            margin-bottom: 20px;
            transition: color 0.3s ease;
        }

        .feature-item:hover .feature-icon {
            color: var(--accent);
        }

        .feature-title {
            font-size: 20px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .feature-desc {
            color: var(--text-secondary);
            font-size: 15px;
            line-height: 1.6;
        }

        /* Footer */
        footer {
            background: var(--glass-bg);
            padding: 100px 0 40px;
            border-top: 1px solid var(--glass-border);
            margin-top: 60px;
            backdrop-filter: blur(10px);
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 60px;
        }

        .footer-column h3 {
            font-size: 20px;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 10px;
            color: var(--primary);
        }

        .footer-column h3:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: var(--gradient);
            border-radius: 2px;
        }

        .footer-column p {
            color: var(--text-secondary);
            margin-bottom: 25px;
            line-height: 1.7;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 15px;
        }

        .footer-links a {
            color: var(--text-secondary);
            text-decoration: none;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
        }

        .footer-links a:before {
            content: '▸';
            margin-right: 10px;
            color: var(--primary-soft);
            transition: all 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--primary);
        }

        .footer-links a:hover:before {
            color: var(--primary);
            transform: translateX(5px);
        }

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: var(--card-bg);
            color: var(--text);
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
        }

        .social-links a:hover {
            background: var(--gradient);
            color: white;
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .copyright {
            text-align: center;
            padding-top: 40px;
            border-top: 1px solid var(--glass-border);
            color: var(--text-secondary);
            font-size: 15px;
        }

        /* Animations */
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(10deg);
            }
        }

        @keyframes bounceIn {
            0% { opacity: 0; transform: scale(0.3); }
            50% { opacity: 1; transform: scale(1.05); }
            70% { transform: scale(0.9); }
            100% { transform: scale(1); }
        }

        .rotate-in {
            animation: rotateIn 1s ease-out forwards;
        }

        .bounce-in {
            animation: bounceIn 1s ease-out forwards;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .page-title {
                font-size: 3rem;
            }
        }

        @media (max-width: 992px) {
            .page-title {
                font-size: 2.5rem;
            }

            .section-title {
                font-size: 36px;
            }

            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .page-title {
                font-size: 2rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }

            .section-title {
                font-size: 32px;
                margin: 80px 0 40px;
            }

            .user-menu:hover .dropdown {
                display: none;
            }

            .user-btn {
                font-size: 16px;
            }

            .dropdown {
                width: 150px;
                right: -10px;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .categories-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 1.8rem;
            }

            .page-subtitle {
                font-size: 0.9rem;
            }

            .cta-btn {
                padding: 10px 20px;
                font-size: 14px;
            }

            .section-title {
                font-size: 28px;
            }

            .footer-content {
                grid-template-columns: 1fr;
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
            <li><a href="categories.jsp" class="active">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="deals.jsp">Deals</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>

        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <button class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></button>
            <!-- Theme toggle button removed as requested -->
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i></button>
                <div class="dropdown">
                    <a href="sign-in.jsp" class="dropdown-item">Sign In</a>
                    <a href="sign-up.jsp" class="dropdown-item">Sign Up</a>
                </div>
            </div>
            <button class="cta-btn" onclick="window.location.href='shop.jsp'">Shop Now</button>
        </div>
    </div>
</header>

<!-- Page Header -->
<section class="page-header">
    <h1 class="page-title">Instrument Categories</h1>
    <p class="page-subtitle">Explore our wide range of musical instruments organized by category</p>
</section>

<!-- Categories Grid -->
<section class="categories-section">
    <h2 class="section-title">Browse Categories</h2>
    <div class="categories-grid">
        <div class="category-card">
            <i class="fas fa-guitar category-icon"></i>
            <h3 class="category-title">Guitars</h3>
            <p class="category-description">Acoustic, electric, and bass guitars for every skill level</p>
            <div class="category-stats">
                <span>245 Products</span>
                <span>4.8 ★</span>
            </div>
        </div>

        <div class="category-card">
            <i class="fas fa-piano category-icon"></i>
            <h3 class="category-title">Pianos & Keyboards</h3>
            <p class="category-description">Grand pianos, digital keyboards, and synthesizers</p>
            <div class="category-stats">
                <span>128 Products</span>
                <span>4.9 ★</span>
            </div>
        </div>

        <div class="category-card">
            <i class="fas fa-drum category-icon"></i>
            <h3 class="category-title">Drums & Percussion</h3>
            <p class="category-description">Complete drum kits and percussion instruments</p>
            <div class="category-stats">
                <span>187 Products</span>
                <span>4.7 ★</span>
            </div>
        </div>

        <div class="category-card">
            <i class="fas fa-violin category-icon"></i>
            <h3 class="category-title">String Instruments</h3>
            <p class="category-description">Violins, cellos, violas, and double basses</p>
            <div class="category-stats">
                <span>94 Products</span>
                <span>4.8 ★</span>
            </div>
        </div>

        <div class="category-card">
            <i class="fas fa-trumpet category-icon"></i>
            <h3 class="category-title">Brass Instruments</h3>
            <p class="category-description">Trumpets, trombones, and brass sections</p>
            <div class="category-stats">
                <span>76 Products</span>
                <span>4.6 ★</span>
            </div>
        </div>

        <div class="category-card">
            <i class="fas fa-flute category-icon"></i>
            <h3 class="category-title">Woodwind Instruments</h3>
            <p class="category-description">Flutes, clarinets, saxophones, and oboes</p>
            <div class="category-stats">
                <span>112 Products</span>
                <span>4.7 ★</span>
            </div>
        </div>

        <div class="category-card">
            <i class="fas fa-microphone category-icon"></i>
            <h3 class="category-title">Recording Equipment</h3>
            <p class="category-description">Studio gear and professional audio equipment</p>
            <div class="category-stats">
                <span>203 Products</span>
                <span>4.8 ★</span>
            </div>
        </div>

        <div class="category-card">
            <i class="fas fa-music category-icon"></i>
            <h3 class="category-title">Accessories</h3>
            <p class="category-description">Everything you need for your instrument</p>
            <div class="category-stats">
                <span>315 Products</span>
                <span>4.5 ★</span>
            </div>
        </div>
    </div>
</section>

<!-- Brands Section -->
<section class="brands-section">
    <h2 class="section-title">Popular Brands</h2>
    <div class="brands-grid">
        <div class="brand-card">
            <i class="fab fa-spotify brand-logo"></i>
            <span>Fender</span>
        </div>
        <div class="brand-card">
            <i class="fab fa-itunes-note brand-logo"></i>
            <span>Yamaha</span>
        </div>
        <div class="brand-card">
            <i class="fas fa-guitar brand-logo"></i>
            <span>Gibson</span>
        </div>
        <div class="brand-card">
            <i class="fas fa-keyboard brand-logo"></i>
            <span>Roland</span>
        </div>
        <div class="brand-card">
            <i class="fas fa-drum brand-logo"></i>
            <span>Pearl</span>
        </div>
        <div class="brand-card">
            <i class="fas fa-piano brand-logo"></i>
            <span>Kawai</span>
        </div>
    </div>
</section>

<!-- Features -->
<section class="why-categories">
    <h2 class="section-title">Why Shop by Category?</h2>
    <div class="features-grid">
        <div class="feature-item">
            <i class="fas fa-search feature-icon"></i>
            <h3 class="feature-title">Easy Navigation</h3>
            <p class="feature-desc">Quickly find what you're looking for</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-star feature-icon"></i>
            <h3 class="feature-title">Expert Curation</h3>
            <p class="feature-desc">Carefully selected by music experts</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-compare feature-icon"></i>
            <h3 class="feature-title">Easy Comparison</h3>
            <p class="feature-desc">Compare similar products easily</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-tags feature-icon"></i>
            <h3 class="feature-title">Category Deals</h3>
            <p class="feature-desc">Special offers for each category</p>
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
                <h3>Company</h3>
                <ul class="footer-links">
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Shipping & Returns</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Newsletter</h3>
                <p>Subscribe to our newsletter for the latest products and exclusive offers.</p>
                <form>
                    <input type="email" placeholder="Your Email" style="width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 10px; border: 1px solid var(--glass-border); background: var(--card-bg); color: var(--text);">
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

    // Intersection Observer for animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                if (entry.target.classList.contains('feature-item')) {
                    entry.target.classList.add('bounce-in');
                } else if (entry.target.classList.contains('category-card')) {
                    entry.target.classList.add('rotate-in');
                }
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.section-title, .category-card, .feature-item').forEach((el) => {
        observer.observe(el);
    });

    // Simple script to handle category clicks
    document.addEventListener('DOMContentLoaded', function() {
        const categoryCards = document.querySelectorAll('.category-card');

        categoryCards.forEach(card => {
            card.addEventListener('click', function() {
                const categoryName = this.querySelector('.category-title').textContent;
                alert('Navigating to ' + categoryName + ' category');
                // In real implementation: window.location.href = 'instruments.jsp?category=' + categoryName;
            });
        });
    });
</script>
</body>
</html>