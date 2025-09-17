<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Harmony Instruments | Special Deals</title>
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
      --sale-red: #ff4757;
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
      background: linear-gradient(to right, rgba(255, 107, 53, 0.2), rgba(255, 215, 0, 0.2));
      border-radius: 0 0 20px 20px;
    }

    .page-title {
      font-size: 3.5rem;
      margin-bottom: 1rem;
      background: linear-gradient(90deg, var(--golden-yellow), var(--vibrant-orange));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .page-subtitle {
      font-size: 1.2rem;
      color: var(--light-gray);
      max-width: 700px;
      margin: 0 auto 2rem;
    }

    .countdown {
      background: var(--dark-card);
      display: inline-block;
      padding: 1rem 2rem;
      border-radius: 50px;
      margin-top: 1rem;
    }

    .countdown-text {
      color: var(--golden-yellow);
      margin-right: 1rem;
      font-weight: 600;
    }

    .countdown-timer {
      font-size: 1.5rem;
      font-weight: 700;
    }

    .deals-section {
      padding: 2rem 5% 5rem;
    }

    .section-title {
      font-size: 2.5rem;
      margin-bottom: 3rem;
      color: var(--white);
      position: relative;
      display: inline-block;
      padding-left: 1rem;
      border-left: 4px solid var(--vibrant-orange);
    }

    .deals-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 2rem;
    }

    .deal-card {
      background: var(--dark-card);
      border-radius: 15px;
      overflow: hidden;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
      position: relative;
    }

    .deal-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
    }

    .deal-badge {
      position: absolute;
      top: 1rem;
      left: 1rem;
      background: var(--sale-red);
      color: var(--white);
      padding: 0.5rem 1rem;
      border-radius: 50px;
      font-size: 0.9rem;
      font-weight: 700;
      z-index: 2;
    }

    .deal-badge.hot {
      background: linear-gradient(90deg, var(--vibrant-orange), var(--golden-yellow));
    }

    .deal-badge.new {
      background: var(--golden-yellow);
      color: var(--dark-bg);
    }

    .deal-image {
      height: 200px;
      width: 100%;
      overflow: hidden;
      background: #000;
      position: relative;
    }

    .deal-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      object-position: center;
      transition: transform 0.5s ease;
    }

    .deal-card:hover .deal-image img {
      transform: scale(1.1);
    }

    .deal-content {
      padding: 1.5rem;
    }

    .deal-title {
      font-size: 1.5rem;
      margin-bottom: 0.5rem;
      color: var(--white);
    }

    .deal-description {
      color: var(--light-gray);
      margin-bottom: 1rem;
      line-height: 1.5;
    }

    .deal-pricing {
      display: flex;
      align-items: center;
      margin-bottom: 1.5rem;
    }

    .deal-price {
      font-size: 1.8rem;
      font-weight: 700;
      color: var(--golden-yellow);
    }

    .original-price {
      font-size: 1.2rem;
      text-decoration: line-through;
      color: var(--light-gray);
      margin-left: 1rem;
    }

    .discount {
      background: var(--sale-red);
      color: var(--white);
      padding: 0.3rem 0.8rem;
      border-radius: 50px;
      font-size: 0.9rem;
      font-weight: 600;
      margin-left: auto;
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

    .featured-deal {
      background: linear-gradient(to right, var(--dark-card), var(--dark-accent));
      border-radius: 15px;
      overflow: hidden;
      margin: 4rem 0;
      display: flex;
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
    }

    .featured-image {
      flex: 1;
      min-height: 300px;
      overflow: hidden;
    }

    .featured-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .featured-content {
      flex: 1;
      padding: 2rem;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    .featured-badge {
      background: linear-gradient(90deg, var(--vibrant-orange), var(--golden-yellow));
      color: var(--white);
      padding: 0.5rem 1rem;
      border-radius: 50px;
      font-size: 0.9rem;
      font-weight: 700;
      display: inline-block;
      margin-bottom: 1rem;
    }

    .featured-title {
      font-size: 2.2rem;
      margin-bottom: 1rem;
      color: var(--white);
    }

    .featured-description {
      color: var(--light-gray);
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
      color: var(--golden-yellow);
    }

    .featured-original {
      font-size: 1.5rem;
      text-decoration: line-through;
      color: var(--light-gray);
      margin-left: 1rem;
    }

    .featured-discount {
      background: var(--sale-red);
      color: var(--white);
      padding: 0.5rem 1rem;
      border-radius: 50px;
      font-size: 1.1rem;
      font-weight: 600;
      margin-left: auto;
    }

    .newsletter-section {
      background: var(--dark-accent);
      padding: 4rem 5%;
      text-align: center;
      border-radius: 15px;
      margin: 4rem 5%;
    }

    .newsletter-title {
      font-size: 2.2rem;
      margin-bottom: 1rem;
      color: var(--white);
    }

    .newsletter-text {
      color: var(--light-gray);
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
      background: var(--dark-card);
      border: none;
      padding: 1rem 1.5rem;
      border-radius: 50px 0 0 50px;
      color: var(--white);
      outline: none;
    }

    .newsletter-btn {
      background: linear-gradient(90deg, var(--black-accent), var(--vibrant-orange));
      color: var(--white);
      border: none;
      padding: 1rem 1.5rem;
      border-radius: 0 50px 50px 0;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .newsletter-btn:hover {
      background: linear-gradient(90deg, var(--vibrant-orange), var(--golden-yellow));
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

    .deal-card {
      animation: fadeIn 0.5s ease-out;
    }

    @keyframes pulse {
      0% { transform: scale(1); }
      50% { transform: scale(1.05); }
      100% { transform: scale(1); }
    }

    .pulse {
      animation: pulse 2s infinite;
    }

    @media (max-width: 1200px) {
      .deals-grid {
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
      }
    }

    @media (max-width: 992px) {
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
        font-size: 2.5rem;
      }

      .deal-card {
        max-width: 100%;
      }

      .deal-actions {
        flex-direction: column;
        gap: 0.5rem;
      }

      .add-to-cart, .details-btn {
        margin: 0;
        width: 100%;
      }

      .newsletter-form {
        flex-direction: column;
      }

      .newsletter-input {
        border-radius: 50px;
        margin-bottom: 1rem;
      }

      .newsletter-btn {
        border-radius: 50px;
      }
    }

    @media (max-width: 576px) {
      .page-title {
        font-size: 2rem;
      }

      .page-subtitle {
        font-size: 1rem;
      }

      .deal-title {
        font-size: 1.3rem;
      }

      .deal-price {
        font-size: 1.5rem;
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
<nav>
  <div class="logo">
    <i class="fas fa-music"></i>
    <span>Harmony Instruments</span>
  </div>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/">Home</a>
    <a href="${pageContext.request.contextPath}/instruments.jsp">Instruments</a>
    <a href="${pageContext.request.contextPath}/brands.jsp">Brands</a>
    <a href="${pageContext.request.contextPath}/deals.jsp" class="active">Deals</a>
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
        <img src="${pageContext.request.contextPath}/images/guitar.jpg" alt="Fender Stratocaster">
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
        <img src="${pageContext.request.contextPath}/images/keyboard.jpg" alt="Yamaha Keyboard">
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
        <img src="${pageContext.request.contextPath}/images/drums.jpg" alt="Drum Set">
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
        <img src="${pageContext.request.contextPath}/images/saxophone.jpg" alt="Saxophone">
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
        <img src="${pageContext.request.contextPath}/images/violin.jpg" alt="Violin">
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
        <img src="${pageContext.request.contextPath}/images/amp.jpg" alt="Guitar Amplifier">
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
    <img src="${pageContext.request.contextPath}/images/piano.jpg" alt="Grand Piano">
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
      <h3>About</h3>
      <ul>
        <li><a href="#">Our Story</a></li>
        <li><a href="#">Store Locations</a></li>
        <li><a href="#">Careers</a></li>
        <li><a href="#">Privacy Policy</a></li>
        <li><a href="#">Terms of Service</a></li>
      </ul>
    </div>
  </div>

  <div class="copyright">
    <p>&copy; 2023 Harmony Instruments. All rights reserved.</p>
  </div>
</footer>

<script>
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

  // Animation for deal cards
  const dealCards = document.querySelectorAll('.deal-card');
  dealCards.forEach((card, index) => {
    card.style.animationDelay = `${index * 0.1}s`;
  });

  // Add to cart animation
  const addToCartBtns = document.querySelectorAll('.add-to-cart');
  addToCartBtns.forEach(btn => {
    btn.addEventListener('click', function() {
      const originalText = this.textContent;
      this.innerHTML = '<i class="fas fa-check"></i> Added to Cart';
      this.style.background = 'var(--vibrant-orange)';

      setTimeout(() => {
        this.textContent = originalText;
        this.style.background = '';
      }, 2000);
    });
  });
</script>
</body>
</html>