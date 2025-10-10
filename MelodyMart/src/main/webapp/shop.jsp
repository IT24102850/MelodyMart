<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop | Melody Mart</title>
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
            --gradient-soft: linear-gradient(135deg, #e1f5fe, #b3e5fc);
            --glass-bg: rgba(255, 255, 255, 0.85);
            --glass-border: rgba(179, 229, 252, 0.5);
            --shadow: 0 5px 20px rgba(33, 150, 243, 0.15);
            --shadow-hover: 0 10px 30px rgba(33, 150, 243, 0.25);
            --header-bg: rgba(255, 255, 255, 0.95);
            --section-bg: #e1f5fe;
            --border-radius: 16px;
            --filter-bg: #e1f5fe;
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
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-left: 20px;
            position: relative;
            overflow: hidden;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: var(--shadow);
        }

        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
        }

        .cta-btn:focus {
            outline: 2px solid var(--primary-light);
            outline-offset: 3px;
        }

        .cta-btn i {
            font-size: 16px;
            transition: transform 0.3s ease;
        }

        .cta-btn:hover i {
            transform: translateX(6px);
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
            background: var(--gradient);
            padding: 150px 0 80px;
            text-align: center;
            margin-top: 80px;
            position: relative;
            overflow: hidden;
        }

        .page-header:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><path fill="rgba(255,255,255,0.1)" d="M500,250c138.07,0,250,111.93,250,250s-111.93,250-250,250s-250-111.93-250-250S361.93,250,500,250z"/></svg>') no-repeat center;
            background-size: cover;
            opacity: 0.2;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            color: white;
            position: relative;
            z-index: 2;
        }

        .page-subtitle {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 600px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        /* Shop Layout */
        .shop-container {
            display: flex;
            gap: 30px;
            padding: 60px 0;
        }

        /* Filters Sidebar */
        .filters-sidebar {
            width: 300px;
            background: var(--glass-bg);
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: var(--shadow);
            height: fit-content;
            position: sticky;
            top: 120px;
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
        }

        .filter-section {
            margin-bottom: 30px;
            border-bottom: 1px solid var(--glass-border);
            padding-bottom: 20px;
        }

        .filter-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }

        .filter-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--text);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .filter-options {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .filter-option {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }

        .filter-option input {
            display: none;
        }

        .custom-checkbox {
            width: 20px;
            height: 20px;
            border: 2px solid var(--primary-light);
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .filter-option input:checked + .custom-checkbox {
            background: var(--primary-light);
        }

        .filter-option input:checked + .custom-checkbox:after {
            content: '✓';
            color: white;
            font-size: 14px;
            font-weight: bold;
        }

        .filter-option label {
            cursor: pointer;
            color: var(--text-secondary);
            transition: color 0.3s ease;
        }

        .filter-option:hover label {
            color: var(--text);
        }

        .price-range {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .price-inputs {
            display: flex;
            gap: 10px;
        }

        .price-input {
            flex: 1;
            padding: 10px 15px;
            border: 1px solid var(--glass-border);
            border-radius: 8px;
            background: var(--card-bg);
            color: var(--text);
        }

        .price-slider {
            width: 100%;
            height: 5px;
            background: var(--card-bg);
            border-radius: 5px;
            outline: none;
            -webkit-appearance: none;
        }

        .price-slider::-webkit-slider-thumb {
            -webkit-appearance: none;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background: var(--primary-light);
            cursor: pointer;
        }

        .brand-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .brand-tag {
            padding: 8px 15px;
            background: var(--card-bg);
            border-radius: 20px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .brand-tag:hover, .brand-tag.active {
            background: var(--primary-light);
            color: white;
        }

        /* Products Section */
        .products-section {
            flex: 1;
        }

        .products-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: var(--glass-bg);
            padding: 20px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
        }

        .products-count {
            color: var(--text-secondary);
        }

        .sort-options {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .sort-select {
            padding: 10px 15px;
            border-radius: 8px;
            background: var(--card-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
            cursor: pointer;
        }

        .view-options {
            display: flex;
            gap: 10px;
        }

        .view-btn {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--card-bg);
            color: var(--text-secondary);
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .view-btn.active, .view-btn:hover {
            background: var(--primary-light);
            color: white;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .product-card {
            background: var(--glass-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            transition: all 0.5s ease;
            position: relative;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .product-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: var(--accent-alt);
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            z-index: 2;
        }

        .product-img {
            height: 220px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            transition: transform 0.5s ease;
            background: var(--gradient-soft);
        }

        .product-card:hover .product-img {
            transform: scale(1.05);
        }

        .product-img:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, transparent, rgba(100, 181, 246, 0.1));
            transition: opacity 0.3s ease;
        }

        .product-card:hover .product-img:after {
            opacity: 0.8;
        }

        .product-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .product-card:hover .product-img img {
            transform: scale(1.1);
        }

        .product-info {
            padding: 20px;
        }

        .product-category {
            color: var(--accent);
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .product-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            line-height: 1.4;
        }

        .product-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 10px;
        }

        .rating-stars {
            color: var(--accent);
        }

        .rating-count {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .product-price {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        .current-price {
            color: var(--text);
            font-weight: 700;
            font-size: 20px;
        }

        .original-price {
            color: var(--text-secondary);
            text-decoration: line-through;
            font-size: 16px;
        }

        .product-desc {
            color: var(--text-secondary);
            font-size: 14px;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .product-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .add-to-cart {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .add-to-cart:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .wishlist-btn {
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            transition: all 0.3s ease;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .wishlist-btn:hover {
            color: var(--accent-alt);
            background: var(--primary-soft);
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 50px;
            gap: 10px;
        }

        .pagination-btn {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--glass-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pagination-btn.active, .pagination-btn:hover {
            background: var(--primary-light);
            color: white;
        }

        /* Footer */
        footer {
            background: var(--glass-bg);
            padding: 80px 0 30px;
            border-top: 1px solid var(--glass-border);
            margin-top: 60px;
            backdrop-filter: blur(10px);
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 50px;
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
            padding-top: 30px;
            border-top: 1px solid var(--glass-border);
            color: var(--text-secondary);
            font-size: 15px;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .shop-container {
                flex-direction: column;
            }

            .filters-sidebar {
                width: 100%;
                position: static;
            }

            .products-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .products-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }

            .page-title {
                font-size: 2.5rem;
            }
        }

        @media (max-width: 576px) {
            .products-grid {
                grid-template-columns: 1fr;
            }

            .price-inputs {
                flex-direction: column;
            }

            .product-actions {
                flex-direction: column;
                gap: 10px;
            }

            .add-to-cart {
                width: 100%;
                justify-content: center;
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
            <li><a href="shop.jsp" class="active">Shop</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>

        <div class="nav-actions">
            <!-- Theme toggle button removed as requested -->
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

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1 class="page-title">Premium Instruments Shop</h1>
        <p class="page-subtitle">Discover our curated collection of professional musical instruments and equipment</p>
    </div>
</section>

<!-- Shop Content -->
<div class="container shop-container">
    <!-- Filters Sidebar -->
    <aside class="filters-sidebar">
        <div class="filter-section">
            <h3 class="filter-title">Categories</h3>
            <div class="filter-options">
                <div class="filter-option">
                    <input type="checkbox" id="cat-guitars">
                    <label for="cat-guitars" class="custom-checkbox"></label>
                    <label for="cat-guitars">Guitars</label>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="cat-drums">
                    <label for="cat-drums" class="custom-checkbox"></label>
                    <label for="cat-drums">Drums & Percussion</label>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="cat-pianos">
                    <label for="cat-pianos" class="custom-checkbox"></label>
                    <label for="cat-pianos">Pianos & Keyboards</label>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="cat-recording">
                    <label for="cat-recording" class="custom-checkbox"></label>
                    <label for="cat-recording">Recording Equipment</label>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="cat-strings">
                    <label for="cat-strings" class="custom-checkbox"></label>
                    <label for="cat-strings">String Instruments</label>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="cat-wind">
                    <label for="cat-wind" class="custom-checkbox"></label>
                    <label for="cat-wind">Wind Instruments</label>
                </div>
            </div>
        </div>

        <div class="filter-section">
            <h3 class="filter-title">Price Range</h3>
            <div class="price-range">
                <div class="price-inputs">
                    <input type="number" class="price-input" placeholder="Min" value="0">
                    <input type="number" class="price-input" placeholder="Max" value="5000">
                </div>
                <input type="range" class="price-slider" min="0" max="10000" value="5000">
            </div>
        </div>

        <div class="filter-section">
            <h3 class="filter-title">Brands</h3>
            <div class="brand-tags">
                <div class="brand-tag active">Fender</div>
                <div class="brand-tag">Gibson</div>
                <div class="brand-tag">Yamaha</div>
                <div class="brand-tag">Roland</div>
                <div class="brand-tag">Shure</div>
                <div class="brand-tag">Sennheiser</div>
            </div>
        </div>

        <div class="filter-section">
            <h3 class="filter-title">Rating</h3>
            <div class="filter-options">
                <div class="filter-option">
                    <input type="checkbox" id="rating-5">
                    <label for="rating-5" class="custom-checkbox"></label>
                    <label for="rating-5">
                        <span class="rating-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                        </span>
                    </label>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="rating-4">
                    <label for="rating-4" class="custom-checkbox"></label>
                    <label for="rating-4">
                        <span class="rating-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
                        </span> & Up
                    </label>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="rating-3">
                    <label for="rating-3" class="custom-checkbox"></label>
                    <label for="rating-3">
                        <span class="rating-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                        </span> & Up
                    </label>
                </div>
            </div>
        </div>

        <button class="cta-btn" style="width: 100%; margin-top: 20px;">Apply Filters</button>
    </aside>

    <!-- Products Section -->
    <main class="products-section">
        <div class="products-header">
            <div>
                <h2 style="margin-bottom: 5px;">All Instruments</h2>
                <p class="products-count">Showing 1-12 of 48 products</p>
            </div>
            <div class="sort-options">
                <select class="sort-select">
                    <option>Sort by: Featured</option>
                    <option>Price: Low to High</option>
                    <option>Price: High to Low</option>
                    <option>Customer Rating</option>
                    <option>Newest Arrivals</option>
                </select>
                <div class="view-options">
                    <button class="view-btn active"><i class="fas fa-th"></i></button>
                    <button class="view-btn"><i class="fas fa-list"></i></button>
                </div>
            </div>
        </div>

        <div class="products-grid">
            <!-- Product 1 -->
            <div class="product-card">
                <div class="product-badge">New</div>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Professional Electric Guitar">
                </div>
                <div class="product-info">
                    <div class="product-category">Guitars</div>
                    <h3 class="product-title">Fender American Professional Stratocaster</h3>
                    <div class="product-rating">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                        </div>
                        <span class="rating-count">(42)</span>
                    </div>
                    <div class="product-price">
                        <span class="current-price">$1,499.99</span>
                        <span class="original-price">$1,699.99</span>
                    </div>
                    <p class="product-desc">Professional-grade electric guitar with V-Mod pickups and deep "C" neck profile.</p>
                    <div class="product-actions">
                        <button class="add-to-cart">
                            <i class="fas fa-shopping-cart"></i>
                            Add to Cart
                        </button>
                        <button class="wishlist-btn">
                            <i class="far fa-heart"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Product 2 -->
            <div class="product-card">
                <div class="product-badge">Sale</div>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1519892300165-cb5542fb47c7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Premium Drum Set">
                </div>
                <div class="product-info">
                    <div class="product-category">Drums</div>
                    <h3 class="product-title">Yamaha Stage Custom Birch Drum Set</h3>
                    <div class="product-rating">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
                        </div>
                        <span class="rating-count">(28)</span>
                    </div>
                    <div class="product-price">
                        <span class="current-price">$1,199.99</span>
                        <span class="original-price">$1,399.99</span>
                    </div>
                    <p class="product-desc">5-piece drum kit with birch shells for powerful projection and warm tones.</p>
                    <div class="product-actions">
                        <button class="add-to-cart">
                            <i class="fas fa-shopping-cart"></i>
                            Add to Cart
                        </button>
                        <button class="wishlist-btn">
                            <i class="far fa-heart"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Product 3 -->
            <div class="product-card">
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1520523839897-bd0b52f945a0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Digital Grand Piano">
                </div>
                <div class="product-info">
                    <div class="product-category">Pianos</div>
                    <h3 class="product-title">Roland LX700 Digital Grand Piano</h3>
                    <div class="product-rating">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                        </div>
                        <span class="rating-count">(35)</span>
                    </div>
                    <div class="product-price">
                        <span class="current-price">$3,799.99</span>
                    </div>
                    <p class="product-desc">Premium digital piano with authentic grand piano sound and responsive keyboard action.</p>
                    <div class="product-actions">
                        <button class="add-to-cart">
                            <i class="fas fa-shopping-cart"></i>
                            Add to Cart
                        </button>
                        <button class="wishlist-btn">
                            <i class="far fa-heart"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Product 4 -->
            <div class="product-card">
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Saxophone">
                </div>
                <div class="product-info">
                    <div class="product-category">Wind Instruments</div>
                    <h3 class="product-title">Yamaha YAS-280 Alto Saxophone</h3>
                    <div class="product-rating">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                        </div>
                        <span class="rating-count">(19)</span>
                    </div>
                    <div class="product-price">
                        <span class="current-price">$1,899.99</span>
                    </div>
                    <p class="product-desc">Professional alto saxophone with responsive key action and rich, focused tone.</p>
                    <div class="product-actions">
                        <button class="add-to-cart">
                            <i class="fas fa-shopping-cart"></i>
                            Add to Cart
                        </button>
                        <button class="wishlist-btn">
                            <i class="far fa-heart"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Product 5 -->
            <div class="product-card">
                <div class="product-badge">Best Seller</div>
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1593696141115-3f0b37671c36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Violin">
                </div>
                <div class="product-info">
                    <div class="product-category">String Instruments</div>
                    <h3 class="product-title">Stentor Student II Violin Outfit</h3>
                    <div class="product-rating">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
                        </div>
                        <span class="rating-count">(31)</span>
                    </div>
                    <div class="product-price">
                        <span class="current-price">$299.99</span>
                    </div>
                    <p class="product-desc">Complete violin outfit perfect for students, featuring quality craftsmanship.</p>
                    <div class="product-actions">
                        <button class="add-to-cart">
                            <i class="fas fa-shopping-cart"></i>
                            Add to Cart
                        </button>
                        <button class="wishlist-btn">
                            <i class="far fa-heart"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Product 6 -->
            <div class="product-card">
                <div class="product-img">
                    <img src="https://images.unsplash.com/photo-1571974599782-87624638275f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1742&q=80" alt="Microphone">
                </div>
                <div class="product-info">
                    <div class="product-category">Recording</div>
                    <h3 class="product-title">Shure SM7B Vocal Microphone</h3>
                    <div class="product-rating">
                        <div class="rating-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                        </div>
                        <span class="rating-count">(47)</span>
                    </div>
                    <div class="product-price">
                        <span class="current-price">$399.99</span>
                    </div>
                    <p class="product-desc">Professional dynamic microphone with smooth, flat frequency response.</p>
                    <div class="product-actions">
                        <button class="add-to-cart">
                            <i class="fas fa-shopping-cart"></i>
                            Add to Cart
                        </button>
                        <button class="wishlist-btn">
                            <i class="far fa-heart"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <button class="pagination-btn"><i class="fas fa-chevron-left"></i></button>
            <button class="pagination-btn active">1</button>
            <button class="pagination-btn">2</button>
            <button class="pagination-btn">3</button>
            <button class="pagination-btn">4</button>
            <button class="pagination-btn"><i class="fas fa-chevron-right"></i></button>
        </div>
    </main>
</div>

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
                <h3>Customer Service</h3>
                <ul class="footer-links">
                    <li><a href="#">My Account</a></li>
                    <li><a href="#">Order Tracking</a></li>
                    <li><a href="#">Wish List</a></li>
                    <li><a href="#">Customer Support</a></li>
                    <li><a href="#">Returns & Exchanges</a></li>
                </ul>
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

    // Filter functionality
    const brandTags = document.querySelectorAll('.brand-tag');
    brandTags.forEach(tag => {
        tag.addEventListener('click', () => {
            tag.classList.toggle('active');
        });
    });

    // View toggle functionality
    const viewBtns = document.querySelectorAll('.view-btn');
    viewBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            viewBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const productsGrid = document.querySelector('.products-grid');
            if (btn.querySelector('.fa-list')) {
                productsGrid.style.gridTemplateColumns = '1fr';
            } else {
                productsGrid.style.gridTemplateColumns = 'repeat(auto-fill, minmax(280px, 1fr))';
            }
        });
    });

    // Wishlist toggle
    const wishlistBtns = document.querySelectorAll('.wishlist-btn');
    wishlistBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const icon = btn.querySelector('i');
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
    });
</script>
</body>
</html>