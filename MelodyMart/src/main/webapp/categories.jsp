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
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
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
            line-height: 1.6;
        }

        .container {
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            padding: 20px 0;
            background: rgba(10, 10, 10, 0.95);
            backdrop-filter: blur(10px);
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
        }

        .nav-links a.active {
            color: var(--primary-light);
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

        /* Categories Grid */
        .categories-section {
            padding: 2rem 5% 5rem;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: var(--text);
            text-align: center;
        }

        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .category-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            transition: transform 0.3s ease;
            cursor: pointer;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .category-card:hover {
            transform: translateY(-5px);
        }

        .category-icon {
            font-size: 4rem;
            color: var(--primary-light);
            margin-bottom: 1rem;
        }

        .category-title {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--text);
        }

        .category-description {
            color: var(--text-secondary);
            margin-bottom: 1rem;
        }

        .category-stats {
            display: flex;
            justify-content: space-between;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        /* Brands Section */
        .brands-section {
            padding: 2rem 5% 5rem;
            background: rgba(30, 30, 30, 0.7);
            margin: 2rem 5%;
            border-radius: 15px;
        }

        .brands-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .brand-card {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .brand-card:hover {
            transform: translateY(-3px);
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
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
        }

        .feature-item {
            text-align: center;
            padding: 2rem;
            background: var(--card-bg);
            border-radius: 10px;
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-light);
            margin-bottom: 1rem;
        }

        /* Footer */
        footer {
            background: #0a0a0a;
            padding: 80px 0 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
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
            color: var(--text);
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
        }

        .copyright {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--text-secondary);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .page-title {
                font-size: 2.5rem;
            }

            .categories-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
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
            <h3>Easy Navigation</h3>
            <p>Quickly find what you're looking for</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-star feature-icon"></i>
            <h3>Expert Curation</h3>
            <p>Carefully selected by music experts</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-compare feature-icon"></i>
            <h3>Easy Comparison</h3>
            <p>Compare similar products easily</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-tags feature-icon"></i>
            <h3>Category Deals</h3>
            <p>Special offers for each category</p>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-column">
                <h3>Melody Mart</h3>
                <p>Your premier destination for musical instruments</p>
            </div>
            <div class="footer-column">
                <h3>Categories</h3>
                <ul class="footer-links">
                    <li><a href="#">Guitars</a></li>
                    <li><a href="#">Pianos</a></li>
                    <li><a href="#">Drums</a></li>
                    <li><a href="#">Strings</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Support</h3>
                <ul class="footer-links">
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">Shipping</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Warranty</a></li>
                </ul>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2023 Melody Mart. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
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