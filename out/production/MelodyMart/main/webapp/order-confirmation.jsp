<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --success: #28a745;
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
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
            background-image: linear-gradient(rgba(10, 10, 10, 0.9), rgba(10, 10, 10, 0.9)),
            url('https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1740&q=80');
            background-size: cover;
        }

        .confirmation-container {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 40px;
            text-align: center;
            max-width: 500px;
            width: 100%;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5);
        }

        .success-icon {
            font-size: 80px;
            color: var(--success);
            margin-bottom: 20px;
        }

        .confirmation-title {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            margin-bottom: 15px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .confirmation-message {
            color: var(--text-secondary);
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .order-details {
            background: rgba(138, 43, 226, 0.1);
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
            text-align: left;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .detail-label {
            color: var(--text-secondary);
        }

        .detail-value {
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 25px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            flex: 1;
            text-align: center;
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
        }

        .btn-secondary {
            background: transparent;
            border: 2px solid var(--primary-light);
            color: var(--primary-light);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
        }
    </style>
</head>
<body>
<div class="confirmation-container">
    <div class="success-icon">
        <i class="fas fa-check-circle"></i>
    </div>

    <h1 class="confirmation-title">Order Confirmed!</h1>

    <p class="confirmation-message">
        Thank you for your purchase! Your order has been successfully placed and will be processed shortly.
    </p>

    <div class="order-details">
        <div class="detail-item">
            <span class="detail-label">Order Number:</span>
            <span class="detail-value">#MM-<%= System.currentTimeMillis() %></span>
        </div>
        <div class="detail-item">
            <span class="detail-label">Total Amount:</span>
            <span class="detail-value">LKR 27,539</span>
        </div>
        <div class="detail-item">
            <span class="detail-label">Estimated Delivery:</span>
            <span class="detail-value">3-5 business days</span>
        </div>
    </div>

    <div class="action-buttons">
        <a href="payment-gateway.jsp" class="btn btn-primary">Continue Shopping</a>
        <a href="orders.jsp" class="btn btn-secondary">View Orders</a>
    </div>
</div>
</body>
</html>