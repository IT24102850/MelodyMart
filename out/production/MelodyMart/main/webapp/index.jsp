<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Harmony Instruments | Premium Musical Experience</title>
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

        .hero {
            height: 100vh;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 5%;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            max-width: 40%;
            text-align: left;
            z-index: 1;
        }

        .hero h1 {
            font-size: 4rem;
            margin-bottom: 1rem;
            background: linear-gradient(90deg, var(--black-accent), var(--vibrant-orange));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: slideInLeft 1.2s ease-out;
        }

        .hero p {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            color: var(--light-gray);
            max-width: 600px;
            animation: slideInLeft 1.2s ease-out 0.2s forwards;
            opacity: 0;
        }

        .cta-button {
            background: linear-gradient(90deg, var(--black-accent), var(--vibrant-orange));
            color: var(--white);
            border: none;
            padding: 1rem 2.5rem;
            font-size: 1.2rem;
            font-weight: 600;
            border-radius: 50px;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: slideInLeft 1.2s ease-out 0.4s forwards;
            opacity: 0;
        }

        .cta-button:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.4);
        }

        .hero-instrument {
            width: 50%;
            height: 600px;
            position: relative;
        }

        .instrument-slider {
            width: 100%;
            height: 100%;
            overflow: hidden;
            position: relative;
        }

        .instrument-slides {
            display: flex;
            height: 100%;
            transition: transform 1s ease-in-out;
        }

        .slide {
            flex: 0 0 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .instrument-card {
            background: var(--dark-card);
            border-radius: 15px;
            overflow: hidden;
            width: 500px;
            height: 550px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            transition: transform 0.5s ease, box-shadow 0.5s ease;
        }

        .instrument-card:hover {
            transform: rotateY(5deg);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
        }

        .instrument-image {
            height: 400px;
            width: 100%;
            overflow: hidden;
            background: #000;
        }

        .instrument-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
            transition: transform 0.5s ease;
        }

        .instrument-image img:hover {
            transform: scale(1.1);
        }

        .instrument-info {
            padding: 1.5rem;
        }

        .instrument-info h3 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            color: var(--white);
        }

        .instrument-info p {
            color: var(--light-gray);
            margin-bottom: 1rem;
            font-size: 1rem;
        }

        .instrument-price {
            font-size: 2rem;
            font-weight: 700;
            color: var(--golden-yellow);
            margin-bottom: 1rem;
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
        }

        .details-btn:hover {
            background: var(--light-gray);
            color: var(--dark-bg);
            transform: scale(1.05);
        }

        .slider-controls {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 10px;
        }

        .slider-dot {
            width: 12px;
            height: 12px;
            background: var(--light-gray);
            border-radius: 50%;
            cursor: pointer;
            opacity: 0.5;
            transition: opacity 0.3s ease, background 0.3s ease;
        }

        .slider-dot.active {
            opacity: 1;
            background: var(--golden-yellow);
        }

        .categories {
            padding: 5rem 5%;
            background: var(--dark-bg);
        }

        .section-title {
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: var(--white);
            position: relative;
            display: inline-block;
            animation: fadeIn 1s ease-out;
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

        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .category-card {
            background: var(--dark-card);
            border-radius: 15px;
            overflow: hidden;
            text-align: center;
            padding: 2rem;
            transition: transform 0.5s ease, box-shadow 0.5s ease;
            cursor: pointer;
        }

        .category-card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.4);
        }

        .category-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--golden-yellow);
            animation: iconPulse 2s ease-in-out infinite;
        }

        .category-card h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--white);
        }

        .category-card p {
            color: var(--light-gray);
            font-size: 0.9rem;
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

        .debug-message {
            position: fixed;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(255, 0, 0, 0.8);
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            display: none;
            z-index: 1001;
            max-width: 80%;
            text-align: center;
            word-wrap: break-word;
        }

        @keyframes slideInLeft {
            from { opacity: 0; transform: translateX(-50px); }
            to { opacity: 1; transform: translateX(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes iconPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.2); }
        }

        @media (max-width: 1200px) {
            .hero-content { max-width: 50%; }
            .hero-instrument { width: 45%; }
            .instrument-card { width: 400px; height: 500px; }
            .instrument-image { height: 350px; }
        }

        @media (max-width: 992px) {
            .hero { flex-direction: column; justify-content: center; }
            .hero-content { max-width: 80%; text-align: center; }
            .hero-instrument { width: 80%; height: 500px; margin-top: 2rem; }
            .nav-links { display: none; }
        }

        @media (max-width: 768px) {
            .hero h1 { font-size: 2.5rem; }
            .hero p { font-size: 1.2rem; }
            .instrument-card { width: 100%; height: 450px; }
            .instrument-image { height: 300px; }
        }

        @media (max-width: 576px) {
            .hero h1 { font-size: 2rem; }
            .hero p { font-size: 1rem; }
            .cta-button { padding: 0.8rem 1.8rem; font-size: 1rem; }
            .section-title { font-size: 2rem; }
            .hero-instrument { height: 400px; }
            .instrument-card { height: 350px; }
            .instrument-image { height: 200px; }
            .instrument-info h3 { font-size: 1.5rem; }
            .instrument-price { font-size: 1.5rem; }
        }
    </style>
</head>
<body>
<div id="debugMessage" class="debug-message"></div>

<nav>
    <div class="logo">
        <i class="fas fa-music"></i>
        <span>Melody Mart</span>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/instruments.jsp">Instruments</a>
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

<c:if test="${not empty sessionScope.user}">
    <p class="text-center mt-4">Welcome, <c:out value="${sessionScope.user.fullName}"/>!</p>
</c:if>

<section class="hero">
    <div class="hero-content">
        <h1>Unleash Your Musical Soul</h1>
        <p>Premium instruments for passionate musicians. Experience the perfect harmony of quality and craftsmanship.</p>
        <button class="cta-button">Explore Instruments</button>
    </div>
    <div class="hero-instrument">
        <div class="instrument-slider">
            <div class="instrument-slides">
                <div class="slide">
                    <div class="instrument-card">
                        <div class="instrument-image">
                            <img src="${pageContext.request.contextPath}/images/digitalkeyboard2.jpg" alt="Fender Stratocaster">
                        </div>
                        <div class="instrument-info">
                            <h3>Fender Stratocaster</h3>
                            <p>The iconic electric guitar loved by professionals worldwide for its versatile tone and comfortable playability.</p>


                        </div>
                    </div>
                </div>
                <div class="slide">
                    <div class="instrument-card">
                        <div class="instrument-image">
                            <img src="${pageContext.request.contextPath}/images/piano.jpg" alt="Yamaha Grand Piano">
                        </div>
                        <div class="instrument-info">
                            <h3>Yamaha Grand Piano</h3>
                            <p>Experience the rich, resonant sound of this expertly crafted grand piano, perfect for concert halls and home studios.</p>
                            <div class="instrument-price">$12,999</div>
                            <div class="instrument-actions">
                                <button class="add-to-cart">Add to Cart</button>
                                <button class="details-btn">Details</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="slide">
                    <div class="instrument-card">
                        <div class="instrument-image">
                            <img src="${pageContext.request.contextPath}/images/drums.jpg" alt="Pearl Drum Set">
                        </div>
                        <div class="instrument-info">
                            <h3>Pearl Drum Set</h3>
                            <p>A professional drum kit with exceptional sound quality and durability, designed for the serious drummer.</p>
                            <div class="instrument-price">$2,799</div>
                            <div class="instrument-actions">
                                <button class="add-to-cart">Add to Cart</button>
                                <button class="details-btn">Details</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="slider-controls">
                <div class="slider-dot active" data-slide="0"></div>
                <div class="slider-dot" data-slide="1"></div>
                <div class="slider-dot" data-slide="2"></div>
            </div>
        </div>
    </div>
</section>

<section class="categories">
    <h2 class="section-title">Shop By Category</h2>
    <div class="category-grid">
        <div class="category-card">
            <div class="category-icon">
                <i class="fas fa-guitar"></i>
            </div>
            <h3>String Instruments</h3>
            <p>Guitars, Violins, Bass, and more</p>
        </div>
        <div class="category-card">
            <div class="category-icon">
                <i class="fas fa-drum"></i>
            </div>
            <h3>Percussion</h3>
            <p>Drums, Cymbals, Percussion sets</p>
        </div>
        <div class="category-card">
            <div class="category-icon">
                <i class="fas fa-wind"></i>
            </div>
            <h3>Wind Instruments</h3>
            <p>Saxophones, Flutes, Trumpets</p>
        </div>
        <div class="category-card">
            <div class="category-icon">
                <i class="fas fa-sliders-h"></i>
            </div>
            <h3>Electronic</h3>
            <p>Synthesizers, Digital Pianos, Audio Interfaces</p>
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
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
        <div class="footer-column">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                <li><a href="${pageContext.request.contextPath}/brands">Brands</a></li>
                <li><a href="${pageContext.request.contextPath}/deals">Deals</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
            </ul>
        </div>
        <div class="footer-column">
            <h3>Customer Service</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                <li><a href="${pageContext.request.contextPath}/shipping">Shipping & Returns</a></li>
                <li><a href="${pageContext.request.contextPath}/faq">FAQ</a></li>
                <li><a href="${pageContext.request.contextPath}/warranty">Warranty</a></li>
                <li><a href="${pageContext.request.contextPath}/repairs">Repair Services</a></li>
            </ul>
        </div>
        <div class="footer-column">
            <h3>Newsletter</h3>
            <p>Subscribe to get special offers, free giveaways, and new product notifications.</p>
            <form action="${pageContext.request.contextPath}/subscribe" method="post">
                <input type="email" name="email" placeholder="Your email address" style="padding: 10px; width: 100%; margin-bottom: 10px; border-radius: 5px; border: none;">
                <button type="submit" style="background: var(--black-accent); color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; width: 100%;">Subscribe</button>
            </form>
        </div>
    </div>
    <div class="copyright">
        <p>&copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> Harmony Instruments. All rights reserved.</p>
    </div>
</footer>

<script>
    // Initialize slider
    document.addEventListener('DOMContentLoaded', () => {
        const slidesContainer = document.querySelector('.instrument-slides');
        const dots = document.querySelectorAll('.slider-dot');
        const debugMessage = document.getElementById('debugMessage');
        let currentSlide = 0;
        let slideInterval;

        if (!slidesContainer || !dots.length) {
            console.error('Slider initialization failed: Missing slides container or dots.');
            debugMessage.style.display = 'block';
            debugMessage.innerText = 'Slider initialization failed. Check console.';
            return;
        }

        // Calculate total slides dynamically
        const totalSlides = document.querySelectorAll('.slide').length;

        // Function to update slide and dot
        function updateSlide(index) {
            try {
                currentSlide = index;
                slidesContainer.style.transform = `translateX(-${currentSlide * 100}%)`;
                dots.forEach(dot => dot.classList.remove('active'));
                dots[currentSlide].classList.add('active');
            } catch (e) {
                console.error(`Slider error: ${e.message}`);
                debugMessage.style.display = 'block';
                debugMessage.innerText = 'Slider error. Check console.';
            }
        }

        // Automatic slide transition
        function startSlider() {
            slideInterval = setInterval(() => {
                currentSlide = (currentSlide + 1) % totalSlides;
                updateSlide(currentSlide);
            }, 5000); // Change slide every 5 seconds
        }

        // Manual slide navigation
        dots.forEach(dot => {
            dot.addEventListener('click', () => {
                clearInterval(slideInterval); // Pause auto-slide on manual click
                updateSlide(parseInt(dot.dataset.slide));
                startSlider(); // Restart auto-slide
            });
        });

        // Pause slider on hover
        slidesContainer.addEventListener('mouseenter', () => clearInterval(slideInterval));
        slidesContainer.addEventListener('mouseleave', startSlider);

        // Start the slider
        startSlider();
    });
</script>
</body>
</html>