<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page isErrorPage="true" %>
<%
    String orderId = request.getParameter("orderId");
    String paymentId = null;
    String errorMessage = null;

    if (orderId == null) {
        errorMessage = "No order ID provided. Please check the payment process.";
    } else {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT PaymentID FROM Payment WHERE OrderID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                paymentId = rs.getString("PaymentID");
            } else {
                errorMessage = "No payment record found for Order ID: " + orderId;
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            errorMessage = "Database error: " + e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            errorMessage = "Unexpected error: " + e.getMessage();
            e.printStackTrace();
        }
    }

    if (paymentId == null && errorMessage == null) {
        paymentId = "Not Available"; // Fallback
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Success | MelodyMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --light: #f8f9fa;
            --dark: #212529;
            --border: #e9ecef;
            --success: #28a745;
            --error: #dc3545;
        }

        body {
            background: var(--light);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
            padding: 20px;
            margin: 0;
        }

        .success-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .success-icon {
            font-size: 3rem;
            color: var(--success);
            margin-bottom: 20px;
        }

        h1 {
            color: var(--success);
            font-size: 2rem;
            margin-bottom: 15px;
        }

        p {
            font-size: 1.1rem;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .payment-ref {
            font-weight: 600;
            color: var(--primary);
        }

        .error-message {
            color: var(--error);
            background: #f8d7da;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
            display: <%= errorMessage != null ? "block" : "none" %>;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: var(--primary);
            font-weight: 600;
            padding: 10px 20px;
            border: 2px solid var(--primary);
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        a:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
    </style>
</head>
<body>
<div class="success-container">
    <div class="success-icon">
        <i class="fas fa-check-circle"></i>
    </div>
    <h1>Payment Successful!</h1>
    <% if (errorMessage != null) { %>
    <div class="error-message">
        <%= errorMessage %>
    </div>
    <% } %>
    <p>Your payment reference ID is: <span class="payment-ref"><%= paymentId %></span></p>
    <p>Thank you for shopping with MelodyMart 🎵</p>
    <a href="index.jsp">Return to Home</a>
</div>
</body>
</html>