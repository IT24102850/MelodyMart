package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet("/SubmitRepairRequestServlet")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max file size
public class SubmitRepairRequestServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SubmitRepairRequestServlet.class.getName());

    // Upload folder relative to your webapp
    private static final String UPLOAD_DIR = "images" + File.separator + "repairrequest";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        LOGGER.info("Received POST request to SubmitRepairRequestServlet");

        // Get form inputs
        String orderIdStr = request.getParameter("orderId");
        String issueDescription = request.getParameter("issueDescription");
        String repairDate = request.getParameter("repairDate");

        if (orderIdStr == null || issueDescription == null || repairDate == null) {
            LOGGER.warning("Validation failed: Missing required fields");
            response.sendRedirect("customerlanding.jsp?error=missingFields");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderIdStr);
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid Order ID: " + orderIdStr);
            response.sendRedirect("customerlanding.jsp?error=invalidOrderId");
            return;
        }

        // Handle uploaded file
        String photoPath = null;
        try {
            Part filePart = request.getPart("photos");
            if (filePart != null && filePart.getSize() > 0) {
                LOGGER.info("Processing uploaded file, size=" + filePart.getSize());

                // Validate file type
                String contentType = filePart.getContentType();
                if (contentType == null ||
                        (!contentType.startsWith("image/jpeg") &&
                                !contentType.startsWith("image/png") &&
                                !contentType.startsWith("image/gif"))) {
                    LOGGER.warning("Invalid file type: " + contentType);
                    response.sendRedirect("customerlanding.jsp?error=invalidFileType");
                    return;
                }

                // Extract original file name manually
                String originalFileName = extractFileName(filePart);
                String extension = "";
                if (originalFileName != null && originalFileName.contains(".")) {
                    extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                }

                // Generate unique file name
                String fileName = "repair_" + System.currentTimeMillis() + extension;

                // Absolute upload path inside webapp
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    boolean created = uploadDir.mkdirs();
                    LOGGER.info("Upload directory created: " + created + " at " + uploadPath);
                }

                String filePath = uploadPath + File.separator + fileName;
                LOGGER.info("Saving uploaded file to: " + filePath);

                try (InputStream inputStream = filePart.getInputStream();
                     FileOutputStream outputStream = new FileOutputStream(filePath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                }

                // Store relative path in DB
                photoPath = UPLOAD_DIR + "/" + fileName;
                LOGGER.info("File uploaded successfully: " + photoPath);
            } else {
                LOGGER.info("No photo uploaded for repair request");
            }
        } catch (Exception e) {
            LOGGER.severe("Error during file upload: " + e.getMessage());
            response.sendRedirect("customerlanding.jsp?error=uploadError");
            return;
        }

        // Insert into DB
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO RepairRequest (OrderID, IssueDescription, Photos, RepairDate) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            stmt.setString(2, issueDescription);
            stmt.setString(3, photoPath);
            stmt.setString(4, repairDate);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                LOGGER.info("Repair request saved successfully");
                response.sendRedirect("customerlanding.jsp?success=1");
            } else {
                LOGGER.warning("Repair request insert failed");
                response.sendRedirect("customerlanding.jsp?error=dbInsertFailed");
            }

        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            response.sendRedirect("customerlanding.jsp?error=db");
        }
    }

    // Helper method to extract file name from Part header (for older Servlet APIs)
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            for (String token : contentDisp.split(";")) {
                if (token.trim().startsWith("filename")) {
                    return token.substring(token.indexOf("=") + 2, token.length() - 1);
                }
            }
        }
        return null;
    }
}
