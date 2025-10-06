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
            --shadow: 0 5px 20px rgb(30, 64, 175);
            --shadow-hover: 0 10px 30px rgb(30, 64, 175);
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
            --glass-bg: rgb(30, 64, 175);
            --glass-border: rgba(255, 255, 255, 0.1);
            --shadow: 0 5px 20px rgb(30, 64, 175);
            --shadow-hover: 0 10px 30px rgb(30, 64, 175);
            --header-bg: rgb(30, 64, 175);
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

        /* Header & Navigation - Enhanced Colors */
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

        /* Hero Section - Completely Redesigned */
        .hero {
            height: 100vh;
            position: relative;
            overflow: hidden;
            padding-top: 80px;
            background: linear-gradient(135deg, #1e40af 0%, #06b6d4 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .hero-content {
            text-align: center;
            max-width: 800px;
            padding: 0 20px;
            z-index: 2;
            position: relative;
        }

        .hero-title {
            font-family: 'Playfair Display', serif;
            font-size: 4.5rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            color: white;
            line-height: 1.1;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease 0.5s forwards;
        }

        .hero-subtitle {
            font-size: 1.5rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2.5rem;
            line-height: 1.6;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease 0.8s forwards;
        }

        .hero-btns {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease 1.1s forwards;
        }

        .hero-btn {
            padding: 15px 35px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .hero-btn.primary {
            background: white;
            color: #1e40af;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .hero-btn.primary:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .hero-btn.secondary {
            background: transparent;
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.7);
        }

        .hero-btn.secondary:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: white;
            transform: translateY(-5px);
        }

        /* Animated Background Elements */
        .hero-bg-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 1;
        }

        .bg-circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 15s infinite ease-in-out;
        }

        .bg-circle:nth-child(1) {
            width: 300px;
            height: 300px;
            top: -150px;
            right: -100px;
            animation-delay: 0s;
        }

        .bg-circle:nth-child(2) {
            width: 200px;
            height: 200px;
            bottom: -50px;
            left: 10%;
            animation-delay: 2s;
        }

        .bg-circle:nth-child(3) {
            width: 150px;
            height: 150px;
            top: 20%;
            left: 5%;
            animation-delay: 4s;
        }

        .bg-circle:nth-child(4) {
            width: 100px;
            height: 100px;
            bottom: 20%;
            right: 15%;
            animation-delay: 6s;
        }

        /* Musical Notes Animation */
        .musical-notes {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 1;
        }

        .note {
            position: absolute;
            font-size: 2rem;
            color: rgba(255, 255, 255, 0.3);
            animation: floatNote 8s infinite linear;
        }

        .note:nth-child(1) {
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .note:nth-child(2) {
            top: 60%;
            left: 85%;
            animation-delay: 1s;
        }

        .note:nth-child(3) {
            top: 80%;
            left: 20%;
            animation-delay: 2s;
        }

        .note:nth-child(4) {
            top: 40%;
            left: 75%;
            animation-delay: 3s;
        }

        .note:nth-child(5) {
            top: 10%;
            left: 50%;
            animation-delay: 4s;
        }

        .note:nth-child(6) {
            top: 70%;
            left: 40%;
            animation-delay: 5s;
        }

        /* Stats Section */
        .hero-stats {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin-top: 60px;
            flex-wrap: wrap;
            opacity: 0;
            animation: fadeIn 1s ease 1.4s forwards;
        }

        .stat-item {
            text-align: center;
            color: white;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 5px;
            display: block;
        }

        .stat-label {
            font-size: 1rem;
            opacity: 0.8;
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

        /* Featured Products */
        .products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
            margin-bottom: 80px;
        }

        .product-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            transition: all 0.5s ease;
            position: relative;
            opacity: 0;
            transform: translateY(50px);
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow);
        }

        .product-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .product-img {
            height: 240px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            transition: transform 0.5s ease;
            background: var(--gradient-soft);
        }

        .product-card:hover .product-img {
            transform: scale(1.05);
        }

        .product-img:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, transparent, rgba(59, 130, 246, 0.1));
            transition: opacity 0.3s ease;
        }

        .product-card:hover .product-img:after {
            opacity: 0.8;
        }

        .product-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .product-card:hover .product-img img {
            transform: scale(1.1);
        }

        .product-info {
            padding: 25px;
        }

        .product-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .product-price {
            color: var(--primary);
            font-weight: 700;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .product-desc {
            color: var(--text-secondary);
            font-size: 15px;
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .product-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Categories */
        .categories {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 80px;
        }

        .category-card {
            height: 220px;
            border-radius: var(--border-radius);
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
            box-shadow: var(--shadow);
        }

        .category-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .category-card:hover {
            background: var(--card-hover);
            transform: scale(1.05);
            box-shadow: var(--shadow-hover);
        }

        .category-card i {
            font-size: 50px;
            margin-bottom: 20px;
            color: var(--primary);
            transition: transform 0.3s ease;
        }

        .category-card:hover i {
            transform: scale(1.2);
            color: var(--accent);
        }

        .category-card h3 {
            font-weight: 600;
            font-size: 20px;
        }

        /* Why Choose Us */
        .why-choose {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 80px 0;
            margin: 80px 0;
            box-shadow: var(--shadow);
            width: 100%;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
        }

        .feature-item {
            text-align: center;
            padding: 30px 20px;
            border-radius: var(--border-radius);
            background: var(--card-bg);
            transition: all 0.3s ease;
            opacity: 0;
            transform: translateY(30px);
            box-shadow: var(--shadow);
        }

        .feature-item.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .feature-item:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
            background: var(--card-hover);
        }

        .feature-icon {
            font-size: 50px;
            color: var(--primary);
            margin-bottom: 20px;
            transition: color 0.3s ease;
        }

        .feature-item:hover .feature-icon {
            color: var(--accent);
        }

        .feature-title {
            font-size: 20px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .feature-desc {
            color: var(--text-secondary);
            font-size: 15px;
            line-height: 1.6;
        }

        /* Testimonials */
        .testimonials {
            background: var(--card-bg);
            padding: 100px 0;
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
            font-size: 24px;
            font-style: italic;
            margin-bottom: 30px;
            max-width: 800px;
            margin: 0 auto 30px;
            line-height: 1.7;
            color: var(--text);
            position: relative;
        }

        .testimonial-text:before, .testimonial-text:after {
            content: '"';
            font-size: 60px;
            color: var(--primary-soft);
            position: absolute;
            line-height: 1;
        }

        .testimonial-text:before {
            top: -20px;
            left: -40px;
        }

        .testimonial-text:after {
            bottom: -40px;
            right: -40px;
        }

        .testimonial-author {
            font-weight: 600;
            color: var(--primary);
            font-size: 18px;
        }

        .testimonial-role {
            color: var(--text-secondary);
            font-size: 15px;
        }

        /* Newsletter */
        .newsletter {
            background: var(--gradient);
            padding: 80px 0;
            text-align: center;
            border-radius: var(--border-radius);
            margin: 100px 0;
            box-shadow: var(--shadow-hover);
            position: relative;
            overflow: hidden;
        }

        .newsletter:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><path fill="rgba(255,255,255,0.1)" d="M500,250c138.07,0,250,111.93,250,250s-111.93,250-250,250s-250-111.93-250-250S361.93,250,500,250z"/></svg>') no-repeat center;
            background-size: cover;
            opacity: 0.2;
        }

        .newsletter h2 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            margin-bottom: 20px;
            color: white;
        }

        .newsletter p {
            max-width: 600px;
            margin: 0 auto 40px;
            color: rgba(255, 255, 255, 0.9);
            font-size: 18px;
        }

        .newsletter-form {
            display: flex;
            max-width: 500px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        .newsletter-input {
            flex: 1;
            padding: 18px 25px;
            border: none;
            border-radius: 30px 0 0 30px;
            font-size: 16px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .newsletter-btn {
            background: var(--secondary);
            color: var(--primary);
            border: none;
            padding: 0 30px;
            border-radius: 0 30px 30px 0;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .newsletter-btn:hover {
            background: var(--primary-soft);
            transform: translateY(-2px);
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

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        .social-links a {
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

        .social-links a:hover {
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

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(10deg);
            }
        }

        @keyframes floatNote {
            0% {
                transform: translateY(100px) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 0.5;
            }
            90% {
                opacity: 0.5;
            }
            100% {
                transform: translateY(-100px) rotate(360deg);
                opacity: 0;
            }
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

        /* Premium Elements */
        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 40px;
            box-shadow: var(--shadow);
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .hero-title {
                font-size: 3.5rem;
            }
        }

        @media (max-width: 992px) {
            .hero-title {
                font-size: 3rem;
            }

            .section-title {
                font-size: 36px;
            }

            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtitle {
                font-size: 1.2rem;
            }

            .hero-btn {
                padding: 12px 25px;
                font-size: 1rem;
            }

            .stat-number {
                font-size: 2rem;
            }

            .hero-stats {
                gap: 20px;
            }

            .section-title {
                font-size: 32px;
                margin: 80px 0 40px;
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
                padding: 18px;
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

            .modal-content {
                padding: 30px;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .hero-title {
                font-size: 2rem;
            }

            .hero-subtitle {
                font-size: 1.1rem;
            }

            .hero-btns {
                flex-direction: column;
                align-items: center;
            }

            .hero-btn {
                width: 100%;
                max-width: 250px;
                justify-content: center;
            }

            .cta-btn {
                padding: 10px 20px;
                font-size: 14px;
            }

            .section-title {
                font-size: 28px;
            }

            .modal-content {
                width: 95%;
                padding: 25px;
            }

            .footer-content {
                grid-template-columns: 1fr;
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
            <button class="cta-btn" onclick="window.location.href='shop.jsp'">Shop Now</button>
        </div>
    </div>
</header>

<!-- Hero Section - Completely Redesigned -->
<section class="hero">
    <div class="hero-bg-elements">
        <div class="bg-circle"></div>
        <div class="bg-circle"></div>
        <div class="bg-circle"></div>
        <div class="bg-circle"></div>
    </div>

    <div class="musical-notes">
        <div class="note">♪</div>
        <div class="note">♫</div>
        <div class="note">🎵</div>
        <div class="note">🎶</div>
        <div class="note">♪</div>
        <div class="note">♫</div>
    </div>

    <div class="hero-content">
        <h1 class="hero-title">Elevate Your Sound Experience</h1>
        <p class="hero-subtitle">Discover the world's finest musical instruments crafted for professionals and enthusiasts alike. Experience unparalleled quality and sound.</p>

        <div class="hero-btns">
            <a href="shop.jsp" class="hero-btn primary">
                <i class="fas fa-shopping-cart"></i>
                Shop Instruments
            </a>
            <a href="categories.jsp" class="hero-btn secondary">
                <i class="fas fa-guitar"></i>
                Explore Categories
            </a>
        </div>

        <div class="hero-stats">
            <div class="stat-item">
                <span class="stat-number">500+</span>
                <span class="stat-label">Premium Instruments</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">10K+</span>
                <span class="stat-label">Happy Musicians</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">50+</span>
                <span class="stat-label">Top Brands</span>
            </div>
        </div>
    </div>
</section>

<!-- Why Choose Us Section -->
<section class="container">
    <div class="why-choose glass-card">
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
    </div>
</section>

<!-- Featured Products -->
<section class="container">
    <h2 class="section-title">Featured Instruments</h2>
    <div class="products">
        <div class="product-card">
            <div class="product-img">
                <img src="https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Professional Electric Guitar">
            </div>
            <div class="product-info">
                <h3 class="product-title">Professional Electric Guitar</h3>
                <div class="product-price">$1,299.99</div>
                <p class="product-desc">Premium crafted guitar with exceptional tone and playability for professional musicians.</p>
                <div class="product-actions">
                    <button class="cta-btn" style="padding: 10px 20px; font-size: 14px;">Add to Cart</button>
                    <button style="background: none; border: none; color: var(--text-secondary); cursor: pointer;">
                        <i class="far fa-heart"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="product-card">
            <div class="product-img">
                <img src="https://images.unsplash.com/photo-1519892300165-cb5542fb47c7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Premium Drum Set">
            </div>
            <div class="product-info">
                <h3 class="product-title">Premium Drum Set</h3>
                <div class="product-price">$2,499.99</div>
                <p class="product-desc">Professional 7-piece drum kit with hardware and cymbals included. Perfect for studio and stage.</p>
                <div class="product-actions">
                    <button class="cta-btn" style="padding: 10px 20px; font-size: 14px;">Add to Cart</button>
                    <button style="background: none; border: none; color: var(--text-secondary); cursor: pointer;">
                        <i class="far fa-heart"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="product-card">
            <div class="product-img">
                <img src="https://images.unsplash.com/photo-1520523839897-bd0b52f945a0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Digital Grand Piano">
            </div>
            <div class="product-info">
                <h3 class="product-title">Digital Grand Piano</h3>
                <div class="product-price">$3,799.99</div>
                <p class="product-desc">Concert-grade digital piano with weighted keys and authentic sound sampling from world-class grands.</p>
                <div class="product-actions">
                    <button class="cta-btn" style="padding: 10px 20px; font-size: 14px;">Add to Cart</button>
                    <button style="background: none; border: none; color: var(--text-secondary); cursor: pointer;">
                        <i class="far fa-heart"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Categories -->
<section class="section-bg">
    <div class="container">
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
    </div>
</section>

<!-- Testimonials -->
<section class="testimonials">
    <div class="container">
        <h2 class="section-title">What Our Customers Say</h2>
        <div class="testimonial-container">
            <div class="testimonial active">
                <p class="testimonial-text">The quality of instruments at Melody Mart is unmatched. My new guitar sounds incredible and was delivered perfectly set up and ready to play.</p>
                <div class="testimonial-author">Alex Johnson</div>
                <div class="testimonial-role">Professional Musician</div>
            </div>
            <div class="testimonial">
                <p class="testimonial-text">Excellent customer service and a fantastic selection. The piano I purchased exceeded my expectations in every way.</p>
                <div class="testimonial-author">Sarah Lee</div>
                <div class="testimonial-role">Music Teacher</div>
            </div>
            <div class="testimonial">
                <p class="testimonial-text">Fast shipping and great prices. Melody Mart is my go-to for all drumming needs.</p>
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
                    <input type="email" placeholder="Your Email" style="width: 100%; padding: 15px; margin-bottom: 15px; border-radius: 10px; border: 1px solid var(--glass-border); background: var(--secondary); color: var(--text);">
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

    document.querySelectorAll('.section-title, .product-card, .category-card, .feature-item').forEach((el) => {
        observer.observe(el);
    });
</script>
</body>
</html>