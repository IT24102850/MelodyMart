<%@ page import="java.io.*, java.sql.*, java.util.*, javax.servlet.http.*, javax.servlet.*, main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Generate next Instrument ID from the database
    String nextInstrumentId = "I001";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement("SELECT MAX(InstrumentID) FROM Instrument");
         ResultSet rs = ps.executeQuery()) {
        if (rs.next() && rs.getString(1) != null) {
            String lastId = rs.getString(1);
            int num = Integer.parseInt(lastId.substring(1));
            nextInstrumentId = String.format("I%03d", num + 1);
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error generating Instrument ID: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Instrument | MelodyMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #1e40af;
            --primary-light: #3b82f6;
            --primary-soft: #dbeafe;
            --secondary: #ffffff;
            --text: #1e40af;
            --text-secondary: #475569;
            --card-bg: #f8fafc;
            --shadow: 0 5px 20px rgba(30, 64, 175, 0.1);
            --border-radius: 16px;
        }

        [data-theme="dark"] {
            --primary: #3b82f6;
            --primary-light: #60a5fa;
            --primary-soft: #1e3a8a;
            --secondary: #1e293b;
            --text: #f1f5f9;
            --text-secondary: #cbd5e1;
            --card-bg: #1e293b;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #1e40af 0%, #06b6d4 100%);
            color: var(--text);
            padding: 80px 20px 40px;
            line-height: 1.6;
            margin: 0;
            min-height: 100vh;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background: var(--primary-soft);
            padding: 30px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            border: 2px solid var(--primary-light);
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            text-align: center;
            margin-bottom: 30px;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        h2 i {
            margin-right: 10px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--text);
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--primary-light);
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-color: var(--secondary);
            color: var(--text);
        }

        input:focus, select:focus, textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 5px rgba(30, 64, 175, 0.3);
            outline: none;
        }

        input.readonly {
            background-color: rgba(219, 234, 254, 0.7);
            color: var(--text-secondary);
            cursor: not-allowed;
        }

        select {
            appearance: none;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%231e40af' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E") no-repeat right 12px center;
            background-color: var(--secondary);
            padding-right: 30px;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        button {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background-color: var(--primary-light);
            transform: translateY(-2px);
        }

        .error {
            color: #ef4444;
            font-size: 14px;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>🎵 Add New Instrument</h2>

    <form action="SaveInstrument" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Instrument ID (Auto Generated):</label>
            <input type="text" name="instrumentId" value="<%= nextInstrumentId %>" readonly class="readonly">
        </div>

        <div class="form-group">
            <label>Instrument Name:</label>
            <input type="text" name="name" placeholder="Instrument Name" required>
        </div>

        <div class="form-group">
            <label>Brand ID:</label>
            <select name="brandId" required>
                <option value="">Select Brand</option>
                <option value="B001">Yamaha Music</option>
                <option value="B002">Squier</option>
                <option value="B003">Epiphone</option>
                <option value="B004">Roland Pro</option>
                <option value="B005">Korg Studio</option>
                <option value="B006">Casio Privia</option>
                <option value="B007">Taylor Baby</option>
                <option value="B008">Ibanez Prestige</option>
                <option value="B009">Pearl Export</option>
                <option value="B010">Boss Katana</option>
            </select>
        </div>

        <div class="form-group">
            <label>Manufacturer ID:</label>
            <select name="manufacturerId" required>
                <option value="">Select Manufacturer</option>
                <option value="M001">Yamaha Corporation</option>
                <option value="M002">Fender Musical Instruments</option>
                <option value="M003">Gibson Brands</option>
                <option value="M004">Roland Corporation</option>
                <option value="M005">Korg Inc.</option>
                <option value="M006">Casio Musical Instruments</option>
                <option value="M007">Taylor Guitars</option>
                <option value="M008">Ibanez</option>
                <option value="M009">Pearl Drums</option>
                <option value="M010">Boss Corporation</option>
            </select>
        </div>

        <div class="form-group">
            <label>Model:</label>
            <input type="text" name="model" placeholder="Model">
        </div>

        <div class="form-group">
            <label>Color:</label>
            <input type="text" name="color" placeholder="Color">
        </div>

        <div class="form-group">
            <label>Price:</label>
            <input type="number" step="0.01" name="price" placeholder="Price" required>
        </div>

        <div class="form-group">
            <label>Quantity:</label>
            <input type="number" name="quantity" placeholder="Quantity" required>
        </div>

        <div class="form-group">
            <label>Warranty:</label>
            <input type="text" name="warranty" placeholder="Warranty">
        </div>

        <div class="form-group">
            <label>Description:</label>
            <textarea name="description" placeholder="Description"></textarea>
        </div>

        <div class="form-group">
            <label>Upload Images:</label>
            <input type="file" name="images" accept="image/*" multiple required>
        </div>

        <button type="submit">Add Instrument</button>
        <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
    </form>
</div>

<script>
    // Smooth scroll prevention for better UX
    document.querySelector('form').addEventListener('submit', function(e) {
        e.preventDefault();
        this.submit();
    });
</script>
</body>
</html>