<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .sidebar { transition: transform 0.3s ease-in-out; }
        .sidebar-hidden { transform: translateX(-100%); }
    </style>
</head>
<body class="bg-gray-100">
<!-- Navbar -->
<nav class="bg-indigo-600 text-white p-4 flex justify-between items-center">
    <h1 class="text-2xl font-bold">Customer Dashboard</h1>
    <div>
        <span>Welcome, Customer</span>
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
                <li><a href="#products" class="block py-2 px-4 hover:bg-indigo-100">Browse Products</a></li>
                <li><a href="#cart" class="block py-2 px-4 hover:bg-indigo-100">Cart</a></li>
                <li><a href="#orders" class="block py-2 px-4 hover:bg-indigo-100">My Orders</a></li>
                <li><a href="#feedback" class="block py-2 px-4 hover:bg-indigo-100">Feedback & Ratings</a></li>
                <li><a href="#repairs" class="block py-2 px-4 hover:bg-indigo-100">Repair Requests</a></li>
                <li><a href="#messages" class="block py-2 px-4 hover:bg-indigo-100">Messages</a></li>
            </ul>
        </div>
    </aside>

    <!-- Main Dashboard -->
    <main class="flex-1 p-6">
        <!-- Browse Products -->
        <section id="products" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">Browse Products</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <div class="flex mb-4">
                    <input type="text" id="searchInput" placeholder="Search products..." class="w-full p-2 border rounded-l">
                    <button onclick="searchProducts()" class="bg-indigo-500 text-white px-4 py-2 rounded-r hover:bg-indigo-600">Search</button>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <!-- Example product, replace with dynamic JSP data -->
                    <div class="p-4 bg-gray-50 rounded-lg shadow">
                        <h3 class="font-semibold">Acoustic Guitar</h3>
                        <p>$199.99</p>
                        <button onclick="addToCart(101)" class="bg-indigo-500 text-white px-3 py-1 rounded hover:bg-indigo-600 mt-2">Add to Cart</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Cart -->
        <section id="cart" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">Cart</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
                        <th class="p-2">Product ID</th>
                        <th class="p-2">Name</th>
                        <th class="p-2">Price</th>
                        <th class="p-2">Quantity</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2">101</td>
                        <td class="p-2">Acoustic Guitar</td>
                        <td class="p-2">$199.99</td>
                        <td class="p-2">
                            <input type="number" min="1" value="1" onchange="updateCart(101, this.value)" class="w-16 p-1 border rounded">
                        </td>
                        <td class="p-2">
                            <button onclick="removeFromCart(101)" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Remove</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <button onclick="placeOrder()" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 mt-4">Place Order</button>
            </div>
        </section>

        <!-- My Orders -->
        <section id="orders" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">My Orders</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
                        <th class="p-2">Order ID</th>
                        <th class="p-2">Product</th>
                        <th class="p-2">Status</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2">1001</td>
                        <td class="p-2">Acoustic Guitar</td>
                        <td class="p-2">Shipped</td>
                        <td class="p-2">
                            <button onclick="trackOrder(1001)" class="bg-indigo-500 text-white px-3 py-1 rounded hover:bg-indigo-600">Track</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Feedback & Ratings -->
        <section id="feedback" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">Feedback & Ratings</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <form action="feedbackServlet" method="post">
                    <input type="hidden" name="productId" id="feedbackProductId">
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Product</label>
                        <select name="product" id="feedbackProduct" class="w-full p-2 border rounded">
                            <option value="101">Acoustic Guitar</option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Rating</label>
                        <select name="rating" class="w-full p-2 border rounded">
                            <option value="5">5 Stars</option>
                            <option value="4">4 Stars</option>
                            <option value="3">3 Stars</option>
                            <option value="2">2 Stars</option>
                            <option value="1">1 Star</option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Comment</label>
                        <textarea name="comment" class="w-full p-2 border rounded"></textarea>
                    </div>
                    <button type="submit" class="bg-indigo-500 text-white px-4 py-2 rounded hover:bg-indigo-600">Submit Feedback</button>
                </form>
            </div>
        </section>

        <!-- Repair Requests -->
        <section id="repairs" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">Repair Requests</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <form action="repairServlet" method="post">
                    <input type="hidden" name="orderId" id="repairOrderId">
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Order</label>
                        <select name="order" id="repairOrder" class="w-full p-2 border rounded">
                            <option value="1001">Order #1001 - Acoustic Guitar</option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium">Issue Description</label>
                        <textarea name="issue" class="w-full p-2 border rounded" required></textarea>
                    </div>
                    <button type="submit" class="bg-indigo-500 text-white px-4 py-2 rounded hover:bg-indigo-600">Submit Repair Request</button>
                </form>
            </div>
        </section>

        <!-- Messages -->
        <section id="messages">
            <h2 class="text-2xl font-semibold mb-4">Messages</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
                        <th class="p-2">Message ID</th>
                        <th class="p-2">Seller</th>
                        <th class="p-2">Message</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2">401</td>
                        <td class="p-2">Music Store</td>
                        <td class="p-2">The guitar is available in black.</td>
                        <td class="p-2">
                            <button onclick="respondMessage(401)" class="bg-indigo-500 text-white px-3 py-1 rounded hover:bg-indigo-600">Reply</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <!-- Message Reply Form (Hidden by default) -->
                <div id="messageForm" class="hidden bg-white p-6 rounded-lg shadow-md mt-4">
                    <h3 class="text-lg font-semibold mb-4">Reply to Message</h3>
                    <form action="messageServlet" method="post">
                        <input type="hidden" name="messageId" id="messageId">
                        <div class="mb-4">
                            <label class="block text-sm font-medium">Reply</label>
                            <textarea name="reply" id="messageReply" class="w-full p-2 border rounded" required></textarea>
                        </div>
                        <button type="submit" class="bg-indigo-500 text-white px-4 py-2 rounded hover:bg-indigo-600">Send</button>
                        <button type="button" onclick="hideMessageForm()" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">Cancel</button>
                    </form>
                </div>
            </div>
        </section>
    </main>
</div>

<script>
    // Placeholder JavaScript functions for actions
    function searchProducts() {
        let query = document.getElementById('searchInput').value;
        alert(`Searching for: ${query}`);
        // Add server-side logic to search/filter products
    }

    function addToCart(id) {
        alert(`Adding product ID: ${id} to cart`);
        // Add server-side logic to add to cart
    }

    function updateCart(id, quantity) {
        alert(`Updating cart for product ID: ${id} to quantity: ${quantity}`);
        // Add server-side logic to update cart
    }

    function removeFromCart(id) {
        if (confirm(`Are you sure you want to remove product ID: ${id} from cart?`)) {
            alert(`Removing product ID: ${id} from cart`);
            // Add server-side logic to remove from cart
        }
    }

    function placeOrder() {
        alert(`Placing order...`);
        // Add server-side logic to place order
    }

    function trackOrder(id) {
        alert(`Tracking order ID: ${id}`);
        // Add server-side logic to show tracking details
    }

    function respondMessage(id) {
        document.getElementById('messageForm').classList.remove('hidden');
        document.getElementById('messageId').value = id;
        document.getElementById('messageReply').value = '';
    }

    function hideMessageForm() {
        document.getElementById('messageForm').classList.add('hidden');
    }
</script>
</body>
</html>