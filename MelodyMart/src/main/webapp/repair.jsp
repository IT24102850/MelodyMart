<%@ page import="java.sql.*" %>
<%@ page import="main.java.com.melodymart.util.DBConnection" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // ✅ Get logged-in userID from session (set in login servlet)
    String userID = (String) session.getAttribute("userID");

    // If session expired accidentally, redirect once to login
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Create a list to store repair requests data for JavaScript
    List<Map<String, Object>> repairRequestsList = new ArrayList<>();

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

        while (rs.next()) {
            Map<String, Object> repairReq = new HashMap<>();
            repairReq.put("id", rs.getString("RepairRequestID"));
            repairReq.put("orderId", rs.getString("OrderID"));
            repairReq.put("issueDescription", rs.getString("IssueDescription"));
            repairReq.put("status", rs.getString("Status"));
            repairReq.put("requestDate", rs.getTimestamp("RequestDate").toString());
            repairReq.put("repairDate", rs.getDate("RepairDate") != null ? rs.getDate("RepairDate").toString() : null);
            repairReq.put("estimatedCost", rs.getBigDecimal("EstimatedCost") != null ? "₹" + rs.getBigDecimal("EstimatedCost") : "₹0.00");
            repairReq.put("photoPath", rs.getString("PhotoPath"));
            repairReq.put("comment", rs.getString("Comment") != null ? rs.getString("Comment") : "No comment available");

            // Get status history for this request
            List<Map<String, String>> statusHistory = new ArrayList<>();
            try (PreparedStatement historyPs = conn.prepareStatement(
                    "SELECT Status, Comment, UpdatedDate FROM RepairStatusHistory " +
                            "WHERE RepairRequestID = ? ORDER BY UpdatedDate ASC")) {
                historyPs.setString(1, rs.getString("RepairRequestID"));
                ResultSet historyRs = historyPs.executeQuery();
                while (historyRs.next()) {
                    Map<String, String> historyItem = new HashMap<>();
                    historyItem.put("status", historyRs.getString("Status"));
                    historyItem.put("comment", historyRs.getString("Comment"));
                    historyItem.put("date", historyRs.getTimestamp("UpdatedDate").toString());
                    statusHistory.add(historyItem);
                }
            }
            repairReq.put("statusHistory", statusHistory);

            repairRequestsList.add(repairReq);
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
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
        <!-- Repair requests will be dynamically inserted here -->
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
    // Convert Java List to JavaScript array
    const repairRequests = [
        <% for (int i = 0; i < repairRequestsList.size(); i++) {
            Map<String, Object> repairReq = repairRequestsList.get(i);
        %>
        {
            id: "<%= repairReq.get("id") %>",
            orderId: "<%= repairReq.get("orderId") %>",
            issueDescription: "<%= escapeJavaScript((String)repairReq.get("issueDescription")) %>",
            status: "<%= repairReq.get("status") %>",
            requestDate: "<%= repairReq.get("requestDate") %>",
            repairDate: "<%= repairReq.get("repairDate") != null ? repairReq.get("repairDate") : "" %>",
            estimatedCost: "<%= repairReq.get("estimatedCost") %>",
            photoPath: "<%= repairReq.get("photoPath") != null ? repairReq.get("photoPath") : "" %>",
            comment: "<%= escapeJavaScript((String)repairReq.get("comment")) %>",
            statusHistory: [
                <%
                List<Map<String, String>> statusHistory = (List<Map<String, String>>) repairReq.get("statusHistory");
                for (int j = 0; j < statusHistory.size(); j++) {
                    Map<String, String> history = statusHistory.get(j);
                %>
                {
                    status: "<%= history.get("status") %>",
                    date: "<%= history.get("date") %>",
                    comment: "<%= escapeJavaScript(history.get("comment")) %>"
                }<%= j < statusHistory.size() - 1 ? "," : "" %>
                <% } %>
            ]
        }<%= i < repairRequestsList.size() - 1 ? "," : "" %>
        <% } %>
    ];

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
        renderRequests(repairRequests);
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

        let filteredRequests = repairRequests.filter(function(repairReq) {
            // Search filter
            const matchesSearch =
                repairReq.id.toLowerCase().includes(searchTerm) ||
                repairReq.issueDescription.toLowerCase().includes(searchTerm) ||
                (repairReq.orderId && repairReq.orderId.toLowerCase().includes(searchTerm));

            // Status filter
            const matchesStatus = statusValue === 'all' || repairReq.status === statusValue;

            return matchesSearch && matchesStatus;
        });

        // Sort requests
        filteredRequests.sort(function(a, b) {
            switch(sortValue) {
                case 'newest':
                    return new Date(b.requestDate) - new Date(a.requestDate);
                case 'oldest':
                    return new Date(a.requestDate) - new Date(b.requestDate);
                case 'status':
                    return a.status.localeCompare(b.status);
                default:
                    return 0;
            }
        });

        renderRequests(filteredRequests);
    }

    // Render requests to the page
    function renderRequests(requests) {
        if (requests.length === 0) {
            requestsContainer.innerHTML = '<div class="no-requests"><i class="fas fa-tools"></i><p>No repair requests found matching your criteria.</p></div>';
            return;
        }

        requestsContainer.innerHTML = '';

        requests.forEach(function(repairReq) {
            const requestCard = document.createElement('div');
            requestCard.className = 'request-card';

            const statusClass = 'status-' + repairReq.status.toLowerCase().replace(' ', '-');
            const statusText = repairReq.status;

            requestCard.innerHTML = '<div class="request-header">' +
                '<div>' +
                '<div class="request-id">' + repairReq.id + '</div>' +
                '<div class="request-date">Requested: ' + formatDate(repairReq.requestDate) + '</div>' +
                '</div>' +
                '<div class="request-status ' + statusClass + '">' + statusText + '</div>' +
                '</div>' +

                '<div class="request-details">' +
                '<div class="detail-row">' +
                '<span class="detail-label">Order ID:</span>' +
                '<span class="detail-value">' + (repairReq.orderId || 'N/A') + '</span>' +
                '</div>' +
                '<div class="detail-row">' +
                '<span class="detail-label">Repair Date:</span>' +
                '<span class="detail-value">' + (repairReq.repairDate ? formatDate(repairReq.repairDate) : 'Not scheduled') + '</span>' +
                '</div>' +
                '<div class="detail-row">' +
                '<span class="detail-label">Estimated Cost:</span>' +
                '<span class="detail-value">' + repairReq.estimatedCost + '</span>' +
                '</div>' +
                '</div>' +

                '<div class="request-description">' +
                '<div class="detail-label">Issue Description:</div>' +
                '<div class="detail-value">' + truncateText(repairReq.issueDescription, 100) + '</div>' +
                '</div>' +

                '<div class="request-actions">' +
                '<button class="action-btn view-btn" data-id="' + repairReq.id + '">' +
                '<i class="fas fa-eye"></i> View Details' +
                '</button>' +
                (repairReq.status === 'Submitted' ? '<button class="action-btn update-btn" data-id="' + repairReq.id + '"><i class="fas fa-edit"></i> Update</button>' : '') +
                '</div>';

            requestsContainer.appendChild(requestCard);
        });

        // Add event listeners to the action buttons
        document.querySelectorAll('.view-btn').forEach(function(button) {
            button.addEventListener('click', function() {
                const requestId = this.getAttribute('data-id');
                showRequestDetails(requestId);
            });
        });

        document.querySelectorAll('.update-btn').forEach(function(button) {
            button.addEventListener('click', function() {
                const requestId = this.getAttribute('data-id');
                updateRequest(requestId);
            });
        });
    }

    // Show request details in modal
    function showRequestDetails(requestId) {
        const repairReq = repairRequests.find(function(req) { return req.id === requestId; });
        if (!repairReq) return;

        const statusClass = 'status-' + repairReq.status.toLowerCase().replace(' ', '-');
        const statusText = repairReq.status;

        let photosHtml = '';
        if (repairReq.photoPath) {
            photosHtml = '<div><div class="detail-label">Photo:</div><div style="margin-top: 10px;">' +
                '<img src="' + repairReq.photoPath + '" style="max-width: 100%; max-height: 300px; border-radius: 6px; object-fit: cover;">' +
                '</div></div>';
        }

        let historyHtml = '';
        if (repairReq.statusHistory && repairReq.statusHistory.length > 0) {
            repairReq.statusHistory.forEach(function(history) {
                historyHtml += '<div class="history-item">' +
                    '<div class="history-date">' + formatDate(history.date) + '</div>' +
                    '<div class="history-status">' + history.status + '</div>' +
                    '<div class="history-comment">' + history.comment + '</div>' +
                    '</div>';
            });
        } else {
            historyHtml = '<p>No status history available.</p>';
        }

        modalBody.innerHTML = '<div class="detail-row">' +
            '<span class="detail-label">Request ID:</span>' +
            '<span class="detail-value">' + repairReq.id + '</span>' +
            '</div>' +
            '<div class="detail-row">' +
            '<span class="detail-label">Order ID:</span>' +
            '<span class="detail-value">' + (repairReq.orderId || 'N/A') + '</span>' +
            '</div>' +
            '<div class="detail-row">' +
            '<span class="detail-label">Status:</span>' +
            '<span class="detail-value request-status ' + statusClass + '">' + statusText + '</span>' +
            '</div>' +
            '<div class="detail-row">' +
            '<span class="detail-label">Request Date:</span>' +
            '<span class="detail-value">' + formatDate(repairReq.requestDate) + '</span>' +
            '</div>' +
            '<div class="detail-row">' +
            '<span class="detail-label">Repair Date:</span>' +
            '<span class="detail-value">' + (repairReq.repairDate ? formatDate(repairReq.repairDate) : 'Not scheduled') + '</span>' +
            '</div>' +
            '<div class="detail-row">' +
            '<span class="detail-label">Estimated Cost:</span>' +
            '<span class="detail-value">' + repairReq.estimatedCost + '</span>' +
            '</div>' +

            '<div>' +
            '<div class="detail-label">Issue Description:</div>' +
            '<div class="detail-value">' + repairReq.issueDescription + '</div>' +
            '</div>' +

            '<div>' +
            '<div class="detail-label">Latest Comment:</div>' +
            '<div class="detail-value">' + repairReq.comment + '</div>' +
            '</div>' +

            photosHtml +

            '<div class="status-history">' +
            '<div class="detail-label">Status History:</div>' +
            '<div style="margin-top: 10px;">' + historyHtml + '</div>' +
            '</div>';

        requestModal.style.display = 'flex';
    }

    // Update request (placeholder function)
    function updateRequest(requestId) {
        alert('Update functionality for request ' + requestId + ' would be implemented here.');
        // In a real application, this would open a form to update the request
    }

    // Helper function to format dates
    function formatDate(dateString) {
        const options = { year: 'numeric', month: 'short', day: 'numeric' };
        return new Date(dateString).toLocaleDateString('en-US', options);
    }

    // Helper function to truncate text
    function truncateText(text, maxLength) {
        if (text.length <= maxLength) return text;
        return text.substring(0, maxLength) + '...';
    }
</script>
</body>
</html>

<%!
    // Helper method to escape JavaScript strings
    private String escapeJavaScript(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("'", "\\'")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
%>