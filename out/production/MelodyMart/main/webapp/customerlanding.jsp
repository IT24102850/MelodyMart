


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Melody Mart | Premium Musical Instruments</title>
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
        }

        header.scrolled {
            background: rgba(10, 10, 10, 0.95);
            padding: 15px 0;
            backdrop-filter: blur(10px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.5);
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
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            bottom: -5px;
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

        .search-btn, .cart-btn {
            background: none;
            border: none;
            color: var(--text);
            font-size: 18px;
            margin-left: 20px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .search-btn:hover, .cart-btn:hover {
            color: var(--primary-light);
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
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
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
        }

        .user-btn:hover {
            color: var(--primary-light);
        }

        .dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 10px;
            width: 150px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(10px);
            transition: opacity 0.3s ease, transform 0.3s ease, visibility 0.3s;
            z-index: 1000;
        }

        .user-menu:hover .dropdown {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-item {
            display: block;
            padding: 10px 15px;
            color: var(--text);
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s ease, color 0.3s ease;
            cursor: pointer;
        }

        .dropdown-item:hover {
            background: var(--card-hover);
            color: var(--primary-light);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 30px;
            max-width: 400px;
            width: 90%;
            position: relative;
            opacity: 0;
            transform: scale(0.8);
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .modal.active .modal-content {
            opacity: 1;
            transform: scale(1);
        }

        .modal-close {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            color: var(--text);
            font-size: 20px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .modal-close:hover {
            color: var(--primary-light);
        }

        .modal h2 {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            margin-bottom: 20px;
            text-align: center;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .modal form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .modal input {
            padding: 12px;
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            border-radius: 5px;
            font-size: 14px;
        }

        .modal input:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 5px rgba(138, 43, 226, 0.5);
        }

        .modal button[type="submit"] {
            background: var(--gradient);
            padding: 12px;
            border: none;
            border-radius: 30px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .modal button[type="submit"]:hover {
            background: var(--gradient-alt);
            transform: translateY(-2px);
        }

        .modal .switch-form {
            text-align: center;
            margin-top: 15px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .modal .switch-form a {
            color: var(--primary-light);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .modal .switch-form a:hover {
            color: var(--accent);
        }

        /* Hero Section with Slideshow */
        .hero {
            height: 100vh;
            position: relative;
            overflow: hidden;
            padding-top: 80px;
        }

        .slideshow {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .slide {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            transition: opacity 1.5s ease-in-out;
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
        }

        .slide.active {
            opacity: 1;
        }

        .slide-1 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
        }
        .slide-2 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1511735111819-9a3f7709049c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1674&q=80');
        }
        .slide-3 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1506157786151-b8491531f063?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
        }
        .slide-4 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('./images/drums1.jpg');
        }
        .slide-5 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('./images/10.jpg');
        }
        .slide-6 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
        }
        .slide-7 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1494232410401-ad00d5433cfa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
        }
        .slide-8 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('./images/99.jpg');
        }
        .slide-9 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
        }
        .slide-10 {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1519741497674-611481863552?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80');
        }

        .slide-content {
            max-width: 650px;
            padding-left: 10%;
            opacity: 0;
            transform: translateY(50px);
            transition: opacity 1s ease, transform 1s ease;
        }

        .slide.active .slide-content {
            opacity: 1;
            transform: translateY(0);
        }

        .slide h1 {
            font-family: 'Playfair Display', serif;
            font-size: 60px;
            font-weight: 800;
            margin-bottom: 20px;
            line-height: 1.2;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
        }

        .slide p {
            font-size: 18px;
            color: var(--text-secondary);
            margin-bottom: 30px;
            max-width: 90%;
        }

        .slide-btns {
            display: flex;
            gap: 15px;
        }

        .slideshow-dots {
            position: absolute;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 10px;
            z-index: 10;
        }

        .dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.5);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .dot.active {
            background: var(--primary);
            transform: scale(1.3);
        }

        /* Section Title */
        .section-title {
            text-align: center;
            font-family: 'Playfair Display', serif;
            font-size: 36px;
            margin: 80px 0 50px;
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
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--gradient);
        }

        /* Featured Products */
        .products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 80px;
        }

        .product-card {
            background: var(--card-bg);
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.5s ease;
            position: relative;
            opacity: 0;
            transform: translateY(50px);
            border: 1px solid var(--glass-border);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .product-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(138, 43, 226, 0.2);
        }

        .product-img {
            height: 220px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            transition: transform 0.5s ease;
        }

        .product-card:hover .product-img {
            transform: scale(1.1);
        }

        .product-img:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, transparent, rgba(0, 0, 0, 0.7));
            transition: opacity 0.3s ease;
        }

        .product-card:hover .product-img:after {
            opacity: 0.8;
        }

        .product-img i {
            font-size: 80px;
            color: var(--primary-light);
            opacity: 0.7;
            z-index: 2;
            transition: color 0.3s ease;
        }

        .product-card:hover .product-img i {
            color: var(--accent);
        }

        .product-info {
            padding: 20px;
        }

        .product-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .product-price {
            color: var(--primary-light);
            font-weight: 700;
            font-size: 22px;
            margin-bottom: 15px;
        }

        .product-desc {
            color: var(--text-secondary);
            font-size: 14px;
            margin-bottom: 20px;
        }

        .product-actions {
            display: flex;
            justify-content: space-between;
        }

        /* Categories */
        .categories {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 80px;
        }

        .category-card {
            height: 200px;
            border-radius: 15px;
            background: var(--card-bg);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: all 0.4s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            opacity: 0;
            transform: translateY(50px);
            border: 1px solid var(--glass-border);
        }

        .category-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .category-card:hover {
            background: var(--card-hover);
            transform: scale(1.05) rotate(2deg);
        }

        .category-card i {
            font-size: 40px;
            margin-bottom: 15px;
            color: var(--primary-light);
            transition: transform 0.3s ease;
        }

        .category-card:hover i {
            transform: scale(1.2);
        }

        .category-card h3 {
            font-weight: 600;
        }

        /* Why Choose Us (Inspired by SolaaX features) */
        .why-choose {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 60px 0;
            margin: 80px 0;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
        }

        .feature-item {
            text-align: center;
            padding: 20px;
            border-radius: 10px;
            background: var(--card-bg);
            transition: all 0.3s ease;
            opacity: 0;
            transform: translateY(30px);
        }

        .feature-item.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .feature-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.2);
        }

        .feature-icon {
            font-size: 40px;
            color: var(--primary-light);
            margin-bottom: 15px;
        }

        .feature-title {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .feature-desc {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Testimonials */
        .testimonials {
            background: var(--card-bg);
            padding: 80px 0;
            margin: 80px 0;
            position: relative;
            border-top: 1px solid var(--glass-border);
            border-bottom: 1px solid var(--glass-border);
        }

        .testimonial-container {
            display: flex;
            overflow: hidden;
            scroll-behavior: smooth;
            padding: 20px 0;
            transition: transform 0.5s ease;
        }

        .testimonial {
            min-width: 100%;
            padding: 0 50px;
            text-align: center;
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .testimonial.active {
            opacity: 1;
        }

        .testimonial-text {
            font-size: 22px;
            font-style: italic;
            margin-bottom: 30px;
            max-width: 800px;
            margin: 0 auto 30px;
        }

        .testimonial-author {
            font-weight: 600;
            color: var(--primary-light);
        }

        .testimonial-role {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Contact Section (Inspired by SolaaX) */
        .contact {
            padding: 80px 0;
            background: var(--card-bg);
            border-top: 1px solid var(--glass-border);
        }

        .contact-form {
            max-width: 600px;
            margin: 0 auto;
        }

        .contact-form input, .contact-form textarea {
            width: 100%;
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            border-radius: 5px;
        }

        .contact-form button {
            width: 100%;
            padding: 15px;
        }

        .locations {
            display: flex;
            justify-content: space-around;
            margin-top: 50px;
        }

        .location {
            text-align: center;
            padding: 20px;
            background: var(--glass-bg);
            border-radius: 10px;
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 1s ease, transform 1s ease;
        }

        .location.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* Newsletter */
        .newsletter {
            background: var(--gradient);
            padding: 60px 0;
            text-align: center;
            border-radius: 15px;
            margin: 80px 0;
        }

        .newsletter h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            margin-bottom: 20px;
        }

        .newsletter p {
            max-width: 600px;
            margin: 0 auto 30px;
            color: rgba(255, 255, 255, 0.9);
        }

        .newsletter-form {
            display: flex;
            max-width: 500px;
            margin: 0 auto;
        }

        .newsletter-input {
            flex: 1;
            padding: 15px 20px;
            border: none;
            border-radius: 30px 0 0 30px;
            font-size: 16px;
        }

        .newsletter-btn {
            background: var(--secondary);
            color: white;
            border: none;
            padding: 0 25px;
            border-radius: 0 30px 30px 0;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .newsletter-btn:hover {
            background: #000;
        }

        /* Footer */
        footer {
            background: #0a0a0a;
            padding: 80px 0 30px;
            border-top: 1px solid var(--glass-border);
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
            position: relative;
            padding-bottom: 10px;
        }

        .footer-column h3:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 2px;
            background: var(--gradient);
        }

        .footer-column p {
            color: var(--text-secondary);
            margin-bottom: 20px;
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
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--primary-light);
        }

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--card-bg);
            color: var(--text);
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: var(--gradient);
            transform: translateY(-3px);
        }

        .copyright {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid #1e1e1e;
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Additional Animations */
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        @keyframes rotateIn {
            from { transform: rotate(-10deg) scale(0.8); opacity: 0; }
            to { transform: rotate(0) scale(1); opacity: 1; }
        }

        @keyframes bounceIn {
            0% { opacity: 0; transform: scale(0.3); }
            50% { opacity: 1; transform: scale(1.05); }
            70% { transform: scale(0.9); }
            100% { transform: scale(1); }
        }

        .float-animation {
            animation: float 5s ease-in-out infinite;
        }

        .pulse-animation {
            animation: pulse 2s ease-in-out infinite;
        }

        .rotate-in {
            animation: rotateIn 1s ease-out forwards;
        }

        .bounce-in {
            animation: bounceIn 1s ease-out forwards;
        }

        .floating-icons {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            overflow: hidden;
            z-index: -1;
        }

        .floating-icon {
            position: absolute;
            font-size: 24px;
            color: rgba(138, 43, 226, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        /* Premium Elements */
        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .slide h1 {
                font-size: 45px;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .slide-content {
                text-align: center;
                padding: 0 5%;
                margin: 0 auto;
            }

            .slide p {
                margin: 0 auto 30px;
            }

            .slide-btns {
                justify-content: center;
            }

            .section-title {
                font-size: 32px;
            }

            .newsletter-form {
                flex-direction: column;
            }

            .newsletter-input {
                border-radius: 30px;
                margin-bottom: 10px;
            }

            .newsletter-btn {
                border-radius: 30px;
                padding: 15px;
            }

            .locations {
                flex-direction: column;
            }

            .user-menu:hover .dropdown {
                display: none;
            }

            .user-btn {
                font-size: 16px;
            }

            .dropdown {
                width: 120px;
                right: -10px;
            }

            .modal-content {
                padding: 20px;
            }
        }

        @media (max-width: 576px) {
            .slide h1 {
                font-size: 36px;
            }

            .slide p {
                font-size: 16px;
            }

            .cta-btn {
                padding: 10px 20px;
            }

            .section-title {
                font-size: 28px;
            }

            .modal-content {
                width: 95%;
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
            <li><a href="#">Home</a></li>
            <li><a href="shop.jsp">Shop</a></li>
            <li><a href="categories.jsp">Categories</a></li>
            <li><a href="brands.jsp">Brands</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="content.jsp">Contact</a></li>


        </ul>





        <div class="nav-actions">
            <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
            <button class="cart-btn" aria-label="Cart"><i class="fas fa-shopping-cart"></i></button>

            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i></button>
                <div class="dropdown">
                    <%
                        String customerName = (String) session.getAttribute("customerName");
                        if (customerName == null) {
                    %>
                    <a href="sign-in.jsp" class="dropdown-item">Sign In</a>
                    <a href="sign-up.jsp" class="dropdown-item">Sign Up</a>
                    <%
                    } else {
                    %>
                    <a href="logout.jsp" class="dropdown-item">Logout</a>
                    <%
                        }
                    %>
                </div>
            </div>

            <% if (customerName != null) { %>
            <span class="welcome-text">Welcome, <%= customerName %> 🎶</span>
            <% } %>

            <button class="cta-btn">Shop Now</button>
        </div>

    </div>
</header>

<!-- Sign In Modal -->
<div class="modal" id="signInModal">
    <div class="modal-content">
        <button class="modal-close" aria-label="Close Sign In Modal">&times;</button>
        <h2>Sign In</h2>
        <form id="signInForm">
            <input type="email" placeholder="Email *" required aria-label="Email">
            <input type="password" placeholder="Password *" required aria-label="Password">
            <button type="submit">Sign In</button>
            <div class="switch-form">
                Don't have an account? <a href="#" onclick="switchModal('signUpModal')">Sign Up</a>
            </div>
        </form>
    </div>
</div>




<!-- Sign Up Modal -->
<div class="modal" id="signUpModal">
    <div class="modal-content">
        <button class="modal-close" aria-label="Close Sign Up Modal">&times;</button>
        <h2>Sign Up</h2>
        <form id="signUpForm" action="sign-up.jsp" method="post" class="space-y-4">
            <input type="text" name="fullName" placeholder="Full Name *" required aria-label="Full Name">
            <input type="email" name="email" placeholder="Email *" required aria-label="Email">
            <input type="password" name="password" placeholder="Password *" required minlength="8" aria-label="Password">
            <select name="role" required aria-label="Role">
                <option value="" disabled selected>Select Role</option>
                <option value="customer">Customer</option>
                <option value="seller">Seller</option>
                <option value="admin">Admin</option>
            </select>
            <select name="country" required aria-label="Country">
                <option value="" disabled selected>Select Country</option>
                <option value="US">United States</option>
                <option value="CA">Canada</option>
                <option value="UK">United Kingdom</option>
                <option value="AU">Australia</option>
                <option value="IN">India</option>
                <option value="DE">Germany</option>
                <option value="FR">France</option>
                <option value="JP">Japan</option>
                <option value="CN">China</option>
                <option value="BR">Brazil</option>
                <option value="SL">Sri Lanka</option>
            </select>
            <button type="submit">Sign Up</button>
            <div class="switch-form">
                Already have an account? <a href="#" onclick="switchModal('signInModal')">Sign In</a>
            </div>
        </form>
    </div>
</div>

<!-- Hero Section with Slideshow -->
<section class="hero">
    <div class="slideshow">
        <div class="slide slide-1 active">
            <div class="slide-content">
                <h1>Elevate Your <span style="color: var(--accent);">Sound</span> Experience</h1>
                <p>Discover the world's finest musical instruments crafted for professionals and enthusiasts alike. Experience unparalleled quality and sound.</p>
                <div class="slide-btns">
                    <button class="cta-btn">Explore Collection</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">Learn More</button>
                </div>
            </div>
        </div>
        <div class="slide slide-2">
            <div class="slide-content">
                <h1>Premium <span style="color: var(--accent);">Guitars</span> For Every Musician</h1>
                <p>From classic acoustics to modern electrics, find the perfect guitar to express your musical vision.</p>
                <div class="slide-btns">
                    <button class="cta-btn">View Guitars</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">View Offers</button>
                </div>
            </div>
        </div>
        <div class="slide slide-3">
            <div class="slide-content">
                <h1>Studio <span style="color: var(--accent);">Essentials</span> & Equipment</h1>
                <p>Everything you need to create, record and produce music at the highest quality.</p>
                <div class="slide-btns">
                    <button class="cta-btn">Explore Gear</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">Book a Demo</button>
                </div>
            </div>
        </div>
        <div class="slide slide-4">
            <div class="slide-content">
                <h1>Professional <span style="color: var(--accent);">Drums</span> & Percussion</h1>
                <p>Find your rhythm with our premium selection of drum kits and percussion instruments.</p>
                <div class="slide-btns">
                    <button class="cta-btn">Explore Drums</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">View Brands</button>
                </div>
            </div>
        </div>
        <div class="slide slide-5">
            <div class="slide-content">
                <h1>Classic <span style="color: var(--accent);">Pianos</span> & Keyboards</h1>
                <p>From grand pianos to versatile keyboards, discover instruments that inspire creativity.</p>
                <div class="slide-btns">
                    <button class="cta-btn">View Pianos</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">Schedule Trial</button>
                </div>
            </div>
        </div>
        <div class="slide slide-6">
            <div class="slide-content">
                <h1>Vintage <span style="color: var(--accent);">Vinyl</span> Players</h1>
                <p>Rediscover the warm, authentic sound of vinyl with our high-quality record players.</p>
                <div class="slide-btns">
                    <button class="cta-btn">Explore Vinyl Players</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">View Collections</button>
                </div>
            </div>
        </div>
        <div class="slide slide-7">
            <div class="slide-content">
                <h1>Curated <span style="color: var(--accent);">Vinyl</span> Records</h1>
                <p>Explore our collection of vinyl records for audiophiles and music enthusiasts.</p>
                <div class="slide-btns">
                    <button class="cta-btn">Browse Records</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">Discover Genres</button>
                </div>
            </div>
        </div>
        <div class="slide slide-8">
            <div class="slide-content">
                <h1>Professional <span style="color: var(--accent);">Microphones</span></h1>
                <p>Capture every note with our studio-grade microphones for recording and live performances.</p>
                <div class="slide-btns">
                    <button class="cta-btn">Explore Microphones</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">View Specs</button>
                </div>
            </div>
        </div>
        <div class="slide slide-9">
            <div class="slide-content">
                <h1>Live <span style="color: var(--accent);">Performance</span> Gear</h1>
                <p>Elevate your stage presence with top-tier instruments and equipment for live shows.</p>
                <div class="slide-btns">
                    <button class="cta-btn">Shop Performance Gear</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">Book a Demo</button>
                </div>
            </div>
        </div>
        <div class="slide slide-10">
            <div class="slide-content">
                <h1>Musical <span style="color: var(--accent);">Scores</span> & Sheets</h1>
                <p>Find beautifully crafted sheet music for all genres and skill levels.</p>
                <div class="slide-btns">
                    <button class="cta-btn">Browse Sheet Music</button>
                    <button class="cta-btn" style="background: transparent; border: 2px solid var(--primary-light);">Explore Composers</button>
                </div>
            </div>
        </div>
    </div>

    <div class="slideshow-dots">
        <span class="dot" onclick="goToSlide(0)"></span>
        <span class="dot" onclick="goToSlide(1)"></span>
        <span class="dot" onclick="goToSlide(2)"></span>
        <span class="dot" onclick="goToSlide(3)"></span>
        <span class="dot" onclick="goToSlide(4)"></span>
        <span class="dot" onclick="goToSlide(5)"></span>
        <span class="dot" onclick="goToSlide(6)"></span>
        <span class="dot" onclick="goToSlide(7)"></span>
        <span class="dot" onclick="goToSlide(8)"></span>
        <span class="dot" onclick="goToSlide(9)"></span>
    </div>

    <div class="floating-icons">
        <i class="floating-icon" style="top: 20%; left: 5%; animation-delay: 0s;">🎸</i>
        <i class="floating-icon" style="top: 60%; left: 10%; animation-delay: 1s;">🎹</i>
        <i class="floating-icon" style="top: 30%; right: 15%; animation-delay: 2s;">🎷</i>
        <i class="floating-icon" style="top: 70%; right: 5%; animation-delay: 3s;">🥁</i>
        <i class="floating-icon" style="top: 40%; left: 15%; animation-delay: 4s;">🎻</i>
        <i class="floating-icon" style="top: 50%; left: 80%; animation-delay: 0.5s;">🎺</i>
        <i class="floating-icon" style="top: 10%; right: 20%; animation-delay: 1.5s;">🎼</i>
        <i class="floating-icon" style="top: 80%; left: 30%; animation-delay: 2.5s;">📯</i>
        <i class="floating-icon" style="top: 25%; right: 40%; animation-delay: 3.5s;">🎵</i>
        <i class="floating-icon" style="top: 65%; left: 50%; animation-delay: 4.5s;">🎶</i>
    </div>
</section>

<!-- Why Choose Us Section (Inspired by SolaaX features) -->
<section class="container why-choose glass-card">
    <h2 class="section-title">Why Choose Melody Mart</h2>
    <div class="features-grid">
        <div class="feature-item">
            <i class="fas fa-star feature-icon"></i>
            <h3 class="feature-title">Premium Quality</h3>
            <p class="feature-desc">Hand-selected instruments from top brands for exceptional performance.</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-shield-alt feature-icon"></i>
            <h3 class="feature-title">Expert Support</h3>
            <p class="feature-desc">Dedicated team for personalized advice and after-sales service.</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-rocket feature-icon"></i>
            <h3 class="feature-title">Fast Shipping</h3>
            <p class="feature-desc">Worldwide delivery with secure packaging for your instruments.</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-sync-alt feature-icon"></i>
            <h3 class="feature-title">Easy Returns</h3>
            <p class="feature-desc">Hassle-free returns and exchanges within 30 days.</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-users feature-icon"></i>
            <h3 class="feature-title">Community Focus</h3>
            <p class="feature-desc">Join our musician community for tips, events, and more.</p>
        </div>
        <div class="feature-item">
            <i class="fas fa-chart-line feature-icon"></i>
            <h3 class="feature-title">Data-Driven Recommendations</h3>
            <p class="feature-desc">Personalized suggestions based on your preferences and trends.</p>
        </div>
    </div>
</section>

<!-- Featured Products -->
<section class="container">
    <h2 class="section-title">Featured Instruments</h2>
    <div class="products">
        <div class="product-card">
            <div class="product-img">
                <i class="fas fa-guitar"></i>
            </div>
            <div class="product-info">
                <h3 class="product-title">Professional Electric Guitar</h3>
                <div class="product-price">$1,299.99</div>
                <p class="product-desc">Premium crafted guitar with exceptional tone and playability for professional musicians.</p>
                <div class="product-actions">
                    <button class="cta-btn" style="padding: 8px 15px; font-size: 14px;">Add to Cart</button>
                    <button style="background: none; border: none; color: var(--text-secondary); cursor: pointer;">
                        <i class="far fa-heart"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="product-card">
            <div class="product-img">
                <i class="fas fa-drum"></i>
            </div>
            <div class="product-info">
                <h3 class="product-title">Premium Drum Set</h3>
                <div class="product-price">$2,499.99</div>
                <p class="product-desc">Professional 7-piece drum kit with hardware and cymbals included. Perfect for studio and stage.</p>
                <div class="product-actions">
                    <button class="cta-btn" style="padding: 8px 15px; font-size: 14px;">Add to Cart</button>
                    <button style="background: none; border: none; color: var(--text-secondary); cursor: pointer;">
                        <i class="far fa-heart"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="product-card">
            <div class="product-img">
                <i class="fas fa-piano"></i>
            </div>
            <div class="product-info">
                <h3 class="product-title">Digital Grand Piano</h3>
                <div class="product-price">$3,799.99</div>
                <p class="product-desc">Concert-grade digital piano with weighted keys and authentic sound sampling from world-class grands.</p>
                <div class="product-actions">
                    <button class="cta-btn" style="padding: 8px 15px; font-size: 14px;">Add to Cart</button>
                    <button style="background: none; border: none; color: var(--text-secondary); cursor: pointer;">
                        <i class="far fa-heart"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Categories -->
<section class="container">
    <h2 class="section-title">Shop By Category</h2>
    <div class="categories">
        <div class="category-card">
            <i class="fas fa-guitar"></i>
            <h3>Guitars</h3>
        </div>
        <div class="category-card">
            <i class="fas fa-drum"></i>
            <h3>Drums & Percussion</h3>
        </div>
        <div class="category-card">
            <i class="fas fa-piano"></i>
            <h3>Pianos & Keyboards</h3>
        </div>
        <div class="category-card">
            <i class="fas fa-microphone"></i>
            <h3>Recording Equipment</h3>
        </div>
    </div>
</section>

<!-- Testimonials -->
<section class="testimonials">
    <div class="container">
        <h2 class="section-title">What Our Customers Say</h2>
        <div class="testimonial-container">
            <div class="testimonial">
                <p class="testimonial-text">"The quality of instruments at Melody Mart is unmatched. My new guitar sounds incredible and was delivered perfectly set up and ready to play."</p>
                <div class="testimonial-author">Alex Johnson</div>
                <div class="testimonial-role">Professional Musician</div>
            </div>
            <div class="testimonial">
                <p class="testimonial-text">"Excellent customer service and a fantastic selection. The piano I purchased exceeded my expectations in every way."</p>
                <div class="testimonial-author">Sarah Lee</div>
                <div class="testimonial-role">Music Teacher</div>
            </div>
            <div class="testimonial">
                <p class="testimonial-text">"Fast shipping and great prices. Melody Mart is my go-to for all drumming needs."</p>
                <div class="testimonial-author">Mike Rodriguez</div>
                <div class="testimonial-role">Studio Drummer</div>
            </div>
        </div>
    </div>
</section>

<!-- Newsletter -->
<section class="container">
    <div class="newsletter glass-card">
        <h2>Stay in Tune with Melody Mart</h2>
        <p>Subscribe to our newsletter for exclusive offers, new arrivals, and expert tips.</p>
        <form class="newsletter-form">
            <input type="email" class="newsletter-input" placeholder="Your Email Address">
            <button type="submit" class="newsletter-btn">Subscribe</button>
        </form>
    </div>
</section>

<!-- Contact Section (Inspired by SolaaX) -->
<section class="contact">
    <div class="container">
        <h2 class="section-title">Get in Touch</h2>
        <p style="text-align: center; margin-bottom: 40px; color: var(--text-secondary);">Have questions or ready to explore our collection? Fill out the form below, and our team will get back to you shortly.</p>
        <form class="contact-form">
            <input type="text" placeholder="First Name *" required>
            <input type="text" placeholder="Last Name *" required>
            <input type="email" placeholder="Email *" required>
            <input type="tel" placeholder="Phone">
            <textarea placeholder="Comment" rows="5"></textarea>
            <label><input type="checkbox" required> I have read the terms and conditions *</label>
            <button type="submit" class="cta-btn">Contact Us</button>
        </form>
        <div class="locations">
            <div class="location">
                <h3>Netherlands</h3>
                <p>HQ Beta<br>High Tech Campus 9<br>5656 AE, Eindhoven</p>
            </div>
            <div class="location">
                <h3>UAE</h3>
                <p>1008, Iris Bay Tower<br>Business Bay,<br>41018, Dubai, UAE</p>
            </div>
            <div class="location">
                <h3>USA</h3>
                <p>Coming Soon</p>
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
                <p>Your premier destination for high-quality musical instruments and professional audio equipment.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <div class="footer-column">
                <h3>Shop</h3>
                <ul class="footer-links">
                    <li><a href="#">Guitars</a></li>
                    <li><a href="#">Drums & Percussion</a></li>
                    <li><a href="#">Pianos & Keyboards</a></li>
                    <li><a href="#">Recording Equipment</a></li>
                    <li><a href="#">Accessories</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Company</h3>
                <ul class="footer-links">
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Shipping & Returns</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h3>Newsletter</h3>
                <p>Subscribe to our newsletter for the latest products and exclusive offers.</p>
                <form>
                    <input type="email" placeholder="Your Email" style="width: 100%; padding: 12px; margin-bottom: 10px; border-radius: 5px; border: none; background: var(--card-bg); color: var(--text);">
                    <button class="cta-btn" style="width: 100%;">Subscribe</button>
                </form>
            </div>
        </div>

        <div class="copyright">
            &copy; 2025 Melody Mart. All rights reserved.
        </div>
    </div>
</footer>

<script>
    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // Modal handling
    function openModal(modalId) {
        const modal = document.getElementById(modalId);
        modal.style.display = 'flex';
        setTimeout(() => modal.classList.add('active'), 10); // Allow animation
    }

    function closeModal(modalId) {
        const modal = document.getElementById(modalId);
        modal.classList.remove('active');
        setTimeout(() => modal.style.display = 'none', 300); // Match animation duration
    }

    function switchModal(modalId) {
        document.querySelectorAll('.modal').forEach(modal => {
            modal.classList.remove('active');
            setTimeout(() => modal.style.display = 'none', 300);
        });
        openModal(modalId);
    }

    // Close modal on clicking outside
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                closeModal(modal.id);
            }
        });
    });

    // Close modal on clicking close button
    document.querySelectorAll('.modal-close').forEach(btn => {
        btn.addEventListener('click', () => {
            closeModal(btn.closest('.modal').id);
        });
    });

    // Form submission (placeholder)
    document.getElementById('signInForm').addEventListener('submit', (e) => {
        e.preventDefault();
        alert('Sign In submitted! (Placeholder)');
        closeModal('signInModal');
    });

    document.getElementById('signUpForm').addEventListener('submit', (e) => {
        e.preventDefault();
        alert('Sign Up submitted! (Placeholder)');
        closeModal('signUpModal');
    });

    // Slideshow handling
    let currentSlide = 0;
    const slides = document.querySelectorAll('.slide');
    const dots = document.querySelectorAll('.dot');
    const totalSlides = slides.length;

    function showSlide(index) {
        currentSlide = (index + totalSlides) % totalSlides;
        slides.forEach((slide, i) => {
            slide.classList.toggle('active', i === currentSlide);
        });
        dots.forEach((dot, i) => {
            dot.classList.toggle('active', i === currentSlide);
        });
    }

    function changeSlide(direction) {
        showSlide(currentSlide + direction);
    }

    function goToSlide(index) {
        showSlide(index);
    }

    let autoSlide = setInterval(() => changeSlide(1), 5000);

    const slideshowContainer = document.querySelector('.slideshow');
    slideshowContainer.addEventListener('mouseenter', () => clearInterval(autoSlide));
    slideshowContainer.addEventListener('mouseleave', () => {
        autoSlide = setInterval(() => changeSlide(1), 5000);
    });

    showSlide(currentSlide);

    // Testimonials carousel
    const testimonialContainer = document.querySelector('.testimonial-container');
    const testimonials = document.querySelectorAll('.testimonial');
    let currentTestimonial = 0;

    function showTestimonial(n) {
        testimonials.forEach(t => t.classList.remove('active'));
        currentTestimonial = (n + testimonials.length) % testimonials.length;
        testimonialContainer.style.transform = `translateX(-${currentTestimonial * 100}%)`;
        testimonials[currentTestimonial].classList.add('active');
    }

    function nextTestimonial() {
        showTestimonial(currentTestimonial + 1);
    }

    setInterval(nextTestimonial, 5000);

    showTestimonial(0);

    // Intersection Observer for animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                if (entry.target.classList.contains('feature-item')) {
                    entry.target.classList.add('bounce-in');
                } else if (entry.target.classList.contains('category-card')) {
                    entry.target.classList.add('rotate-in');
                }
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.section-title, .product-card, .category-card, .feature-item, .location').forEach((el) => {
        observer.observe(el);
    });

    // Add floating icons dynamically
    function addFloatingIcons() {
        const icons = ['🎸', '🎹', '🎷', '🥁', '🎻', '🎺', '🎼', '📯', '🎵', '🎶'];
        const container = document.querySelector('.floating-icons');

        for (let i = 0; i < 20; i++) {
            const icon = document.createElement('div');
            icon.className = 'floating-icon';
            icon.textContent = icons[Math.floor(Math.random() * icons.length)];
            icon.style.left = Math.random() * 100 + '%';
            icon.style.top = Math.random() * 100 + '%';
            icon.style.animationDelay = Math.random() * 5 + 's';
            icon.style.fontSize = (Math.random() * 20 + 16) + 'px';
            if (Math.random() > 0.5) {
                icon.classList.add('pulse-animation');
            }
            container.appendChild(icon);
        }
    }

    addFloatingIcons();
</script>
</body>
</html>