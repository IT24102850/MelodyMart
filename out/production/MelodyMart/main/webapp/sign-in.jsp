<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Your original head and styles remain the same -->
</head>
<body>
<div class="floating-icons">
    <!-- Your floating icons -->
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
        Don't have an account? <a href="sign-up.jsp">Sign Up</a>
    </div>

    <!-- Rest of your original content (divider, social buttons) -->
</div>

<!-- Your original script -->
</body>
</html>