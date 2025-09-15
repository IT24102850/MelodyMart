<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Premium Musical Instruments</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        :root {
            --dark-bg: #0d0d0d;
            --dark-card: #1a1a1a;
            --dark-accent: #2a2a2a;
            --black-accent: #333333;
            --golden-yellow: #ffd700;
            --vibrant-orange: #ff6b35;
            --white: #ffffff;
            --light-gray: #e0e0e0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, var(--dark-accent) 0%, var(--dark-bg) 100%);
            color: var(--white);
            overflow-x: hidden;
            min-height: 100vh;
        }

        nav {
            position: fixed;
            top: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 5%;
            background: rgba(13, 13, 13, 0.9);
            backdrop-filter: blur(10px);
            z-index: 1000;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--white);
        }

        .logo i {
            color: var(--golden-yellow);
            margin-right: 0.5rem;
            font-size: 2rem;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
        }

        .nav-links a {
            color: var(--light-gray);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--golden-yellow);
        }

        .nav-actions {
            display: flex;
            gap: 1.5rem;
            align-items: center;
        }

        .nav-actions i {
            font-size: 1.5rem;
            color: var(--light-gray);
            cursor: pointer;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        .nav-actions i:hover {
            color: var(--golden-yellow);
            transform: scale(1.2);
        }

        .page-header {
            margin-top: 100px;
            padding: 3rem 5%;
            text-align: center;
        }

        .page-title {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(90deg, var(--black-accent), var(--vibrant-orange));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .page-subtitle {
            font-size: 1.2rem;
            color: var(--light-gray);
            max-width: 700px;
            margin: 0 auto 2rem;
        }

        .filters-section {
            padding: 1rem 5%;
            background: var(--dark-card);
            margin-bottom: 2rem;
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
            background: var(--dark-accent);
            border-radius: 50px;
            padding: 0.5rem 1rem;
            width: 300px;
        }

        .search-bar input {
            background: transparent;
            border: none;
            color: var(--white);
            padding: 0.5rem;
            width: 100%;
            outline: none;
        }

        .search-bar i {
            color: var(--light-gray);
            cursor: pointer;
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
            background: var(--dark-accent);
            color: var(--white);
            border: none;
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .filter-btn:hover {
            background: var(--black-accent);
        }

        .instruments-grid {
            padding: 0 5% 5rem;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .instrument-card {
            background: var(--dark-card);
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .instrument-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
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
            background: var(--vibrant-orange);
            color: var(--white);
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
            color: var(--white);
        }

        .instrument-info p {
            color: var(--light-gray);
            margin-bottom: 1rem;
            font-size: 0.9rem;
            line-height: 1.5;
        }

        .instrument-price {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--golden-yellow);
            margin-bottom: 1rem;
        }

        .instrument-rating {
            display: flex;
            align-items: center;
            gap: 0.3rem;
            margin-bottom: 1rem;
        }

        .instrument-rating i {
            color: var(--golden-yellow);
            font-size: 0.9rem;
        }

        .instrument-actions {
            display: flex;
            justify-content: space-between;
        }

        .add-to-cart {
            background: var(--black-accent);
            color: var(--white);
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
            flex: 1;
            margin-right: 0.5rem;
        }

        .add-to-cart:hover {
            background: #444444;
            transform: scale(1.05);
        }

        .details-btn {
            background: transparent;
            color: var(--light-gray);
            border: 1px solid var(--light-gray);
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease, transform 0.3s ease;
            flex: 1;
            margin-left: 0.5rem;
        }

        .details-btn:hover {
            background: var(--light-gray);
            color: var(--dark-bg);
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
            background: var(--dark-card);
            color: var(--white);
            border: none;
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
            background: var(--vibrant-orange);
            transform: scale(1.1);
        }

        footer {
            background: var(--dark-bg);
            padding: 3rem 5%;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .footer-column h3 {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: var(--white);
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column ul li {
            margin-bottom: 0.8rem;
        }

        .footer-column ul li a {
            color: var(--light-gray);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-column ul li a:hover {
            color: var(--golden-yellow);
        }

        .social-icons {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-icons a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--dark-card);
            color: var(--white);
            transition: all 0.3s ease, transform 0.3s ease;
        }

        .social-icons a:hover {
            background: var(--golden-yellow);
            transform: translateY(-5px);
        }

        .copyright {
            text-align: center;
            margin-top: 3rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--light-gray);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .instrument-card {
            animation: fadeIn 0.5s ease-out;
        }

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
<nav>
    <div class="logo">
        <i class="fas fa-music"></i>
        <span>Melody Mart</span>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/instruments.jsp" class="active">Instruments</a>
        <a href="${pageContext.request.contextPath}/brands.jsp">Brands</a>
        <a href="${pageContext.request.contextPath}/deals.jsp">Deals</a>
        <a href="${pageContext.request.contextPath}/studio">Studio</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
    </div>
    <div class="nav-actions">
        <i class="fas fa-search"></i>
        <i class="fas fa-shopping-cart"></i>
        <i class="fas fa-user"></i>
    </div>
</nav>

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
    <div class="footer-content">
        <div class="footer-column">
            <h3>Harmony Instruments</h3>
            <p>Your premier destination for quality musical instruments since 1995.</p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
            </div>
        </div>

        <div class="footer-column">
            <h3>Shop</h3>
            <ul>
                <li><a href="#">Guitars</a></li>
                <li><a href="#">Keyboards</a></li>
                <li><a href="#">Drums</a></li>
                <li><a href="#">Brass Instruments</a></li>
                <li><a href="#">Woodwinds</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h3>Support</h3>
            <ul>
                <li><a href="#">Contact Us</a></li>
                <li><a href="#">Shipping & Returns</a></li>
                <li><a href="#">FAQ</a></li>
                <li><a href="#">Warranty</a></li>
                <li><a href="#">Repair Services</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h3>Newsletter</h3>
            <p>Subscribe to get special offers, free giveaways, and new product notifications.</p>
            <form>
                <div class="search-bar">
                    <input type="email" placeholder="Your email address">
                    <i class="fas fa-paper-plane"></i>
                </div>
            </form>
        </div>
    </div>

    <div class="copyright">
        <p>&copy; 2023 Harmony Instruments. All rights reserved.</p>
    </div>
</footer>

<script>
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
</script>
</body>
</html>