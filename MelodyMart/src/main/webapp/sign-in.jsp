<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In | Melody Mart</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            line-height: 1.6;
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

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-15px) rotate(5deg); }
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            padding: 40px;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            z-index: 10;
            margin: 20px;
        }

        .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo a {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }

        .logo i {
            margin-right: 10px;
            font-size: 36px;
        }

        h3 {
            font-family: 'Playfair Display', serif;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            background: rgba(255, 0, 0, 0.1);
            border: 1px solid rgba(255, 0, 0, 0.2);
            color: #ff6b6b;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-secondary);
        }

        .form-group input {
            width: 100%;
            padding: 14px 16px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--glass-border);
            border-radius: 8px;
            color: var(--text);
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 2px rgba(138, 43, 226, 0.3);
        }

        .form-group i {
            position: absolute;
            right: 15px;
            top: 42px;
            color: var(--text-secondary);
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
        }

        .btn-primary:before {
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

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4);
        }

        .btn-primary:hover:before {
            width: 100%;
        }

        .signup-link {
            text-align: center;
            margin-top: 25px;
            color: var(--text-secondary);
        }

        .signup-link a {
            color: var(--primary-light);
            text-decoration: none;
            transition: color 0.3s ease;
            font-weight: 600;
        }

        .signup-link a:hover {
            color: var(--accent);
            text-decoration: underline;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
            color: var(--text-secondary);
        }

        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid var(--glass-border);
        }

        .divider span {
            padding: 0 15px;
            font-size: 14px;
        }

        .social-login {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        .social-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--card-bg);
            color: var(--text);
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .social-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
        }

        .social-btn.google:hover {
            background: #DB4437;
            color: white;
        }

        .social-btn.facebook:hover {
            background: #4267B2;
            color: white;
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 30px 20px;
                margin: 15px;
            }

            h3 {
                font-size: 24px;
            }

            .logo a {
                font-size: 28px;
            }

            .logo i {
                font-size: 32px;
            }
        }
    </style>
</head>
<body>
<div class="floating-icons">
    <i class="floating-icon" style="top: 10%; left: 5%; animation-delay: 0s;">🎸</i>
    <i class="floating-icon" style="top: 70%; left: 10%; animation-delay: 1s;">🎹</i>
    <i class="floating-icon" style="top: 30%; right: 15%; animation-delay: 2s;">🎷</i>
    <i class="floating-icon" style="top: 80%; right: 5%; animation-delay: 3s;">🥁</i>
    <i class="floating-icon" style="top: 45%; left: 15%; animation-delay: 4s;">🎻</i>
    <i class="floating-icon" style="top: 60%; left: 80%; animation-delay: 0.5s;">🎺</i>
</div>

<div class="login-container">
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
    <form action="login" method="post">
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" name="email" id="email" required>
            <i class="fas fa-envelope"></i>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" name="password" id="password" required>
            <i class="fas fa-lock"></i>
        </div>

        <button type="submit" class="btn btn-primary">
            <i class="fas fa-sign-in-alt"></i> Sign In
        </button>
    </form>

    <div class="signup-link">
        Don't have an account? <a href="sign_up.jsp">Sign Up</a>
    </div>

    <div class="divider">
        <span>Or continue with</span>
    </div>

    <div class="social-login">
        <button class="social-btn google">
            <i class="fab fa-google"></i>
        </button>
        <button class="social-btn facebook">
            <i class="fab fa-facebook-f"></i>
        </button>
    </div>
</div>

<script>
    // Add floating icons dynamically
    function addFloatingIcons() {
        const icons = ['🎸', '🎹', '🎷', '🥁', '🎻', '🎺', '🎼', '📯', '🎵', '🎶'];
        const container = document.querySelector('.floating-icons');

        for (let i = 0; i < 10; i++) {
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

    addFloatingIcons();
</script>
</body>
</html>