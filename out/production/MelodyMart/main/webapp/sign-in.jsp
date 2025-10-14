<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Sign In</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon.ico">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3b82f6; /* Bright Blue */
            --primary-light: #60a5fa;
            --secondary: #ffffff; /* White */
            --accent: #06b6d4; /* Cyan Accent */
            --gold-accent: #f59e0b; /* Amber Gold */
            --text: #fdfdfd; /* Dark Blue-Gray */
            --text-secondary: #64748b; /* Medium Gray */
            --card-bg: rgba(30, 41, 59, 0.85); /* Darker glass background */
            --glass-bg: rgba(30, 41, 59, 0.8);
            --glass-border: rgba(59, 130, 246, 0.3);
            --shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
        }

        body {
            font-family: 'Inter', sans-serif;
            background:
                    linear-gradient(135deg, rgba(224, 242, 254, 0.9), rgba(240, 249, 255, 0.9)),
                    url('https://images.unsplash.com/photo-1506157786151-b8491531f063?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: var(--text);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
            line-height: 1.6;
        }

        /* Background blur overlay */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: inherit;
            filter: blur(8px) brightness(0.9);
            z-index: -1;
            transform: scale(1.1);
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            margin: 20px auto;
            padding: 20px;
            z-index: 1;
        }

        .login-card {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 40px;
            box-shadow: var(--shadow);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            color: white;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
        }

        .logo {
            margin-bottom: 20px;
        }

        .logo a {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2.5rem;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .logo a i {
            color: var(--accent);
            animation: pulse 2s infinite;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.3));
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        h3 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2rem;
            color: white;
            margin-bottom: 25px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .alert {
            background: rgba(239, 68, 68, 0.2);
            color: #fecaca;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 500;
            border: 1px solid rgba(239, 68, 68, 0.3);
            backdrop-filter: blur(5px);
        }

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: #e2e8f0;
            margin-bottom: 8px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px 12px 40px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
            background: rgba(255, 255, 255, 0.15);
        }

        .form-group .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.7);
        }

        .btn-primary {
            width: 100%;
            padding: 12px;
            background: var(--gradient);
            border: none;
            border-radius: 25px;
            color: white;
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(5px);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
        }

        .btn-primary:active {
            transform: translateY(-1px);
        }

        .btn-primary i {
            margin-right: 8px;
        }

        .signup-link {
            margin-top: 20px;
            color: #cbd5e1;
            font-weight: 500;
        }

        .signup-link a {
            color: var(--primary-light);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .signup-link a:hover {
            color: var(--accent);
            text-decoration: underline;
        }

        .floating-icons {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 0;
        }

        .floating-icon {
            position: absolute;
            font-size: 24px;
            color: rgba(59, 130, 246, 0.3);
            animation: float 6s ease-in-out infinite;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
        }

        /* Enhanced focus states for accessibility */
        .form-group input:focus + .input-icon {
            color: var(--accent);
        }

        /* Loading animation for button */
        .btn-primary.loading {
            pointer-events: none;
            opacity: 0.8;
        }

        .btn-primary.loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            top: 50%;
            left: 50%;
            margin-left: -10px;
            margin-top: -10px;
            border: 2px solid transparent;
            border-top-color: white;
            border-radius: 50%;
            animation: button-loading-spinner 1s ease infinite;
        }

        @keyframes button-loading-spinner {
            from { transform: rotate(0turn); }
            to { transform: rotate(1turn); }
        }

        @media (max-width: 768px) {
            .login-card {
                padding: 25px;
            }

            h3 {
                font-size: 1.8rem;
            }

            .logo a {
                font-size: 2rem;
            }

            body::before {
                filter: blur(5px) brightness(0.9);
            }
        }
    </style>
</head>
<body>
<div class="floating-icons">
    <div class="floating-icon" style="top: 10%; left: 5%; animation-delay: 0s;">🎵</div>
    <div class="floating-icon" style="top: 20%; right: 10%; animation-delay: 1s;">🎸</div>
    <div class="floating-icon" style="top: 60%; left: 8%; animation-delay: 2s;">🎹</div>
    <div class="floating-icon" style="top: 70%; right: 7%; animation-delay: 3s;">🥁</div>
    <div class="floating-icon" style="top: 40%; left: 15%; animation-delay: 4s;">🎻</div>
</div>

<div class="login-container">
    <div class="login-card">
        <div class="logo">
            <a href="index.jsp"><i class="fas fa-music"></i>Melody Mart</a>
        </div>

        <h3>Sign In</h3>

        <!-- Display error message if passed via query param -->
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
        <div class="alert">
            <i class="fas fa-exclamation-circle"></i> <%= error %>
        </div>
        <%
            }
        %>

        <!-- Sign In Form -->
        <form action="LoginServlet" method="post" class="space-y-4" id="signinForm">
            <div class="form-group relative">
                <label for="email">Email</label>
                <div class="relative">
                    <input type="email" name="email" id="email" required placeholder="Enter your email">
                    <i class="fas fa-envelope input-icon"></i>
                </div>
            </div>

            <div class="form-group relative">
                <label for="password">Password</label>
                <div class="relative">
                    <input type="password" name="password" id="password" required placeholder="Enter your password">
                    <i class="fas fa-lock input-icon"></i>
                </div>
            </div>

            <button type="submit" class="btn-primary" id="submitBtn">
                <i class="fas fa-sign-in-alt"></i> Sign In
            </button>
        </form>

        <div class="signup-link">
            Don't have an account? <a href="sign-up.jsp">Sign Up</a>
        </div>
    </div>
</div>

<script>
    // Add floating icons dynamically
    function addFloatingIcons() {
        const icons = ['🎵', '🎸', '🎹', '🥁', '🎻', '🎺', '🎼', '📯'];
        const container = document.querySelector('.floating-icons');

        for (let i = 0; i < 12; i++) {
            const icon = document.createElement('div');
            icon.className = 'floating-icon';
            icon.textContent = icons[Math.floor(Math.random() * icons.length)];
            icon.style.left = Math.random() * 100 + '%';
            icon.style.top = Math.random() * 100 + '%';
            icon.style.animationDelay = Math.random() * 5 + 's';
            icon.style.fontSize = (Math.random() * 20 + 16) + 'px';
            container.appendChild(icon);
        }
    }

    // Form submission loading state
    document.getElementById('signinForm').addEventListener('submit', function(e) {
        const submitBtn = document.getElementById('submitBtn');
        submitBtn.classList.add('loading');
        submitBtn.innerHTML = 'Signing In...';

        // Simulate loading for demo (remove in production)
        setTimeout(() => {
            submitBtn.classList.remove('loading');
            submitBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';
        }, 2000);
    });

    // Input focus effects
    document.querySelectorAll('.form-group input').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.querySelector('.input-icon').style.color = '#06b6d4';
        });

        input.addEventListener('blur', function() {
            this.parentElement.querySelector('.input-icon').style.color = 'rgba(255, 255, 255, 0.7)';
        });
    });

    // Initialize floating icons
    addFloatingIcons();
</script>
</body>
</html>