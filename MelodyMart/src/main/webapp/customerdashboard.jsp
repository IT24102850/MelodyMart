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

        /* User Welcome Message */
        .user-welcome {
            display: flex;
            align-items: center;
            margin-left: 20px;
            color: var(--text);
            font-weight: 500;
        }

        .user-welcome i {
            margin-right: 8px;
            color: var(--primary-light);
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
            background-image: linear-gradient(rgana(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('./images/10.jpg');
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

            .user-welcome {
                display: none;
            }

            .user-welcome.mobile {
                display: block;
                text-align: center;
                margin: 10px 0;
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

            <!-- Check if user is logged in -->
            <%
                // Simulate a logged-in user (in a real application, this would come from session)
                String customerName = (String) session.getAttribute("customerName");
                if (customerName != null) {
            %>
            <!-- Display welcome message and user dropdown -->
            <div class="user-welcome">
                <i class="fas fa-user-circle"></i>
                <span>Welcome, <%= customerName %></span>
            </div>
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i></button>
                <div class="dropdown">
                    <a href="profile.jsp" class="dropdown-item">My Profile</a>
                    <a href="orders.jsp" class="dropdown-item">My Orders</a>
                    <a href="wishlist.jsp" class="dropdown-item">Wishlist</a>
                    <a href="logout.jsp" class="dropdown-item">Logout</a>
                </div>
            </div>
            <%
            } else {
            %>
            <!-- Display login/signup options -->
            <div class="user-menu">
                <button class="user-btn" aria-label="User Menu"><i class="fas fa-user"></i></button>
                <div class="dropdown">
                    <a href="#" onclick="openModal('signInModal')" class="dropdown-item">Sign In</a>
                    <a href="#" onclick="openModal('signUpModal')" class="dropdown-item">Sign Up</a>
                </div>
            </div>
            <%
                }
            %>

            <button class="cta-btn">Shop Now</button>
        </div>
    </div>

    <!-- Mobile view user welcome (hidden on desktop) -->
    <%
        if (customerName != null) {
    %>
    <div class="user-welcome mobile" style="display: none;">
        <i class="fas fa-user-circle"></i>
        <span>Welcome, <%= customerName %></span>
    </div>
    <%
        }
    %>
</header>

<!-- The rest of your HTML content remains the same -->
<!-- ... -->

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

    // Handle mobile view for user welcome message
    function checkMobileView() {
        const mobileWelcome = document.querySelector('.user-welcome.mobile');
        const desktopWelcome = document.querySelector('.nav-actions .user-welcome');

        if (window.innerWidth <= 768) {
            if (mobileWelcome) mobileWelcome.style.display = 'block';
            if (desktopWelcome) desktopWelcome.style.display = 'none';
        } else {
            if (mobileWelcome) mobileWelcome.style.display = 'none';
            if (desktopWelcome) desktopWelcome.style.display = 'flex';
        }
    }

    // Run on load and resize
    window.addEventListener('load', checkMobileView);
    window.addEventListener('resize', checkMobileView);

    // Modal handling
    function openModal(modalId) {
        const modal = document.getElementById(modalId);
        modal.style.display = 'flex';
        setTimeout(() => modal.classList.add('active'), 10);
    }

    function closeModal(modalId) {
        const modal = document.getElementById(modalId);
        modal.classList.remove('active');
        setTimeout(() => modal.style.display = 'none', 300);
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