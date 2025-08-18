<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MelodyMart - Contact Us</title>
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
        .contact-card {
            background: linear-gradient(to bottom right, #2e3a4f, #1c1c1c);
            border-radius: 0.5rem;
        }
        .form-input {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 0.375rem;
        }
        .form-input:focus {
            border-color: #4A90E2;
            box-shadow: 0 0 5px rgba(74, 144, 226, 0.5);
        }
        .cta-button {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .cta-button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
        }
        @media (max-width: 640px) {
            .contact-card {
                padding: 1rem;
            }
            .form-input {
                width: 100%;
            }
            .cta-button {
                width: 100%;
            }
            .contact-card h2 {
                font-size: 1.5rem;
            }
            .contact-card p {
                font-size: 0.875rem;
            }
        }
        @media (min-width: 641px) {
            .contact-card {
                padding: 2rem;
            }
        }
    </style>
</head>
<body class="relative">
<!-- Header Navigation -->
<header class="flex justify-between items-center p-6 z-10 relative">
    <div class="text-3xl font-bold font-['Bebas+Neue']">MelodyMart</div>
    <nav class="flex space-x-6 items-center">
        <a href="index.jsp" class="text-lg hover:text-blue-300">Home</a>
        <a href="instruments.jsp" class="text-lg hover:text-blue-300">Instruments</a>
        <a href="accessories.jsp" class="text-lg hover:text-blue-300">Accessories</a>
        <a href="deals.jsp" class="text-lg hover:text-blue-300">Deals</a>
        <a href="contact-us.jsp" class="text-lg hover:text-blue-300">Contact Us</a>
        <% if (session.getAttribute("user") == null) { %>
        <button class="auth-button" id="signInBtn" onclick="window.location.href='login.jsp'">Sign In</button>
        <button class="auth-button" id="signUpBtn" onclick="window.location.href='register.jsp'">Sign Up</button>
        <% } else { %>
        <button class="auth-button" onclick="window.location.href='profile.jsp'">My Account</button>
        <button class="auth-button" onclick="window.location.href='LogoutServlet'">Logout</button>
        <% } %>
    </nav>
</header>

<!-- Main Content -->
<main class="p-4 md:p-6 relative z-10">
    <div class="max-w-2xl mx-auto">
        <div class="contact-card p-4 md:p-6">
            <h2 class="text-2xl md:text-3xl font-semibold mb-4">Contact Us</h2>
            <p class="text-sm md:text-base mb-6">We'd love to hear from you! Please fill out the form below or reach us at <a href="mailto:support@melodymart.com" class="text-blue-300">support@melodymart.com</a>.</p>

            <!-- Contact Form -->
            <form id="contactForm" action="ContactServlet" method="POST" class="space-y-4">
                <div>
                    <label for="name" class="block text-sm md:text-base mb-1">Name</label>
                    <input type="text" id="name" name="name" required class="w-full p-2 form-input text-white focus:outline-none"
                           value="<%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "" %>"
                           aria-label="Your name">
                </div>
                <div>
                    <label for="email" class="block text-sm md:text-base mb-1">Email</label>
                    <input type="email" id="email" name="email" required class="w-full p-2 form-input text-white focus:outline-none"
                           value="<%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "" %>"
                           aria-label="Your email">
                </div>
                <div>
                    <label for="subject" class="block text-sm md:text-base mb-1">Subject</label>
                    <input type="text" id="subject" name="subject" required class="w-full p-2 form-input text-white focus:outline-none" aria-label="Subject of your message">
                </div>
                <div>
                    <label for="message" class="block text-sm md:text-base mb-1">Message</label>
                    <textarea id="message" name="message" rows="4" required class="w-full p-2 form-input text-white focus:outline-none" aria-label="Your message"></textarea>
                </div>
                <button type="submit" class="bg-white text-black px-4 py-2 md:px-6 md:py-3 rounded-full text-sm md:text-base font-semibold cta-button">Send Message</button>
            </form>

            <!-- Feedback Message -->
            <% if (request.getAttribute("message") != null) { %>
            <p id="feedback" class="mt-4 text-sm md:text-base
                    <%= request.getAttribute("status").equals("success") ? "text-green-300" : "text-red-300" %>">
                <%= request.getAttribute("message") %>
            </p>
            <script>
                // Hide feedback after 5 seconds
                setTimeout(() => {
                    document.getElementById('feedback').style.display = 'none';
                }, 5000);
            </script>
            <% } else { %>
            <p id="feedback" class="mt-4 text-sm md:text-base text-green-300 hidden"></p>
            <% } %>
        </div>
    </div>
</main>

<script>
    // Form Submission
    document.getElementById('contactForm').addEventListener('submit', function(e) {
        const feedback = document.getElementById('feedback');
        feedback.textContent = "Sending your message...";
        feedback.classList.remove('hidden');

        // Form will submit to ContactServlet via normal form submission
        // The servlet will process and redirect back with status/message
    });

    // Button hover effect
    document.querySelectorAll('.cta-button').forEach(button => {
        button.addEventListener('mouseenter', () => {
            button.style.boxShadow = '0 0 15px rgba(255, 255, 255, 0.5)';
        });
        button.addEventListener('mouseleave', () => {
            button.style.boxShadow = 'none';
        });
    });

    // Display current date/time
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