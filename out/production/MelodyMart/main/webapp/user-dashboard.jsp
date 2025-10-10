<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - User Dashboard</title>
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
        .dashboard-card {
            background: linear-gradient(to bottom right, #2e3a4f, #1c1c1c);
            border-radius: 0.5rem;
        }
        .cta-button {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .cta-button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
        }
        @media (max-width: 640px) {
            .dashboard-card {
                padding: 1rem;
            }
            .dashboard-card h2 {
                font-size: 1.5rem;
            }
            .dashboard-card p, .dashboard-card li {
                font-size: 0.875rem;
            }
            .cta-button {
                width: 100%;
            }
        }
        @media (min-width: 641px) {
            .dashboard-card {
                padding: 2rem;
            }
        }
    </style>
</head>
<body class="relative">
<!-- Navbar Include -->
<div id="navbar-container"></div>
<script>
    // Dynamically load
    fetch('delivery_coordination.jsp')
        .then(response => response.text())
        .then(html => {
            document.getElementById('navbar-container').innerHTML = html;
        })
        .catch(error => console.error('Error loading navbar:', error));
</script>

<!-- Main Content -->
<main class="p-4 md:p-6 relative z-10">
    <div class="max-w-3xl mx-auto">
        <div class="dashboard-card p-4 md:p-6">
            <h2 class="text-2xl md:text-3xl font-semibold mb-4">User Dashboard</h2>

            <!-- User Profile -->
            <section class="mb-6">
                <h3 class="text-lg md:text-xl font-semibold mb-2">Profile</h3>
                <p><strong>Name:</strong> John Doe</p>
                <p><strong>Email:</strong> john.doe@example.com</p>
                <p><strong>Role:</strong> Customer</p>
            </section>

            <!-- Order History (Customer Role) -->
            <section class="mb-6">
                <h3 class="text-lg md:text-xl font-semibold mb-2">Order History</h3>
                <ul class="list-disc list-inside">
                    <li>Order #1234 - Acoustic Guitar - $299.99 - Delivered on July 20, 2025</li>
                    <li>Order #1235 - Drum Sticks - $14.99 - Shipped on July 28, 2025</li>
                </ul>
            </section>

            <!-- Admin Controls (Placeholder for Admin Role) -->
            <section class="mb-6 hidden" id="adminControls">
                <h3 class="text-lg md:text-xl font-semibold mb-2">Admin Controls</h3>
                <p>Manage users, products, and reviews here.</p>
                <button class="bg-yellow-500 text-black px-4 py-2 rounded-full mt-2 cta-button">Manage Users</button>
            </section>

            <!-- Logout Button -->
            <button class="bg-red-500 text-white px-4 py-2 md:px-6 md:py-3 rounded-full text-sm md:text-base font-semibold cta-button" onclick="logout()">Logout</button>
        </div>
    </div>
</main>

<script>
    // Simulate Role-Based Display (Placeholder)
    const userRole = "Customer"; // Replace with session data from servlet
    if (userRole === "Admin") {
        document.getElementById('adminControls').classList.remove('hidden');
    }

    // Logout Function (Placeholder)
    function logout() {
        // Replace with servlet call to invalidate session (e.g., /servlet/Logout)
        alert('Logged out successfully. Redirecting to login page.');
        // window.location.href = 'login.html'; // Redirect to login page
    }

    // Button hover effect
    document.querySelectorAll('.cta-button').forEach(button => {
        button.addEventListener('mouseenter', () => {
            button.style.boxShadow = '0 0 15px rgba(255, 255, 255, 0.5)';
        });
        button.addEventListener('mouseleave', () => {
            button.style.boxShadow = 'none';
        });
    });

    // Display current date/time (04:16 PM +0530, Thursday, July 31, 2025)
    const dateTime = new Date().toLocaleString('en-US', {
        timeZone: 'Asia/Colombo',
        hour12: true,
        hour: '2-digit',
        minute: '2-digit',
        timeZoneName: 'short',
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
    document.body.innerHTML += `<p class="text-center mt-4 text-sm md:text-base">${dateTime}</p>`;
</script>
</body>
</html>