<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Sign In</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon_io%20(9)/favicon.ico">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --gold-accent: #d4af37;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --card-hover: #2a2a2a;
            --glass-bg: rgba(26, 26, 26, 0.85);
            --glass-border: rgba(255, 255, 255, 0.2);
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent), var(--primary));
            --metallic-gradient: linear-gradient(135deg, #c0c0c0, #a9a9a9);
        }

        body {
            background: linear-gradient(to bottom, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.75)), url('https://images.unsplash.com/photo-1511379938547-c1f69419868d');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
            color: var(--text);
            overflow-x: hidden;
            position: relative;
        }

        body::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, transparent 60%, rgba(0, 0, 0, 0.4) 100%);
            pointer-events: none;
        }

        .main-content {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 80px);
            padding: 20px;
        }

        .signin-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 2px solid transparent;
            border-image: linear-gradient(45deg, var(--primary), var(--gold-accent)) 1;
            border-radius: 25px;
            padding: 20px;
            max-width: 400px;
            width: 100%;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5), 0 0 15px rgba(138, 43, 226, 0.3);
            position: relative;
            overflow: hidden;
            animation: floatIn 1s cubic-bezier(0.2, 0.6, 0.4, 1);
            will-change: transform, opacity;
        }

        @keyframes floatIn {
            from { opacity: 0; transform: translateY(60px) scale(0.95); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .signin-card::before {
            content: '';
            position: absolute;
            top: -30%;
            left: -30%;
            width: 160%;
            height: 160%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M20 20 Q50 80 80 20" fill="none" stroke="%23d4af37" stroke-width="0.5" opacity="0.15"/></svg>');
            background-size: 60px 60px;
            z-index: 0;
            animation: rotateSlow 30s linear infinite;
        }

        @keyframes rotateSlow {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .signin-card > * {
            position: relative;
            z-index: 1;
        }

        .signin-card h1 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 3rem;
            text-align: center;
            background: linear-gradient(90deg, var(--primary), var(--gold-accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
            text-shadow: 0 3px 6px rgba(0, 0, 0, 0.4);
        }

        .form-grid {
            display: grid;
            gap: 15px;
        }

        .form-group {
            margin: 0;
        }

        .form-group label {
            display: block;
            font-weight: 700;
            color: var(--text-secondary);
            margin-bottom: 8px;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--glass-border);
            background: linear-gradient(var(--secondary), rgba(255, 255, 255, 0.05));
            color: var(--text);
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--gold-accent);
            box-shadow: 0 0 15px rgba(212, 175, 55, 0.4);
            transform: scale(1.03);
        }

        .form-group input:hover {
            transform: scale(1.02);
        }

        .error-message {
            color: #dc2626;
            font-size: 0.9rem;
            margin-top: 6px;
            animation: fadeInError 0.4s ease-in-out;
            display: none;
        }

        @keyframes fadeInError {
            from { opacity: 0; transform: translateY(-5px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .signin-btn {
            background: var(--metallic-gradient);
            padding: 12px;
            border: none;
            border-radius: 30px;
            color: var(--text);
            font-weight: 800;
            width: 100%;
            cursor: pointer;
            transition: all 0.5s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .signin-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 215, 0, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.7s ease, height 0.7s ease;
            z-index: 0;
        }

        .signin-btn:hover::before {
            width: 300%;
            height: 300%;
        }

        .signin-btn:hover {
            background: linear-gradient(135deg, #d3d3d3, #c0c0c0);
            transform: translateY(-4px);
            box-shadow: 0 15px 30px rgba(212, 175, 55, 0.6);
        }

        .signin-btn .spinner {
            display: none;
            border: 3px solid #fff;
            border-top: 3px solid var(--gold-accent);
            border-radius: 50%;
            width: 20px;
            height: 20px;
            animation: spin 1.2s linear infinite;
            margin-right: 8px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .success-message {
            display: none;
            text-align: center;
            color: var(--gold-accent);
            font-size: 0.9rem;
            margin-top: 10px;
            animation: fadeInSuccess 0.5s ease-in-out;
        }

        @keyframes fadeInSuccess {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        .switch-link {
            text-align: center;
            margin-top: 15px;
            color: var(--text-secondary);
            font-size: 1rem;
        }

        .switch-link a {
            color: var(--accent);
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
        }

        .switch-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--gold-accent);
            transition: width 0.3s ease;
        }

        .switch-link a:hover::after {
            width: 100%;
        }

        .switch-link a:hover {
            color: var(--primary-light);
            text-shadow: 0 0 15px var(--gold-accent);
        }
    </style>
</head>
<body>
<main class="main-content">
    <div class="signin-card">
        <h1>Sign In to MelodyMart</h1>
        <c:if test="${not empty param.error}">
            <p class="error-message" style="display: block">${param.error}</p>
        </c:if>
        <form id="signinForm" action="/login" method="post" class="form-grid" novalidate>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="${param.email}" required aria-label="Email" aria-describedby="email-error">
                <p id="email-error" class="error-message">Please enter a valid email address.</p>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required minlength="8" aria-label="Password" aria-describedby="password-error">
                <p id="password-error" class="error-message">Please enter your password.</p>
            </div>
            <div class="form-group">
                <label class="flex items-center space-x-3">
                    <input type="checkbox" id="remember" name="remember" class="h-5 w-5 text-gray-600 focus:ring-gray-500 border-gray-300 rounded">
                    <span class="text-base text-gray-300">Remember Me</span>
                </label>
            </div>
            <button type="submit" class="signin-btn" id="signinButton">
                <span class="spinner" id="spinner"></span>Sign In
            </button>
            <div class="switch-link">
                Don't have an account? <a href="sign-up.jsp" target="_blank">Sign Up</a>
            </div>
            <div class="switch-link">
                <a href="forgot-password.jsp">Forgot Password?</a>
            </div>
            <div id="successMessage" class="success-message">Sign-in successful! Redirecting...</div>
        </form>
    </div>
</main>

<script>
    document.getElementById('signinForm').addEventListener('submit', function(event) {
        event.preventDefault();
        let isValid = true;
        const signinButton = document.getElementById('signinButton');
        const spinner = document.getElementById('spinner');
        const successMessage = document.getElementById('successMessage');

        // Reset states
        document.querySelectorAll('.error-message').forEach(error => error.style.display = 'none');
        spinner.style.display = 'inline-block';
        signinButton.disabled = true;
        successMessage.style.display = 'none';

        // Email validation
        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            document.getElementById('email-error').style.display = 'block';
            isValid = false;
        }

        // Password validation
        const password = document.getElementById('password').value;
        if (!password) {
            document.getElementById('password-error').style.display = 'block';
            isValid = false;
        }

        if (isValid) {
            setTimeout(() => {
                successMessage.style.display = 'block';
                setTimeout(() => {
                    this.submit(); // Servlet handles the actual redirect
                }, 1000); // Delay for success message visibility
            }, 500); // Simulate server processing
        } else {
            spinner.style.display = 'none';
            signinButton.disabled = false;
        }
    });

    // Parallax effect
    window.addEventListener('scroll', () => {
        const scrollPosition = window.pageYOffset;
        document.body.style.backgroundPositionY = -scrollPosition * 0.3 + 'px';
    });
</script>
</body>
</html>