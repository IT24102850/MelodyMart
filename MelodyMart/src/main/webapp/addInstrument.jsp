<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Add/Update Instrument</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon.ico">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2563eb;
            --secondary: #f8fafc;
            --text: #1e293b;
            --card-bg: #ffffff;
            --border: #e2e8f0;
            --success: #10b981;
            --warning: #f59e0b;
            --error: #ef4444;
            --info: #3b82f6;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: var(--secondary);
            color: var(--text);
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            margin-bottom: 30px;
            border-bottom: 2px solid var(--border);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 28px;
            font-weight: 700;
            color: var(--primary);
        }

        .logo i {
            font-size: 32px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .back-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: var(--error);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .back-btn:hover {
            background: #dc2626;
            transform: translateY(-2px);
        }

        .user-profile {
            width: 45px;
            height: 45px;
            background: var(--gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }

        .dashboard-header {
            margin-bottom: 30px;
        }

        .dashboard-header h1 {
            font-size: 36px;
            color: var(--text);
            margin-bottom: 10px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .dashboard-header p {
            font-size: 18px;
            color: #64748b;
        }

        .form-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        @media (max-width: 768px) {
            .form-container {
                grid-template-columns: 1fr;
            }
        }

        .form-section {
            background: var(--card-bg);
            padding: 30px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
        }

        .form-section h2 {
            font-size: 20px;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: var(--text);
            margin-bottom: 8px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--text);
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .required::after {
            content: " *";
            color: var(--error);
        }

        .image-upload-container {
            border: 2px dashed var(--border);
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .image-upload-container:hover {
            border-color: var(--primary);
        }

        .image-upload-container.dragover {
            border-color: var(--primary);
            background: rgba(37, 99, 235, 0.05);
        }

        .image-preview {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
        }

        .preview-item {
            position: relative;
            width: 100px;
            height: 100px;
        }

        .preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--border);
        }

        .preview-item .remove-btn {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--error);
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 12px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #64748b;
            color: white;
        }

        .btn-secondary:hover {
            background: #475569;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: var(--error);
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
        }

        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
            align-items: center;
            gap: 10px;
            font-weight: 500;
        }

        .message-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .message-error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .instrument-list {
            background: var(--card-bg);
            padding: 30px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
            margin-top: 40px;
        }

        .instrument-list h2 {
            font-size: 24px;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border);
        }

        .instrument-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }

        .instrument-table th,
        .instrument-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--border);
        }

        .instrument-table th {
            background: #f8fafc;
            font-weight: 600;
            color: var(--text);
        }

        .image-gallery {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }

        .image-gallery img {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid var(--border);
            cursor: pointer;
        }

        .action-buttons-small {
            display: flex;
            gap: 8px;
        }

        .btn-small {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background: var(--info);
            color: white;
        }

        .btn-delete {
            background: var(--error);
            color: white;
        }

        .btn-edit:hover,
        .btn-delete:hover {
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
<div class="container">
    <header>
        <div class="logo">
            <i class="fas fa-music"></i>
            <span>MelodyMart</span>
        </div>
        <div class="header-right">
            <a href="sellerdashboard.jsp" class="back-btn">
                <i class="fas fa-arrow-left"></i>
                <span>Back to Dashboard</span>
            </a>
            <div class="user-profile">
                <i class="fas fa-user"></i>
            </div>
        </div>
    </header>

    <!-- Role Check -->
    <%
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null || !userRole.equalsIgnoreCase("seller")) {
            response.sendRedirect("sign-in.jsp?error=Access denied. Please log in as a seller.");
            return;
        }
        String status = request.getParameter("status");
        String message = request.getParameter("message");
        if ("success".equals(status) && message != null) {
            out.println("<div class='message message-success' style='display: flex;'><i class='fas fa-check-circle'></i> " + URLDecoder.decode(message, "UTF-8") + "</div>");
        } else if ("error".equals(status) && message != null) {
            out.println("<div class='message message-error' style='display: flex;'><i class='fas fa-exclamation-circle'></i> " + URLDecoder.decode(message, "UTF-8") + "</div>");
        }
        session.removeAttribute("status");
        session.removeAttribute("message");
    %>

    <div class="dashboard-header">
        <h1>Instrument Management</h1>
        <p>Add new instruments or update existing ones in your inventory</p>
    </div>

    <div id="dynamicMessage" class="message message-error" style="display: none;">
        <i class="fas fa-exclamation-circle"></i> <span id="dynamicMessageText"></span>
    </div>
    <div id="dynamicSuccess" class="message message-success" style="display: none;">
        <i class="fas fa-check-circle"></i> <span id="dynamicSuccessText"></span>
    </div>

    <form id="instrumentForm" method="post" action="InstrumentManagementServlet" enctype="multipart/form-data">
        <input type="hidden" id="instrumentID" name="instrumentID" value="">
        <input type="hidden" name="action" value="save">

        <div class="form-container">
            <div class="form-section">
                <h2>Basic Information</h2>

                <div class="form-group">
                    <label for="name" class="required">Instrument Name</label>
                    <input type="text" id="name" name="name" required>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" placeholder="Describe the instrument..."></textarea>
                </div>

                <div class="form-group">
                    <label for="manufacturerID" class="required">Manufacturer</label>
                    <select id="manufacturerID" name="manufacturerID" required>
                        <option value="">Select Manufacturer</option>
                        <option value="M001">Yamaha Corporation</option>
                        <option value="M002">Fender Musical Instruments</option>
                        <option value="M003">Gibson Brands</option>
                        <option value="M004">Roland Corporation</option>
                        <option value="M005">Korg Inc.</option>
                        <option value="M006">Casio Musical Instruments</option>
                        <option value="M007">Taylor Guitars</option>
                        <option value="M008">Ibanez Guitars</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="brandID" class="required">Brand</label>
                    <select id="brandID" name="brandID" required>
                        <option value="">Select Brand</option>
                        <option value="B001">Yamaha Music</option>
                        <option value="B002">Squier</option>
                        <option value="B003">Epiphone</option>
                        <option value="B004">Roland Pro</option>
                        <option value="B005">Korg Studio</option>
                        <option value="B006">Casio Privia</option>
                        <option value="B007">Taylor Baby</option>
                        <option value="B008">Ibanez Prestige</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="model">Model</label>
                    <input type="text" id="model" name="model" placeholder="Model name/number">
                </div>

                <div class="form-group">
                    <label for="color">Color</label>
                    <input type="text" id="color" name="color" placeholder="Instrument color">
                </div>
            </div>

            <div class="form-section">
                <h2>Pricing & Inventory</h2>

                <div class="form-group">
                    <label for="price" class="required">Price ($)</label>
                    <input type="number" id="price" name="price" step="0.01" min="0" placeholder="0.00" required>
                </div>

                <div class="form-group">
                    <label for="quantity" class="required">Quantity</label>
                    <input type="number" id="quantity" name="quantity" min="0" placeholder="0" required>
                </div>

                <div class="form-group">
                    <label for="stockLevel">Stock Level</label>
                    <select id="stockLevel" name="stockLevel">
                        <option value="In Stock">In Stock</option>
                        <option value="Low Stock">Low Stock</option>
                        <option value="Out of Stock">Out of Stock</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="warranty">Warranty</label>
                    <input type="text" id="warranty" name="warranty" placeholder="e.g., 1 Year Limited">
                </div>

                <div class="form-group">
                    <label for="specifications">Specifications</label>
                    <textarea id="specifications" name="specifications" placeholder="Technical specifications..."></textarea>
                </div>

                <div class="form-group">
                    <label for="images" class="required">Product Images</label>
                    <div class="image-upload-container" id="dropZone">
                        <i class="fas fa-cloud-upload-alt" style="font-size: 48px; color: var(--primary); margin-bottom: 10px;"></i>
                        <p style="margin-bottom: 10px; font-weight: 500;">Drag & drop images here or click to browse</p>
                        <input type="file" id="images" name="images" multiple accept="image/*" style="display: none;">
                        <button type="button" class="btn btn-primary" onclick="document.getElementById('images').click()">
                            <i class="fas fa-folder-open"></i> Browse Files
                        </button>
                        <small style="color: #64748b; display: block; margin-top: 10px;">Maximum 5 images • PNG, JPG, JPEG</small>
                    </div>
                    <div id="imagePreview" class="image-preview"></div>
                </div>
            </div>
        </div>

        <div class="action-buttons">
            <button type="submit" class="btn btn-primary" id="submitBtn">
                <i class="fas fa-save"></i> Save Instrument
            </button>
            <button type="reset" class="btn btn-secondary" id="resetBtn">
                <i class="fas fa-undo"></i> Reset Form
            </button>
            <a href="sellerdashboard.jsp" class="btn btn-danger">
                <i class="fas fa-times"></i> Cancel
            </a>
        </div>
    </form>

    <div class="instrument-list">
        <h2>Existing Instruments</h2>
        <table class="instrument-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Brand</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Images</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="instrumentTable">
            <!-- Instruments will be loaded dynamically -->
            </tbody>
        </table>
    </div>
</div>

<script>
    const userRole = "<%= session.getAttribute("userRole") != null ? session.getAttribute("userRole") : "unknown" %>";
    if (userRole !== 'seller') {
        alert('Access denied. Please log in as a seller.');
        window.location.href = '<%= request.getContextPath() %>/sign-in.jsp';
    }

    let uploadedImages = [];

    function validateForm() {
        const requiredFields = ['name', 'manufacturerID', 'brandID', 'price', 'quantity'];
        let isValid = true;

        requiredFields.forEach(field => {
            const input = document.getElementById(field);
            if (!input.value.trim()) {
                isValid = false;
                input.style.borderColor = 'var(--error)';
                showMessage('error', input.labels[0].textContent + ' is required.');
            } else {
                input.style.borderColor = '';
            }
        });

        if (uploadedImages.length === 0) {
            showMessage('error', 'Please upload at least one image.');
            isValid = false;
        }

        if (!isValid) return false;

        const submitBtn = document.getElementById('submitBtn');
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';

        const formData = new FormData(document.getElementById('instrumentForm'));

        // Append all uploaded images
        uploadedImages.forEach((image, index) => {
            formData.append('imageFile', image.file);
        });

        fetch('<%= request.getContextPath() %>/InstrumentManagementServlet', {
            method: 'POST',
            body: formData
        })
            .then(response => response.text())
            .then(text => {
                const [status, message] = text.split('|');
                if (status === 'SUCCESS') {
                    showMessage('success', message || 'Instrument saved successfully!');
                    document.getElementById('instrumentForm').reset();
                    document.getElementById('imagePreview').innerHTML = '';
                    uploadedImages = [];
                    loadInstruments();
                } else {
                    throw new Error(message || 'Failed to save instrument.');
                }
            })
            .catch(error => showMessage('error', error.message))
            .finally(() => {
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fas fa-save"></i> Save Instrument';
            });

        return false;
    }

    function loadInstruments() {
        fetch('<%= request.getContextPath() %>/InstrumentManagementServlet?action=list')
            .then(response => response.text())
            .then(text => {
                const tableBody = document.getElementById('instrumentTable');
                tableBody.innerHTML = '';

                if (!text.trim()) {
                    tableBody.innerHTML = '<tr><td colspan="7" style="text-align: center; padding: 20px;">No instruments found.</td></tr>';
                    return;
                }

                const lines = text.trim().split('\n');
                lines.forEach(line => {
                    if (line) {
                        const [instrumentID, name, brandID, price, quantity, imageURLs] = line.split('|');
                        const row = document.createElement('tr');

                        const brandName = getBrandName(brandID);
                        const images = imageURLs ? imageURLs.split(',') : [];

                        row.innerHTML =
                            '<td>' + (instrumentID || 'N/A') + '</td>' +
                            '<td>' + (name || 'N/A') + '</td>' +
                            '<td>' + (brandName || brandID || 'N/A') + '</td>' +
                            '<td>$' + (price ? parseFloat(price).toFixed(2) : '0.00') + '</td>' +
                            '<td>' + (quantity || '0') + '</td>' +
                            '<td>' +
                            '<div class="image-gallery">' +
                            (images.length > 0 ?
                                    images.map(img =>
                                        '<img src="' + img + '" alt="Instrument" onclick="openImageModal(\'' + img + '\')">'
                                    ).join('') :
                                    'No images'
                            ) +
                            '</div>' +
                            '</td>' +
                            '<td>' +
                            '<div class="action-buttons-small">' +
                            '<button class="btn-small btn-edit" onclick="editInstrument(\'' + instrumentID + '\')">Edit</button>' +
                            '<button class="btn-small btn-delete" onclick="deleteInstrument(\'' + instrumentID + '\')">Delete</button>' +
                            '</div>' +
                            '</td>';

                        tableBody.appendChild(row);
                    }
                });
            })
            .catch(error => {
                console.error('Error loading instruments:', error);
                showMessage('error', 'Failed to load instruments.');
            });
    }

    function getBrandName(brandID) {
        const brandMap = {
            'B001': 'Yamaha Music',
            'B002': 'Squier',
            'B003': 'Epiphone',
            'B004': 'Roland Pro',
            'B005': 'Korg Studio',
            'B006': 'Casio Privia',
            'B007': 'Taylor Baby',
            'B008': 'Ibanez Prestige'
        };
        return brandMap[brandID] || brandID;
    }

    function editInstrument(id) {
        fetch('<%= request.getContextPath() %>/InstrumentManagementServlet?action=get&id=' + encodeURIComponent(id))
            .then(response => response.text())
            .then(text => {
                const data = text.split('|');
                if (data[0] === 'ERROR') throw new Error(data[1]);

                const [status, instrumentID, name, description, brandID, model, color, price, specifications, warranty, quantity, stockLevel, manufacturerID, imageURLs] = data;

                document.getElementById('instrumentID').value = instrumentID || '';
                document.getElementById('name').value = name || '';
                document.getElementById('description').value = description || '';
                document.getElementById('manufacturerID').value = manufacturerID || '';
                document.getElementById('brandID').value = brandID || '';
                document.getElementById('model').value = model || '';
                document.getElementById('color').value = color || '';
                document.getElementById('price').value = price || '';
                document.getElementById('specifications').value = specifications || '';
                document.getElementById('warranty').value = warranty || '';
                document.getElementById('quantity').value = quantity || '';
                document.getElementById('stockLevel').value = stockLevel || 'In Stock';

                // Clear existing images
                document.getElementById('imagePreview').innerHTML = '';
                uploadedImages = [];

                // Load existing images for editing
                if (imageURLs) {
                    const images = imageURLs.split(',');
                    images.forEach(imgUrl => {
                        if (imgUrl.trim()) {
                            addImageToPreview(null, imgUrl);
                        }
                    });
                }

                showMessage('success', 'Instrument loaded for editing.');
                document.getElementById('instrumentForm').scrollIntoView({ behavior: 'smooth' });
            })
            .catch(error => showMessage('error', 'Error loading instrument: ' + error.message));
    }

    function deleteInstrument(id) {
        if (confirm('Are you sure you want to delete this instrument? This action cannot be undone.')) {
            fetch('<%= request.getContextPath() %>/InstrumentManagementServlet?action=delete&id=' + encodeURIComponent(id), {
                method: 'DELETE'
            })
                .then(response => response.text())
                .then(text => {
                    const [status, message] = text.split('|');
                    if (status === 'SUCCESS') {
                        showMessage('success', message || 'Instrument deleted successfully!');
                        loadInstruments();
                    } else {
                        throw new Error(message || 'Deletion failed');
                    }
                })
                .catch(error => showMessage('error', 'Error deleting instrument: ' + error.message));
        }
    }

    function addImageToPreview(file, existingUrl = null) {
        const preview = document.getElementById('imagePreview');
        const previewItem = document.createElement('div');
        previewItem.className = 'preview-item';

        const img = document.createElement('img');
        if (existingUrl) {
            img.src = existingUrl;
        } else {
            img.src = URL.createObjectURL(file);
        }

        const removeBtn = document.createElement('button');
        removeBtn.className = 'remove-btn';
        removeBtn.innerHTML = '<i class="fas fa-times"></i>';
        removeBtn.onclick = function() {
            if (file) {
                uploadedImages = uploadedImages.filter(img => img.file !== file);
            }
            previewItem.remove();
        };

        previewItem.appendChild(img);
        previewItem.appendChild(removeBtn);
        preview.appendChild(previewItem);

        if (file) {
            uploadedImages.push({ file: file, url: URL.createObjectURL(file) });
        }
    }

    function handleImageSelection(files) {
        const maxImages = 5;
        const currentCount = uploadedImages.length;

        if (currentCount + files.length > maxImages) {
            showMessage('error', `Maximum ${maxImages} images allowed. You have ${currentCount} and tried to add ${files.length} more.`);
            return;
        }

        Array.from(files).forEach(file => {
            if (!file.type.startsWith('image/')) {
                showMessage('error', 'Please select only image files.');
                return;
            }
            addImageToPreview(file);
        });
    }

    function showMessage(type, message) {
        hideMessages();
        const messageDiv = document.getElementById(type === 'success' ? 'dynamicSuccess' : 'dynamicMessage');
        document.getElementById(type === 'success' ? 'dynamicSuccessText' : 'dynamicMessageText').textContent = message;
        messageDiv.style.display = 'flex';

        setTimeout(() => {
            messageDiv.style.display = 'none';
        }, 5000);
    }

    function hideMessages() {
        document.getElementById('dynamicMessage').style.display = 'none';
        document.getElementById('dynamicSuccess').style.display = 'none';
    }

    function openImageModal(imageUrl) {
        // Simple image modal implementation
        const modal = document.createElement('div');
        modal.style.position = 'fixed';
        modal.style.top = '0';
        modal.style.left = '0';
        modal.style.width = '100%';
        modal.style.height = '100%';
        modal.style.backgroundColor = 'rgba(0,0,0,0.8)';
        modal.style.display = 'flex';
        modal.style.alignItems = 'center';
        modal.style.justifyContent = 'center';
        modal.style.zIndex = '1000';
        modal.style.cursor = 'pointer';

        const img = document.createElement('img');
        img.src = imageUrl;
        img.style.maxWidth = '90%';
        img.style.maxHeight = '90%';
        img.style.objectFit = 'contain';

        modal.appendChild(img);
        modal.onclick = function() {
            document.body.removeChild(modal);
        };

        document.body.appendChild(modal);
    }

    // Event Listeners
    document.getElementById('images').addEventListener('change', function(e) {
        handleImageSelection(e.target.files);
        this.value = ''; // Reset file input
    });

    // Drag and drop functionality
    const dropZone = document.getElementById('dropZone');
    dropZone.addEventListener('dragover', function(e) {
        e.preventDefault();
        this.classList.add('dragover');
    });

    dropZone.addEventListener('dragleave', function(e) {
        e.preventDefault();
        this.classList.remove('dragover');
    });

    dropZone.addEventListener('drop', function(e) {
        e.preventDefault();
        this.classList.remove('dragover');
        handleImageSelection(e.dataTransfer.files);
    });

    document.getElementById('instrumentForm').addEventListener('submit', function(e) {
        e.preventDefault();
        validateForm();
    });

    document.getElementById('resetBtn').addEventListener('click', function() {
        document.getElementById('imagePreview').innerHTML = '';
        uploadedImages = [];
        hideMessages();
    });

    document.getElementById('dynamicMessage').addEventListener('click', hideMessages);
    document.getElementById('dynamicSuccess').addEventListener('click', hideMessages);

    // Initialize
    window.onload = function() {
        loadInstruments();

        const elements = document.querySelectorAll('.form-section, .instrument-list');
        elements.forEach((el, index) => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            setTimeout(() => {
                el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                el.style.opacity = '1';
                el.style.transform = 'translateY(0)';
            }, index * 200);
        });
    };
</script>
</body>
</html>