<%@ page import="java.sql.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // ✅ Get logged-in userID from session (set in login servlet)
    String userID = (String) session.getAttribute("userID");

    // If session expired accidentally, redirect once to login
    if (userID == null) {
        response.sendRedirect("sign-up.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Repair Requests | MelodyMart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1e40af;
            --primary-light: #3b82f6;
            --primary-soft: #93c5fd;
            --secondary: #93c5fd;
            --text: #1e293b;
            --text-secondary: #475569;
            --glass-bg: rgba(147, 197, 253, 0.9);
            --glass-border: rgba(147, 197, 253, 0.3);
            --gradient: linear-gradient(135deg, var(--primary), var(--primary-light));
            --shadow: 0 5px 20px rgba(30, 64, 175, 0.1);
            --shadow-hover: 0 10px 30px rgba(30, 64, 175, 0.2);
            --header-bg: rgba(147, 197, 253, 0.95);
            --card-bg: var(--secondary);
            --card-hover: #76a9fc;
            --border-radius: 16px;
            --success: #10b981;
            --warning: #f59e0b;
            --error: #ef4444;
        }

        [data-theme="dark"] {
            --primary: #3b82f6;
            --primary-light: #60a5fa;
            --primary-soft: #0f2a5e;
            --secondary: #0f2a5e;
            --text: #f1f5f9;
            --text-secondary: #cbd5e1;
            --glass-bg: rgba(15, 42, 94, 0.9);
            --glass-border: rgba(255, 255, 255, 0.1);
            --gradient: linear-gradient(135deg, var(--primary), var(--primary-light));
            --shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
            --shadow-hover: 0 10px 30px rgba(0, 0, 0, 0.4);
            --header-bg: rgba(15, 42, 94, 0.95);
            --card-bg: var(--secondary);
            --card-hover: #0e2a5d;
            --success: #34d399;
            --warning: #fbbf24;
            --error: #f87171;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.4s ease, color 0.4s ease, border-color 0.4s ease, box-shadow 0.4s ease;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--secondary);
            color: var(--text);
            overflow-x: hidden;
            line-height: 1.6;
        }

        .container {
            width: 85%;
            max-width: 1400px;
            margin: 60px auto;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            padding: 35px 45px;
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.8s ease, transform 0.8s ease;
        }

        .container.visible {
            opacity: 1;
            transform: translateY(0);
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            color: var(--primary);
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }

        h2:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--gradient);
            border-radius: 2px;
        }

        h3 {
            font-family: 'Montserrat', sans-serif;
            font-size: 24px;
            color: var(--primary);
            margin: 25px 0 15px;
        }

        form {
            margin-top: 25px;
            padding: 20px;
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            background: var(--card-bg);
            box-shadow: var(--shadow);
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.6s ease, transform 0.6s ease;
        }

        form.visible {
            opacity: 1;
            transform: translateY(0);
        }

        label {
            font-weight: 600;
            color: var(--text);
            display: block;
            margin-top: 15px;
        }

        input[type="text"], input[type="date"], textarea, select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--glass-border);
            border-radius: 6px;
            margin-top: 5px;
            background: var(--secondary);
            color: var(--text);
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus, input[type="date"]:focus, textarea:focus, select:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 5px rgba(59, 130, 246, 0.3);
            outline: none;
        }

        input[type="file"] {
            margin-top: 6px;
            color: var(--text-secondary);
        }

        button {
            margin-top: 20px;
            padding: 12px 30px;
            background: var(--gradient);
            border: none;
            color: white;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        button:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
        }

        button i {
            font-size: 14px;
        }

        .esc-button {
            margin-top: 20px;
            padding: 10px 20px;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            color: var(--text);
            border-radius: 30px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
            display: inline-block;
            text-decoration: none;
        }

        .esc-button:hover {
            background: var(--card-hover);
            color: var(--text-secondary);
            box-shadow: var(--shadow-hover);
        }

        /* Repair Requests Section */
        .requests-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .filters {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .filters label {
            margin-top: 0;
            font-weight: 500;
        }

        .filters select {
            width: auto;
            min-width: 150px;
        }

        .search-box {
            position: relative;
            width: 250px;
        }

        .search-box input {
            padding-left: 40px;
        }

        .search-box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }

        .requests-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .request-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--shadow);
            border: 1px solid var(--glass-border);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .request-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .request-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 1px solid var(--glass-border);
            padding-bottom: 10px;
        }

        .request-id {
            font-weight: 700;
            color: var(--primary);
            font-size: 18px;
        }

        .request-date {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .request-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-submitted {
            background-color: rgba(59, 130, 246, 0.2);
            color: var(--primary);
        }

        .status-approved {
            background-color: rgba(16, 185, 129, 0.2);
            color: var(--success);
        }

        .status-in-progress {
            background-color: rgba(245, 158, 11, 0.2);
            color: var(--warning);
        }

        .status-completed {
            background-color: rgba(16, 185, 129, 0.2);
            color: var(--success);
        }

        .status-rejected {
            background-color: rgba(239, 68, 68, 0.2);
            color: var(--error);
        }

        .request-details {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
        }

        .detail-label {
            font-weight: 600;
            color: var(--text-secondary);
        }

        .detail-value {
            color: var(--text);
            text-align: right;
            max-width: 60%;
        }

        .request-description {
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid var(--glass-border);
        }

        .request-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .action-btn {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            border: none;
            transition: all 0.3s ease;
            flex: 1;
            text-align: center;
            text-decoration: none;
        }

        .view-btn {
            background-color: var(--primary-light);
            color: white;
        }

        .view-btn:hover {
            background-color: var(--primary);
        }

        .update-btn {
            background-color: var(--warning);
            color: white;
        }

        .update-btn:hover {
            background-color: #e69500;
        }

        .no-requests {
            text-align: center;
            padding: 40px 20px;
            color: var(--text-secondary);
            grid-column: 1 / -1;
        }

        .no-requests i {
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--primary-soft);
        }

        .no-requests p {
            font-size: 18px;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: var(--glass-bg);
            border-radius: var(--border-radius);
            padding: 30px;
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: var(--shadow-hover);
            border: 1px solid var(--glass-border);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--glass-border);
        }

        .modal-title {
            font-size: 24px;
            color: var(--primary);
            font-weight: 600;
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 24px;
            color: var(--text-secondary);
            cursor: pointer;
            padding: 0;
            margin: 0;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-body {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .status-history {
            margin-top: 20px;
        }

        .history-item {
            padding: 10px 0;
            border-bottom: 1px solid var(--glass-border);
        }

        .history-item:last-child {
            border-bottom: none;
        }

        .history-date {
            font-size: 12px;
            color: var(--text-secondary);
        }

        .history-status {
            font-weight: 600;
            margin: 5px 0;
        }

        .history-comment {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                width: 90%;
                margin: 40px auto;
                padding: 25px;
            }

            h2 {
                font-size: 32px;
            }

            h3 {
                font-size: 20px;
            }

            form {
                padding: 15px;
            }

            .requests-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .filters {
                width: 100%;
                justify-content: space-between;
            }

            .search-box {
                width: 100%;
            }

            .requests-grid {
                grid-template-columns: 1fr;
            }

            .request-actions {
                flex-direction: column;
            }
        }

        @media (max-width: 576px) {
            .container {
                width: 95%;
                padding: 20px;
            }

            h2 {
                font-size: 28px;
            }

            .filters {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .filters select {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>🛠 Submit a New Repair Request</h2>

    <!-- Repair Request Form -->
    <form action="SubmitRepairRequestServlet" method="post" enctype="multipart/form-data">
        <!-- No need to send userID — servlet reads from session -->
        <label for="orderId">Order ID (optional)</label>
        <input type="text" name="orderId" id="orderId" placeholder="Enter related order ID">

        <label for="issueDescription">Issue Description</label>
        <textarea name="issueDescription" id="issueDescription" rows="4" placeholder="Describe the issue" required></textarea>

        <label for="repairDate">Preferred Repair Date</label>
        <input type="date" name="repairDate" id="repairDate" required>

        <label for="photos">Upload Photo (optional)</label>
        <input type="file" name="photos" accept="image/*">

        <button type="submit"><i class="fas fa-paper-plane"></i> Submit Request</button>
    </form>

    <a href="customerlanding.jsp" class="esc-button">Esc - Back to Customer Landing</a>

    <hr style="border: 1px solid var(--glass-border); margin: 40px 0;">

    <!-- Repair Requests Section -->
    <div class="requests-header">
        <h3>📋 Your Repair Requests</h3>
        <div class="filters">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search requests...">
            </div>
            <label for="statusFilter">Status:</label>
            <select id="statusFilter">
                <option value="all">All Statuses</option>
                <option value="Submitted">Submitted</option>
                <option value="Approved">Approved</option>
                <option value="In Progress">In Progress</option>
                <option value="Completed">Completed</option>
                <option value="Rejected">Rejected</option>
            </select>
            <label for="sortBy">Sort by:</label>
            <select id="sortBy">
                <option value="newest">Newest First</option>
                <option value="oldest">Oldest First</option>
                <option value="status">Status</option>
            </select>
        </div>
    </div>

    <div class="requests-grid" id="requestsContainer">
        <%
            try (Connection conn = DBConnection.getConnection()) {
                // Query to get repair requests with related data
                String sql = "SELECT " +
                        "rr.RepairRequestID, " +
                        "rr.OrderID, " +
                        "rr.IssueDescription, " +
                        "rr.Status, " +
                        "rr.RequestDate, " +
                        "rc.RepairDate, " +
                        "rc.EstimatedCost, " +
                        "rp.PhotoPath, " +
                        "rsh.Comment " +
                        "FROM RepairRequest rr " +
                        "LEFT JOIN RepairCost rc ON rr.RepairRequestID = rc.RepairRequestID " +
                        "LEFT JOIN RepairPhoto rp ON rr.RepairRequestID = rp.RepairRequestID " +
                        "LEFT JOIN ( " +
                        "    SELECT RepairRequestID, Comment, ROW_NUMBER() OVER (PARTITION BY RepairRequestID ORDER BY UpdatedDate DESC) as rn " +
                        "    FROM RepairStatusHistory " +
                        ") rsh ON rr.RepairRequestID = rsh.RepairRequestID AND rsh.rn = 1 " +
                        "WHERE rr.UserID = ? " +
                        "ORDER BY rr.RequestDate DESC";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, userID);
                ResultSet rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) {
        %>
        <div class="no-requests">
            <i class="fas fa-tools"></i>
            <p>No repair requests found yet.</p>
        </div>
        <%
        } else {
            while (rs.next()) {
                String repairRequestId = rs.getString("RepairRequestID");
                String orderId = rs.getString("OrderID");
                String issueDescription = rs.getString("IssueDescription");
                String status = rs.getString("Status");
                Timestamp requestDate = rs.getTimestamp("RequestDate");
                String repairDate = rs.getString("RepairDate");
                String estimatedCost = rs.getString("EstimatedCost");
                String photoPath = rs.getString("PhotoPath");
                String comment = rs.getString("Comment");

                // Format dates
                String formattedRequestDate = requestDate != null ?
                        new java.text.SimpleDateFormat("MMM dd, yyyy").format(requestDate) : "N/A";
                String formattedRepairDate = repairDate != null ?
                        new java.text.SimpleDateFormat("MMM dd, yyyy").format(
                                java.sql.Date.valueOf(repairDate)) : "Not scheduled";

                // Format cost
                String formattedCost = "₹0.00";
                if (estimatedCost != null && !estimatedCost.equals("0.00")) {
                    formattedCost = "₹" + estimatedCost;
                }

                // Get status history for this request
                java.util.List<java.util.Map<String, String>> statusHistory = new java.util.ArrayList<>();
                try (PreparedStatement historyPs = conn.prepareStatement(
                        "SELECT Status, Comment, UpdatedDate FROM RepairStatusHistory " +
                                "WHERE RepairRequestID = ? ORDER BY UpdatedDate DESC")) {
                    historyPs.setString(1, repairRequestId);
                    ResultSet historyRs = historyPs.executeQuery();
                    while (historyRs.next()) {
                        java.util.Map<String, String> historyItem = new java.util.HashMap<>();
                        historyItem.put("status", historyRs.getString("Status"));
                        historyItem.put("comment", historyRs.getString("Comment"));
                        historyItem.put("date", historyRs.getString("UpdatedDate"));
                        statusHistory.add(historyItem);
                    }
                }
        %>
        <div class="request-card" data-id="<%= repairRequestId %>" data-status="<%= status %>">
            <div class="request-header">
                <div>
                    <div class="request-id"><%= repairRequestId %></div>
                    <div class="request-date">Requested: <%= formattedRequestDate %></div>
                </div>
                <div class="request-status status-<%= status.toLowerCase().replace(" ", "-") %>">
                    <%= status %>
                </div>
            </div>

            <div class="request-details">
                <div class="detail-row">
                    <span class="detail-label">Order ID:</span>
                    <span class="detail-value"><%= orderId %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Repair Date:</span>
                    <span class="detail-value"><%= formattedRepairDate %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Estimated Cost:</span>
                    <span class="detail-value"><%= formattedCost %></span>
                </div>
            </div>

            <div class="request-description">
                <div class="detail-label">Issue Description:</div>
                <div class="detail-value">
                    <%= issueDescription.length() > 100 ? issueDescription.substring(0, 100) + "..." : issueDescription %>
                </div>
            </div>

            <div class="request-actions">
                <button class="action-btn view-btn" onclick="showRequestDetails('<%= repairRequestId %>')">
                    <i class="fas fa-eye"></i> View Details
                </button>
                <% if ("Submitted".equals(status)) { %>
                <button class="action-btn update-btn" onclick="updateRequest('<%= repairRequestId %>')">
                    <i class="fas fa-edit"></i> Update
                </button>
                <% } %>
            </div>
        </div>
        <%
                    }
                    rs.close();
                    ps.close();
                }
            } catch (SQLException e) {
                out.println("<div class='no-requests'><p style='color: var(--error);'>Database error: " + e.getMessage() + "</p></div>");
            }
        %>
    </div>
</div>

<!-- Request Details Modal -->
<div class="modal" id="requestModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Repair Request Details</h3>
            <button class="close-modal">&times;</button>
        </div>
        <div class="modal-body" id="modalBody">
            <!-- Modal content will be dynamically inserted here -->
        </div>
    </div>
</div>

<script>
    // DOM elements
    const requestsContainer = document.getElementById('requestsContainer');
    const searchInput = document.getElementById('searchInput');
    const statusFilter = document.getElementById('statusFilter');
    const sortBy = document.getElementById('sortBy');
    const requestModal = document.getElementById('requestModal');
    const modalBody = document.getElementById('modalBody');
    const closeModal = document.querySelector('.close-modal');

    // Initialize the page
    document.addEventListener('DOMContentLoaded', function() {
        setupEventListeners();

        // Add visible class for animations
        document.querySelector('.container').classList.add('visible');
        document.querySelector('form').classList.add('visible');
    });

    // Set up event listeners
    function setupEventListeners() {
        searchInput.addEventListener('input', filterRequests);
        statusFilter.addEventListener('change', filterRequests);
        sortBy.addEventListener('change', filterRequests);
        closeModal.addEventListener('click', function() {
            requestModal.style.display = 'none';
        });

        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === requestModal) {
                requestModal.style.display = 'none';
            }
        });

        // Handle Esc key press for redirection
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                if (requestModal.style.display === 'flex') {
                    requestModal.style.display = 'none';
                } else {
                    window.location.href = 'customerlanding.jsp';
                }
            }
        });
    }

    // Filter and sort requests
    function filterRequests() {
        const searchTerm = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;
        const sortValue = sortBy.value;

        const requestCards = document.querySelectorAll('.request-card');
        let visibleCards = [];

        requestCards.forEach(function(card) {
            const requestId = card.getAttribute('data-id').toLowerCase();
            const requestStatus = card.getAttribute('data-status');
            const requestText = card.textContent.toLowerCase();

            // Search filter
            const matchesSearch = requestId.includes(searchTerm) || requestText.includes(searchTerm);

            // Status filter
            const matchesStatus = statusValue === 'all' || requestStatus === statusValue;

            if (matchesSearch && matchesStatus) {
                card.style.display = 'flex';
                visibleCards.push(card);
            } else {
                card.style.display = 'none';
            }
        });

        // Sort requests
        visibleCards.sort(function(a, b) {
            const aId = a.getAttribute('data-id');
            const bId = b.getAttribute('data-id');
            const aStatus = a.getAttribute('data-status');
            const bStatus = b.getAttribute('data-status');

            switch(sortValue) {
                case 'newest':
                    return bId.localeCompare(aId); // Assuming newer IDs are higher
                case 'oldest':
                    return aId.localeCompare(bId);
                case 'status':
                    return aStatus.localeCompare(bStatus);
                default:
                    return 0;
            }
        });

        // Reorder the DOM (optional - for visual sorting)
        visibleCards.forEach(function(card) {
            requestsContainer.appendChild(card);
        });
    }

    // Show request details in modal (this would need server-side implementation for full details)
    function showRequestDetails(requestId) {
        // For now, show a simple alert. In a real implementation, you would:
        // 1. Make an AJAX call to get detailed information
        // 2. Populate the modal with the response data

        modalBody.innerHTML = '<p>Loading details for request: ' + requestId + '</p>' +
            '<p>In a full implementation, this would fetch detailed information from the server including:</p>' +
            '<ul>' +
            '<li>Complete status history</li>' +
            '<li>All uploaded photos</li>' +
            '<li>Detailed cost breakdown</li>' +
            '<li>Technician notes</li>' +
            '</ul>' +
            '<p>For now, please check the database directly for complete details.</p>';

        requestModal.style.display = 'flex';
    }

    // Update request (placeholder function)
    function updateRequest(requestId) {
        alert('Update functionality for request ' + requestId + ' would be implemented here.\n\nThis would typically allow you to:\n- Update the issue description\n- Change the preferred repair date\n- Add additional photos\n- Cancel the request');
    }
</script>
</body>
</html>