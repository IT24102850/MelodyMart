<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Contact Us</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1e40af;
            --primary-light: #3b82f6;
            --primary-soft: #dbeafe;
            --secondary: #ffffff;
            --accent: #06b6d4;
            --accent-alt: #ef4444;
            --text: #1e40af;
            --text-secondary: #475569;
            --text-soft: #64748b;
            --card-bg: #f8fafc;
            --card-hover: #ffffff;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
            --gradient-soft: linear-gradient(135deg, var(--primary-soft), #e0f2fe);
            --glass-bg: rgba(255, 255, 255, 0.9);
            --glass-border: rgba(255, 255, 255, 0.3);
            --shadow: 0 5px 20px rgba(30, 64, 175, 0.1);
            --shadow-hover: 0 10px 30px rgba(30, 64, 175, 0.2);
            --header-bg: rgba(255, 255, 255, 0.95);
            --section-bg: #f1f5f9;
            --border-radius: 16px;
        }

        [data-theme="dark"] {
            --primary: #3b82f6;
            --primary-light: #60a5fa;
            --primary-soft: #1e3a8a;
            --secondary: #1e40af;
            --accent: #22d3ee;
            --accent-alt: #f87171;
            --text: #f1f5f9;
            --text-secondary: #cbd5e1;
            --text-soft: #94a3b8;
            --card-bg: #1e293b;
            --card-hover: #334155;
            --glass-bg: rgba(30, 64, 175, 0.9);
            --glass-border: rgba(255, 255, 255, 0.1);
            --shadow: 0 5px 20px rgba(30, 64, 175, 0.3);
            --shadow-hover: 0 10px 30px rgba(30, 64, 175, 0.4);
            --header-bg: rgba(30, 64, 175, 0.95);
            --section-bg: #1e40af;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.4s ease, color 0.4s ease, border-color 0.4s ease, box-shadow 0.4s ease;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--secondary);
            color: var(--text);
            overflow-x: hidden;
            line-height: 1.6;
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
        }

        header.scrolled {
            padding: 15px 0;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            background-color: var(--header-bg);
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

        .nav-links a.active {
            color: var(--primary-light);
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
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-left: 20px;
            position: relative;
            overflow: hidden;
            z-index: 1;
            box-shadow: 0 4px 15px rgba(30, 64, 175, 0.3);
        }

        .cta-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background: var(--gradient-alt);
            transition: all 0.4s ease;
            z-index: -1;
        }

        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(30, 64, 175, 0.4);
        }

        .cta-btn:hover:before {
            width: 100%;
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
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease 0.5s forwards;
        }

        .page-subtitle {
            font-size: 1.2rem;
            color: var(--text-secondary);
            max-width: 700px;
            margin: 0 auto 2rem;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease 0.8s forwards;
        }

        /* Section Title */
        .section-title {
            text-align: center;
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            margin: 100px 0 60px;
            position: relative;
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 1s ease, transform 1s ease;
        }

        .section-title.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--gradient);
            border-radius: 2px;
        }

        /* Section Backgrounds */
        .section-bg {
            background: var(--section-bg);
            padding: 100px 0;
            margin: 80px 0;
        }

        /* Contact Section */
        .contact-section {
            padding: 2rem 5% 5rem;
        }

        .contact-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
            margin-top: 2rem;
        }

        .contact-info {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .contact-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 2rem;
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
            opacity: 0;
            transform: translateY(30px);
        }

        .contact-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .contact-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .contact-icon {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 1rem;
            transition: color 0.3s ease;
        }

        .contact-card:hover .contact-icon {
            color: var(--accent);
        }

        .contact-title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--text);
            font-weight: 600;
        }

        .contact-detail {
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .contact-detail i {
            color: var(--primary);
            width: 20px;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: var(--card-bg);
            color: var(--text);
            transition: all 0.3s ease;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
        }

        .social-link:hover {
            background: var(--gradient);
            color: white;
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        /* Contact Form */
        .contact-form-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 2.5rem;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
        }

        .form-title {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            color: var(--text);
            position: relative;
            padding-bottom: 10px;
            font-weight: 600;
        }

        .form-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: var(--gradient);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--text);
            font-weight: 500;
        }

        .form-input, .form-textarea, .form-select {
            width: 100%;
            padding: 15px;
            border-radius: var(--border-radius);
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            font-size: 1rem;
            transition: all 0.3s ease;
            font-family: 'Montserrat', sans-serif;
        }

        .form-input:focus, .form-textarea:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
        }

        .form-textarea {
            min-height: 150px;
            resize: vertical;
        }

        .submit-btn {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            position: relative;
            overflow: hidden;
            z-index: 1;
            box-shadow: 0 4px 15px rgba(30, 64, 175, 0.3);
        }

        .submit-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background: var(--gradient-alt);
            transition: all 0.4s ease;
            z-index: -1;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(30, 64, 175, 0.4);
        }

        .submit-btn:hover:before {
            width: 100%;
        }

        /* FAQ Section */
        .faq-section {
            padding: 2rem 5% 5rem;
        }

        .faq-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .faq-item {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            border: 1px solid var(--glass-border);
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
            opacity: 0;
            transform: translateY(30px);
        }

        .faq-item.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .faq-item:hover {
            box-shadow: var(--shadow-hover);
        }

        .faq-question {
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .faq-question:hover {
            background: var(--card-hover);
        }

        .faq-question h3 {
            font-size: 1.2rem;
            color: var(--text);
            flex: 1;
            font-weight: 600;
        }

        .faq-icon {
            color: var(--primary);
            transition: transform 0.3s ease;
        }

        .faq-answer {
            padding: 0 1.5rem;
            max-height: 0;
            overflow: hidden;
            transition: all 0.3s ease;
            color: var(--text-secondary);
            line-height: 1.6;
        }

        .faq-item.active .faq-answer {
            padding: 0 1.5rem 1.5rem;
            max-height: 500px;
        }

        .faq-item.active .faq-icon {
            transform: rotate(180deg);
        }

        /* Map Section */
        .map-section {
            padding: 2rem 5% 5rem;
        }

        .map-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
        }

        .map-placeholder {
            height: 400px;
            background: var(--gradient-soft);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: var(--primary);
        }

        .map-placeholder i {
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        /* Footer */
        footer {
            background: var(--card-bg);
            padding: 100px 0 40px;
            border-top: 1px solid var(--glass-border);
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 60px;
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

        .social-links-footer {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        .social-links-footer a {
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

        .social-links-footer a:hover {
            background: var(--gradient);
            color: white;
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .copyright {
            text-align: center;
            padding-top: 40px;
            border-top: 1px solid var(--glass-border);
            color: var(--text-secondary);
            font-size: 15px;
        }

        /* Animations */
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounceIn {
            0% { opacity: 0; transform: scale(0.3); }
            50% { opacity: 1; transform: scale(1.05); }
            70% { transform: scale(0.9); }
            100% { transform: scale(1); }
        }

        .bounce-in {
            animation: bounceIn 1s ease-out forwards;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .page-title {
                font-size: 3rem;
            }
        }

        @media (max-width: 992px) {
            .page-title {
                font-size: 2.5rem;
            }

            .section-title {
                font-size: 36px;
            }

            .contact-container {
                grid-template-columns: 1fr;
            }

            .nav-links {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }

            .section-title {
                font-size: 32px;
                margin: 80px 0 40px;
            }

            .contact-form-container {
                padding: 1.5rem;
            }

            .user-menu:hover .dropdown {
                display: none;
            }

            .user-btn {
                font-size: 16px;
            }

            .dropdown {
                width: 150px;
                right: -10px;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 1.8rem;
            }

            .page-subtitle {
                font-size: 0.9rem;
            }

            .cta-btn {
                padding: 10px 20px;
                font-size: 14px;
            }

            .section-title {
                font-size: 28px;
            }

            .footer-content {
                grid-template-columns: 1fr;
            }

            .contact-card {
                padding: 1.5rem;
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
            <li><a href="instruments.jsp">Instruments</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="deals.jsp">Deals</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp" class="active">Contact</a></li>
        </ul>

        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <button class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></button>
            <button class="theme-toggle" aria-label="Toggle Theme" id="themeToggle">
                <i class="fas fa-moon"></i>
            </button>
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i></button>
                <div class="dropdown">
                    <a href="sign-in.jsp" class="dropdown-item">Sign In</a>
                    <a href="sign-up.jsp" class="dropdown-item">Sign Up</a>
                </div>
            </div>
            <button class="cta-btn" onclick="window.location.href='instruments.jsp'">Shop Now</button>
        </div>
    </div>
</header>

<section class="page-header">
    <h1 class="page-title">Contact Us</h1>
    <p class="page-subtitle">Have questions about our instruments or need assistance? We're here to help you find your perfect sound.</p>
</section>

<section class="contact-section">
    <div class="container">
        <div class="contact-container">
            <!-- Contact Information -->
            <div class="contact-info">
                <div class="contact-card">
                    <i class="fas fa-map-marker-alt contact-icon"></i>
                    <h3 class="contact-title">Visit Our Store</h3>
                    <p class="contact-detail"><i class="fas fa-location-dot"></i> 123 Music Avenue, Nashville, TN 37203</p>
                    <p class="contact-detail"><i class="fas fa-clock"></i> Mon-Sat: 10AM - 8PM, Sun: 12PM - 6PM</p>
                </div>

                <div class="contact-card">
                    <i class="fas fa-phone contact-icon"></i>
                    <h3 class="contact-title">Call Us</h3>
                    <p class="contact-detail"><i class="fas fa-phone"></i> +1 (615) 555-7890</p>
                    <p class="contact-detail"><i class="fas fa-phone"></i> +1 (615) 555-7891</p>
                    <p class="contact-detail"><i class="fas fa-clock"></i> Available 9AM-9PM EST</p>
                </div>

                <div class="contact-card">
                    <i class="fas fa-envelope contact-icon"></i>
                    <h3 class="contact-title">Email Us</h3>
                    <p class="contact-detail"><i class="fas fa-envelope"></i> support@melodymart.com</p>
                    <p class="contact-detail"><i class="fas fa-envelope"></i> sales@melodymart.com</p>
                    <p class="contact-detail"><i class="fas fa-reply"></i> We respond within 24 hours</p>
                </div>

                <div class="contact-card">
                    <i class="fas fa-share-alt contact-icon"></i>
                    <h3 class="contact-title">Follow Us</h3>
                    <p>Stay connected for updates, new arrivals, and exclusive deals</p>
                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="contact-form-container">
                <h2 class="form-title">Send Us a Message</h2>
                <form id="contactForm">
                    <div class="form-group">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" id="name" class="form-input" placeholder="Enter your full name" required>
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" id="email" class="form-input" placeholder="Enter your email" required>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="tel" id="phone" class="form-input" placeholder="Enter your phone number">
                    </div>

                    <div class="form-group">
                        <label for="subject" class="form-label">Subject</label>
                        <select id="subject" class="form-select" required>
                            <option value="" disabled selected>Select a subject</option>
                            <option value="general">General Inquiry</option>
                            <option value="sales">Sales Question</option>
                            <option value="support">Technical Support</option>
                            <option value="warranty">Warranty Claim</option>
                            <option value="repair">Repair Services</option>
                            <option value="other">Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="message" class="form-label">Message</label>
                        <textarea id="message" class="form-textarea" placeholder="Tell us how we can help you..." required></textarea>
                    </div>

                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</section>

<section class="faq-section">
    <div class="container">
        <h2 class="section-title">Frequently Asked Questions</h2>

        <div class="faq-container">
            <div class="faq-item">
                <div class="faq-question">
                    <h3>What is your return policy?</h3>
                    <i class="fas fa-chevron-down faq-icon"></i>
                </div>
                <div class="faq-answer">
                    <p>We offer a 30-day return policy for all unused items in original packaging. Instruments must be in like-new condition with all accessories included. Special order and custom items may have different return conditions.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Do you offer instrument repairs?</h3>
                    <i class="fas fa-chevron-down faq-icon"></i>
                </div>
                <div class="faq-answer">
                    <p>Yes, we have a full-service repair shop staffed by certified technicians. We repair all types of instruments including guitars, brass, woodwinds, and percussion. Repair estimates are provided before work begins.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Can I try instruments before purchasing?</h3>
                    <i class="fas fa-chevron-down faq-icon"></i>
                </div>
                <div class="faq-answer">
                    <p>Absolutely! Our showroom has dedicated spaces for you to try any instrument. We also offer a 7-day trial period for most instruments (some restrictions apply). Contact us to schedule a private demo session.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Do you offer financing options?</h3>
                    <i class="fas fa-chevron-down faq-icon"></i>
                </div>
                <div class="faq-answer">
                    <p>Yes, we offer several financing options including 0% APR for qualified buyers, installment plans, and lease-to-own programs. Apply in-store or online for instant approval on most instruments over $500.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>How long does shipping take?</h3>
                    <i class="fas fa-chevron-down faq-icon"></i>
                </div>
                <div class="faq-answer">
                    <p>Most in-stock items ship within 1-2 business days. Standard shipping takes 3-5 business days, while expedited options are available. Large instruments like pianos may require special delivery arrangements.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="map-section">
    <div class="container">
        <h2 class="section-title">Find Our Store</h2>

        <div class="map-container">
            <div class="map-placeholder">
                <i class="fas fa-map"></i>
                <p>Interactive Map Would Appear Here</p>
                <p style="font-size: 0.9rem; margin-top: 0.5rem;">123 Music Avenue, Nashville, TN 37203</p>
            </div>
        </div>
    </div>
</section>

<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-column">
                <h3>Melody Mart</h3>
                <p>Your premier destination for high-quality musical instruments and professional audio equipment.</p>
                <div class="social-links-footer">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <div class="footer-column">
                <h3>Quick Links</h3>
                <ul class="footer-links">
                    <li><a href="instruments.jsp">Instruments</a></li>
                    <li><a href="brands.jsp">Brands</a></li>
                    <li><a href="deals.jsp">Hot Deals</a></li>
                    <li><a href="#">Rentals</a></li>
                    <li><a href="#">Repairs</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Customer Service</h3>
                <ul class="footer-links">
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Shipping & Returns</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Warranty</a></li>
                    <li><a href="#">Financing</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Newsletter</h3>
                <p>Subscribe to get updates on new products, special offers, and exclusive deals.</p>
                <form>
                    <input type="email" placeholder="Your email address" style="width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 10px; border: 1px solid var(--glass-border); background: var(--secondary); color: var(--text);">
                    <button class="cta-btn" style="width: 100%;">Subscribe</button>
                </form>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; 2025 Melody Mart. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    // Theme toggle functionality
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = themeToggle.querySelector('i');

    // Check for saved theme preference or default to light
    const currentTheme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', currentTheme);
    updateThemeIcon(currentTheme);

    themeToggle.addEventListener('click', () => {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';

        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        updateThemeIcon(newTheme);
    });

    function updateThemeIcon(theme) {
        if (theme === 'light') {
            themeIcon.className = 'fas fa-moon';
        } else {
            themeIcon.className = 'fas fa-sun';
        }
    }

    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // FAQ Accordion
    const faqItems = document.querySelectorAll('.faq-item');

    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');

        question.addEventListener('click', () => {
            // Close all other items
            faqItems.forEach(otherItem => {
                if (otherItem !== item) {
                    otherItem.classList.remove('active');
                }
            });

            // Toggle current item
            item.classList.toggle('active');
        });
    });

    // Contact Form Submission
    const contactForm = document.getElementById('contactForm');

    contactForm.addEventListener('submit', function(e) {
        e.preventDefault();

        // Get form values
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const subject = document.getElementById('subject').value;

        // In a real application, you would send this data to a server
        // For now, we'll just show a success message
        alert(`Thank you, ${name}! Your message has been sent. We'll respond to ${email} regarding your ${subject} inquiry shortly.`);

        // Reset form
        contactForm.reset();
    });

    // Intersection Observer for animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                if (entry.target.classList.contains('contact-card') ||
                    entry.target.classList.contains('faq-item')) {
                    entry.target.classList.add('bounce-in');
                }
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.section-title, .contact-card, .faq-item').forEach((el) => {
        observer.observe(el);
    });
</script>
</body>
</html>