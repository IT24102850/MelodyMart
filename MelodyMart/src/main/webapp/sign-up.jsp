<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, org.mindrot.jbcrypt.BCrypt, java.sql.DriverManager, java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException, java.util.Date" %>
<%
    // Handle form submission (unchanged from original)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String country = request.getParameter("country");

        System.out.println("=== Registration Attempt ===");
        System.out.println("Full Name: " + fullName);
        System.out.println("Email: " + email);
        System.out.println("Role: " + role);
        System.out.println("Country: " + country);

        if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.length() < 8 ||
                role == null || role.trim().isEmpty() ||
                country == null || country.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required and password must be at least 8 characters.");
        } else {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            } catch (ClassNotFoundException e) {
                System.err.println("JDBC Driver not found: " + e.getMessage());
                request.setAttribute("errorMessage", "Database driver not found. Please check if mssql-jdbc jar is in classpath.");
                return;
            }

            String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true";
            String dbUser = "Hasiru";
            String dbPassword = "hasiru2004";

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                String sql = "INSERT INTO Users (name, email, password, role, country, created_at) VALUES (?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);

                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                stmt.setString(1, fullName.trim());
                stmt.setString(2, email.trim().toLowerCase());
                stmt.setString(3, hashedPassword);
                stmt.setString(4, role);
                stmt.setString(5, country);
                stmt.setTimestamp(6, new java.sql.Timestamp(new Date().getTime()));

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    session.setAttribute("userEmail", email.trim().toLowerCase());
                    session.setAttribute("userRole", role);
                    session.setAttribute("userFullName", fullName.trim());
                    session.setMaxInactiveInterval(30 * 60);
                    response.sendRedirect("sign-in.jsp");
                    return;
                } else {
                    request.setAttribute("errorMessage", "Registration failed. No rows were inserted.");
                }
            } catch (SQLException e) {
                System.err.println("=== SQL ERROR DETAILS ===");
                System.err.println("Message: " + e.getMessage());
                System.err.println("SQL State: " + e.getSQLState());
                System.err.println("Error Code: " + e.getErrorCode());
                e.printStackTrace();

                String errorMessage = "Database error occurred.";
                if (e.getErrorCode() == 2627 || e.getMessage().contains("UNIQUE KEY constraint")) {
                    errorMessage = "Email already exists. Please use a different email address.";
                } else if (e.getMessage().contains("Login failed") || e.getSQLState().equals("28000")) {
                    errorMessage = "Database authentication failed.";
                } else if (e.getMessage().contains("server was not found") || e.getSQLState().equals("08001")) {
                    errorMessage = "Cannot connect to SQL Server.";
                } else if (e.getMessage().contains("Invalid object name")) {
                    errorMessage = "Database table 'Users' not found.";
                } else if (e.getSQLState().equals("08S01")) {
                    errorMessage = "Communication link failure.";
                } else {
                    errorMessage = "Database error: " + e.getMessage();
                }
                request.setAttribute("errorMessage", errorMessage);
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    System.err.println("Error closing database resources: " + e.getMessage());
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Sign Up</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon.ico">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --accent-alt: #ff00c8;
            --gold-accent: #d4af37;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --card-hover: #2a2a2a;
            --glass-bg: rgba(26, 26, 26, 0.85);
            --glass-border: rgba(255, 255, 255, 0.2);
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
            --metallic-gradient: linear-gradient(135deg, #c0c0c0, #a9a9a9);
        }

        body {
            background: linear-gradient(to bottom, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.75)), url('https://images.unsplash.com/photo-1511735111819-9a3f7709049c');
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
            background: radial-gradient(circle, transparent 50%, rgba(0, 0, 0, 0.3) 100%);
            pointer-events: none;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            position: relative;
            z-index: 1;
        }

        .signup-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 80px);
            padding: 50px 20px;
        }

        .signup-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 2px solid transparent;
            border-image: linear-gradient(45deg, var(--primary), var(--gold-accent)) 1;
            border-radius: 25px;
            padding: 50px;
            max-width: 480px;
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

        .signup-card::before {
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

        .signup-card > * {
            position: relative;
            z-index: 1;
        }

        .signup-card h1 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 3.5rem;
            text-align: center;
            background: linear-gradient(90deg, var(--primary), var(--gold-accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 30px;
            text-shadow: 0 3px 6px rgba(0, 0, 0, 0.4);
        }

        .form-grid {
            display: grid;
            gap: 25px;
        }

        .form-group {
            margin: 0;
        }

        .form-group label {
            display: block;
            font-weight: 700;
            color: var(--text-secondary);
            margin-bottom: 10px;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 16px 20px;
            border: 2px solid var(--glass-border);
            background: linear-gradient(var(--secondary), rgba(255, 255, 255, 0.05));
            color: var(--text);
            border-radius: 10px;
            font-size: 1.1rem;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--gold-accent);
            box-shadow: 0 0 15px rgba(212, 175, 55, 0.4);
            transform: scale(1.03);
        }

        .form-group input:hover,
        .form-group select:hover {
            transform: scale(1.02);
        }

        .error-message {
            color: #dc2626;
            font-size: 0.9rem;
            margin-top: 8px;
            animation: fadeInError 0.4s ease-in-out;
            display: none;
        }

        @keyframes fadeInError {
            from { opacity: 0; transform: translateY(-5px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .submit-btn {
            background: var(--metallic-gradient);
            padding: 16px;
            border: none;
            border-radius: 40px;
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

        .submit-btn::before {
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

        .submit-btn:hover::before {
            width: 300%;
            height: 300%;
        }

        .submit-btn:hover {
            background: linear-gradient(135deg, #d3d3d3, #c0c0c0);
            transform: translateY(-4px);
            box-shadow: 0 15px 30px rgba(212, 175, 55, 0.6);
        }

        .submit-btn .spinner {
            display: none;
            border: 3px solid #fff;
            border-top: 3px solid var(--gold-accent);
            border-radius: 50%;
            width: 24px;
            height: 24px;
            animation: spin 1.2s linear infinite;
            margin-right: 10px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .success-message {
            display: none;
            text-align: center;
            color: var(--gold-accent);
            font-size: 1rem;
            margin-top: 15px;
            animation: fadeInSuccess 0.5s ease-in-out;
        }

        @keyframes fadeInSuccess {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        .switch-link {
            text-align: center;
            margin-top: 25px;
            color: var(--text-secondary);
            font-size: 1.1rem;
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
<div class="container signup-container">
    <div class="signup-card">
        <h1>Sign Up for MelodyMart</h1>
        <c:if test="${not empty errorMessage}">
            <p class="error-message" style="display: block;"><c:out value="${errorMessage}"/></p>
        </c:if>
        <form id="signupForm" action="sign-up.jsp" method="post" class="form-grid" novalidate>
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" value="${param.fullName}" required aria-label="Full Name" aria-describedby="name-error">
                <p id="name-error" class="error-message">Please enter your full name.</p>
            </div>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="${param.email}" required aria-label="Email" aria-describedby="email-error">
                <p id="email-error" class="error-message">Please enter a valid email address.</p>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required minlength="8" aria-label="Password" aria-describedby="password-error">
                <p id="password-error" class="error-message">Password must be at least 8 characters.</p>
            </div>
            <div class="form-group">
                <label for="role">Role</label>
                <select id="role" name="role" required aria-label="Role" aria-describedby="role-error">
                    <option value="">Select your role</option>
                    <option value="customer" ${param.role == 'customer' ? 'selected' : ''}>Customer</option>
                    <option value="seller" ${param.role == 'seller' ? 'selected' : ''}>Seller</option>
                    <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                </select>
                <p id="role-error" class="error-message">Please select your role.</p>
            </div>
            <div class="form-group">
                <label for="country">Country</label>
                <select id="country" name="country" required aria-label="Country" aria-describedby="country-error">
                    <option value="">Select your country</option>
                    <option value="US" ${param.country == 'US' ? 'selected' : ''}>United States</option>
                    <option value="CA" ${param.country == 'CA' ? 'selected' : ''}>Canada</option>
                    <option value="UK" ${param.country == 'UK' ? 'selected' : ''}>United Kingdom</option>
                    <option value="AU" ${param.country == 'AU' ? 'selected' : ''}>Australia</option>
                    <option value="IN" ${param.country == 'IN' ? 'selected' : ''}>India</option>
                    <option value="DE" ${param.country == 'DE' ? 'selected' : ''}>Germany</option>
                    <option value="FR" ${param.country == 'FR' ? 'selected' : ''}>France</option>
                    <option value="JP" ${param.country == 'JP' ? 'selected' : ''}>Japan</option>
                    <option value="CN" ${param.country == 'CN' ? 'selected' : ''}>China</option>
                    <option value="BR" ${param.country == 'BR' ? 'selected' : ''}>Brazil</option>
                    <option value="SL" ${param.country == 'SL' ? 'selected' : ''}>Sri Lanka</option>
                </select>
                <p id="country-error" class="error-message">Please select your country.</p>
            </div>
            <button type="submit" class="submit-btn" id="submitButton">
                <span class="spinner" id="spinner"></span>Create Account
            </button>
            <div class="switch-link">
                Already have an account? <a href="sign-in.jsp">Sign In</a>
            </div>
            <div id="successMessage" class="success-message">Registration successful! Redirecting...</div>
        </form>
    </div>
</div>

<script>
    document.getElementById('signupForm').addEventListener('submit', function(event) {
        event.preventDefault();
        let isValid = true;
        const submitButton = document.getElementById('submitButton');
        const spinner = document.getElementById('spinner');
        const successMessage = document.getElementById('successMessage');

        // Reset states
        document.querySelectorAll('.error-message').forEach(error => error.style.display = 'none');
        spinner.style.display = 'inline-block';
        submitButton.disabled = true;
        successMessage.style.display = 'none';

        // Full Name validation
        const fullName = document.getElementById('fullName').value.trim();
        if (!fullName) {
            document.getElementById('name-error').style.display = 'block';
            isValid = false;
        }

        // Email validation
        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            document.getElementById('email-error').style.display = 'block';
            isValid = false;
        }

        // Password validation
        const password = document.getElementById('password').value;
        if (password.length < 8) {
            document.getElementById('password-error').style.display = 'block';
            isValid = false;
        }

        // Role validation
        const role = document.getElementById('role').value;
        if (!role) {
            document.getElementById('role-error').style.display = 'block';
            isValid = false;
        }

        // Country validation
        const country = document.getElementById('country').value;
        if (!country) {
            document.getElementById('country-error').style.display = 'block';
            isValid = false;
        }

        if (isValid) {
            setTimeout(() => {
                successMessage.style.display = 'block';
                setTimeout(() => {
                    this.submit();
                }, 1000); // Delay for success message visibility
            }, 500); // Simulate server processing
        } else {
            spinner.style.display = 'none';
            submitButton.disabled = false;
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