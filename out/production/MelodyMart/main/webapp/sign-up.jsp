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
                    response.sendRedirect("user-dashboard.jsp");
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
            --glass-bg: rgba(30, 30, 30, 0.7);
            --glass-border: rgba(255, 255, 255, 0.1);
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
        }

        body {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('./images/1162694.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
            color: var(--text);
            overflow-x: hidden;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .signup-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 80px);
            padding: 20px;
        }

        .signup-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 30px;
            max-width: 400px;
            width: 100%;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .signup-card h1 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2.5rem;
            text-align: center;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--text-secondary);
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--glass-border);
            background: var(--secondary);
            color: var(--text);
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 5px rgba(138, 43, 226, 0.5);
        }

        .error-message {
            color: #ef4444;
            font-size: 12px;
            margin-top: 5px;
            animation: shake 0.3s ease-in-out;
            display: none;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .submit-btn {
            background: var(--gradient);
            padding: 12px;
            border: none;
            border-radius: 30px;
            color: var(--text);
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .submit-btn:hover {
            background: var(--gradient-alt);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
        }

        .switch-link {
            text-align: center;
            margin-top: 15px;
            color: var(--text-secondary);
        }

        .switch-link a {
            color: var(--accent);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .switch-link a:hover {
            color: var(--primary-light);
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
        <form id="signupForm" action="sign-up.jsp" method="post" class="space-y-4" novalidate>
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
            <button type="submit" class="submit-btn">Create Account</button>
            <div class="switch-link">
                Already have an account? <a href="sign-in.jsp">Sign In</a>
            </div>
        </form>
    </div>
</div>

<script>
    document.getElementById('signupForm').addEventListener('submit', function(event) {
        event.preventDefault();
        let isValid = true;

        // Reset error messages
        document.querySelectorAll('.error-message').forEach(error => error.style.display = 'none');

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
            this.submit();
        }
    });
</script>
</body>
</html>