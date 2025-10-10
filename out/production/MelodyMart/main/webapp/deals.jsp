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
            --primary: #1e40af;
            --primary-light: #3b82f6;
            --primary-soft: #dbeafe;
            --secondary: #ffffff;
            --accent: #06b6d4;
            --accent-alt: #ef4444;
            --text: #1e40af;
            --text-secondary: #475569;
            --text-soft: #64748b;
            --card-bg: #f8fafc;
            --card-hover: #ffffff;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
            --gradient-soft: linear-gradient(135deg, var(--primary-soft), #e0f2fe);
            --glass-bg: rgba(255, 255, 255, 0.9);
            --glass-border: rgba(255, 255, 255, 0.3);
            --shadow: 0 5px 20px rgba(30, 64, 175, 0.1);
            --shadow-hover: 0 10px 30px rgba(30, 64, 175, 0.2);
            --header-bg: rgba(255, 255, 255, 0.95);
            --section-bg: #f1f5f9;
            --border-radius: 16px;
            --sale-red: #ef4444;
        }

        [data-theme="dark"] {
            --primary: #3b82f6;
            --primary-light: #60a5fa;
            --primary-soft: #1e3a8a;
            --secondary: #1e40af;
            --accent: #22d3ee;
            --accent-alt: #f87171;
            --text: #f1f5f9;
            --text-secondary: #cbd5e1;
            --text-soft: #94a3b8;
            --card-bg: #1e293b;
            --card-hover: #334155;
            --glass-bg: rgba(30, 64, 175, 0.9);
            --glass-border: rgba(255, 255, 255, 0.1);
            --shadow: 0 5px 20px rgba(30, 64, 175, 0.3);
            --shadow-hover: 0 10px 30px rgba(30, 64, 175, 0.4);
            --header-bg: rgba(30, 64, 175, 0.95);
            --section-bg: #1e40af;
            --sale-red: #f87171;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.4s ease, color 0.4s ease, border-color 0.4s ease, box-shadow 0.4s ease;
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
            backdrop-filter: blur(10px);
        }

        header.scrolled {
            padding: 15px 0;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            background-color: var(--header-bg);
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
            box-shadow: 0 4px 15px rgba(30, 64, 175, 0.3);
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
            box-shadow: 0 10px 20px rgba(30, 64, 175, 0.4);
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
            background: var(--gradient-soft);
            border-radius: 0 0 var(--border-radius) var(--border-radius);
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

        .countdown {
            background: var(--card-bg);
            display: inline-block;
            padding: 1rem 2rem;
            border-radius: 50px;
            margin-top: 1rem;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
        }

        .countdown-text {
            color: var(--primary);
            margin-right: 1rem;
            font-weight: 600;
        }

        .countdown-timer {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-light);
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

        /* Deals Section */
        .deals-section {
            padding: 2rem 5% 5rem;
        }

        .deals-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
            margin-bottom: 80px;
        }

        .deal-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            transition: all 0.5s ease;
            position: relative;
            opacity: 0;
            transform: translateY(50px);
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
        }

        .deal-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .deal-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .deal-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: var(--sale-red);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 700;
            z-index: 2;
            box-shadow: var(--shadow);
        }

        .deal-badge.hot {
            background: var(--gradient);
        }

        .deal-badge.new {
            background: var(--accent);
            color: var(--text);
        }

        .deal-image {
            height: 200px;
            width: 100%;
            overflow: hidden;
            background: var(--gradient-soft);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .deal-image i {
            font-size: 80px;
            color: var(--primary);
            transition: all 0.3s ease;
        }

        .deal-card:hover .deal-image i {
            color: var(--accent);
            transform: scale(1.1);
        }

        .deal-content {
            padding: 25px;
        }

        .deal-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--text);
        }

        .deal-description {
            color: var(--text-secondary);
            font-size: 15px;
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .deal-pricing {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .deal-price {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary);
        }

        .original-price {
            font-size: 18px;
            text-decoration: line-through;
            color: var(--text-secondary);
            margin-left: 15px;
        }

        .discount {
            background: var(--sale-red);
            color: white;
            padding: 5px 15px;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 600;
            margin-left: auto;
        }

        .deal-actions {
            display: flex;
            gap: 15px;
        }

        .add-to-cart {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            flex: 1;
            box-shadow: 0 4px 15px rgba(30, 64, 175, 0.3);
        }

        .add-to-cart:hover {
            background: var(--gradient-alt);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(30, 64, 175, 0.4);
        }

        .details-btn {
            background: transparent;
            color: var(--text);
            border: 1px solid var(--glass-border);
            padding: 12px 20px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            flex: 1;
        }

        .details-btn:hover {
            background: var(--primary-soft);
            border-color: var(--primary);
            transform: translateY(-2px);
        }

        /* Featured Deal */
        .featured-deal {
            background: var(--section-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            overflow: hidden;
            margin: 4rem 5%;
            display: flex;
            box-shadow: var(--shadow-hover);
        }

        .featured-image {
            flex: 1;
            min-height: 300px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--gradient-soft);
        }

        .featured-image i {
            font-size: 120px;
            color: var(--primary);
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
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 700;
            display: inline-block;
            margin-bottom: 1rem;
            box-shadow: var(--shadow);
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
            color: var(--primary);
        }

        .featured-original {
            font-size: 1.5rem;
            text-decoration: line-through;
            color: var(--text-secondary);
            margin-left: 1rem;
        }

        .featured-discount {
            background: var(--sale-red);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            margin-left: auto;
        }

        /* Newsletter Section */
        .newsletter-section {
            background: var(--section-bg);
            border: 1px solid var(--glass-border);
            padding: 4rem 5%;
            text-align: center;
            border-radius: var(--border-radius);
            margin: 4rem 5%;
            box-shadow: var(--shadow);
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
            padding: 15px 20px;
            border-radius: 30px 0 0 30px;
            color: var(--text);
            outline: none;
            font-family: 'Montserrat', sans-serif;
        }

        .newsletter-btn {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 15px 25px;
            border-radius: 0 30px 30px 0;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(30, 64, 175, 0.3);
        }

        .newsletter-btn:hover {
            background: var(--gradient-alt);
            transform: translateY(-2px);
        }

        /* Footer */
        footer {
            background: var(--card-bg);
            padding: 100px 0 40px;
            border-top: 1px solid var(--glass-border);
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

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .pulse {
            animation: pulse 2s infinite;
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

        /* Responsive Design */
        @media (max-width: 1200px) {
            .page-title {
                font-size: 3rem;
            }

            .deals-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 992px) {
            .page-title {
                font-size: 2.5rem;
            }

            .section-title {
                font-size: 36px;
            }

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
                font-size: 2rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }

            .section-title {
                font-size: 32px;
                margin: 80px 0 40px;
            }

            .deal-actions {
                flex-direction: column;
            }

            .add-to-cart, .details-btn {
                width: 100%;
            }

            .newsletter-form {
                flex-direction: column;
            }

            .newsletter-input {
                border-radius: 30px;
                margin-bottom: 10px;
            }

            .newsletter-btn {
                border-radius: 30px;
                padding: 15px;
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

            .deal-title {
                font-size: 18px;
            }

            .deal-price {
                font-size: 20px;
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
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>

        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <button class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></button>
            <button class="theme-toggle" aria-label="Toggle Theme" id="themeToggle">
                <i class="fas fa-moon"></i>
            </button>
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i></button>
                <div class="dropdown">
                    <a href="sign-in.jsp" class="dropdown-item">Sign In</a>
                    <a href="sign-up.jsp" class="dropdown-item">Sign Up</a>
                </div>
            </div>
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
                    <li><a href="about.jsp">Our Story</a></li>
                    <li><a href="#">Store Locations</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                </ul>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; 2025 Melody Mart. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    // Theme toggle functionality
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = themeToggle.querySelector('i');

    // Check for saved theme preference or default to light
    const currentTheme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', currentTheme);
    updateThemeIcon(currentTheme);

    themeToggle.addEventListener('click', () => {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';

        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        updateThemeIcon(newTheme);
    });

    function updateThemeIcon(theme) {
        if (theme === 'light') {
            themeIcon.className = 'fas fa-moon';
        } else {
            themeIcon.className = 'fas fa-sun';
        }
    }

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
                if (entry.target.classList.contains('deal-card')) {
                    entry.target.classList.add('bounce-in');
                }
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.section-title, .deal-card').forEach((el) => {
        observer.observe(el);
    });
</script>
</body>
</html>