<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart - Elevate Your Sound Experience</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;800&family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --card-hover: #2a2a2a;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
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
            line-height: 1.6;
            overflow-x: hidden;
        }

        .navbar {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--glass-border);
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
        }

        .navbar-nav .nav-link {
            color: var(--text);
            font-weight: 500;
            margin-left: 1.5rem;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: var(--primary-light);
        }

        .search-bar {
            max-width: 300px;
            margin-left: 1rem;
        }

        .btn-primary {
            background: var(--gradient);
            border: none;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--accent), var(--primary));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
        }

        .hero {
            height: 100vh;
            background: url('https://via.placeholder.com/1920x1080?text=Hero+Image') no-repeat center center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            color: var(--text);
        }

        .hero-content h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            animation: fadeIn 1s ease-in;
        }

        .hero-content p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            color: var(--text-secondary);
        }

        .card {
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
        }

        .card-img-top {
            height: 200px;
            object-fit: cover;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .card-text {
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .btn-outline-secondary {
            border-color: var(--primary-light);
            color: var(--primary-light);
        }

        .btn-outline-secondary:hover {
            background: rgba(138, 43, 226, 0.1);
            color: var(--primary-light);
        }

        .accordion-button {
            background: var(--card-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
        }

        .accordion-button:not(.collapsed) {
            background: var(--glass-bg);
            color: var(--primary-light);
        }

        .testimonial {
            background: var(--glass-bg);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }

        .testimonial .rating {
            color: #ffc107;
            margin-top: 0.5rem;
        }

        .contact-form {
            background: var(--card-bg);
            padding: 2rem;
            border-radius: 15px;
            border: 1px solid var(--glass-border);
        }

        .form-check-label {
            color: var(--text);
        }

        .footer {
            background: var(--glass-bg);
            padding: 2rem 0;
            border-top: 1px solid var(--glass-border);
        }

        .footer a {
            color: var(--text-secondary);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: var(--primary-light);
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @media (max-width: 992px) {
            .navbar-nav {
                background: var(--card-bg);
                padding: 1rem;
                border-radius: 10px;
                margin-top: 1rem;
            }

            .hero-content h1 {
                font-size: 2.5rem;
            }

            .hero-content p {
                font-size: 1rem;
            }

            .card {
                margin-bottom: 1.5rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Melody Mart</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#shop">Shop</a></li>
                <li class="nav-item"><a class="nav-link" href="#categories">Categories</a></li>
                <li class="nav-item"><a class="nav-link" href="#brands">Brands</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
            </ul>
            <form class="d-flex search-bar">
                <input class="form-control me-2" type="search" placeholder="Search instruments..." aria-label="Search">
                <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
            </form>
            <div class="d-flex ms-3">
                <a href="sign-in.jsp" class="btn btn-outline-secondary me-2">Sign In</a>
                <a href="sign-up.jsp" class="btn btn-primary">Sign Up</a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section id="home" class="hero">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1>Elevate Your Sound Experience</h1>
        <p>Discover the world's finest musical instruments crafted for professionals and enthusiasts alike.</p>
        <a href="#shop" class="btn btn-primary btn-lg">Explore Collection</a>
        <a href="#about" class="btn btn-outline-secondary btn-lg ms-3">Learn More</a>
    </div>
</section>

<!-- Featured Categories -->
<section id="categories" class="py-5">
    <div class="container">
        <h2 class="text-center mb-4" style="font-family: 'Playfair Display', serif; font-size: 2rem; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Featured Categories</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100">
                    <img src="https://via.placeholder.com/300x200?text=Guitars" class="card-img-top" alt="Guitars">
                    <div class="card-body text-center">
                        <h5 class="card-title">Premium Guitars</h5>
                        <p class="card-text">From classics to modern electrics.</p>
                        <a href="#shop" class="btn btn-outline-secondary">View Guitars</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100">
                    <img src="https://via.placeholder.com/300x200?text=Drums" class="card-img-top" alt="Drums">
                    <div class="card-body text-center">
                        <h5 class="card-title">Drums & Percussion</h5>
                        <p class="card-text">Perfect for studio and stage.</p>
                        <a href="#shop" class="btn btn-outline-secondary">Explore Drums</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100">
                    <img src="https://via.placeholder.com/300x200?text=Pianos" class="card-img-top" alt="Pianos">
                    <div class="card-body text-center">
                        <h5 class="card-title">Pianos & Keyboards</h5>
                        <p class="card-text">Inspire your creativity.</p>
                        <a href="#shop" class="btn btn-outline-secondary">View Pianos</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Why Choose Melody Mart -->
<section id="about" class="py-5 bg-dark">
    <div class="container">
        <h2 class="text-center mb-4" style="font-family: 'Playfair Display', serif; font-size: 2rem; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Why Choose Melody Mart</h2>
        <div class="accordion" id="whyChooseAccordion">
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        Premium Quality
                    </button>
                </h2>
                <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#whyChooseAccordion">
                    <div class="accordion-body">Hand-selected instruments from top brands for exceptional performance.</div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        Expert Support
                    </button>
                </h2>
                <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#whyChooseAccordion">
                    <div class="accordion-body">Dedicated team for personalized advice and after-sales service.</div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        Fast Shipping
                    </button>
                </h2>
                <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#whyChooseAccordion">
                    <div class="accordion-body">Worldwide delivery with secure packaging for your instruments.</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Featured Instruments -->
<section id="shop" class="py-5">
    <div class="container">
        <h2 class="text-center mb-4" style="font-family: 'Playfair Display', serif; font-size: 2rem; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Featured Instruments</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100">
                    <img src="https://via.placeholder.com/300x200?text=Electric+Guitar" class="card-img-top" alt="Electric Guitar">
                    <div class="card-body text-center">
                        <h5 class="card-title">Professional Electric Guitar</h5>
                        <p class="card-text">$1,299.99</p>
                        <p class="card-text">Premium crafted guitar with exceptional tone.</p>
                        <button class="btn btn-primary" onclick="addToCart(1)">Add to Cart</button>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100">
                    <img src="https://via.placeholder.com/300x200?text=Drum+Set" class="card-img-top" alt="Drum Set">
                    <div class="card-body text-center">
                        <h5 class="card-title">Premium Drum Set</h5>
                        <p class="card-text">$2,499.99</p>
                        <p class="card-text">7-piece kit for studio and stage.</p>
                        <button class="btn btn-primary" onclick="addToCart(2)">Add to Cart</button>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100">
                    <img src="https://via.placeholder.com/300x200?text=Digital+Piano" class="card-img-top" alt="Digital Piano">
                    <div class="card-body text-center">
                        <h5 class="card-title">Digital Grand Piano</h5>
                        <p class="card-text">$3,799.99</p>
                        <p class="card-text">Concert-grade with weighted keys.</p>
                        <button class="btn btn-primary" onclick="addToCart(3)">Add to Cart</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials -->
<section id="testimonials" class="py-5">
    <div class="container">
        <h2 class="text-center mb-4" style="font-family: 'Playfair Display', serif; font-size: 2rem; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">What Our Customers Say</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="testimonial">
                    <p>"The quality of instruments at Melody Mart is unmatched. My new guitar sounds incredible."</p>
                    <p class="fw-bold">Alex Johnson</p>
                    <p class="rating"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="testimonial">
                    <p>"Excellent customer service and a fantastic selection. The piano exceeded my expectations."</p>
                    <p class="fw-bold">Sarah Lee</p>
                    <p class="rating"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i></p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="testimonial">
                    <p>"Fast shipping and great prices. My go-to for all drumming needs."</p>
                    <p class="fw-bold">Mike Rodriguez</p>
                    <p class="rating"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Newsletter -->
<section id="newsletter" class="py-5 bg-dark">
    <div class="container text-center">
        <h2 class="mb-4" style="font-family: 'Playfair Display', serif; font-size: 2rem; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Stay in Tune with Melody Mart</h2>
        <p class="mb-3">Subscribe to our newsletter for exclusive offers, new arrivals, and expert tips.</p>
        <form class="d-flex justify-content-center">
            <input type="email" class="form-control me-2" placeholder="Enter your email" required>
            <button type="submit" class="btn btn-primary">Subscribe</button>
        </form>
    </div>
</section>

<!-- Contact -->
<section id="contact" class="py-5">
    <div class="container">
        <h2 class="text-center mb-4" style="font-family: 'Playfair Display', serif; font-size: 2rem; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Get in Touch</h2>
        <div class="row g-4">
            <div class="col-md-6">
                <div class="contact-form">
                    <form>
                        <div class="mb-3">
                            <input type="text" class="form-control" placeholder="Name" required>
                        </div>
                        <div class="mb-3">
                            <input type="email" class="form-control" placeholder="Email" required>
                        </div>
                        <div class="mb-3">
                            <textarea class="form-control" rows="3" placeholder="Message" required></textarea>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="terms" required>
                            <label class="form-check-label" for="terms">I have read the terms and conditions *</label>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Contact Us</button>
                    </form>
                </div>
            </div>
            <div class="col-md-6">
                <div class="accordion" id="contactAccordion">
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#contactOne" aria-expanded="true" aria-controls="contactOne">
                                Netherlands
                            </button>
                        </h2>
                        <div id="contactOne" class="accordion-collapse collapse show" data-bs-parent="#contactAccordion">
                            <div class="accordion-body">HQ Beta, High Tech Campus 9, 5656 AE, Eindhoven</div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#contactTwo" aria-expanded="false" aria-controls="contactTwo">
                                UAE
                            </button>
                        </h2>
                        <div id="contactTwo" class="accordion-collapse collapse" data-bs-parent="#contactAccordion">
                            <div class="accordion-body">1008, Iris Bay Tower, Business Bay, 41018, Dubai, UAE</div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#contactThree" aria-expanded="false" aria-controls="contactThree">
                                USA
                            </button>
                        </h2>
                        <div id="contactThree" class="accordion-collapse collapse" data-bs-parent="#contactAccordion">
                            <div class="accordion-body">Coming Soon</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h5>Melody Mart</h5>
                <p>Your premier destination for high-quality musical instruments.</p>
                <div class="social-icons">
                    <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                    <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="col-md-4">
                <h5>Shop</h5>
                <ul class="list-unstyled">
                    <li><a href="#shop">Guitars</a></li>
                    <li><a href="#shop">Drums & Percussion</a></li>
                    <li><a href="#shop">Pianos & Keyboards</a></li>
                    <li><a href="#shop">Recording Equipment</a></li>
                    <li><a href="#shop">Accessories</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>Company</h5>
                <ul class="list-unstyled">
                    <li><a href="#about">About Us</a></li>
                    <li><a href="#contact">Contact Us</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Shipping & Returns</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
        </div>
        <hr class="bg-light">
        <p class="text-center mt-3">© 2025 Melody Mart. All rights reserved.</p>
    </div>
</footer>

<!-- Modal for Add to Cart -->
<div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-dark text-light">
            <div class="modal-header">
                <h5 class="modal-title" id="cartModalLabel">Added to Cart</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="modalMessage">Item has been added to your cart!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Continue Shopping</button>
                <a href="cart.jsp" class="btn btn-primary">View Cart</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelectorAll('.nav-link').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({ behavior: 'smooth' });
        });
    });

    function addToCart(instrumentId) {
        // Simulate adding to cart (replace with actual API call)
        fetch(`AddToCartServlet?id=${instrumentId}`, { method: 'POST' })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const modal = new bootstrap.Modal(document.getElementById('cartModal'));
                    document.getElementById('modalMessage').textContent = data.message;
                    modal.show();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => alert('Error: ' + error.message));
    }
</script>
</body>
</html>