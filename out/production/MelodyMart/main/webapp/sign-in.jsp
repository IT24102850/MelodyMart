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
            --primary: #8a2be2; /* Rich Purple */
            --primary-light: #a349f5;
            --secondary: #1a1a1a; /* Deep Gray */
            --accent: #00e5ff; /* Cyan Accent */
            --gold-accent: #d4af37; /* Metallic Gold */
            --text: #ffffff; /* White */
            --text-secondary: #d3d3d3; /* Light Gray */
            --card-bg: rgba(26, 26, 26, 0.9); /* Dark Glass Background */
            --glass-bg: rgba(26, 26, 26, 0.85);
            --glass-border: rgba(255, 255, 255, 0.1);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--primary), var(--secondary)), url('https://images.unsplash.com/photo-1506157786151-b8491531f063?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-blend-mode: overlay;
            background-size: cover;
            background-position: center;
            color: var(--text);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
            line-height: 1.6;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            margin: 20px auto;
            padding: 20px;
        }

        .login-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 40px;
            box-shadow: var(--shadow);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(138, 43, 226, 0.4);
        }

        .logo {
            margin-bottom: 20px;
        }

        .logo a {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2.5rem;
            color: var(--gold-accent);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo a i {
            color: var(--accent);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        h3 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2rem;
            color: var(--text);
            margin-bottom: 25px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .alert {
            background: rgba(255, 99, 71, 0.1);
            color: #ff6347;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
        }

        .form-group {
            text-align: left;
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: var(--text-secondary);
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--glass-border);
            border-radius: 10px;
            color: var(--text);
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.2);
        }

        .form-group i {
            position: absolute;
            margin-left: -30px;
            margin-top: 12px;
            color: var(--text-secondary);
        }

        .btn-primary {
            width: 100%;
            padding: 12px;
            background: var(--gradient);
            border: none;
            border-radius: 25px;
            color: var(--text);
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: transform 0.3s ease, background 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            background: linear-gradient(135deg, var(--accent), var(--primary));
        }

        .btn-primary i {
            margin-right: 8px;
        }

        .signup-link {
            margin-top: 20px;
            color: var(--text-secondary);
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
        }
    </style>
</head>
<body>
<div class="floating-icons">
    <!-- Floating icons can be added here with CSS animations for premium feel -->
    <div class="absolute top-5 left-5 text-gold-accent text-2xl animate-bounce">🎵</div>
    <div class="absolute top-10 right-5 text-accent text-3xl animate-pulse">✨</div>
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
        <form action="login" method="post" class="space-y-4">
            <div class="form-group relative">
                <label for="email">Email</label>
                <input type="email" name="email" id="email" required placeholder="Enter your email" class="pl-10">
                <i class="fas fa-envelope"></i>
            </div>

            <div class="form-group relative">
                <label for="password">Password</label>
                <input type="password" name="password" id="password" required placeholder="Enter your password" class="pl-10">
                <i class="fas fa-lock"></i>
            </div>

            <button type="submit" class="btn-primary">
                <i class="fas fa-sign-in-alt"></i> Sign In
            </button>
        </form>

        <div class="signup-link">
            Don't have an account? <a href="sign-up.jsp">Sign Up</a>
        </div>


    </div>
</div>

<script>
    // Parallax effect for background
    window.addEventListener('scroll', () => {
        const scrollPosition = window.pageYOffset;
        document.body.style.backgroundPositionY = -scrollPosition * 0.3 + 'px';
    });

    // Form focus effect
    document.querySelectorAll('.form-group input').forEach(input => {
        input.addEventListener('focus', () => {
            input.parentElement.classList.add('border-primary-light');
        });
        input.addEventListener('blur', () => {
            input.parentElement.classList.remove('border-primary-light');
        });
    });
</script>
</body>
</html>