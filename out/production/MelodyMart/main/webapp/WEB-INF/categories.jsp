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
            background: rgba(10, 10, 10, 0.95);
            backdrop-filter: blur(10px);
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

        /* Categories Section */
        .categories-section {
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

        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .category-card {
            background: var(--card-bg);
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.5s ease;
            position: relative;
            opacity: 0;
            transform: translateY(50px);
            border: 1px solid var(--glass-border);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }

        .category-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .category-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(138, 43, 226, 0.2);
        }

        .category-image {
            height: 200px;
            width: 100%;
            overflow: hidden;
            background: #000;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .category-image i {
            font-size: 80px;
            color: var(--primary-light);
            opacity: 0.7;
            transition: all 0.3s ease;
        }

        .category-card:hover .category-image i {
            color: var(--accent);
            transform: scale(1.1);
        }

        .category-content {
            padding: 1.5rem;
            text-align: center;
        }

        .category-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--primary-light);
            transition: color 0.3s ease;
        }

        .category-card:hover .category-icon {
            color: var(--accent);
        }

        .category-title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--text);
        }

        .category-description {
            color: var(--text-secondary);
            margin-bottom: 1rem;
            line-height: 1.5;
        }

        .category-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 1rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .category-stats span {
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        /* Popular Brands Section */
        .brands-section {
            padding: 2rem 5% 5rem;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            margin: 2rem 5%;
        }

        .brands-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .brand-card {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
            cursor: pointer;
        }

        .brand-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .brand-logo {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--primary-light);
            transition: color 0.3s ease;
        }

        .brand-card:hover .brand-logo {
            color: var(--accent);
        }

        .brand-name {
            font-weight: 600;
            color: var(--text);
            text-align: center;
        }

        /* Why Shop Categories Section */
        .why-categories {
            padding: 2rem 5% 5rem;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
        }

        .feature-item {
            text-align: center;
            padding: 2rem;
            border-radius: 10px;
            background: var(--card-bg);
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
        }

        .feature-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-light);
            margin-bottom: 1rem;
        }

        .feature-title {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: var(--text);
        }

        .feature-desc {
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

        .category-card, .brand-card, .feature-item {
            animation: fadeIn 0.5s ease-out;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .categories-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 992px) {
            .nav-links {
                display: none;
            }

            .brands-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2.5rem;
            }

            .category-card {
                max-width: 100%;
            }

            .features-grid {
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

            .category-title {
                font-size: 1.3rem;
            }

            .brands-grid {
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
            <li><a href="categories.jsp" class="active">Categories</a></li>
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
    <h1 class="page-title">Instrument Categories</h1>
    <p class="page-subtitle">Explore our wide range of musical instruments organized by category. Find the perfect instrument for your musical journey.</p>
</section>

<section class="categories-section">
    <h2 class="section-title">Browse by Category</h2>
    <div class="categories-grid">
        <!-- Category 1 -->
        <div class="category-card" onclick="filterByCategory('guitars')">
            <div class="category-image">
                <i class="fas fa-guitar"></i>
            </div>
            <div class="category-content">
                <i class="fas fa-guitar category-icon"></i>
                <h3 class="category-title">Guitars</h3>
                <p class="category-description">From acoustic to electric, find the perfect guitar for your style and skill level.</p>
                <div class="category-stats">
                    <span><i class="fas fa-guitar"></i> 245 Products</span>
                    <span><i class="fas fa-star"></i> 4.8 Rating</span>
                </div>
            </div>
        </div>

        <!-- Category 2 -->
        <div class="category-card" onclick="filterByCategory('pianos')">
            <div class="category-image">
                <i class="fas fa-piano"></i>
            </div>
            <div class="category-content">
                <i class="fas fa-piano category-icon"></i>
                <h3 class="category-title">Pianos & Keyboards</h3>
                <p class="category-description">Grand pianos, digital keyboards, and synthesizers for all levels of musicians.</p>
                <div class="category-stats">
                    <span><i class="fas fa-piano"></i> 128 Products</span>
                    <span><i class="fas fa-star"></i> 4.9 Rating</span>
                </div>
            </div>
        </div>

        <!-- Category 3 -->
        <div class="category-card" onclick="filterByCategory('drums')">
            <div class="category-image">
                <i class="fas fa-drum"></i>
            </div>
            <div class="category-content">
                <i class="fas fa-drum category-icon"></i>
                <h3 class="category-title">Drums & Percussion</h3>
                <p class="category-description">Complete drum kits, cymbals, and percussion instruments for rhythm makers.</p>
                <div class="category-stats">
                    <span><i class="fas fa-drum"></i> 187 Products</span>
                    <span><i class="fas fa-star"></i> 4.7 Rating</span>
                </div>
            </div>
        </div>

        <!-- Category 4 -->
        <div class="category-card" onclick="filterByCategory('strings')">
            <div class="category-image">
                <i class="fas fa-violin"></i>
            </div>
            <div class="category-content">
                <i class="fas fa-violin category-icon"></i>
                <h3 class="category-title">String Instruments</h3>
                <p class="category-description">Violins, cellos, violas, and double basses for classical and contemporary music.</p>
                <div class="category-stats">
                    <span><i class="fas fa-violin"></i> 94 Products</span>
                    <span><i class="fas fa-star"></i> 4.8 Rating</span>
                </div>
            </div>
        </div>

        <!-- Category 5 -->
        <div class="category-card" onclick="filterByCategory('brass')">
            <div class="category-image">
                <i class="fas fa-trumpet"></i>
            </div>
            <div class="category-content">
                <i class="fas fa-trumpet category-icon"></i>
                <h3 class="category-title">Brass Instruments</h3>
                <p class="category-description">Trumpets, trombones, French horns, and tubas for powerful brass sections.</p>
                <div class="category-stats">
                    <span><i class="fas fa-trumpet"></i> 76 Products</span>
                    <span><i class="fas fa-star"></i> 4.6 Rating</span>
                </div>
            </div>
        </div>

        <!-- Category 6 -->
        <div class="category-card" onclick="filterByCategory('woodwind')">
            <div class="category-image">
                <i class="fas fa-flute"></i>
            </div>
            <div class="category-content">
                <i class="fas fa-flute category-icon"></i>
                <h3 class="category-title">Woodwind Instruments</h3>
                <p class="category-description">Flutes, clarinets, saxophones, and oboes for melodic woodwind expression.</p>
                <div class="category-stats">
                    <span><i class="fas fa-flute"></i> 112 Products</span>
                    <span><i class="fas fa-star"></i> 4.7 Rating</span>
                </div>
            </div>
        </div>

        <!-- Category 7 -->
        <div class="category-card" onclick="filterByCategory('recording')">
            <div class="category-image">
                <i class="fas fa-microphone"></i>
            </div>
            <div class="category-content">
                <i class="fas fa-microphone category-icon"></i>
                <h3 class="category-title">Recording Equipment</h3>
                <p class="category-description">Microphones, audio interfaces, and studio monitors for professional recording.</p>
                <div class="category-stats">
                    <span><i class="fas fa-microphone"></i> 203 Products</span>
                    <span><i class="fas fa-star"></i> 4.8 Rating</span>
                </div>
            </div>
        </div>

        <!-- Category 8 -->
        <div class="category-card" onclick="filterByCategory('accessories')">
            <div class="category-image">
                <i class="fas fa-music"></i>
            </div>
            <div class="category-content">
                <i class="fas fa-music category-icon"></i>
                <h3 class="category-title">Accessories</h3>
                <p class="category-description">Strings, picks, stands, cases, and everything else you need for your instrument.</p>
                <div class="category-stats">
                    <span><i class="fas fa-music"></i> 315 Products</span>
                    <span><i class="fas fa-star"></i> 4.5 Rating</span>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="brands-section">
    <h2 class="section-title">Popular Brands</h2>
    <div class="brands-grid">
        <div class="brand-card" onclick="filterByBrand('fender')">
            <i class="fab fa-spotify brand-logo"></i>
            <span class="brand-name">Fender</span>
        </div>
        <div class="brand-card" onclick="filterByBrand('yamaha')">
            <i class="fab fa-itunes-note brand-logo"></i>
            <span class="brand-name">Yamaha</span>
        </div>
        <div class="brand-card" onclick="filterByBrand('gibson')">
            <i class="fas fa-guitar brand-logo"></i>
            <span class="brand-name">Gibson</span>
        </div>
        <div class="brand-card" onclick="filterByBrand('roland')">
            <i class="fas fa-keyboard brand-logo"></i>
            <span class="brand-name">Roland</span>
        </div>
        <div class="brand-card" onclick="filterByBrand('pearl')">
            <i class="fas fa-drum brand-logo"></i>
            <span class="brand-name">Pearl</span>
        </div>
        <div class="brand-card" onclick="filterByBrand('kawai')">
            <i class="fas fa-piano brand-logo"></i>
            <span class="brand-name">Kawai</span>
        </div>
        <div class="brand-card" onclick="filterByBrand('selmer')">
            <i class="fas fa-saxophone brand-logo"></i>
            <span class="brand-name">Selmer</span>
        </div>
        <div class="brand-card" onclick="filterByBrand('shure')">
            <i class="fas fa-microphone brand-logo"></i>
            <span class="brand-name">Shure</span>
        </div>
    </div>
</section>

<section class="why-categories">
    <h2 class="section-title">Why Shop by Category?</h2>
    <div class="features-grid">
        <div class="feature-item">
            <i class="fas fa-search feature-icon"></i>
            <h3 class="feature-title">Easy Navigation</h3>
            <p class="feature-desc">Quickly find exactly what you're looking for with our organized categories.</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-star feature-icon"></i>
            <h3 class="feature-title">Expert Curation</h3>
            <p class="feature-desc">Each category is carefully curated by our team of music experts.</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-compare feature-icon"></i>
            <h3 class="feature-title">Easy Comparison</h3>
            <p class="feature-desc">Compare similar products within the same category to make the best choice.</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-tags feature-icon"></i>
            <h3 class="feature-title">Category Deals</h3>
            <p class="feature-desc">Find special offers and discounts specific to each instrument category.</p>
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
                <h3>Categories</h3>
                <ul class="footer-links">
                    <li><a href="categories.jsp?filter=guitars">Guitars</a></li>
                    <li><a href="categories.jsp?filter=pianos">Pianos & Keyboards</a></li>
                    <li><a href="categories.jsp?filter=drums">Drums & Percussion</a></li>
                    <li><a href="categories.jsp?filter=strings">String Instruments</a></li>
                    <li><a href="categories.jsp?filter=brass">Brass & Woodwind</a></li>
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
                <p>Subscribe to get updates on new categories, products, and exclusive offers.</p>
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
    function filterByCategory(category) {
        // In real implementation, this would filter the products
        // For now, redirect to instruments with category filter
        window.location.href = `instruments.jsp?category=${category}`;
    }

    function filterByBrand(brand) {
        // In real implementation, this would filter the products
        // For now, redirect to instruments with brand filter
        window.location.href = `instruments.jsp?brand=${brand}`;
    }

    // Intersection Observer for animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.category-card, .brand-card, .feature-item').forEach((el) => {
        observer.observe(el);
    });

    // Handle URL parameters for filtering
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        const regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        const results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    // Check for filter parameter on page load
    document.addEventListener('DOMContentLoaded', function() {
        const filter = getUrlParameter('filter');
        if (filter) {
            // Highlight the filtered category
            const categoryCards = document.querySelectorAll('.category-card');
            categoryCards.forEach(card => {
                const category = card.querySelector('.category-title').textContent.toLowerCase().replace(' & ', '-').replace(' ', '-');
                if (category === filter) {
                    card.style.border = '2px solid var(--accent)';
                    card.style.transform = 'scale(1.02)';
                }
            });
        }
    });
</script>
</body>
</html>