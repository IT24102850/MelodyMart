<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Harmony Instruments | Deals</title>
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

    .deals-section {
      padding: 8rem 5% 5rem;
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

    .deal-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 2rem;
      margin-top: 3rem;
    }

    .deal-card {
      background: var(--dark-card);
      border-radius: 15px;
      overflow: hidden;
      transition: transform 0.5s ease, box-shadow 0.5s ease;
      cursor: pointer;
    }

    .deal-card:hover {
      transform: translateY(-10px) scale(1.03);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.4);
    }

    .deal-image {
      height: 300px;
      width: 100%;
      overflow: hidden;
      background: #000;
    }

    .deal-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      object-position: center;
      transition: transform 0.5s ease;
    }

    .deal-image img:hover {
      transform: scale(1.1);
    }

    .deal-info {
      padding: 1.5rem;
    }

    .deal-info h3 {
      font-size: 1.8rem;
      margin-bottom: 0.5rem;
      color: var(--white);
    }

    .deal-info p {
      color: var(--light-gray);
      margin-bottom: 1rem;
      font-size: 1rem;
    }

    .deal-price {
      display: flex;
      align-items: center;
      gap: 1rem;
      margin-bottom: 1rem;
    }

    .original-price {
      font-size: 1.5rem;
      color: var(--light-gray);
      text-decoration: line-through;
    }

    .discount-price {
      font-size: 2rem;
      font-weight: 700;
      color: var(--golden-yellow);
    }

    .deal-actions {
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

    .pagination {
      display: flex;
      justify-content: center;
      gap: 1rem;
      margin-top: 3rem;
    }

    .pagination a {
      color: var(--light-gray);
      text-decoration: none;
      padding: 0.5rem 1rem;
      border: 1px solid var(--light-gray);
      border-radius: 5px;
      transition: all 0.3s ease;
    }

    .pagination a:hover {
      background: var(--golden-yellow);
      color: var(--dark-bg);
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

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    @media (max-width: 992px) {
      .nav-links { display: none; }
      .deals-section { padding: 6rem 5% 3rem; }
      .deal-grid { grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); }
    }

    @media (max-width: 768px) {
      .section-title { font-size: 2rem; }
      .deal-image { height: 250px; }
      .deal-info h3 { font-size: 1.5rem; }
      .discount-price { font-size: 1.8rem; }
      .original-price { font-size: 1.3rem; }
    }

    @media (max-width: 576px) {
      .section-title { font-size: 1.8rem; }
      .deal-image { height: 200px; }
      .deal-info h3 { font-size: 1.3rem; }
      .deal-info p { font-size: 0.9rem; }
      .discount-price { font-size: 1.5rem; }
      .original-price { font-size: 1.2rem; }
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

<section class="deals-section">
  <h2 class="section-title">Exclusive Deals</h2>
  <div class="deal-grid">
    <div class="deal-card">
      <div class="deal-image">
        <img src="${pageContext.request.contextPath}/images/guitar.jpg" alt="Fender Stratocaster">
      </div>
      <div class="deal-info">
        <h3>Fender Stratocaster</h3>
        <p>Iconic electric guitar with versatile tone, now at a special discount.</p>
        <div class="deal-price">
          <span class="original-price">$1,499</span>
          <span class="discount-price">$1,199</span>
        </div>
        <div class="deal-actions">
          <button class="add-to-cart">Add to Cart</button>
          <button class="details-btn">Details</button>
        </div>
      </div>
    </div>
    <div class="deal-card">
      <div class="deal-image">
        <img src="${pageContext.request.contextPath}/images/saxophone.jpg" alt="Selmer Saxophone">
      </div>
      <div class="deal-info">
        <h3>Selmer Saxophone</h3>
        <p>Professional alto saxophone with rich tone, limited-time offer.</p>
        <div class="deal-price">
          <span class="original-price">$3,450</span>
          <span class="discount-price">$2,999</span>
        </div>
        <div class="deal-actions">
          <button class="add-to-cart">Add to Cart</button>
          <button class="details-btn">Details</button>
        </div>
      </div>
    </div>
    <div class="deal-card">
      <div class="deal-image">
        <img src="${pageContext.request.contextPath}/images/bass.jpg" alt="Fender Jazz Bass">
      </div>
      <div class="deal-info">
        <h3>Fender Jazz Bass</h3>
        <p>Iconic bass guitar with smooth playability, now on sale.</p>
        <div class="deal-price">
          <span class="original-price">$1,350</span>
          <span class="discount-price">$1,099</span>
        </div>
        <div class="deal-actions">
          <button class="add-to-cart">Add to Cart</button>
          <button class="details-btn">Details</button>
        </div>
      </div>
    </div>
    <div class="deal-card">
      <div class="deal-image">
        <img src="${pageContext.request.contextPath}/images/flute.jpg" alt="Yamaha Flute">
      </div>
      <div class="deal-info">
        <h3>Yamaha Flute</h3>
        <p>Professional flute with excellent intonation, special deal.</p>
        <div class="deal-price">
          <span class="original-price">$1,850</span>
          <span class="discount-price">$1,599</span>
        </div>
        <div class="deal-actions">
          <button class="add-to-cart">Add to Cart</button>
          <button class="details-btn">Details</button>
        </div>
      </div>
    </div>
  </div>

  <div class="pagination">
    <a href="#">1</a>
    <a href="#">2</a>
    <a href="#">3</a>
    <a href="#">4</a>
    <a href="#">></a>
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
      <h3>Shop</h3>
      <ul>
        <li><a href="${pageContext.request.contextPath}/products?category=guitars">Guitars</a></li>
        <li><a href="${pageContext.request.contextPath}/products?category=keyboards">Keyboards</a></li>
        <li><a href="${pageContext.request.contextPath}/products?category=drums">Drums</a></li>
        <li><a href="${pageContext.request.contextPath}/products?category=brass">Brass Instruments</a></li>
        <li><a href="${pageContext.request.contextPath}/products?category=woodwinds">Woodwinds</a></li>
      </ul>
    </div>
    <div class="footer-column">
      <h3>Support</h3>
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
</body>
</html>