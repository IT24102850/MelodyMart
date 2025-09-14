<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Harmony Instruments | Premium Brands</title>
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

        .brands-section {
            padding: 2rem 5% 5rem;
        }

        .brands-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .brand-card {
            background: var(--dark-card);
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .brand-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
        }

        .brand-header {
            padding: 2rem;
            text-align: center;
            background: var(--dark-accent);
            position: relative;
        }

        .brand-logo {
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .brand-logo img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }

        .brand-name {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            color: var(--white);
        }

        .founded {
            color: var(--golden-yellow);
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .country {
            display: inline-block;
            background: var(--black-accent);
            color: var(--white);
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.8rem;
        }

        .brand-content {
            padding: 1.5rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .brand-description {
            color: var(--light-gray);
            margin-bottom: 1.5rem;
            line-height: 1.6;
            flex-grow: 1;
        }

        .specialties {
            margin-bottom: 1.5rem;
        }

        .specialties-title {
            font-size: 1rem;
            color: var(--golden-yellow);
            margin-bottom: 0.5rem;
        }

        .specialties-list {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .specialty {
            background: var(--dark-accent);
            color: var(--light-gray);
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.8rem;
        }

        .brand-actions {
            display: flex;
            justify-content: space-between;
            margin-top: auto;
        }

        .explore-btn {
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

        .explore-btn:hover {
            background: #444444;
            transform: scale(1.05);
        }

        .website-btn {
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

        .website-btn:hover {
            background: var(--light-gray);
            color: var(--dark-bg);
            transform: scale(1.05);
        }

        .featured-brands {
            padding: 3rem 5%;
            text-align: center;
        }

        .section-title {
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: var(--white);
            position: relative;
            display: inline-block;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, var(--black-accent), var(--vibrant-orange));
            border-radius: 2px;
        }

        .logos-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 3rem;
            margin-top: 2rem;
        }

        .logo-item {
            background: var(--dark-card);
            padding: 1.5rem;
            border-radius: 15px;
            width: 150px;
            height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .logo-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
        }

        .logo-item img {
            max-width: 100%;
            max-height: 70px;
            filter: brightness(0) invert(1);
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

        .brand-card {
            animation: fadeIn 0.5s ease-out;
        }

        @media (max-width: 1200px) {
            .brands-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 992px) {
            .nav-links {
                display: none;
            }

            .logos-container {
                gap: 2rem;
            }

            .logo-item {
                width: 130px;
                height: 100px;
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2.5rem;
            }

            .brand-card {
                max-width: 100%;
            }

            .brand-actions {
                flex-direction: column;
                gap: 0.5rem;
            }

            .explore-btn, .website-btn {
                margin: 0;
                width: 100%;
            }

            .logos-container {
                gap: 1.5rem;
            }

            .logo-item {
                width: 120px;
                height: 90px;
                padding: 1rem;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 2rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }

            .brand-name {
                font-size: 1.5rem;
            }

            .logos-container {
                gap: 1rem;
            }

            .logo-item {
                width: 100px;
                height: 80px;
            }
        }
    </style>
</head>
<body>
<nav>
    <div class="logo">
        <i class="fas fa-music"></i>
        <span>Harmony Instruments</span>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/instruments.jsp">Instruments</a>
        <a href="${pageContext.request.contextPath}/brands.jsp" class="active">Brands</a>
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
    <h1 class="page-title">World-Class Instrument Brands</h1>
    <p class="page-subtitle">Discover the finest instrument manufacturers from around the world, each with a unique heritage of craftsmanship and innovation.</p>
</section>

<section class="brands-section">
    <div class="brands-grid">
        <!-- Brand 1 -->
        <div class="brand-card">
            <div class="brand-header">
                <div class="brand-logo">
                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCAxMDAgNDAiPjxwYXRoIGZpbGw9IiNmZmQ3MDAiIGQ9Ik0zMCAxMGg0MHYyMEgzMHpNMTAgMjVoMTB2NUgxMHoiLz48L3N2Zz4=" alt="Fender">
                </div>
                <h2 class="brand-name">Fender</h2>
                <div class="founded">Est. 1946</div>
                <span class="country">United States</span>
            </div>
            <div class="brand-content">
                <p class="brand-description">Fender Musical Instruments Corporation is the world's foremost manufacturer of guitars, basses, amplifiers and related equipment.</p>
                <div class="specialties">
                    <div class="specialties-title">Specializes in:</div>
                    <div class="specialties-list">
                        <span class="specialty">Guitars</span>
                        <span class="specialty">Basses</span>
                        <span class="specialty">Amplifiers</span>
                    </div>
                </div>
                <div class="brand-actions">
                    <button class="explore-btn">Explore Products</button>
                    <button class="website-btn">Website</button>
                </div>
            </div>
        </div>

        <!-- Brand 2 -->
        <div class="brand-card">
            <div class="brand-header">
                <div class="brand-logo">
                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCAxMDAgNDAiPjxwYXRoIGZpbGw9IiNmZmQ3MDAiIGQ9Ik0yMCAxMGg2MHY1SDIwdjEwaDYwdi01SDIweiIvPjwvc3ZnPg==" alt="Yamaha">
                </div>
                <h2 class="brand-name">Yamaha</h2>
                <div class="founded">Est. 1887</div>
                <span class="country">Japan</span>
            </div>
            <div class="brand-content">
                <p class="brand-description">Yamaha Corporation is a Japanese multinational corporation and conglomerate with a wide range of products and services, predominantly musical instruments.</p>
                <div class="specialties">
                    <div class="specialties-title">Specializes in:</div>
                    <div class="specialties-list">
                        <span class="specialty">Pianos</span>
                        <span class="specialty">Keyboards</span>
                        <span class="specialty">Wind Instruments</span>
                        <span class="specialty">Drums</span>
                    </div>
                </div>
                <div class="brand-actions">
                    <button class="explore-btn">Explore Products</button>
                    <button class="website-btn">Website</button>
                </div>
            </div>
        </div>

        <!-- Brand 3 -->
        <div class="brand-card">
            <div class="brand-header">
                <div class="brand-logo">
                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCAxMDAgNDAiPjxjaXJjbGUgY3g9IjUwIiBjeT0iMjAiIHI9IjE1IiBmaWxsPSIjZmZkNzAwIi8+PC9zdmc+" alt="Gibson">
                </div>
                <h2 class="brand-name">Gibson</h2>
                <div class="founded">Est. 1902</div>
                <span class="country">United States</span>
            </div>
            <div class="brand-content">
                <p class="brand-description">Gibson Brands, Inc. is an American manufacturer of guitars and other instruments, now based in Nashville, Tennessee.</p>
                <div class="specialties">
                    <div class="specialties-title">Specializes in:</div>
                    <div class="specialties-list">
                        <span class="specialty">Electric Guitars</span>
                        <span class="specialty">Acoustic Guitars</span>
                        <span class="specialty">Basses</span>
                    </div>
                </div>
                <div class="brand-actions">
                    <button class="explore-btn">Explore Products</button>
                    <button class="website-btn">Website</button>
                </div>
            </div>
        </div>

        <!-- Brand 4 -->
        <div class="brand-card">
            <div class="brand-header">
                <div class="brand-logo">
                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCAxMDAgNDAiPjxwYXRoIGZpbGw9IiNmZmQ3MDAiIGQ9Ik0xNSA1aDcydjMwSDE1em0zMCAxMmgxMHY2SDQ1eiIvPjwvc3ZnPg==" alt="Roland">
                </div>
                <h2 class="brand-name">Roland</h2>
                <div class="founded">Est. 1972</div>
                <span class="country">Japan</span>
            </div>
            <div class="brand-content">
                <p class="brand-description">Roland Corporation is a Japanese manufacturer of electronic musical instruments, electronic equipment and software.</p>
                <div class="specialties">
                    <div class="specialties-title">Specializes in:</div>
                    <div class="specialties-list">
                        <span class="specialty">Synthesizers</span>
                        <span class="specialty">Drum Machines</span>
                        <span class="specialty">Audio Interfaces</span>
                    </div>
                </div>
                <div class="brand-actions">
                    <button class="explore-btn">Explore Products</button>
                    <button class="website-btn">Website</button>
                </div>
            </div>
        </div>

        <!-- Brand 5 -->
        <div class="brand-card">
            <div class="brand-header">
                <div class="brand-logo">
                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCAxMDAgNDAiPjxwYXRoIGZpbGw9IiNmZmQ3MDAiIGQ9Ik0yMCA1aDYwdjE1SDIwdjE1aDYwVjV6Ii8+PC9zdmc+" alt="Shure">
                </div>
                <h2 class="brand-name">Shure</h2>
                <div class="founded">Est. 1925</div>
                <span class="country">United States</span>
            </div>
            <div class="brand-content">
                <p class="brand-description">Shure Incorporated is an American audio products corporation. It manufactures microphones, wireless microphone systems, in-ear monitors, and other audio electronics.</p>
                <div class="specialties">
                    <div class="specialties-title">Specializes in:</div>
                    <div class="specialties-list">
                        <span class="specialty">Microphones</span>
                        <span class="specialty">Audio Electronics</span>
                        <span class="specialty">Wireless Systems</span>
                    </div>
                </div>
                <div class="brand-actions">
                    <button class="explore-btn">Explore Products</button>
                    <button class="website-btn">Website</button>
                </div>
            </div>
        </div>

        <!-- Brand 6 -->
        <div class="brand-card">
            <div class="brand-header">
                <div class="brand-logo">
                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCAxMDAgNDAiPjxwYXRoIGZpbGw9IiNmZmQ3MDAiIGQ9Ik0xMCAxMGg4MHY1SDEwdjEwaDgwdi01SDEweiIvPjwvc3ZnPg==" alt="Pearl">
                </div>
                <h2 class="brand-name">Pearl</h2>
                <div class="founded">Est. 1946</div>
                <span class="country">Japan</span>
            </div>
            <div class="brand-content">
                <p class="brand-description">Pearl Musical Instrument Company is a multinational corporation based in Japan which manufactures drums, percussion instruments and flute.</p>
                <div class="specialties">
                    <div class="specialties-title">Specializes in:</div>
                    <div class="specialties-list">
                        <span class="specialty">Drum Kits</span>
                        <span class="specialty">Percussion</span>
                        <span class="specialty">Hardware</span>
                    </div>
                </div>
                <div class="brand-actions">
                    <button class="explore-btn">Explore Products</button>
                    <button class="website-btn">Website</button>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="featured-brands">
    <h2 class="section-title">Featured Brands</h2>
    <div class="logos-container">
        <div class="logo-item">
            <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI4MCIgaGVpZ2h0PSI0MCIgdmlld0JveD0iMCAwIDgwIDQwIj48cGF0aCBmaWxsPSIjZmZmIiBkPSJNMzAgMTBoMjB2NUgzMHYxMGgyMHYtNUgzMHoiLz48L3N2Zz4=" alt="Brand 1">
        </div>
        <div class="logo-item">
            <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI4MCIgaGVpZ2h0PSI0MCIgdmlld0JveD0iMCAwIDgwIDQwIj48Y2lyY2xlIGN4PSI0MCIgY3k9IjIwIiByPSIxNSIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==" alt="Brand 2">
        </div>
        <div class="logo-item">
            <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI4MCIgaGVpZ2h0PSI0MCIgdmlld0JveD0iMCAwIDgwIDQwIj48cGF0aCBmaWxsPSIjZmZmIiBkPSJNMTUgMTVoNTB2MTBIMTV6Ii8+PC9zdmc+" alt="Brand 3">
        </div>
        <div class="logo-item">
            <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI4MCIgaGVpZ2h0PSI0MCIgdmlld0JveD0iMCAwIDgwIDQwIj48cGF0aCBmaWxsPSIjZmZmIiBkPSJNMjAgMTVoNDB2MTBIMjB6Ii8+PC9zdmc+" alt="Brand 4">
        </div>
        <div class="logo-item">
            <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI4MCIgaGVpZ2h0PSI0MCIgdmlld0JveD0iMCAwIDgwIDQwIj48cGF0aCBmaWxsPSIjZmZmIiBkPSJNMjUgMTVoMzB2MTBIMjV6Ii8+PC9zdmc+" alt="Brand 5">
        </div>
    </div>
</section>

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
    // Animation for brand cards
    const brandCards = document.querySelectorAll('.brand-card');
    brandCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });

    // Button hover effects
    const buttons = document.querySelectorAll('button');
    buttons.forEach(button => {
        button.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.05)';
        });

        button.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
        });
    });
</script>
</body>
</html>