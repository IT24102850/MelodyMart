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

        /* Section Backgrounds */
        .section-bg {
            background: var(--section-bg);
            padding: 100px 0;
            margin: 80px 0;
        }

        /* Brands Section */
        .brands-section {
            padding: 2rem 5% 5rem;
        }

        .brands-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
            margin-bottom: 80px;
        }

        .brand-card {
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

        .brand-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .brand-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .brand-image {
            height: 180px;
            width: 100%;
            overflow: hidden;
            background: var(--gradient-soft);
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
            padding: 25px;
        }

        .brand-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .brand-description {
            color: var(--text-secondary);
            font-size: 15px;
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .brand-specialty {
            display: inline-block;
            background: var(--gradient);
            color: white;
            padding: 5px 15px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .brand-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .brand-stats span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Featured Brands */
        .featured-brands {
            padding: 2rem 5% 5rem;
            background: var(--section-bg);
            margin: 2rem 5%;
            border-radius: var(--border-radius);
        }

        .featured-brands-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .featured-brand-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 2rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
            cursor: pointer;
            box-shadow: var(--shadow);
            opacity: 0;
            transform: translateY(30px);
        }

        .featured-brand-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .featured-brand-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .featured-brand-logo {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--primary);
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
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
        }

        .category-item {
            text-align: center;
            padding: 30px 20px;
            border-radius: var(--border-radius);
            background: var(--card-bg);
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
            cursor: pointer;
            box-shadow: var(--shadow);
            opacity: 0;
            transform: translateY(30px);
        }

        .category-item.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .category-item:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .category-icon {
            font-size: 50px;
            color: var(--primary);
            margin-bottom: 20px;
            transition: color 0.3s ease;
        }

        .category-item:hover .category-icon {
            color: var(--accent);
        }

        .category-title {
            font-size: 20px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .category-count {
            color: var(--text-secondary);
            font-size: 15px;
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

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
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
        }

        @media (max-width: 992px) {
            .page-title {
                font-size: 2.5rem;
            }

            .section-title {
                font-size: 36px;
            }

            .brands-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
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

            .featured-brands-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
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
                    <input type="email" placeholder="Your email address" style="width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 10px; border: 1px solid var(--glass-border); background: var(--secondary); color: var(--text);">
                    <button class="cta-btn" style="width: 100%;">Subscribe</button>
                </form>
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
                if (entry.target.classList.contains('featured-brand-card') ||
                    entry.target.classList.contains('category-item')) {
                    entry.target.classList.add('bounce-in');
                }
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.section-title, .brand-card, .featured-brand-card, .category-item').forEach((el) => {
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