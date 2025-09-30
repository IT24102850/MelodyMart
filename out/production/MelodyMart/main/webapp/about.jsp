<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | About Us</title>
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

        /* About Content */
        .about-section {
            padding: 2rem 5% 5rem;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: var(--text);
            text-align: center;
        }

        .about-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            margin-bottom: 5rem;
        }

        .about-text {
            padding-right: 2rem;
        }

        .about-text h2 {
            font-size: 2rem;
            margin-bottom: 1.5rem;
            color: var(--primary-light);
        }

        .about-text p {
            margin-bottom: 1.5rem;
            color: var(--text-secondary);
            line-height: 1.8;
        }

        .about-image {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .about-image img {
            width: 100%;
            height: auto;
            display: block;
        }

        /* Stats Section */
        .stats-section {
            background: rgba(30, 30, 30, 0.7);
            padding: 4rem 5%;
            border-radius: 15px;
            margin-bottom: 5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 1.1rem;
        }

        /* Team Section */
        .team-section {
            margin-bottom: 5rem;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
        }

        .team-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            transition: transform 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .team-card:hover {
            transform: translateY(-5px);
        }

        .team-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 1.5rem;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
        }

        .team-name {
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
            color: var(--text);
        }

        .team-role {
            color: var(--primary-light);
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .team-bio {
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        /* Values Section */
        .values-section {
            margin-bottom: 5rem;
        }

        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .value-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .value-card:hover {
            transform: translateY(-5px);
        }

        .value-icon {
            font-size: 3rem;
            color: var(--primary-light);
            margin-bottom: 1.5rem;
        }

        .value-title {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--text);
        }

        .value-description {
            color: var(--text-secondary);
            line-height: 1.7;
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

            .about-content {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .team-grid {
                grid-template-columns: 1fr;
            }

            .values-grid {
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
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="deals.jsp">Deals</a></li>
            <li><a href="about.jsp" class="active">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>
    </div>
</header>

<!-- Page Header -->
<section class="page-header">
    <h1 class="page-title">About Melody Mart</h1>
    <p class="page-subtitle">Your trusted partner in the world of music for over 15 years</p>
</section>

<!-- About Content -->
<section class="about-section">
    <div class="about-content">
        <div class="about-text">
            <h2>Our Story</h2>
            <p>Founded in 2008, Melody Mart began as a small music shop with a simple mission: to make quality musical instruments accessible to everyone. What started as a passion project between three music enthusiasts has grown into one of the most trusted names in the music retail industry.</p>
            <p>Over the years, we've expanded our product range to include everything from beginner instruments to professional-grade equipment, always maintaining our commitment to quality, affordability, and exceptional customer service.</p>
            <p>Our team of experienced musicians and technicians carefully selects every product in our inventory, ensuring that we offer only the best instruments and gear to our customers.</p>
            <h2>Our Mission</h2>
            <p>At Melody Mart, we believe that music has the power to transform lives. Our mission is to inspire and enable people of all ages and skill levels to explore their musical potential by providing high-quality instruments, expert guidance, and a supportive community.</p>
            <p>We're more than just a retailer - we're a hub for musicians to connect, learn, and grow together.</p>
        </div>
        <div class="about-image">
            <!-- Placeholder for an image - in a real implementation, this would be an actual image -->
            <div style="width: 100%; height: 100%; background: var(--gradient); display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem; padding: 2rem;">
                <i class="fas fa-music" style="font-size: 4rem; margin-right: 1rem;"></i>
                <div>Melody Mart Store</div>
            </div>
        </div>
    </div>

    <!-- Stats Section -->
    <div class="stats-section">
        <h2 class="section-title">By The Numbers</h2>
        <div class="stats-grid">
            <div class="stat-item">
                <div class="stat-number">15+</div>
                <div class="stat-label">Years in Business</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">10K+</div>
                <div class="stat-label">Happy Customers</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">500+</div>
                <div class="stat-label">Products</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">50+</div>
                <div class="stat-label">Brands</div>
            </div>
        </div>
    </div>

    <!-- Team Section -->
    <div class="team-section">
        <h2 class="section-title">Meet Our Team</h2>
        <div class="team-grid">
            <div class="team-card">
                <div class="team-image">
                    <i class="fas fa-user"></i>
                </div>
                <h3 class="team-name">Sarah Johnson</h3>
                <div class="team-role">Founder & CEO</div>
                <p class="team-bio">Classically trained pianist with over 20 years of experience in the music industry.</p>
            </div>
            <div class="team-card">
                <div class="team-image">
                    <i class="fas fa-user"></i>
                </div>
                <h3 class="team-name">Michael Chen</h3>
                <div class="team-role">Head of Product</div>
                <p class="team-bio">Professional guitarist and music producer with a passion for instrument craftsmanship.</p>
            </div>
            <div class="team-card">
                <div class="team-image">
                    <i class="fas fa-user"></i>
                </div>
                <h3 class="team-name">Elena Rodriguez</h3>
                <div class="team-role">Customer Experience Manager</div>
                <p class="team-bio">Violinist and music educator dedicated to helping customers find their perfect instrument.</p>
            </div>
            <div class="team-card">
                <div class="team-image">
                    <i class="fas fa-user"></i>
                </div>
                <h3 class="team-name">David Wilson</h3>
                <div class="team-role">Technical Director</div>
                <p class="team-bio">Audio engineer and drum specialist with expertise in instrument maintenance and repair.</p>
            </div>
        </div>
    </div>

    <!-- Values Section -->
    <div class="values-section">
        <h2 class="section-title">Our Values</h2>
        <div class="values-grid">
            <div class="value-card">
                <i class="fas fa-gem value-icon"></i>
                <h3 class="value-title">Quality</h3>
                <p class="value-description">We carefully select every instrument in our collection, ensuring they meet our high standards for sound, playability, and durability.</p>
            </div>
            <div class="value-card">
                <i class="fas fa-handshake value-icon"></i>
                <h3 class="value-title">Integrity</h3>
                <p class="value-description">We believe in transparent pricing, honest advice, and building lasting relationships with our customers based on trust.</p>
            </div>
            <div class="value-card">
                <i class="fas fa-heart value-icon"></i>
                <h3 class="value-title">Passion</h3>
                <p class="value-description">Our team consists of passionate musicians who understand the needs of fellow artists and are dedicated to supporting their musical journey.</p>
            </div>
            <div class="value-card">
                <i class="fas fa-users value-icon"></i>
                <h3 class="value-title">Community</h3>
                <p class="value-description">We actively support local music education programs, host workshops, and create spaces for musicians to connect and collaborate.</p>
            </div>
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
    // Simple animation for stats counting
    document.addEventListener('DOMContentLoaded', function() {
        const statNumbers = document.querySelectorAll('.stat-number');

        statNumbers.forEach(stat => {
            const target = parseInt(stat.textContent);
            let current = 0;
            const increment = target / 50;
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    current = target;
                    clearInterval(timer);
                }
                stat.textContent = Math.floor(current) + (stat.textContent.includes('+') ? '+' : '');
            }, 30);
        });
    });
</script>
</body>
</html>