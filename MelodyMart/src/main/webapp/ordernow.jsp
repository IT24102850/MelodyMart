<%@ page import="java.sql.*, main.java.com.melodymart.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Now | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        /* Reuse styles from shop.jsp or define minimal styles */
        body {
            font-family: 'Montserrat', sans-serif;
            background: #e1f5fe;
            color: #1565c0;
            line-height: 1.6;
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 80px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.85);
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(33, 150, 243, 0.15);
        }
        .order-details {
            padding: 20px;
        }
        .order-details h2 {
            color: #1e88e5;
            margin-bottom: 20px;
        }
        .detail-item {
            margin-bottom: 15px;
        }
        .detail-item label {
            font-weight: 600;
            margin-right: 10px;
        }
        .cta-btn {
            background: linear-gradient(135deg, #ff7043, #f4511e);
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .cta-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(33, 150, 243, 0.25);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="order-details">
        <h2>Order Confirmation</h2>
        <%
            String instrumentId = request.getParameter("instrumentId");
            String price = request.getParameter("price");
            String name = request.getParameter("name");
            String imageURL = request.getParameter("imageURL");
            String description = request.getParameter("description");

            if (instrumentId == null || name == null || price == null) {
                out.println("<p>Error: Missing order details. Please try again.</p>");
            } else {
        %>
        <div class="detail-item">
            <label>Instrument:</label> <%= name %>
        </div>
        <div class="detail-item">
            <label>Price:</label> $<%= price %>
        </div>
        <div class="detail-item">
            <label>Description:</label> <%= description != null ? description : "N/A" %>
        </div>
        <div class="detail-item">
            <label>Image:</label>
            <img src="<%= imageURL != null ? imageURL : "https://via.placeholder.com/150" %>" alt="<%= name %>" style="max-width: 150px;">
        </div>
        <form action="ProcessOrderServlet" method="post">
            <input type="hidden" name="instrumentId" value="<%= instrumentId %>">
            <input type="hidden" name="price" value="<%= price %>">
            <input type="hidden" name="name" value="<%= name %>">
            <button type="submit" class="cta-btn">Confirm Order</button>
        </form>
        <%
            }
        %>
    </div>
</div>
</body>
</html>