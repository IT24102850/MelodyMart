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
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            margin-bottom: 10px;
        }

        .card {
            background: var(--primary-soft);
            padding: 30px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            border: 2px solid var(--primary-light);
            margin-bottom: 30px;
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

        .success {
            color: #10b981;
            font-size: 14px;
            text-align: center;
            margin-top: 10px;
        }

        /* Table Styles */
        .table-container {
            overflow-x: auto;
            margin-top: 20px;
        }

        .instruments-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--secondary);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        .instruments-table th,
        .instruments-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .instruments-table th {
            background: var(--primary);
            color: white;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .instruments-table tr:hover {
            background: #f1f5f9;
        }

        .instruments-table tr:nth-child(even) {
            background: #f8fafc;
        }

        .instrument-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            border: 2px solid var(--primary-light);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 0.85rem;
        }

        .btn-edit {
            background: var(--primary);
            color: white;
        }

        .btn-edit:hover {
            background: var(--primary-light);
            transform: translateY(-1px);
        }

        .btn-delete {
            background: #ef4444;
            color: white;
        }

        .btn-delete:hover {
            background: #dc2626;
            transform: translateY(-1px);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 30px;
            border-radius: 16px;
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .close {
            float: right;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
            color: var(--text-secondary);
        }

        .close:hover {
            color: var(--text);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .image-preview {
            display: flex;
            gap: 10px;
            margin-top: 10px;
            flex-wrap: wrap;
        }

        .preview-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 6px;
            border: 2px solid var(--primary-light);
        }

        .current-images {
            margin-top: 15px;
        }

        .current-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 6px;
            border: 2px solid var(--primary-light);
        }

        .image-container {
            position: relative;
            display: inline-block;
            margin-right: 15px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>🎵 Add New Instrument</h2>
    </div>

    <!-- Success/Error Messages -->
    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if (success != null) {
    %>
    <div class="success">
        ✅ <%= getSuccessMessage(success) %>
    </div>
    <%
        }

        if (error != null) {
    %>
    <div class="error">
        ❌ <%= getErrorMessage(error) %>
    </div>
    <%
        }
    %>

    <!-- Add Instrument Form -->
    <div class="card">
        <h3 style="margin-top: 0;">Add New Instrument</h3>
        <form action="SaveInstrument" method="post" enctype="multipart/form-data" id="addForm">
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
                <label>Specifications:</label>
                <textarea name="specifications" placeholder="Enter detailed specifications of the instrument (e.g., dimensions, materials, features, technical details)"></textarea>
            </div>

            <div class="form-group">
                <label>Description:</label>
                <textarea name="description" placeholder="Description"></textarea>
            </div>

            <div class="form-group">
                <label>Upload Images:</label>
                <input type="file" name="images" accept="image/*" multiple required id="imageInput">
                <div class="image-preview" id="imagePreview"></div>
            </div>

            <button type="submit">Add Instrument</button>
        </form>
    </div>

    <!-- Instruments Table -->
    <div class="card">
        <h3>Existing Instruments</h3>
        <div class="table-container">
            <table class="instruments-table">
                <thead>
                <tr>
                    <th>Image</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Color</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Stock Level</th>
                    <th>Warranty</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement ps = conn.prepareStatement("SELECT * FROM Instrument ORDER BY InstrumentID");
                         ResultSet rs = ps.executeQuery()) {

                        while (rs.next()) {
                            String imageUrl = rs.getString("ImageURL");
                            // Fix image URL if it contains "imageofinstrument:"
                            if (imageUrl != null && imageUrl.startsWith("imageofinstrument:")) {
                                imageUrl = imageUrl.replace("imageofinstrument:", "images/");
                            }
                %>
                <tr>
                    <td>
                        <img src="<%= imageUrl != null ? imageUrl : "images/default-instrument.jpg" %>"
                             alt="<%= rs.getString("Name") %>" class="instrument-image"
                             onerror="this.src='images/default-instrument.jpg'">
                    </td>
                    <td><strong><%= rs.getString("InstrumentID") %></strong></td>
                    <td><%= rs.getString("Name") %></td>
                    <td><%= rs.getString("BrandID") %></td>
                    <td><%= rs.getString("Model") != null ? rs.getString("Model") : "N/A" %></td>
                    <td><%= rs.getString("Color") != null ? rs.getString("Color") : "N/A" %></td>
                    <td>$<%= String.format("%.2f", rs.getDouble("Price")) %></td>
                    <td><%= rs.getInt("Quantity") %></td>
                    <td><%= rs.getString("StockLevel") != null ? rs.getString("StockLevel") : "In Stock" %></td>
                    <td><%= rs.getString("Warranty") != null ? rs.getString("Warranty") : "N/A" %></td>
                    <td>
                        <div class="action-buttons">
                            <button class="btn btn-edit" onclick="openEditModal('<%= rs.getString("InstrumentID") %>')">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                            <form action="RemoveInstrumentServlet" method="post" style="display: inline;">
                                <input type="hidden" name="instrumentId" value="<%= rs.getString("InstrumentID") %>">
                                <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to remove this instrument?')">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='11' style='color:red; text-align:center; padding:20px;'>Error loading instruments: " + e.getMessage() + "</td></tr>");
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditModal()">&times;</span>
        <h3>Edit Instrument</h3>
        <form action="UpdateInstrumentServlet" method="post" enctype="multipart/form-data" id="editForm">
            <input type="hidden" name="instrumentId" id="editInstrumentId">

            <div class="form-row">
                <div class="form-group">
                    <label>Instrument Name:</label>
                    <input type="text" name="name" id="editName" required>
                </div>

                <div class="form-group">
                    <label>Brand ID:</label>
                    <select name="brandId" id="editBrandId" required>
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
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Manufacturer ID:</label>
                    <select name="manufacturerId" id="editManufacturerId" required>
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
                    <input type="text" name="model" id="editModel">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Color:</label>
                    <input type="text" name="color" id="editColor">
                </div>

                <div class="form-group">
                    <label>Price:</label>
                    <input type="number" step="0.01" name="price" id="editPrice" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Quantity:</label>
                    <input type="number" name="quantity" id="editQuantity" required>
                </div>

                <div class="form-group">
                    <label>Warranty:</label>
                    <input type="text" name="warranty" id="editWarranty">
                </div>
            </div>

            <div class="form-group">
                <label>Specifications:</label>
                <textarea name="specifications" id="editSpecifications"></textarea>
            </div>

            <div class="form-group">
                <label>Description:</label>
                <textarea name="description" id="editDescription"></textarea>
            </div>

            <div class="form-group">
                <label>Current Image:</label>
                <div class="current-images" id="currentImages"></div>
            </div>

            <div class="form-group">
                <label>Update Images:</label>
                <input type="file" name="images" accept="image/*" multiple id="editImageInput">
                <div class="image-preview" id="editImagePreview"></div>
            </div>

            <div style="display: flex; gap: 10px;">
                <button type="submit" class="btn btn-edit">Update Instrument</button>
                <button type="button" class="btn btn-delete" onclick="closeEditModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Image preview for add form
    document.getElementById('imageInput').addEventListener('change', function(e) {
        const preview = document.getElementById('imagePreview');
        preview.innerHTML = '';

        for (let file of e.target.files) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.className = 'preview-image';
                preview.appendChild(img);
            }
            reader.readAsDataURL(file);
        }
    });

    // Image preview for edit form
    document.getElementById('editImageInput').addEventListener('change', function(e) {
        const preview = document.getElementById('editImagePreview');
        preview.innerHTML = '';

        for (let file of e.target.files) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.className = 'preview-image';
                preview.appendChild(img);
            }
            reader.readAsDataURL(file);
        }
    });

    function openEditModal(instrumentId) {
        // Fetch instrument data via AJAX
        fetch('GetInstrumentServlet?instrumentId=' + instrumentId)
            .then(response => response.json())
            .then(data => {
                document.getElementById('editInstrumentId').value = data.instrumentId;
                document.getElementById('editName').value = data.name;
                document.getElementById('editBrandId').value = data.brandId;
                document.getElementById('editManufacturerId').value = data.manufacturerId;
                document.getElementById('editModel').value = data.model || '';
                document.getElementById('editColor').value = data.color || '';
                document.getElementById('editPrice').value = data.price;
                document.getElementById('editQuantity').value = data.quantity;
                document.getElementById('editWarranty').value = data.warranty || '';
                document.getElementById('editSpecifications').value = data.specifications || '';
                document.getElementById('editDescription').value = data.description || '';

                // Display current image
                const currentImages = document.getElementById('currentImages');
                currentImages.innerHTML = '';
                if (data.imageUrl) {
                    let displayUrl = data.imageUrl;
                    if (displayUrl.startsWith('imageofinstrument:')) {
                        displayUrl = displayUrl.replace('imageofinstrument:', 'images/');
                    }

                    const container = document.createElement('div');
                    container.className = 'image-container';
                    container.innerHTML = `
                        <img src="${displayUrl}" class="current-image" onerror="this.src='images/default-instrument.jpg'">
                    `;
                    currentImages.appendChild(container);
                }

                document.getElementById('editModal').style.display = 'block';
            })
            .catch(error => {
                console.error('Error fetching instrument data:', error);
                alert('Error loading instrument data');
            });
    }

    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        const modal = document.getElementById('editModal');
        if (event.target === modal) {
            closeEditModal();
        }
    }

    // Prevent form submission scroll
    document.querySelector('#addForm').addEventListener('submit', function(e) {
        e.preventDefault();
        this.submit();
    });
</script>
</body>
</html>

<%!
    // Helper methods for success/error messages
    private String getSuccessMessage(String success) {
        switch (success) {
            case "InstrumentAdded": return "Instrument added successfully!";
            case "InstrumentUpdated": return "Instrument updated successfully!";
            case "InstrumentRemoved": return "Instrument removed successfully!";
            default: return "Operation completed successfully!";
        }
    }

    private String getErrorMessage(String error) {
        switch (error) {
            case "AddFailed": return "Failed to add instrument!";
            case "UpdateFailed": return "Failed to update instrument!";
            case "RemoveFailed": return "Failed to remove instrument!";
            case "InstrumentNotFound": return "Instrument not found!";
            case "ServerError": return "Server error occurred!";
            default: return "An error occurred!";
        }
    }
%>