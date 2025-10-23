<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, org.mindrot.jbcrypt.BCrypt" %>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipCode");
        String country = request.getParameter("country");
        String role = request.getParameter("role");

        if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.length() < 8 ||
                role == null || role.trim().isEmpty() ||
                country == null || country.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required and password must be at least 8 characters.");
        } else {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            } catch (ClassNotFoundException e) {
                request.setAttribute("errorMessage", "JDBC Driver not found.");
                return;
            }

            String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true";
            String dbUser = "Hasiru";
            String dbPassword = "hasiru2004";

            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                // Auto-commit is true by default
                // Check if email already exists
                try (PreparedStatement checkStmt = conn.prepareStatement("SELECT COUNT(*) FROM Person WHERE Email = ?")) {
                    checkStmt.setString(1, email.trim().toLowerCase());
                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        request.setAttribute("errorMessage", "Email already exists. Please use a different email.");
                        rs.close();
                        return;
                    }
                    rs.close();
                }

                // Insert into Person only — trigger will generate PersonID and handle role tables
                String sql = "INSERT INTO Person (FirstName, LastName, Email, Phone, Password, Street, City, State, ZipCode, Country, RegistrationDate, role) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                    stmt.setString(1, firstName.trim());
                    stmt.setString(2, lastName.trim());
                    stmt.setString(3, email.trim().toLowerCase());
                    stmt.setString(4, phone);
                    stmt.setString(5, hashedPassword);
                    stmt.setString(6, street);
                    stmt.setString(7, city);
                    stmt.setString(8, state);
                    stmt.setString(9, zipCode);
                    stmt.setString(10, country);
                    stmt.setString(11, role.toLowerCase());
                    stmt.executeUpdate();
                }

                // ✅ At this point, the trigger has already created the PersonID and related Customer/Seller/Admin entry
                session.setAttribute("userEmail", email.trim().toLowerCase());
                session.setAttribute("userRole", role.toLowerCase());
                session.setAttribute("userFullName", firstName.trim() + " " + lastName.trim());
                response.sendRedirect("sign-in.jsp");
                return;

            } catch (SQLException e) {
                request.setAttribute("errorMessage", e.getMessage().contains("UNIQUE KEY")
                        ? "Email already exists. Please use a different email."
                        : "Database error: " + e.getMessage());
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
            --primary: #3b82f6; /* Bright Blue */
            --primary-light: #60a5fa;
            --secondary: #ffffff; /* White */
            --accent: #06b6d4; /* Cyan Accent */
            --gold-accent: #f59e0b; /* Amber Gold */
            --text: #ffffff; /* Dark Blue-Gray */
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

        .signup-container {
            width: 100%;
            max-width: 700px;
            margin: 20px auto;
            padding: 20px;
            z-index: 1;
        }

        .signup-card {
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

        .signup-card:hover {
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

        h1 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2.5rem;
            color: white;
            margin-bottom: 25px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .error-message {
            background: rgba(239, 68, 68, 0.2);
            color: #fecaca;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 500;
            border: 1px solid rgba(239, 68, 68, 0.3);
            backdrop-filter: blur(5px);
        }

        .form-grid {
            display: grid;
            gap: 15px;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        }

        .form-group {
            text-align: left;
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: #e2e8f0;
            margin-bottom: 8px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
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

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
            background: rgba(255, 255, 255, 0.15);
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background: var(--gradient);
            border: none;
            border-radius: 25px;
            color: white;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(5px);
            grid-column: 1 / -1;
            margin-top: 10px;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        .submit-btn .spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 3px solid #fff;
            border-top: 3px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 10px;
            vertical-align: middle;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .switch-link {
            margin-top: 15px;
            color: #cbd5e1;
            grid-column: 1 / -1;
            text-align: center;
        }

        .switch-link a {
            color: var(--primary-light);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .switch-link a:hover {
            color: var(--accent);
            text-decoration: underline;
        }

        .success-message {
            color: #4CAF50;
            background: rgba(76, 175, 80, 0.2);
            padding: 12px;
            border-radius: 8px;
            margin-top: 15px;
            display: none;
            align-items: center;
            justify-content: center;
            gap: 10px;
            border: 1px solid rgba(76, 175, 80, 0.3);
            backdrop-filter: blur(5px);
            grid-column: 1 / -1;
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

        .form-group input:focus,
        .form-group select:focus {
            border-color: var(--primary-light);
        }

        .submit-btn.loading {
            pointer-events: none;
            opacity: 0.8;
        }

        .submit-btn.loading::after {
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
            .signup-card {
                padding: 25px;
            }

            h1 {
                font-size: 2rem;
            }

            .logo a {
                font-size: 2rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
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

<div class="signup-container">
    <div class="signup-card">
        <div class="logo">
            <a href="index.jsp"><i class="fas fa-music"></i>Melody Mart</a>
        </div>

        <h1>Sign Up for MelodyMart</h1>

        <c:if test="${not empty errorMessage}">
            <div class="error-message" style="display: flex;">
                <i class="fas fa-exclamation-circle"></i> <c:out value="${errorMessage}"/>
            </div>
        </c:if>

        <form id="signupForm" action="sign-up.jsp" method="post" class="form-grid" novalidate>
            <div class="form-group">
                <label for="firstName">First Name</label>
                <input type="text" id="firstName" name="firstName" value="${param.firstName}" required aria-label="First Name">
            </div>
            <div class="form-group">
                <label for="lastName">Last Name</label>
                <input type="text" id="lastName" name="lastName" value="${param.lastName}" required aria-label="Last Name">
            </div>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="${param.email}" required aria-label="Email">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required minlength="8" aria-label="Password">
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" value="${param.phone}" aria-label="Phone">
            </div>
            <div class="form-group">
                <label for="street">Street</label>
                <input type="text" id="street" name="street" value="${param.street}" aria-label="Street">
            </div>
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" id="city" name="city" value="${param.city}" required aria-label="City">
            </div>
            <div class="form-group">
                <label for="state">State</label>
                <input type="text" id="state" name="state" value="${param.state}" aria-label="State">
            </div>
            <div class="form-group">
                <label for="zipCode">Zip Code</label>
                <input type="text" id="zipCode" name="zipCode" value="${param.zipCode}" aria-label="Zip Code">
            </div>
            <div class="form-group">
                <label for="country">Country</label>
                <select id="country" name="country" required aria-label="Country">
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
            </div>
            <div class="form-group">
                <label for="role">Role</label>
                <select id="role" name="role" required aria-label="Role">
                    <option value="">Select your role</option>
                    <option value="customer" ${param.role == 'customer' ? 'selected' : ''}>Customer</option>
                    <option value="seller" ${param.role == 'seller' ? 'selected' : ''}>Seller</option>
                </select>
            </div>

            <button type="submit" class="submit-btn" id="submitButton">
                <span class="spinner" id="spinner"></span>Create Account
            </button>

            <div class="switch-link">
                Already have an account? <a href="sign-in.jsp">Sign In</a>
            </div>

            <div id="successMessage" class="success-message">
                <i class="fas fa-check-circle"></i> Registration successful! Redirecting...
            </div>
        </form>
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

        // Validation
        const firstName = document.getElementById('firstName').value.trim();
        if (!firstName) {
            isValid = false;
        }

        const lastName = document.getElementById('lastName').value.trim();
        if (!lastName) {
            isValid = false;
        }

        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            isValid = false;
        }

        const password = document.getElementById('password').value;
        if (password.length < 8) {
            isValid = false;
        }

        const city = document.getElementById('city').value.trim();
        if (!city) {
            isValid = false;
        }

        const country = document.getElementById('country').value;
        if (!country) {
            isValid = false;
        }

        const role = document.getElementById('role').value;
        if (!role) {
            isValid = false;
        }

        if (isValid) {
            // Show loading state
            submitButton.classList.add('loading');

            setTimeout(() => {
                successMessage.style.display = 'flex';
                setTimeout(() => {
                    this.submit();
                }, 1000); // Delay for success message visibility
            }, 500); // Simulate server processing
        } else {
            spinner.style.display = 'none';
            submitButton.disabled = false;
            submitButton.classList.remove('loading');

            // Show error message
            const errorDiv = document.createElement('div');
            errorDiv.className = 'error-message';
            errorDiv.style.display = 'flex';
            errorDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i> Please fill in all required fields correctly.';
            document.getElementById('signupForm').insertBefore(errorDiv, document.querySelector('.form-group'));
        }
    });

    // Initialize floating icons
    addFloatingIcons();
</script>
</body>
</html>