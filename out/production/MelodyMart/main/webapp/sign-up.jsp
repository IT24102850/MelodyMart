<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, org.mindrot.jbcrypt.BCrypt, java.sql.DriverManager, java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException, java.util.Date" %>
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

            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                conn.setAutoCommit(false);

                String personSql = "INSERT INTO Person (FirstName, LastName, Email, Phone, Password, Street, City, State, ZipCode, Country, RegistrationDate, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?)";
                stmt = conn.prepareStatement(personSql, Statement.RETURN_GENERATED_KEYS);
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

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    ResultSet rs = stmt.getGeneratedKeys();
                    int personId = 0;
                    if (rs.next()) personId = rs.getInt(1);
                    rs.close();

                    if ("customer".equalsIgnoreCase(role)) {
                        PreparedStatement customerStmt = conn.prepareStatement("INSERT INTO Customer (CustomerID, PersonID) VALUES (?, ?)");
                        customerStmt.setInt(1, personId);
                        customerStmt.setInt(2, personId);
                        customerStmt.executeUpdate();
                        customerStmt.close();
                    } else if ("seller".equalsIgnoreCase(role)) {
                        PreparedStatement sellerStmt = conn.prepareStatement("INSERT INTO Seller (SellerID, PersonID) VALUES (?, ?)");
                        sellerStmt.setInt(1, personId);
                        sellerStmt.setInt(2, personId);
                        sellerStmt.executeUpdate();
                        sellerStmt.close();
                    } else if ("admin".equalsIgnoreCase(role)) {
                        PreparedStatement adminStmt = conn.prepareStatement("INSERT INTO Admin (AdminID, PersonID) VALUES (?, ?)");
                        adminStmt.setInt(1, personId);
                        adminStmt.setInt(2, personId);
                        adminStmt.executeUpdate();
                        adminStmt.close();
                    }

                    conn.commit();
                    session.setAttribute("userEmail", email.trim().toLowerCase());
                    session.setAttribute("userRole", role.toLowerCase());
                    session.setAttribute("userFullName", firstName.trim() + " " + lastName.trim());
                    response.sendRedirect("sign-in.jsp");
                    return;
                }
            } catch (SQLException e) {
                if (conn != null) conn.rollback();
                request.setAttribute("errorMessage", e.getMessage().contains("UNIQUE KEY") ? "Email already exists" : "Database error: " + e.getMessage());
            } finally {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
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

        .signup-container {
            width: 100%;
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
        }

        .signup-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        h1 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2.5rem;
            color: var(--text);
            margin-bottom: 20px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .error-message {
            color: #ff6b6b;
            background: rgba(255, 0, 0, 0.1);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            display: none;
        }

        .form-grid {
            display: grid;
            gap: 15px;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        }

        .form-group {
            text-align: left;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: var(--text-secondary);
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--glass-border);
            border-radius: 5px;
            color: var(--text);
            font-size: 1rem;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 2px rgba(138, 43, 226, 0.3);
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background: var(--gradient);
            border: none;
            border-radius: 25px;
            color: var(--text);
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.4);
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
            color: var(--text-secondary);
        }

        .switch-link a {
            color: var(--primary-light);
            text-decoration: none;
            font-weight: 600;
        }

        .switch-link a:hover {
            color: var(--accent);
            text-decoration: underline;
        }

        .success-message {
            color: #4CAF50;
            background: rgba(76, 175, 80, 0.1);
            padding: 10px;
            border-radius: 5px;
            margin-top: 15px;
            display: none;
        }

        @media (max-width: 768px) {
            .signup-card {
                padding: 20px;
            }

            h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<div class="signup-container">
    <div class="signup-card">
        <h1>Sign Up for MelodyMart</h1>
        <c:if test="${not empty errorMessage}">
            <p class="error-message" style="display: block;"><c:out value="${errorMessage}"/></p>
        </c:if>
        <form id="signupForm" action="sign-up.jsp" method="post" class="form-grid" novalidate>
            <div class="form-group">
                <label for="firstName">First Name</label>
                <input type="text" id="firstName" name="firstName" value="${param.firstName}" required aria-label="First Name" aria-describedby="name-error">
                <p id="name-error" class="error-message">Please enter your first name.</p>
            </div>
            <div class="form-group">
                <label for="lastName">Last Name</label>
                <input type="text" id="lastName" name="lastName" value="${param.lastName}" required aria-label="Last Name" aria-describedby="lastName-error">
                <p id="lastName-error" class="error-message">Please enter your last name.</p>
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
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" value="${param.phone}" aria-label="Phone">
            </div>
            <div class="form-group">
                <label for="street">Street</label>
                <input type="text" id="street" name="street" value="${param.street}" aria-label="Street">
            </div>
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" id="city" name="city" value="${param.city}" required aria-label="City" aria-describedby="city-error">
                <p id="city-error" class="error-message">Please enter your city.</p>
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
            <div class="form-group">
                <label for="role">Role</label>
                <select id="role" name="role" required aria-label="Role" aria-describedby="role-error">
                    <option value="">Select your role</option>
                    <option value="customer" ${param.role == 'customer' ? 'selected' : ''}>Customer</option>
                    <option value="seller" ${param.role == 'seller' ? 'selected' : ''}>Seller</option>
                </select>
                <p id="role-error" class="error-message">Please select your role.</p>
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

        // Validation
        const firstName = document.getElementById('firstName').value.trim();
        if (!firstName) {
            document.getElementById('name-error').style.display = 'block';
            isValid = false;
        }

        const lastName = document.getElementById('lastName').value.trim();
        if (!lastName) {
            document.getElementById('lastName-error').style.display = 'block';
            isValid = false;
        }

        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            document.getElementById('email-error').style.display = 'block';
            isValid = false;
        }

        const password = document.getElementById('password').value;
        if (password.length < 8) {
            document.getElementById('password-error').style.display = 'block';
            isValid = false;
        }

        const city = document.getElementById('city').value.trim();
        if (!city) {
            document.getElementById('city-error').style.display = 'block';
            isValid = false;
        }

        const country = document.getElementById('country').value;
        if (!country) {
            document.getElementById('country-error').style.display = 'block';
            isValid = false;
        }

        const role = document.getElementById('role').value;
        if (!role) {
            document.getElementById('role-error').style.display = 'block';
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