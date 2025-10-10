package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.*;
import java.sql.*;
import java.util.UUID;
import java.util.logging.Logger;

@WebServlet("/SubmitRepairRequestServlet")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB
public class SubmitRepairRequestServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SubmitRepairRequestServlet.class.getName());
    private static final String UPLOAD_DIR = "images" + File.separator + "repairrequest";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        LOGGER.info("Received POST request to SubmitRepairRequestServlet");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.warning("Unauthorized access: user not logged in");
            response.sendRedirect("sign-in.jsp?error=unauthorized");
            return;
        }

        String userId = (String) session.getAttribute("userId");
        String orderIdStr = request.getParameter("orderId");
        String issueDescription = request.getParameter("issueDescription");
        String repairDate = request.getParameter("repairDate");

        if (issueDescription == null || issueDescription.trim().isEmpty()) {
            response.sendRedirect("customerlanding.jsp?error=missingDescription");
            return;
        }

        Integer orderId = null;
        if (orderIdStr != null && !orderIdStr.trim().isEmpty()) {
            try {
                orderId = Integer.parseInt(orderIdStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid Order ID: " + orderIdStr);
                response.sendRedirect("customerlanding.jsp?error=invalidOrderId");
                return;
            }
        }

        // Handle uploaded image
        String photoPath = null;
        try {
            Part filePart = request.getPart("photos");
            if (filePart != null && filePart.getSize() > 0) {
                String contentType = filePart.getContentType();
                if (contentType == null ||
                        (!contentType.startsWith("image/jpeg") &&
                                !contentType.startsWith("image/png") &&
                                !contentType.startsWith("image/gif"))) {
                    response.sendRedirect("customerlanding.jsp?error=invalidFileType");
                    return;
                }

                // Generate unique filename
                String originalFileName = extractFileName(filePart);
                String extension = "";
                if (originalFileName != null && originalFileName.contains(".")) {
                    extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                }
                String fileName = "repair_" + System.currentTimeMillis() + extension;

                // Build upload path
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String filePath = uploadPath + File.separator + fileName;

                try (InputStream input = filePart.getInputStream();
                     OutputStream output = new FileOutputStream(filePath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }

                photoPath = UPLOAD_DIR + "/" + fileName;
            }
        } catch (Exception e) {
            LOGGER.severe("Error during file upload: " + e.getMessage());
            response.sendRedirect("customerlanding.jsp?error=uploadError");
            return;
        }

        // Generate IDs
        String repairRequestId = "RR" + String.format("%03d", (int) (Math.random() * 999));
        String photoId = "PH" + UUID.randomUUID().toString().substring(0, 6).toUpperCase();
        String costId = "C" + UUID.randomUUID().toString().substring(0, 6).toUpperCase();
        String historyId = "H" + UUID.randomUUID().toString().substring(0, 6).toUpperCase();

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // transaction start

            // 1️⃣ Insert into RepairRequest
            String sqlRequest = "INSERT INTO RepairRequest (RepairRequestID, UserID, OrderID, IssueDescription, Status, Approved, RequestDate) " +
                    "VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
            try (PreparedStatement ps = conn.prepareStatement(sqlRequest)) {
                ps.setString(1, repairRequestId);
                ps.setString(2, userId);
                if (orderId != null) ps.setInt(3, orderId);
                else ps.setInt(3, 0); // fallback if order optional
                ps.setString(4, issueDescription);
                ps.setString(5, "Submitted");
                ps.setBoolean(6, false);
                ps.executeUpdate();
            }

            // 2️⃣ Insert into RepairPhoto
            if (photoPath != null) {
                String sqlPhoto = "INSERT INTO RepairPhoto (PhotoID, RepairRequestID, PhotoPath, UploadedDate) VALUES (?, ?, ?, GETDATE())";
                try (PreparedStatement ps = conn.prepareStatement(sqlPhoto)) {
                    ps.setString(1, photoId);
                    ps.setString(2, repairRequestId);
                    ps.setString(3, photoPath);
                    ps.executeUpdate();
                }
            }

            // 3️⃣ Insert into RepairCost
            String sqlCost = "INSERT INTO RepairCost (CostID, RepairRequestID, EstimatedCost, RepairDate) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sqlCost)) {
                ps.setString(1, costId);
                ps.setString(2, repairRequestId);
                ps.setBigDecimal(3, new java.math.BigDecimal("0.00"));
                ps.setString(4, repairDate);
                ps.executeUpdate();
            }

            // 4️⃣ Insert into RepairStatusHistory
            String sqlHistory = "INSERT INTO RepairStatusHistory (HistoryID, RepairRequestID, Status, Comment, UpdatedDate) VALUES (?, ?, ?, ?, GETDATE())";
            try (PreparedStatement ps = conn.prepareStatement(sqlHistory)) {
                ps.setString(1, historyId);
                ps.setString(2, repairRequestId);
                ps.setString(3, "Submitted");
                ps.setString(4, "Awaiting approval");
                ps.executeUpdate();
            }

            conn.commit();
            LOGGER.info("✅ Repair request successfully saved with ID " + repairRequestId);
            response.sendRedirect("repair.jsp?success=1");

        } catch (SQLException e) {
            LOGGER.severe("❌ Database error: " + e.getMessage());
            response.sendRedirect("customerlanding.jsp?error=db");
        }
    }

    // Helper: Extract filename from header
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            for (String token : contentDisp.split(";")) {
                if (token.trim().startsWith("filename")) {
                    return token.substring(token.indexOf('=') + 2, token.length() - 1);
                }
            }
        }
        return null;
    }
}
