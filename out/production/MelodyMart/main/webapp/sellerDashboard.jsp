<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .sidebar { transition: transform 0.3s ease-in-out; }
        .sidebar-hidden { transform: translateX(-100%); }
    </style>
</head>
<body class="bg-gray-100">
<!-- Navbar -->
<nav class="bg-green-600 text-white p-4 flex justify-between items-center">
    <h1 class="text-2xl font-bold">Seller Dashboard</h1>
    <div>
        <span>Welcome, Seller</span>
        <a href="logout.jsp" class="ml-4 hover:underline">Logout</a>
    </div>
</nav>

<!-- Main Content -->
<div class="flex min-h-screen">
    <!-- Sidebar -->
    <aside class="w-64 bg-white shadow-md sidebar">
        <div class="p-4">
            <h2 class="text-lg font-semibold mb-4">Navigation</h2>
            <ul>
                <li><a href="#products" class="block py-2 px-4 hover:bg-green-100">Manage Products</a></li>
                <li><a href="#stock" class="block py-2 px-4 hover:bg-green-100">Stock Levels</a></li>
                <li><a href="#orders" class="block py-2 px-4 hover:bg-green-100">Orders</a></li>
                <li><a href="#inquiries" class="block py-2 px-4 hover:bg-green-100">Customer Inquiries</a></li>
            </ul>
        </div>
    </aside>

    <!-- Main Dashboard -->
    <main class="flex-1 p-6">
        <!-- Manage Products -->
        <section id="products" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">Manage Products</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <button onclick="showAddProductForm()" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 mb-4">Add New Product</button>
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
                        <th class="p-2">Product ID</th>
                        <th class="p-2">Name</th>
                        <th class="p-2">Price</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Example data, replace with dynamic JSP data -->
                    <tr>
                        <td class="p-2">101</td>
                        <td class="p-2">Acoustic Guitar</td>
                        <td class="p-2">$199.99</td>
                        <td class="p-2">
                            <button onclick="editProduct(101)" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600">Edit</button>
                            <button onclick="deleteProduct(101)" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Delete</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- Add/Edit Product Form (Hidden by default) -->
            <div id="productForm" class="hidden bg-white p-6 rounded-lg shadow-md mt-4">
                <h3 class="text-lg font-semibold mb-4">Add/Edit Product</h3>
                <form action="productServlet" method="post">
                    <input type="hidden" name="productId" id="productId">
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Product Name</label>
                        <input type="text" name="name" id="productName" class="w-full p-2 border rounded" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Price</label>
                        <input type="number" step="0.01" name="price" id="productPrice" class="w-full p-2 border rounded" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Description</label>
                        <textarea name="description" id="productDescription" class="w-full p-2 border rounded"></textarea>
                    </div>
                    <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Save</button>
                    <button type="button" onclick="hideProductForm()" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">Cancel</button>
                </form>
            </div>
        </section>

        <!-- Stock Levels -->
        <section id="stock" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">Stock Levels</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
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
                            <button onclick="updateStock(101)" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600">Update</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Orders -->
        <section id="orders" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">Orders</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
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
                            <select onchange="updateOrderStatus(1001, this.value)" class="p-2 border rounded">
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
            <h2 class="text-2xl font-semibold mb-4">Customer Inquiries</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
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
                            <button onclick="respondInquiry(301)" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600">Respond</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- Respond Inquiry Form (Hidden by default) -->
            <div id="inquiryForm" class="hidden bg-white p-6 rounded-lg shadow-md mt-4">
                <h3 class="text-lg font-semibold mb-4">Respond to Inquiry</h3>
                <form action="inquiryServlet" method="post">
                    <input type="hidden" name="inquiryId" id="inquiryId">
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Response</label>
                        <textarea name="response" id="inquiryResponse" class="w-full p-2 border rounded" required></textarea>
                    </div>
                    <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Send</button>
                    <button type="button" onclick="hideInquiryForm()" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">Cancel</button>
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
        // Fetch product data via AJAX and populate form
        document.getElementById('productForm').classList.remove('hidden');
        // Example: document.getElementById('productId').value = id;
    }

    function deleteProduct(id) {
        if (confirm(`Are you sure you want to delete product with ID: ${id}?`)) {
            alert(`Deleting product with ID: ${id}`);
            // Add server-side logic to delete product
        }
    }

    function updateStock(id) {
        let stock = prompt(`Enter new stock level for product ID: ${id}`);
        if (stock) {
            alert(`Updating stock for product ID: ${id} to ${stock}`);
            // Add server-side logic to update stock
        }
    }

    function updateOrderStatus(id, status) {
        alert(`Updating order ID: ${id} to status: ${status}`);
        // Add server-side logic to update order status
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