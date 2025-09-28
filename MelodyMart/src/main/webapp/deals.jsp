<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Special Deals</title>
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
            --sale-red: #ff4757;
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
            background: linear-gradient(to right, rgba(138, 43, 226, 0.2), rgba(0, 229, 255, 0.2));
            border-radius: 0 0 20px 20px;
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

        .countdown {
            background: var(--card-bg);
            display: inline-block;
            padding: 1rem 2rem;
            border-radius: 50px;
            margin-top: 1rem;
            border: 1px solid var(--glass-border);
        }

        .countdown-text {
            color: var(--accent);
            margin-right: 1rem;
            font-weight: 600;
        }

        .countdown-timer {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-light);
        }

        /* Deals Section */
        .deals-section {
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

        .deals-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .deal-card {
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

        .deal-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .deal-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(138, 43, 226, 0.2);
        }

        .deal-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: var(--sale-red);
            color: var(--text);
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 700;
            z-index: 2;
        }

        .deal-badge.hot {
            background: var(--gradient);
        }

        .deal-badge.new {
            background: var(--accent);
            color: var(--secondary);
        }

        .deal-image {
            height: 200px;
            width: 100%;
            overflow: hidden;
            background: #000;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .deal-image i {
            font-size: 80px;
            color: var(--primary-light);
            opacity: 0.7;
            transition: color 0.3s ease;
        }

        .deal-card:hover .deal-image i {
            color: var(--accent);
            transform: scale(1.1);
        }

        .deal-content {
            padding: 1.5rem;
        }

        .deal-title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--text);
        }

        .deal-description {
            color: var(--text-secondary);
            margin-bottom: 1rem;
            line-height: 1.5;
        }

        .deal-pricing {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .deal-price {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-light);
        }

        .original-price {
            font-size: 1.2rem;
            text-decoration: line-through;
            color: var(--text-secondary);
            margin-left: 1rem;
        }

        .discount {
            background: var(--sale-red);
            color: var(--text);
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-left: auto;
        }

        .deal-actions {
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
        }

        .add-to-cart:hover {
            background: var(--gradient-alt);
            transform: scale(1.05);
        }

        .details-btn {
            background: transparent;
            color: var(--text);
            border: 1px solid var(--glass-border);
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            flex: 1;
            margin-left: 0.5rem;
        }

        .details-btn:hover {
            background: var(--primary);
            border-color: var(--primary);
            transform: scale(1.05);
        }

        /* Featured Deal */
        .featured-deal {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            overflow: hidden;
            margin: 4rem 5%;
            display: flex;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
        }

        .featured-image {
            flex: 1;
            min-height: 300px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #000;
        }

        .featured-image i {
            font-size: 120px;
            color: var(--primary-light);
            opacity: 0.7;
        }

        .featured-content {
            flex: 1;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .featured-badge {
            background: var(--gradient);
            color: var(--text);
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 700;
            display: inline-block;
            margin-bottom: 1rem;
        }

        .featured-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            margin-bottom: 1rem;
            color: var(--text);
        }

        .featured-description {
            color: var(--text-secondary);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .featured-pricing {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
        }

        .featured-price {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-light);
        }

        .featured-original {
            font-size: 1.5rem;
            text-decoration: line-through;
            color: var(--text-secondary);
            margin-left: 1rem;
        }

        .featured-discount {
            background: var(--sale-red);
            color: var(--text);
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            margin-left: auto;
        }

        /* Newsletter Section */
        .newsletter-section {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            padding: 4rem 5%;
            text-align: center;
            border-radius: 15px;
            margin: 4rem 5%;
        }

        .newsletter-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            margin-bottom: 1rem;
            color: var(--text);
        }

        .newsletter-text {
            color: var(--text-secondary);
            max-width: 600px;
            margin: 0 auto 2rem;
        }

        .newsletter-form {
            display: flex;
            max-width: 500px;
            margin: 0 auto;
        }

        .newsletter-input {
            flex: 1;
            background: var(--secondary);
            border: 1px solid var(--glass-border);
            padding: 1rem 1.5rem;
            border-radius: 50px 0 0 50px;
            color: var(--text);
            outline: none;
        }

        .newsletter-btn {
            background: var(--gradient);
            color: var(--text);
            border: none;
            padding: 1rem 1.5rem;
            border-radius: 0 50px 50px 0;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .newsletter-btn:hover {
            background: var(--gradient-alt);
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

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        .deal-card {
            animation: fadeIn 0.5s ease-out;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .deals-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 992px) {
            .nav-links {
                display: none;
            }

            .featured-deal {
                flex-direction: column;
            }

            .featured-image {
                min-height: 250px;
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2.5rem;
            }

            .deal-card {
                max-width: 100%;
            }

            .deal-actions {
                flex-direction: column;
                gap: 0.5rem;
            }

            .add-to-cart, .details-btn {
                margin: 0;
                width: 100%;
            }

            .newsletter-form {
                flex-direction: column;
            }

            .newsletter-input {
                border-radius: 50px;
                margin-bottom: 1rem;
            }

            .newsletter-btn {
                border-radius: 50px;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 2rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }

            .deal-title {
                font-size: 1.3rem;
            }

            .deal-price {
                font-size: 1.5rem;
            }

            .featured-title {
                font-size: 1.8rem;
            }

            .featured-price {
                font-size: 2rem;
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
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="deals.jsp" class="active">Deals</a></li>
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
    <h1 class="page-title">Special Offers & Deals</h1>
    <p class="page-subtitle">Limited time offers on premium musical instruments. Don't miss out on these incredible deals!</p>
    <div class="countdown">
        <span class="countdown-text">Sale ends in:</span>
        <span class="countdown-timer" id="countdown">72:00:00</span>
    </div>
</section>

<section class="deals-section">
    <h2 class="section-title">Hot Deals</h2>
    <div class="deals-grid">
        <!-- Deal 1 -->
        <div class="deal-card">
            <div class="deal-badge hot">HOT DEAL</div>
            <div class="deal-image">
                <i class="fas fa-guitar"></i>
            </div>
            <div class="deal-content">
                <h3 class="deal-title">Fender Stratocaster</h3>
                <p class="deal-description">The iconic electric guitar with versatile tone and comfortable playability.</p>
                <div class="deal-pricing">
                    <div class="deal-price">$1,299</div>
                    <div class="original-price">$1,499</div>
                    <div class="discount">15% OFF</div>
                </div>
                <div class="deal-actions">
                    <button class="add-to-cart">Add to Cart</button>
                    <button class="details-btn">Details</button>
                </div>
            </div>
        </div>

        <!-- Deal 2 -->
        <div class="deal-card">
            <div class="deal-badge">SALE</div>
            <div class="deal-image">
                <i class="fas fa-piano"></i>
            </div>
            <div class="deal-content">
                <h3 class="deal-title">Yamaha P-125</h3>
                <p class="deal-description">Digital piano with authentic acoustic piano sound and feel.</p>
                <div class="deal-pricing">
                    <div class="deal-price">$599</div>
                    <div class="original-price">$699</div>
                    <div class="discount">14% OFF</div>
                </div>
                <div class="deal-actions">
                    <button class="add-to-cart">Add to Cart</button>
                    <button class="details-btn">Details</button>
                </div>
            </div>
        </div>

        <!-- Deal 3 -->
        <div class="deal-card">
            <div class="deal-badge new">NEW</div>
            <div class="deal-image">
                <i class="fas fa-drum"></i>
            </div>
            <div class="deal-content">
                <h3 class="deal-title">Pearl Export Series</h3>
                <p class="deal-description">Professional drum kit with exceptional sound quality and durability.</p>
                <div class="deal-pricing">
                    <div class="deal-price">$899</div>
                    <div class="original-price">$1,099</div>
                    <div class="discount">18% OFF</div>
                </div>
                <div class="deal-actions">
                    <button class="add-to-cart">Add to Cart</button>
                    <button class="details-btn">Details</button>
                </div>
            </div>
        </div>

        <!-- Deal 4 -->
        <div class="deal-card">
            <div class="deal-badge">SALE</div>
            <div class="deal-image">
                <i class="fas fa-saxophone"></i>
            </div>
            <div class="deal-content">
                <h3 class="deal-title">Yamaha YAS-280</h3>
                <p class="deal-description">Alto saxophone with improved response and accurate intonation.</p>
                <div class="deal-pricing">
                    <div class="deal-price">$1,499</div>
                    <div class="original-price">$1,799</div>
                    <div class="discount">17% OFF</div>
                </div>
                <div class="deal-actions">
                    <button class="add-to-cart">Add to Cart</button>
                    <button class="details-btn">Details</button>
                </div>
            </div>
        </div>

        <!-- Deal 5 -->
        <div class="deal-card">
            <div class="deal-badge hot">HOT DEAL</div>
            <div class="deal-image">
                <i class="fas fa-violin"></i>
            </div>
            <div class="deal-content">
                <h3 class="deal-title">Stentor Student II</h3>
                <p class="deal-description">Perfect violin for students with rich tone and easy playability.</p>
                <div class="deal-pricing">
                    <div class="deal-price">$249</div>
                    <div class="original-price">$329</div>
                    <div class="discount">24% OFF</div>
                </div>
                <div class="deal-actions">
                    <button class="add-to-cart">Add to Cart</button>
                    <button class="details-btn">Details</button>
                </div>
            </div>
        </div>

        <!-- Deal 6 -->
        <div class="deal-card">
            <div class="deal-badge">SALE</div>
            <div class="deal-image">
                <i class="fas fa-volume-up"></i>
            </div>
            <div class="deal-content">
                <h3 class="deal-title">Fender Mustang GTX100</h3>
                <p class="deal-description">Powerful modeling amplifier with 200 presets and Bluetooth connectivity.</p>
                <div class="deal-pricing">
                    <div class="deal-price">$499</div>
                    <div class="original-price">$599</div>
                    <div class="discount">17% OFF</div>
                </div>
                <div class="deal-actions">
                    <button class="add-to-cart">Add to Cart</button>
                    <button class="details-btn">Details</button>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="featured-deal">
    <div class="featured-image">
        <i class="fas fa-piano"></i>
    </div>
    <div class="featured-content">
        <span class="featured-badge">FEATURED DEAL</span>
        <h2 class="featured-title">Yamaha C3X Grand Piano</h2>
        <p class="featured-description">Experience the rich, resonant sound of this expertly crafted grand piano, perfect for concert halls and home studios. Limited time offer with exclusive financing options.</p>
        <div class="featured-pricing">
            <div class="featured-price">$24,999</div>
            <div class="featured-original">$29,999</div>
            <div class="featured-discount">$5,000 OFF</div>
        </div>
        <div class="deal-actions">
            <button class="add-to-cart pulse">Add to Cart</button>
            <button class="details-btn">View Details</button>
        </div>
    </div>
</div>

<section class="newsletter-section">
    <h2 class="newsletter-title">Never Miss a Deal</h2>
    <p class="newsletter-text">Subscribe to our newsletter and be the first to know about exclusive offers, new arrivals, and special promotions.</p>
    <form class="newsletter-form">
        <input type="email" class="newsletter-input" placeholder="Your email address">
        <button type="submit" class="newsletter-btn">Subscribe</button>
    </form>
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
                <h3>Shop</h3>
                <ul class="footer-links">
                    <li><a href="instruments.jsp">Guitars</a></li>
                    <li><a href="instruments.jsp">Keyboards</a></li>
                    <li><a href="instruments.jsp">Drums</a></li>
                    <li><a href="instruments.jsp">Brass Instruments</a></li>
                    <li><a href="instruments.jsp">Woodwinds</a></li>
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
                <h3>About</h3>
                <ul class="footer-links">
                    <li><a href="#">Our Story</a></li>
                    <li><a href="#">Store Locations</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                </ul>
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

    // Countdown timer
    function updateCountdown() {
        const now = new Date();
        const saleEnd = new Date();
        saleEnd.setDate(now.getDate() + 3); // Sale ends in 3 days

        const timeRemaining = saleEnd - now;

        const hours = Math.floor(timeRemaining / (1000 * 60 * 60));
        const minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

        document.getElementById('countdown').textContent =
            `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    }

    setInterval(updateCountdown, 1000);
    updateCountdown();

    // Animation for deal cards
    const dealCards = document.querySelectorAll('.deal-card');
    dealCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });

    // Add to cart animation
    const addToCartBtns = document.querySelectorAll('.add-to-cart');
    addToCartBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const originalText = this.textContent;
            this.innerHTML = '<i class="fas fa-check"></i> Added to Cart';
            this.style.background = 'var(--accent-alt)';

            setTimeout(() => {
                this.textContent = originalText;
                this.style.background = '';
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

    document.querySelectorAll('.deal-card').forEach((el) => {
        observer.observe(el);
    });
</script>
</body>
</html>