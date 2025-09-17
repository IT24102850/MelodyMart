<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign In</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: #f5f5f5;
        }
        .login-container {
            margin-top: 100px;
            max-width: 400px;
            padding: 20px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.15);
        }
        .btn-custom {
            background-color: #007bff;
            color: #fff;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center">
    <div class="login-container">
        <h3 class="text-center mb-4">Sign In</h3>

        <!-- Display error message if passed via query param -->
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
        <div class="alert alert-danger text-center">
            <%= error %>
        </div>
        <%
            }
        %>

        <!-- Sign In Form -->
        <form action="login" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" name="email" id="email"
                       class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" name="password" id="password"
                       class="form-control" required>
            </div>

            <button type="submit" class="btn btn-custom w-100">Sign In</button>
        </form>

        <p class="text-center mt-3">
            Don’t have an account? <a href="sign_up.jsp">Sign Up</a>
        </p>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
