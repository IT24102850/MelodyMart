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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
        if (session == null || session.getAttribute("userID") == null) {
            LOGGER.warning("Unauthorized access: user not logged in");
            response.sendRedirect("sign-in.jsp?error=unauthorized");
            return;
        }

        // 🧑‍💼 Get logged-in user ID from session
        String userID = (String) session.getAttribute("userID");

        // Get form inputs
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

        // Handle uploaded file
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

        // ✅ Insert data into database
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO RepairRequest (UserID, OrderID, IssueDescription, Photos, RepairDate) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userID);

            if (orderId != null)
                stmt.setInt(2, orderId);
            else
                stmt.setNull(2, java.sql.Types.INTEGER);

            stmt.setString(3, issueDescription);
            stmt.setString(4, photoPath);
            stmt.setString(5, repairDate);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                LOGGER.info("Repair request saved successfully");
                response.sendRedirect("repair.jsp?success=1");
            } else {
                LOGGER.warning("Repair request insert failed");
                response.sendRedirect("customerlanding.jsp?error=dbInsertFailed");
            }

        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
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
