<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .sidebar { transition: transform 0.3s ease-in-out; }
        .sidebar-hidden { transform: translateX(-100%); }
    </style>
</head>
<body class="bg-gray-100">
<!-- Navbar -->
<nav class="bg-blue-600 text-white p-4 flex justify-between items-center">
    <h1 class="text-2xl font-bold">Admin Dashboard</h1>
    <div>
        <span>Welcome, Admin</span>
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
                <li><a href="#users" class="block py-2 px-4 hover:bg-blue-100">User Management</a></li>
                <li><a href="#listings" class="block py-2 px-4 hover:bg-blue-100">Listing Moderation</a></li>
                <li><a href="#feedback" class="block py-2 px-4 hover:bg-blue-100">Feedback Moderation</a></li>
                <li><a href="#reports" class="block py-2 px-4 hover:bg-blue-100">Reports</a></li>
                <li><a href="#performance" class="block py-2 px-4 hover:bg-blue-100">System Performance</a></li>
            </ul>
        </div>
    </aside>

    <!-- Main Dashboard -->
    <main class="flex-1 p-6">
        <!-- User Management -->
        <section id="users" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">User Management</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
                        <th class="p-2">User ID</th>
                        <th class="p-2">Username</th>
                        <th class="p-2">Email</th>
                        <th class="p-2">Status</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Example data, replace with dynamic JSP data -->
                    <tr>
                        <td class="p-2">1</td>
                        <td class="p-2">john_doe</td>
                        <td class="p-2">john@example.com</td>
                        <td class="p-2">Active</td>
                        <td class="p-2">
                            <button onclick="approveUser(1)" class="bg-green-500 text-white px-3 py-1 rounded hover:bg-green-600">Approve</button>
                            <button onclick="deleteUser(1)" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Delete</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Listing Moderation -->
        <section id="listings" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">Listing Moderation</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
                        <th class="p-2">Listing ID</th>
                        <th class="p-2">Title</th>
                        <th class="p-2">Seller</th>
                        <th class="p-2">Status</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2">101</td>
                        <td class="p-2">Sample Product</td>
                        <td class="p-2">john_doe</td>
                        <td class="p-2">Pending</td>
                        <td class="p-2">
                            <button onclick="approveListing(101)" class="bg-green-500 text-white px-3 py-1 rounded hover:bg-green-600">Approve</button>
                            <button onclick="deleteListing(101)" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Delete</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Feedback Moderation -->
        <section id="feedback" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">Feedback Moderation</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <table class="w-full table-auto">
                    <thead>
                    <tr class="bg-gray-200">
                        <th class="p-2">Feedback ID</th>
                        <th class="p-2">User</th>
                        <th class="p-2">Comment</th>
                        <th class="p-2">Status</th>
                        <th class="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2">201</td>
                        <td class="p-2">john_doe</td>
                        <td class="p-2">Great product!</td>
                        <td class="p-2">Pending</td>
                        <td class="p-2">
                            <button onclick="approveFeedback(201)" class="bg-green-500 text-white px-3 py-1 rounded hover:bg-green-600">Approve</button>
                            <button onclick="deleteFeedback(201)" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Delete</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- System Performance -->
        <section id="performance" class="mb-8">
            <h2 class="text-2xl font-semibold mb-4">System Performance</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div class="p-4 bg-blue-100 rounded">
                        <h3 class="font-semibold">Uptime</h3>
                        <p>99.9%</p>
                    </div>
                    <div class="p-4 bg-blue-100 rounded">
                        <h3 class="font-semibold">Active Users</h3>
                        <p>1,234</p>
                    </div>
                    <div class="p-4 bg-blue-100 rounded">
                        <h3 class="font-semibold">Server Load</h3>
                        <p>45%</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Reports -->
        <section id="reports">
            <h2 class="text-2xl font-semibold mb-4">Generate Reports</h2>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <div class="flex space-x-4">
                    <button onclick="generateSalesReport()" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Sales Report</button>
                    <button onclick="generateUserReport()" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">User Report</button>
                    <button onclick="generatePerformanceReport()" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Performance Report</button>
                </div>
            </div>
        </section>
    </main>
</div>

<script>
    // Placeholder JavaScript functions for actions
    function approveUser(id) {
        alert(`Approving user with ID: ${id}`);
        // Add server-side logic to approve user
    }

    function deleteUser(id) {
        if (confirm(`Are you sure you want to delete user with ID: ${id}?`)) {
            alert(`Deleting user with ID: ${id}`);
            // Add server-side logic to delete user
        }
    }

    function approveListing(id) {
        alert(`Approving listing with ID: ${id}`);
        // Add server-side logic to approve listing
    }

    function deleteListing(id) {
        if (confirm(`Are you sure you want to delete listing with ID: ${id}?`)) {
            alert(`Deleting listing with ID: ${id}`);
            // Add server-side logic to delete listing
        }
    }

    function approveFeedback(id) {
        alert(`Approving feedback with ID: ${id}`);
        // Add server-side logic to approve feedback
    }

    function deleteFeedback(id) {
        if (confirm(`Are you sure you want to delete feedback with ID: ${id}?`)) {
            alert(`Deleting feedback with ID: ${id}`);
            // Add server-side logic to delete feedback
        }
    }

    function generateSalesReport() {
        alert("Generating sales report...");
        // Add server-side logic to generate sales report
    }

    function generateUserReport() {
        alert("Generating user report...");
        // Add server-side logic to generate user report
    }

    function generatePerformanceReport() {
        alert("Generating performance report...");
        // Add server-side logic to generate performance report
    }
</script>
</body>
</html>