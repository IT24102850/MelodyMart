<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Seller Dashboard</title>
    <link rel="icon" type="image/x-icon" href="./images/favicon_io%20(9)/favicon.ico">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <style>
        body {
            background: url('./images/1162694.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
            color: #FFFFFF;
            overflow-x: hidden;
        }
        .sidebar {
            transition: transform 0.3s ease-in-out;
            background: #000000;
            border-right: 1px solid rgba(255, 255, 255, 0.2);
        }
        .sidebar-hidden {
            transform: translateX(-100%);
        }
        .nav-button, .action-button {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .nav-button:hover, .action-button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
        }
        .table-container {
            background: #000000;
            border-radius: 0.5rem;
            transition: transform 0.3s ease;
        }
        .table-container:hover {
            transform: translateY(-5px);
        }
        @media (max-width: 640px) {
            .sidebar {
                transform: translateX(-100%);
                position: fixed;
                z-index: 20;
            }
            .sidebar-open {
                transform: translateX(0);
            }
        }
    </style>
</head>
<body class="relative">
<!-- Navbar -->
<nav class="bg-black text-white p-6 flex justify-between items-center z-10 relative">
    <h1 class="text-3xl font-bold font-['Bebas+Neue']">MelodyMart Seller Dashboard</h1>
    <div class="flex items-center space-x-4">
        <c:if test="${not empty sessionScope.user}">
            <span>Welcome, ${sessionScope.user.fullName}</span>
        </c:if>
        <a href="logout.jsp" class="bg-white text-black px-4 py-2 rounded-full font-semibold nav-button">Logout</a>
    </div>
</nav>

<!-- Main Content -->
<div class="flex min-h-screen">
    <!-- Sidebar -->
    <aside class="w-64 sidebar z-10">
        <div class="p-4">
            <h2 class="text-xl font-semibold mb-4 font-['Bebas+Neue']">Navigation</h2>
            <ul>
                <li><a href="#products" class="block py-2 px-4 hover:bg-blue-900 text-blue-300 nav-button">Manage Products</a></li>
                <li><a href="#stock" class="block py-2 px-4 hover:bg-blue-900 text-blue-300 nav-button">Stock Levels</a></li>
                <li><a href="#orders" class="block py-2 px-4 hover:bg-blue-900 text-blue-300 nav-button">Orders</a></li>
                <li><a href="#inquiries" class="block py-2 px-4 hover:bg-blue-900 text-blue-300 nav-button">Customer Inquiries</a></li>
            </ul>
        </div>
    </aside>

    <!-- Main Dashboard -->
    <main class="flex-1 p-6">
        <!-- Manage Products -->
        <section id="products" class="mb-8">
            <h2 class="text-3xl font-bold mb-4 font-['Inter']">Manage Products</h2>
            <div class="table-container p-6">
                <button onclick="showAddProductForm()" class="bg-white text-black px-4 py-2 rounded-full font-semibold action-button mb-4">Add New Product</button>
                <table class="w-full table-auto text-white">
                    <thead>
                    <tr class="bg-gray-800">
                        <th class="p-2">Product ID</th>
                        <th class="p-2">Name</th>
                        <th class="p-2">Price</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2">101</td>
                        <td class="p-2">Acoustic Guitar</td>
                        <td class="p-2">$199.99</td>
                        <td class="p-2 flex space-x-2">
                            <button onclick="editProduct(101)" class="bg-blue-500 text-white px-3 py-1 rounded action-button">Edit</button>
                            <button onclick="deleteProduct(101)" class="bg-red-500 text-white px-3 py-1 rounded action-button">Delete</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- Add/Edit Product Form (Hidden by default) -->
            <div id="productForm" class="hidden table-container p-6 mt-4">
                <h3 class="text-xl font-semibold mb-4 font-['Inter']">Add/Edit Product</h3>
                <form action="productServlet" method="post">
                    <input type="hidden" name="productId" id="productId">
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Product Name</label>
                        <input type="text" name="name" id="productName" class="w-full p-2 border rounded bg-gray-800 text-white" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Price</label>
                        <input type="number" step="0.01" name="price" id="productPrice" class="w-full p-2 border rounded bg-gray-800 text-white" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Description</label>
                        <textarea name="description" id="productDescription" class="w-full p-2 border rounded bg-gray-800 text-white"></textarea>
                    </div>
                    <div class="flex space-x-2">
                        <button type="submit" class="bg-white text-black px-4 py-2 rounded-full action-button">Save</button>
                        <button type="button" onclick="hideProductForm()" class="bg-gray-500 text-white px-4 py-2 rounded-full action-button">Cancel</button>
                    </div>
                </form>
            </div>
        </section>

        <!-- Stock Levels -->
        <section id="stock" class="mb-8">
            <h2 class="text-3xl font-bold mb-4 font-['Inter']">Stock Levels</h2>
            <div class="table-container p-6">
                <table class="w-full table-auto text-white">
                    <thead>
                    <tr class="bg-gray-800">
                        <th class="p-2">Product ID</th>
                        <th class="p-2">Name</th>
                        <th class="p-2">Stock</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2">101</td>
                        <td class="p-2">Acoustic Guitar</td>
                        <td class="p-2">50</td>
                        <td class="p-2">
                            <button onclick="updateStock(101)" class="bg-blue-500 text-white px-3 py-1 rounded action-button">Update</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Orders -->
        <section id="orders" class="mb-8">
            <h2 class="text-3xl font-bold mb-4 font-['Inter']">Orders</h2>
            <div class="table-container p-6">
                <table class="w-full table-auto text-white">
                    <thead>
                    <tr class="bg-gray-800">
                        <th class="p-2">Order ID</th>
                        <th class="p-2">Customer</th>
                        <th class="p-2">Product</th>
                        <th class="p-2">Status</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2">1001</td>
                        <td class="p-2">Jane Doe</td>
                        <td class="p-2">Acoustic Guitar</td>
                        <td class="p-2">Pending</td>
                        <td class="p-2">
                            <select onchange="updateOrderStatus(1001, this.value)" class="p-2 border rounded bg-gray-800 text-white">
                                <option value="Pending">Pending</option>
                                <option value="Shipped">Shipped</option>
                                <option value="Delivered">Delivered</option>
                                <option value="Cancelled">Cancelled</option>
                            </select>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Customer Inquiries -->
        <section id="inquiries">
            <h2 class="text-3xl font-bold mb-4 font-['Inter']">Customer Inquiries</h2>
            <div class="table-container p-6">
                <table class="w-full table-auto text-white">
                    <thead>
                    <tr class="bg-gray-800">
                        <th class="p-2">Inquiry ID</th>
                        <th class="p-2">Customer</th>
                        <th class="p-2">Message</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2">301</td>
                        <td class="p-2">Jane Doe</td>
                        <td class="p-2">Is the guitar available in black?</td>
                        <td class="p-2">
                            <button onclick="respondInquiry(301)" class="bg-blue-500 text-white px-3 py-1 rounded action-button">Respond</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- Respond Inquiry Form (Hidden by default) -->
            <div id="inquiryForm" class="hidden table-container p-6 mt-4">
                <h3 class="text-xl font-semibold mb-4 font-['Inter']">Respond to Inquiry</h3>
                <form action="inquiryServlet" method="post">
                    <input type="hidden" name="inquiryId" id="inquiryId">
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Response</label>
                        <textarea name="response" id="inquiryResponse" class="w-full p-2 border rounded bg-gray-800 text-white" required></textarea>
                    </div>
                    <div class="flex space-x-2">
                        <button type="submit" class="bg-white text-black px-4 py-2 rounded-full action-button">Send</button>
                        <button type="button" onclick="hideInquiryForm()" class="bg-gray-500 text-white px-4 py-2 rounded-full action-button">Cancel</button>
                    </div>
                </form>
            </div>
        </section>
    </main>
</div>

<script>
    // Placeholder JavaScript functions for actions
    function showAddProductForm() {
        document.getElementById('productForm').classList.remove('hidden');
        document.getElementById('productId').value = '';
        document.getElementById('productName').value = '';
        document.getElementById('productPrice').value = '';
        document.getElementById('productDescription').value = '';
    }

    function hideProductForm() {
        document.getElementById('productForm').classList.add('hidden');
    }

    function editProduct(id) {
        alert(`Editing product with ID: ${id}`);
        document.getElementById('productForm').classList.remove('hidden');
    }

    function deleteProduct(id) {
        if (confirm(`Are you sure you want to delete product with ID: ${id}?`)) {
            alert(`Deleting product with ID: ${id}`);
        }
    }

    function updateStock(id) {
        let stock = prompt(`Enter new stock level for product ID: ${id}`);
        if (stock) {
            alert(`Updating stock for product ID: ${id} to ${stock}`);
        }
    }

    function updateOrderStatus(id, status) {
        alert(`Updating order ID: ${id} to status: ${status}`);
    }

    function respondInquiry(id) {
        document.getElementById('inquiryForm').classList.remove('hidden');
        document.getElementById('inquiryId').value = id;
        document.getElementById('inquiryResponse').value = '';
    }

    function hideInquiryForm() {
        document.getElementById('inquiryForm').classList.add('hidden');
    }
</script>
</body>
</html>