<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard | Melody Mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8a2be2;
            --primary-light: #9b45f0;
            --secondary: #0a0a0a;
            --accent: #00e5ff;
            --accent-alt: #ff00c8;
            --text: #ffffff;
            --text-secondary: #b3b3b3;
            --card-bg: #1a1a1a;
            --card-hover: #2a2a2a;
            --gradient: linear-gradient(135deg, var(--primary), var(--accent));
            --gradient-alt: linear-gradient(135deg, var(--accent-alt), var(--primary));
            --glass-bg: rgba(30, 30, 30, 0.7);
            --glass-border: rgba(255, 255, 255, 0.1);
            --sidebar-width: 280px;
            --header-height: 70px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Montserrat', sans-serif; background: var(--secondary); color: var(--text); overflow-x: hidden; line-height: 1.6; }
        .dashboard-container { display: flex; min-height: 100vh; }

        .sidebar { width: var(--sidebar-width); background: var(--card-bg); border-right: 1px solid var(--glass-border); height: 100vh; position: fixed; overflow-y: auto; transition: all 0.3s ease; z-index: 1000; }
        .sidebar-header { padding: 20px; border-bottom: 1px solid var(--glass-border); text-align: center; }
        .sidebar-logo { font-family: 'Playfair Display', serif; font-size: 24px; font-weight: 800; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; display: flex; align-items: center; justify-content: center; }
        .sidebar-logo i { margin-right: 10px; font-size: 28px; }
        .sidebar-menu { padding: 20px 0; }
        .menu-category { padding: 10px 20px; color: var(--text-secondary); font-size: 12px; text-transform: uppercase; letter-spacing: 1px; }
        .menu-item { display: flex; align-items: center; padding: 12px 20px; color: var(--text); text-decoration: none; transition: all 0.3s ease; border-left: 3px solid transparent; }
        .menu-item:hover, .menu-item.active { background: var(--glass-bg); color: var(--primary-light); border-left-color: var(--primary); }
        .menu-item i { margin-right: 12px; font-size: 18px; width: 24px; text-align: center; }

        .main-content { flex: 1; margin-left: var(--sidebar-width); padding: 20px; padding-top: calc(var(--header-height) + 20px); }
        .dashboard-header { background: var(--glass-bg); backdrop-filter: blur(10px); border-bottom: 1px solid var(--glass-border); padding: 0 20px; height: var(--header-height); display: flex; align-items: center; justify-content: space-between; position: fixed; top: 0; right: 0; left: var(--sidebar-width); z-index: 900; transition: all 0.3s ease; }
        .page-title { font-family: 'Playfair Display', serif; font-size: 28px; font-weight: 700; }
        .header-actions { display: flex; align-items: center; gap: 15px; }
        .notification-btn, .user-menu-btn { background: none; border: none; color: var(--text); font-size: 18px; cursor: pointer; position: relative; }
        .notification-badge { position: absolute; top: -5px; right: -5px; background: var(--accent); color: var(--secondary); font-size: 10px; width: 16px; height: 16px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; }

        .dashboard-section { display: none; animation: fadeIn 0.5s ease; }
        .dashboard-section.active { display: block; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: var(--card-bg); border-radius: 10px; padding: 20px; display: flex; align-items: center; border: 1px solid var(--glass-border); transition: all 0.3s ease; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); }
        .stat-icon { width: 50px; height: 50px; border-radius: 10px; display: flex; align-items: center; justify-content: center; margin-right: 15px; font-size: 24px; background: var(--gradient); }
        .stat-info h3 { font-size: 24px; font-weight: 700; margin-bottom: 5px; }
        .stat-info p { color: var(--text-secondary); font-size: 14px; }

        .content-card { background: var(--card-bg); border-radius: 15px; padding: 25px; margin-bottom: 30px; border: 1px solid var(--glass-border); box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3); }
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid var(--glass-border); }
        .card-title { font-size: 18px; font-weight: 600; }
        .card-actions { display: flex; gap: 10px; }

        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 12px 15px; text-align: left; border-bottom: 1px solid var(--glass-border); }
        .data-table th { color: var(--text-secondary); font-weight: 600; font-size: 14px; }
        .data-table tbody tr { transition: all 0.3s ease; }
        .data-table tbody tr:hover { background: var(--card-hover); }

        .btn { padding: 8px 16px; border-radius: 5px; font-weight: 500; cursor: pointer; transition: all 0.3s ease; border: none; font-size: 14px; }
        .btn-primary { background: var(--gradient); color: white; }
        .btn-primary:hover { background: var(--gradient-alt); transform: translateY(-2px); box-shadow: 0 10px 20px rgba(138, 43, 226, 0.4); }
        .btn-secondary { background: transparent; border: 1px solid var(--primary-light); color: var(--primary-light); }
        .btn-secondary:hover { background: rgba(138, 43, 226, 0.1); }
        .btn-sm { padding: 5px 10px; font-size: 12px; }

        .status-badge { padding: 5px 10px; border-radius: 20px; font-size: 12px; font-weight: 500; }
        .status-pending { background: rgba(255, 193, 7, 0.2); color: #ffc107; }
        .status-processing { background: rgba(0, 123, 255, 0.2); color: #007bff; }
        .status-completed { background: rgba(40, 167, 69, 0.2); color: #28a745; }
        .status-cancelled { background: rgba(220, 53, 69, 0.2); color: #dc3545; }

        .form-group { margin-bottom: 20px; }
        .form-label { display: block; margin-bottom: 8px; font-weight: 500; color: var(--text); }
        .form-control { width: 100%; padding: 12px 15px; background: var(--secondary); border: 1px solid var(--glass-border); border-radius: 5px; color: var(--text); font-family: 'Montserrat', sans-serif; transition: all 0.3s ease; }
        .form-control:focus { outline: none; border-color: var(--primary-light); box-shadow: 0 0 0 2px rgba(138, 43, 226, 0.2); }
        textarea.form-control { min-height: 120px; resize: vertical; }
        .form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }

        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.7); z-index: 2000; align-items: center; justify-content: center; padding: 20px; }
        .modal-content { background: var(--card-bg); border-radius: 15px; padding: 30px; max-width: 800px; width: 100%; max-height: 90vh; overflow-y: auto; position: relative; border: 1px solid var(--glass-border); box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5); }
        .modal-close { position: absolute; top: 15px; right: 15px; background: none; border: none; color: var(--text); font-size: 20px; cursor: pointer; transition: color 0.3s ease; }
        .modal-close:hover { color: var(--primary-light); }
        .modal-title { font-family: 'Playfair Display', serif; font-size: 24px; margin-bottom: 20px; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

        .premium-form { padding: 20px 0; }
        .premium-form .form-header { text-align: center; margin-bottom: 30px; }
        .premium-form .form-title { font-family: 'Playfair Display', serif; font-size: 28px; font-weight: 700; background: var(--gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 10px; }
        .premium-form .form-subtitle { color: var(--text-secondary); font-size: 16px; }
        .premium-form .form-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; }
        .premium-form .full-width { grid-column: span 2; }
        .premium-form .form-actions { grid-column: span 2; display: flex; justify-content: flex-end; gap: 15px; margin-top: 20px; }
        .premium-form .btn { padding: 12px 25px; border-radius: 30px; font-weight: 600; font-size: 16px; }

        .error-message { color: #ff6b6b; font-size: 14px; margin-top: 5px; display: flex; align-items: center; gap: 5px; }
        .error-message i { font-size: 16px; }
        .notification { padding: 15px; border-radius: 10px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; animation: fadeIn 0.5s ease; }
        .notification.error { background: rgba(220, 53, 69, 0.2); border: 1px solid rgba(220, 53, 69, 0.5); color: #dc3545; }

        .image-upload { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 20px; }
        .image-preview { width: 100px; height: 100px; border-radius: 5px; overflow: hidden; position: relative; border: 1px dashed var(--glass-border); }
        .image-preview img { width: 100%; height: 100%; object-fit: cover; }
        .image-preview .remove-image { position: absolute; top: 5px; right: 5px; background: rgba(220, 53, 69, 0.8); color: white; width: 20px; height: 20px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 12px; cursor: pointer; }
        .upload-btn { width: 100px; height: 100px; border: 1px dashed var(--glass-border); border-radius: 5px; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.3s ease; }
        .upload-btn:hover { border-color: var(--primary-light); color: var(--primary-light); }

        @media (max-width: 992px) {
            .sidebar { transform: translateX(-100%); width: 260px; }
            .sidebar.active { transform: translateX(0); }
            .main-content { margin-left: 0; }
            .dashboard-header { left: 0; }
            .menu-toggle { display: block; }
            .premium-form .form-grid { grid-template-columns: 1fr; }
            .premium-form .full-width { grid-column: span 1; }
            .premium-form .form-actions { grid-column: span 1; flex-direction: column; }
            .premium-form .btn { width: 100%; }
        }
        @media (max-width: 768px) {
            .stats-grid { grid-template-columns: 1fr; }
            .form-grid { grid-template-columns: 1fr; }
        }
        .menu-toggle { display: none; background: none; border: none; color: var(--text); font-size: 24px; cursor: pointer; margin-right: 15px; }
        @media (max-width: 992px) { .menu-toggle { display: block; } }
    </style>
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo"><i class="fas fa-music"></i> Melody Mart</div>
            <small>Seller Dashboard</small>
        </div>
        <div class="sidebar-menu">
            <div class="menu-category">Main</div>
            <a href="#" class="menu-item active" data-section="dashboard"><i class="fas fa-chart-line"></i><span>Dashboard</span></a>
            <div class="menu-category">Management</div>
            <a href="#" class="menu-item" data-section="inventory"><i class="fas fa-box"></i><span>Inventory</span></a>
            <a href="#" class="menu-item" data-section="orders"><i class="fas fa-shopping-cart"></i><span>Orders</span></a>
            <a href="#" class="menu-item" data-section="deliveries"><i class="fas fa-truck"></i><span>Deliveries</span></a>
            <a href="#" class="menu-item" data-section="stock"><i class="fas fa-cubes"></i><span>Stock Management</span></a>
            <div class="menu-category">Reports</div>
            <a href="#" class="menu-item" data-section="reports"><i class="fas fa-chart-bar"></i><span>Sales Reports</span></a>
            <a href="#" class="menu-item" data-section="notifications"><i class="fas fa-bell"></i><span>Notifications</span></a>
            <div class="menu-category">Account</div>
            <a href="#" class="menu-item" data-section="profile"><i class="fas fa-user"></i><span>Profile</span></a>
            <a href="#" class="menu-item" onclick="logout()"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
        </div>
    </div>
    <div class="main-content">
        <header class="dashboard-header">
            <button class="menu-toggle" id="menuToggle"><i class="fas fa-bars"></i></button>
            <h1 class="page-title">Seller Dashboard</h1>
            <div class="header-actions">
                <button class="notification-btn"><i class="fas fa-bell"></i><span class="notification-badge">3</span></button>
                <div class="user-menu"><button class="user-menu-btn"><i class="fas fa-user-circle"></i></button></div>
            </div>
        </header>
        <section id="dashboard" class="dashboard-section active">
            <div class="stats-grid">
                <div class="stat-card"><div class="stat-icon"><i class="fas fa-box"></i></div><div class="stat-info"><h3>142</h3><p>Total Products</p></div></div>
                <div class="stat-card"><div class="stat-icon"><i class="fas fa-shopping-cart"></i></div><div class="stat-info"><h3>56</h3><p>New Orders</p></div></div>
                <div class="stat-card"><div class="stat-icon"><i class="fas fa-truck"></i></div><div class="stat-info"><h3>38</h3><p>Pending Deliveries</p></div></div>
                <div class="stat-card"><div class="stat-icon"><i class="fas fa-chart-line"></i></div><div class="stat-info"><h3>$12,458</h3><p>Total Revenue</p></div></div>
            </div>
            <div class="content-card">
                <div class="card-header"><h2 class="card-title">Recent Orders</h2><div class="card-actions"><button class="btn btn-primary">View All</button></div></div>
                <div class="table-responsive"><table class="data-table"><thead><tr><th>Order ID</th><th>Customer</th><th>Date</th><th>Amount</th><th>Status</th><th>Actions</th></tr></thead><tbody><tr><td>#ORD-7842</td><td>John Smith</td><td>Jul 12, 2025</td><td>$349.99</td><td><span class="status-badge status-pending">Pending</span></td><td><button class="btn btn-sm btn-primary">View</button></td></tr><tr><td>#ORD-7841</td><td>Emma Johnson</td><td>Jul 12, 2025</td><td>$1,249.99</td><td><span class="status-badge status-processing">Processing</span></td><td><button class="btn btn-sm btn-primary">View</button></td></tr><tr><td>#ORD-7839</td><td>Michael Brown</td><td>Jul 11, 2025</td><td>$599.99</td><td><span class="status-badge status-completed">Completed</span></td><td><button class="btn btn-sm btn-primary">View</button></td></tr><tr><td>#ORD-7835</td><td>Sarah Wilson</td><td>Jul 10, 2025</td><td>$2,199.99</td><td><span class="status-badge status-processing">Processing</span></td><td><button class="btn btn-sm btn-primary">View</button></td></tr></tbody></table></div>
            </div>
            <div class="content-card">
                <div class="card-header"><h2 class="card-title">Low Stock Alert</h2><div class="card-actions"><button class="btn btn-secondary">View Inventory</button></div></div>
                <div class="table-responsive"><table class="data-table"><thead><tr><th>Product</th><th>SKU</th><th>Current Stock</th><th>Alert Level</th><th>Actions</th></tr></thead><tbody><tr><td>Fender Stratocaster Electric Guitar</td><td>PROD-4872</td><td>3</td><td>5</td><td><button class="btn btn-sm btn-primary">Restock</button></td></tr><tr><td>Yamaha HS8 Studio Monitor</td><td>PROD-5321</td><td>2</td><td>4</td><td><button class="btn btn-sm btn-primary">Restock</button></td></tr><tr><td>Shure SM58 Microphone</td><td>PROD-2154</td><td>4</td><td>10</td><td><button class="btn btn-sm btn-primary">Restock</button></td></tr></tbody></table></div>
            </div>
        </section>
        <section id="inventory" class="dashboard-section">
            <div class="content-card">
                <div class="card-header"><h2 class="card-title">Product Inventory</h2><div class="card-actions"><button class="btn btn-primary" onclick="openModal('addProductModal')"><i class="fas fa-plus"></i> Add New Product</button></div></div>
                <div class="table-responsive"><table class="data-table"><thead><tr><th>Product</th><th>SKU</th><th>Category</th><th>Price</th><th>Stock</th><th>Status</th><th>Actions</th></tr></thead><tbody><tr><td><div style="display: flex; align-items: center;"><img src="https://via.placeholder.com/40" style="width: 40px; height: 40px; border-radius: 5px; margin-right: 10px;">Fender Stratocaster</div></td><td>PROD-4872</td><td>Guitars</td><td>$1,199.99</td><td>12</td><td><span class="status-badge status-completed">Active</span></td><td><button class="btn btn-sm btn-primary">Edit</button><button class="btn btn-sm btn-secondary">Delete</button></td></tr><tr><td><div style="display: flex; align-items: center;"><img src="https://via.placeholder.com/40" style="width: 40px; height: 40px; border-radius: 5px; margin-right: 10px;">Yamaha HS8 Monitor</div></td><td>PROD-5321</td><td>Audio</td><td>$349.99</td><td>8</td><td><span class="status-badge status-completed">Active</span></td><td><button class="btn btn-sm btn-primary">Edit</button><button class="btn btn-sm btn-secondary">Delete</button></td></tr><tr><td><div style="display: flex; align-items: center;"><img src="https://via.placeholder.com/40" style="width: 40px; height: 40px; border-radius: 5px; margin-right: 10px;">Ludwig Drum Set</div></td><td>PROD-8741</td><td>Drums</td><td>$2,499.99</td><td>5</td><td><span class="status-badge status-completed">Active</span></td><td><button class="btn btn-sm btn-primary">Edit</button><button class="btn btn-sm btn-secondary">Delete</button></td></tr><tr><td><div style="display: flex; align-items: center;"><img src="https://via.placeholder.com/40" style="width: 40px; height: 40px; border-radius: 5px; margin-right: 10px;">Shure SM58 Microphone</div></td><td>PROD-2154</td><td>Audio</td><td>$99.99</td><td>23</td><td><span class="status-badge status-completed">Active</span></td><td><button class="btn btn-sm btn-primary">Edit</button><button class="btn btn-sm btn-secondary">Delete</button></td></tr></tbody></table></div>
            </div>
        </section>
        <section id="orders" class="dashboard-section"><div class="content-card"><div class="card-header"><h2 class="card-title">Order Management</h2></div><p>Order management content goes here...</p></div></section>
        <section id="deliveries" class="dashboard-section"><div class="content-card"><div class="card-header"><h2 class="card-title">Delivery Coordination</h2></div><p>Delivery coordination content goes here...</p></div></section>
        <section id="stock" class="dashboard-section"><div class="content-card"><div class="card-header"><h2 class="card-title">Stock Management</h2></div><p>Stock management content goes here...</p></div></section>
        <section id="reports" class="dashboard-section"><div class="content-card"><div class="card-header"><h2 class="card-title">Sales Reports</h2></div><p>Sales reports content goes here...</p></div></section>
        <section id="notifications" class="dashboard-section"><div class="content-card"><div class="card-header"><h2 class="card-title">Notifications</h2></div><p>Notifications content goes here...</p></div></section>
        <section id="profile" class="dashboard-section"><div class="content-card"><div class="card-header"><h2 class="card-title">Profile Settings</h2></div><p>Profile settings content goes here...</p></div></section>
    </div>
</div>

<div class="modal" id="addProductModal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeModal('addProductModal')">&times;</button>
        <div class="premium-form">
            <div class="form-header">
                <h2 class="form-title">Add New Instrument</h2>
                <p class="form-subtitle">Fill in the details below to add a new instrument to your inventory</p>
            </div>
            <div class="notification error" style="display: none;" id="errorNotification"><i class="fas fa-exclamation-circle"></i><span id="errorText"></span></div>
            <form id="instrumentForm" action="seller-dashboard.jsp" method="post" enctype="multipart/form-data">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="name" class="form-label">Name *</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="price" class="form-label">Price ($) *</label>
                        <input type="number" id="price" name="price" class="form-control" step="0.01" min="0.01" required>
                    </div>
                    <div class="form-group">
                        <label for="brandId" class="form-label">Brand ID</label>
                        <input type="number" id="brandId" name="brandId" class="form-control" min="1">
                    </div>
                    <div class="form-group">
                        <label for="model" class="form-label">Model</label>
                        <input type="text" id="model" name="model" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="color" class="form-label">Color</label>
                        <input type="text" id="color" name="color" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="quantity" class="form-label">Quantity *</label>
                        <input type="number" id="quantity" name="quantity" class="form-control" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="stockLevel" class="form-label">Stock Level</label>
                        <select id="stockLevel" name="stockLevel" class="form-control">
                            <option value="In Stock">In Stock</option>
                            <option value="Low Stock">Low Stock</option>
                            <option value="Out of Stock">Out of Stock</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="manufacturerId" class="form-label">Manufacturer ID</label>
                        <input type="number" id="manufacturerId" name="manufacturerId" class="form-control" min="1">
                    </div>
                    <div class="form-group full-width">
                        <label for="description" class="form-label">Description</label>
                        <textarea id="description" name="description" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="form-group full-width">
                        <label for="specifications" class="form-label">Specifications</label>
                        <textarea id="specifications" name="specifications" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="warranty" class="form-label">Warranty</label>
                        <input type="text" id="warranty" name="warranty" class="form-control">
                    </div>
                    <div class="form-group full-width">
                        <label class="form-label">Upload Images (Max 3, 2MB each)</label>
                        <div class="image-upload" id="imageUpload">
                            <label class="upload-btn" for="imageInput"><i class="fas fa-upload"></i> Upload Image</label>
                            <input type="file" id="imageInput" name="image" accept="image/*" style="display: none;" multiple>
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeModal('addProductModal')">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Instrument</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Menu toggle
        const menuToggle = document.getElementById('menuToggle');
        if (menuToggle) {
            menuToggle.addEventListener('click', function() {
                const sidebar = document.getElementById('sidebar');
                if (sidebar) sidebar.classList.toggle('active');
            });
        }

        // Menu item navigation
        document.querySelectorAll('.menu-item').forEach(item => {
            if (item.getAttribute('data-section')) {
                item.addEventListener('click', function(e) {
                    e.preventDefault();
                    document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                    document.querySelectorAll('.dashboard-section').forEach(s => s.classList.remove('active'));
                    this.classList.add('active');
                    const sectionId = this.getAttribute('data-section');
                    const section = document.getElementById(sectionId);
                    if (section) section.classList.add('active');
                    const pageTitle = document.querySelector('.page-title');
                    if (pageTitle) pageTitle.textContent = this.querySelector('span').textContent;
                    if (window.innerWidth < 992) {
                        const sidebar = document.getElementById('sidebar');
                        if (sidebar) sidebar.classList.remove('active');
                    }
                });
            }
        });

        // Modal functions
        function openModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) modal.style.display = 'flex';
        }

        function closeModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) modal.style.display = 'none';
        }

        window.addEventListener('click', function(e) {
            document.querySelectorAll('.modal').forEach(modal => {
                if (modal && e.target === modal) modal.style.display = 'none';
            });
        });

        // Form submission validation
        const instrumentForm = document.getElementById('instrumentForm');
        if (instrumentForm) {
            instrumentForm.addEventListener('submit', function(e) {
                let isValid = true;
                const name = document.getElementById('name');
                const price = document.getElementById('price');
                const quantity = document.getElementById('quantity');
                document.querySelectorAll('.error-message').forEach(el => el.remove());

                if (name && !name.value.trim()) { showError(name, 'Instrument name is required'); isValid = false; }
                if (price && (!price.value || parseFloat(price.value) <= 0)) { showError(price, 'Please enter a valid price'); isValid = false; }
                if (quantity && (!quantity.value || parseInt(quantity.value) < 0)) { showError(quantity, 'Please enter a valid quantity'); isValid = false; }

                if (!isValid) e.preventDefault();
            });
        }

        // Error display function
        function showError(input, message) {
            if (input) {
                const errorDiv = document.createElement('div');
                errorDiv.className = 'error-message';
                errorDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;
                input.parentNode.appendChild(errorDiv);
                input.focus();
            }
        }

        // Logout function
        function logout() {
            if (confirm('Are you sure you want to logout?')) window.location.href = 'index.jsp';
        }

        // Image upload preview
        const imageInput = document.getElementById('imageInput');
        const imageUpload = document.getElementById('imageUpload');
        const maxFiles = 3;
        const maxSize = 2 * 1024 * 1024; // 2MB in bytes

        if (imageInput && imageUpload) {
            imageInput.addEventListener('change', function(e) {
                const files = e.target.files;
                const currentPreviews = imageUpload.querySelectorAll('.image-preview').length;

                for (let i = 0; i < files.length; i++) {
                    const file = files[i];
                    if (currentPreviews + i >= maxFiles) {
                        alert(`Maximum ${maxFiles} images allowed.`);
                        break;
                    }
                    if (file.size > maxSize) {
                        showError(imageInput, `File ${file.name} exceeds 2MB limit.`);
                        continue;
                    }
                    if (file.type.startsWith('image/')) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            const previewDiv = document.createElement('div');
                            previewDiv.className = 'image-preview';
                            previewDiv.innerHTML = `<img src="${e.target.result}" alt="Preview"><span class="remove-image" onclick="this.parentElement.remove()">×</span>`;
                            imageUpload.insertBefore(previewDiv, imageInput.nextSibling);
                        };
                        reader.readAsDataURL(file);
                    }
                }
                imageInput.value = '';
            });
        }
    });
</script>

<%
    // Handle file upload and database insertion
    String uploadPath = application.getRealPath("/") + "uploads/";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdir();

    String name = "", price = "", brandId = "", model = "", color = "", quantity = "", stockLevel = "", manufacturerId = "", description = "", specifications = "", warranty = "";
    List<String> imagePaths = new ArrayList<>();

    if (ServletFileUpload.isMultipartContent(request)) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("UTF-8");
                    if ("name".equals(fieldName)) name = fieldValue;
                    else if ("price".equals(fieldName)) price = fieldValue;
                    else if ("brandId".equals(fieldName)) brandId = fieldValue;
                    else if ("model".equals(fieldName)) model = fieldValue;
                    else if ("color".equals(fieldName)) color = fieldValue;
                    else if ("quantity".equals(fieldName)) quantity = fieldValue;
                    else if ("stockLevel".equals(fieldName)) stockLevel = fieldValue;
                    else if ("manufacturerId".equals(fieldName)) manufacturerId = fieldValue;
                    else if ("description".equals(fieldName)) description = fieldValue;
                    else if ("specifications".equals(fieldName)) specifications = fieldValue;
                    else if ("warranty".equals(fieldName)) warranty = fieldValue;
                } else {
                    if (!item.getName().isEmpty()) {
                        String fileName = new Date().getTime() + "_" + item.getName().replaceAll("[^a-zA-Z0-9.-]", "_");
                        File file = new File(uploadPath + fileName);
                        item.write(file);
                        imagePaths.add("uploads/" + fileName);
                    }
                }
            }

            // Database insertion
            String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=MelodyMartDB;encrypt=true;trustServerCertificate=true;";
            String dbUser = "Hasiru";
            String dbPass = "hasiru2004";
            String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName(driver);
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                String sql = "INSERT INTO Instrument (Name, Price, BrandID, Model, Color, Quantity, StockLevel, ManufacturerID, Description, Specifications, Warranty, ImageURL) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setDouble(2, Double.parseDouble(price));
                pstmt.setInt(3, brandId.isEmpty() ? 0 : Integer.parseInt(brandId));
                pstmt.setString(4, model);
                pstmt.setString(5, color);
                pstmt.setInt(6, Integer.parseInt(quantity));
                pstmt.setString(7, stockLevel);
                pstmt.setInt(8, manufacturerId.isEmpty() ? 0 : Integer.parseInt(manufacturerId));
                pstmt.setString(9, description);
                pstmt.setString(10, specifications);
                pstmt.setString(11, warranty);
                pstmt.setString(12, imagePaths.isEmpty() ? null : imagePaths.get(0)); // Store first image path
                pstmt.executeUpdate();
                response.sendRedirect("seller-dashboard.jsp");
            } catch (Exception e) {
                request.setAttribute("addStatus", "Error: " + e.getMessage());
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        } catch (Exception e) {
            request.setAttribute("addStatus", "Error uploading files: " + e.getMessage());
        }
    }
%>
</body>
</html>