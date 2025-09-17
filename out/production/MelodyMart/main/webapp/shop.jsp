<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop Musical Instruments - Melody Mart</title>
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
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--secondary);
            color: var(--text);
            overflow-x: hidden;
            line-height: 1.6;
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.85)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        .header {
            background: rgba(10, 10, 10, 0.95);
            backdrop-filter: blur(10px);
            padding: 15px 0;
            border-bottom: 1px solid var(--glass-border);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header-content {
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
            text-decoration: none;
        }

        .logo i {
            margin-right: 10px;
            font-size: 32px;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-link {
            color: var(--text);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: var(--primary-light);
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
        }

        .btn-primary:hover {
            background: var(--gradient-alt);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
        }

        /* Shop Layout */
        .shop-container {
            display: flex;
            padding: 40px 0;
            gap: 30px;
        }

        /* Filters Sidebar */
        .filters-sidebar {
            width: 280px;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 20px;
            height: fit-content;
            position: sticky;
            top: 100px;
        }

        .filters-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--glass-border);
        }

        .filters-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .clear-filters {
            color: var(--primary-light);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .filter-group {
            margin-bottom: 25px;
        }

        .filter-title {
            font-weight: 600;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }

        .filter-title i {
            margin-right: 10px;
            color: var(--primary-light);
        }

        .price-range {
            margin-top: 10px;
        }

        .range-values {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .filter-options {
            list-style: none;
        }

        .filter-option {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .filter-option input {
            margin-right: 10px;
            accent-color: var(--primary);
        }

        .filter-option label {
            cursor: pointer;
        }

        .color-options {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        .color-option {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .color-option:hover {
            transform: scale(1.1);
        }

        .color-option.active {
            border-color: var(--text);
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
        }

        .products-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .search-sort {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .search-box {
            position: relative;
        }

        .search-input {
            padding: 12px 15px 12px 45px;
            border: 1px solid var(--glass-border);
            background: var(--card-bg);
            color: var(--text);
            border-radius: 30px;
            width: 250px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.3);
        }

        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }

        .sort-select {
            padding: 12px 15px;
            border: 1px solid var(--glass-border);
            background: var(--card-bg);
            color: var(--text);
            border-radius: 8px;
            cursor: pointer;
        }

        .sort-select:focus {
            outline: none;
            border-color: var(--primary-light);
        }

        /* Products Grid */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .product-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.2);
        }

        .product-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: var(--gradient);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            z-index: 2;
        }

        .product-image {
            height: 200px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .product-card:hover .product-image img {
            transform: scale(1.1);
        }

        .product-image:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, transparent, rgba(0, 0, 0, 0.7));
        }

        .quick-view {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            color: var(--text);
            padding: 10px 15px;
            border-radius: 30px;
            border: 1px solid var(--glass-border);
            opacity: 0;
            transition: all 0.3s ease;
            z-index: 3;
            cursor: pointer;
        }

        .product-card:hover .quick-view {
            opacity: 1;
        }

        .product-info {
            padding: 20px;
        }

        .product-category {
            color: var(--primary-light);
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }

        .product-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-rating {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .stars {
            color: #ffc107;
            margin-right: 8px;
        }

        .rating-count {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .product-price {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .current-price {
            font-size: 20px;
            font-weight: 700;
            color: var(--primary-light);
        }

        .original-price {
            text-decoration: line-through;
            color: var(--text-secondary);
            margin-left: 10px;
            font-size: 14px;
        }

        .product-actions {
            display: flex;
            justify-content: space-between;
        }

        .add-to-cart {
            flex: 1;
            margin-right: 10px;
        }

        .wishlist-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            color: var(--text);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .wishlist-btn:hover {
            color: #ff4d4d;
            border-color: #ff4d4d;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 50px;
            gap: 10px;
        }

        .page-btn {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            color: var(--text);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .page-btn.active {
            background: var(--gradient);
            border-color: transparent;
        }

        .page-btn:hover:not(.active) {
            border-color: var(--primary-light);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .shop-container {
                flex-direction: column;
            }

            .filters-sidebar {
                width: 100%;
                position: static;
                margin-bottom: 30px;
            }

            .products-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }

            .search-sort {
                width: 100%;
                justify-content: space-between;
            }

            .search-input {
                width: 100%;
            }
        }

        @media (max-width: 576px) {
            .products-grid {
                grid-template-columns: 1fr;
            }

            .nav-actions {
                display: none;
            }

            .header-content {
                justify-content: center;
            }
        }

        /* Filter toggle for mobile */
        .filters-toggle {
            display: none;
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 15px;
            margin-bottom: 20px;
            cursor: pointer;
            width: 100%;
            justify-content: center;
            align-items: center;
        }

        .filters-toggle i {
            margin-right: 8px;
        }

        @media (max-width: 992px) {
            .filters-toggle {
                display: flex;
            }

            .filters-sidebar {
                display: none;
            }

            .filters-sidebar.active {
                display: block;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header class="header">
    <div class="container header-content">
        <a href="index.jsp" class="logo">
            <i class="fas fa-music"></i>
            Melody Mart
        </a>

        <div class="nav-actions">
            <a href="index.jsp" class="nav-link">Home</a>
            <a href="shop.jsp" class="nav-link">Shop</a>
            <a href="#" class="nav-link">Categories</a>
            <a href="#" class="nav-link">About</a>
            <a href="sign-in.jsp" class="btn btn-primary">
                <i class="fas fa-sign-in-alt"></i>Sign In
            </a>
        </div>
    </div>
</header>

<!-- Shop Content -->
<div class="container">
    <button class="filters-toggle">
        <i class="fas fa-filter"></i>Show Filters
    </button>

    <div class="shop-container">
        <!-- Filters Sidebar -->
        <div class="filters-sidebar">
            <div class="filters-header">
                <h2>Filters</h2>
                <button class="clear-filters">Clear All</button>
            </div>

            <!-- Categories -->
            <div class="filter-group">
                <div class="filter-title">
                    <i class="fas fa-list"></i>Categories
                </div>
                <ul class="filter-options">
                    <li class="filter-option">
                        <input type="checkbox" id="guitars" name="category">
                        <label for="guitars">Guitars</label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="pianos" name="category">
                        <label for="pianos">Pianos & Keyboards</label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="drums" name="category">
                        <label for="drums">Drums & Percussion</label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="brass" name="category">
                        <label for="brass">Brass Instruments</label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="woodwind" name="category">
                        <label for="woodwind">Woodwind Instruments</label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="accessories" name="category">
                        <label for="accessories">Accessories</label>
                    </li>
                </ul>
            </div>

            <!-- Price Range -->
            <div class="filter-group">
                <div class="filter-title">
                    <i class="fas fa-tag"></i>Price Range
                </div>
                <input type="range" min="0" max="10000" value="5000" class="price-range" style="width: 100%;">
                <div class="range-values">
                    <span>$0</span>
                    <span>$10,000</span>
                </div>
            </div>

            <!-- Brands -->
            <div class="filter-group">
                <div class="filter-title">
                    <i class="fas fa-crown"></i>Brands
                </div>
                <ul class="filter-options">
                    <li class="filter-option">
                        <input type="checkbox" id="fender" name="brand">
                        <label for="fender">Fender</label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="gibson" name="brand">
                        <label for="gibson">Gibson</label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="yamaha" name="brand">
                        <label for="yamaha">Yamaha</label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="roland" name="brand">
                        <label for="roland">Roland</label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="shure" name="brand">
                        <label for="shure">Shure</label>
                    </li>
                </ul>
            </div>

            <!-- Rating -->
            <div class="filter-group">
                <div class="filter-title">
                    <i class="fas fa-star"></i>Customer Rating
                </div>
                <ul class="filter-options">
                    <li class="filter-option">
                        <input type="checkbox" id="rating5" name="rating">
                        <label for="rating5">
                            <span class="stars">★★★★★</span> 5 & up
                        </label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="rating4" name="rating">
                        <label for="rating4">
                            <span class="stars">★★★★☆</span> 4 & up
                        </label>
                    </li>
                    <li class="filter-option">
                        <input type="checkbox" id="rating3" name="rating">
                        <label for="rating3">
                            <span class="stars">★★★☆☆</span> 3 & up
                        </label>
                    </li>
                </ul>
            </div>

            <!-- Color -->
            <div class="filter-group">
                <div class="filter-title">
                    <i class="fas fa-palette"></i>Color
                </div>
                <div class="color-options">
                    <div class="color-option active" style="background-color: #8B4513;" title="Brown"></div>
                    <div class="color-option" style="background-color: #000000;" title="Black"></div>
                    <div class="color-option" style="background-color: #FFFFFF; border: 1px solid #333;" title="White"></div>
                    <div class="color-option" style="background-color: #FFD700;" title="Gold"></div>
                    <div class="color-option" style="background-color: #C0C0C0;" title="Silver"></div>
                    <div class="color-option" style="background-color: #FF0000;" title="Red"></div>
                </div>
            </div>

            <button class="btn btn-primary" style="width: 100%;">
                <i class="fas fa-check"></i>Apply Filters
            </button>
        </div>

        <!-- Products Section -->
        <div class="products-section">
            <div class="products-header">
                <h1>Musical Instruments</h1>
                <div class="search-sort">
                    <div class="search-box">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" class="search-input" placeholder="Search instruments...">
                    </div>
                    <select class="sort-select">
                        <option>Sort by: Featured</option>
                        <option>Price: Low to High</option>
                        <option>Price: High to Low</option>
                        <option>Highest Rated</option>
                        <option>Newest Arrivals</option>
                    </select>
                </div>
            </div>

            <div class="products-grid">
                <!-- Product 1 -->
                <div class="product-card">
                    <div class="product-badge">Popular</div>
                    <div class="product-image">
                        <img src="https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80" alt="Fender Stratocaster">
                        <button class="quick-view">Quick View</button>
                    </div>
                    <div class="product-info">
                        <div class="product-category">Guitars</div>
                        <h3 class="product-title">Fender American Professional II Stratocaster</h3>
                        <div class="product-rating">
                            <div class="stars">★★★★★</div>
                            <div class="rating-count">(128)</div>
                        </div>
                        <div class="product-price">
                            <div class="current-price">$1,499.99</div>
                            <div class="original-price">$1,699.99</div>
                        </div>
                        <div class="product-actions">
                            <button class="btn btn-primary add-to-cart">
                                <i class="fas fa-shopping-cart"></i>Add to Cart
                            </button>
                            <button class="wishlist-btn">
                                <i class="far fa-heart"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://images.unsplash.com/photo-1507748632472-2f976b7730e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80" alt="Yamaha Piano">
                        <button class="quick-view">Quick View</button>
                    </div>
                    <div class="product-info">
                        <div class="product-category">Pianos</div>
                        <h3 class="product-title">Yamaha P-125 Digital Piano</h3>
                        <div class="product-rating">
                            <div class="stars">★★★★☆</div>
                            <div class="rating-count">(96)</div>
                        </div>
                        <div class="product-price">
                            <div class="current-price">$649.99</div>
                        </div>
                        <div class="product-actions">
                            <button class="btn btn-primary add-to-cart">
                                <i class="fas fa-shopping-cart"></i>Add to Cart
                            </button>
                            <button class="wishlist-btn">
                                <i class="far fa-heart"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="product-card">
                    <div class="product-badge">Sale</div>
                    <div class="product-image">
                        <img src="https://images.unsplash.com/photo-1519892300165-cb5542fb47c7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80" alt="Drum Set">
                        <button class="quick-view">Quick View</button>
                    </div>
                    <div class="product-info">
                        <div class="product-category">Drums</div>
                        <h3 class="product-title">Pearl Export Series Drum Set</h3>
                        <div class="product-rating">
                            <div class="stars">★★★★★</div>
                            <div class="rating-count">(74)</div>
                        </div>
                        <div class="product-price">
                            <div class="current-price">$899.99</div>
                            <div class="original-price">$1,099.99</div>
                        </div>
                        <div class="product-actions">
                            <button class="btn btn-primary add-to-cart">
                                <i class="fas fa-shopping-cart"></i>Add to Cart
                            </button>
                            <button class="wishlist-btn">
                                <i class="far fa-heart"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://images.unsplash.com/photo-1599407950360-5fd3c0fe2a31?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80" alt="Saxophone">
                        <button class="quick-view">Quick View</button>
                    </div>
                    <div class="product-info">
                        <div class="product-category">Woodwind</div>
                        <h3 class="product-title">Yamaha YAS-280 Alto Saxophone</h3>
                        <div class="product-rating">
                            <div class="stars">★★★★☆</div>
                            <div class="rating-count">(52)</div>
                        </div>
                        <div class="product-price">
                            <div class="current-price">$1,299.99</div>
                        </div>
                        <div class="product-actions">
                            <button class="btn btn-primary add-to-cart">
                                <i class="fas fa-shopping-cart"></i>Add to Cart
                            </button>
                            <button class="wishlist-btn">
                                <i class="far fa-heart"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Product 5 -->
                <div class="product-card">
                    <div class="product-badge">New</div>
                    <div class="product-image">
                        <img src="https://images.unsplash.com/photo-1605020420620-44c155a96725?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80" alt="Violin">
                        <button class="quick-view">Quick View</button>
                    </div>
                    <div class="product-info">
                        <div class="product-category">Strings</div>
                        <h3 class="product-title">Stentor Student II Violin Outfit</h3>
                        <div class="product-rating">
                            <div class="stars">★★★★☆</div>
                            <div class="rating-count">(38)</div>
                        </div>
                        <div class="product-price">
                            <div class="current-price">$199.99</div>
                        </div>
                        <div class="product-actions">
                            <button class="btn btn-primary add-to-cart">
                                <i class="fas fa-shopping-cart"></i>Add to Cart
                            </button>
                            <button class="wishlist-btn">
                                <i class="far fa-heart"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Product 6 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80" alt="Microphone">
                        <button class="quick-view">Quick View</button>
                    </div>
                    <div class="product-info">
                        <div class="product-category">Accessories</div>
                        <h3 class="product-title">Shure SM58 Dynamic Vocal Microphone</h3>
                        <div class="product-rating">
                            <div class="stars">★★★★★</div>
                            <div class="rating-count">(214)</div>
                        </div>
                        <div class="product-price">
                            <div class="current-price">$99.99</div>
                        </div>
                        <div class="product-actions">
                            <button class="btn btn-primary add-to-cart">
                                <i class="fas fa-shopping-cart"></i>Add to Cart
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
                <button class="page-btn"><i class="fas fa-chevron-left"></i></button>
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn">3</button>
                <button class="page-btn">4</button>
                <button class="page-btn"><i class="fas fa-chevron-right"></i></button>
            </div>
        </div>
    </div>
</div>

<script>
    // Toggle filters on mobile
    document.querySelector('.filters-toggle').addEventListener('click', function() {
        document.querySelector('.filters-sidebar').classList.toggle('active');

        if (this.textContent.includes('Show')) {
            this.innerHTML = '<i class="fas fa-times"></i>Hide Filters';
        } else {
            this.innerHTML = '<i class="fas fa-filter"></i>Show Filters';
        }
    });

    // Product card hover effects
    document.querySelectorAll('.product-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
            this.style.boxShadow = '0 10px 20px rgba(138, 43, 226, 0.2)';
        });

        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = 'none';
        });
    });

    // Wishlist toggle
    document.querySelectorAll('.wishlist-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const icon = this.querySelector('i');
            if (icon.classList.contains('far')) {
                icon.classList.remove('far');
                icon.classList.add('fas');
                this.style.color = '#ff4d4d';
            } else {
                icon.classList.remove('fas');
                icon.classList.add('far');
                this.style.color = '';
            }
        });
    });

    // Quick view modal (simplified)
    document.querySelectorAll('.quick-view').forEach(btn => {
        btn.addEventListener('click', function() {
            alert('Quick view feature would show product details here.');
        });
    });

    // Add to cart animation
    document.querySelectorAll('.add-to-cart').forEach(btn => {
        btn.addEventListener('click', function() {
            const originalText = this.innerHTML;
            this.innerHTML = '<i class="fas fa-check"></i>Added to Cart';

            setTimeout(() => {
                this.innerHTML = originalText;
            }, 2000);
        });
    });

    // Color selection
    document.querySelectorAll('.color-option').forEach(option => {
        option.addEventListener('click', function() {
            document.querySelectorAll('.color-option').forEach(opt => {
                opt.classList.remove('active');
            });
            this.classList.add('active');
        });
    });
</script>
</body>
</html>