package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UpdateRepairRequestServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UpdateRepairRequestServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "images/repairrequest";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String repairRequestId = request.getParameter("repairRequestId");
        String issueDescription = request.getParameter("issueDescription");
        String additionalComment = request.getParameter("additionalComment");
        String repairDate = request.getParameter("repairDate");

        // Validate required fields
        if (repairRequestId == null || issueDescription == null || repairDate == null) {
            request.getSession().setAttribute("errorMessage", "Missing required fields.");
            response.sendRedirect("customerlanding.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<String> newPhotoPaths = new ArrayList<>();

        try {
            conn = DBConnection.getConnection();

            // Build upload path inside webapp
            String applicationPath = getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Handle uploaded files
            for (Part part : request.getParts()) {
                if ("additionalPhotos".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = getFileName(part);
                    if (fileName != null && !fileName.isEmpty()) {
                        String filePath = uploadPath + File.separator + fileName;
                        part.write(filePath);
                        // Save relative path in DB
                        newPhotoPaths.add(UPLOAD_DIR + "/" + fileName);
                    }
                }
            }

            // Retrieve existing photos and comments
            String existingPhotos = "";
            String existingComment = "";
            String sqlSelect = "SELECT Photos, Comment FROM RepairRequest WHERE RepairRequestID = ?";
            ps = conn.prepareStatement(sqlSelect);
            ps.setInt(1, Integer.parseInt(repairRequestId));
            rs = ps.executeQuery();
            if (rs.next()) {
                existingPhotos = rs.getString("Photos") != null ? rs.getString("Photos") : "";
                existingComment = rs.getString("Comment") != null ? rs.getString("Comment") : "";
            }
            rs.close();
            ps.close();

            // Append new photos
            String updatedPhotos = existingPhotos;
            if (!newPhotoPaths.isEmpty()) {
                updatedPhotos = existingPhotos.isEmpty()
                        ? String.join(";", newPhotoPaths)
                        : existingPhotos + ";" + String.join(";", newPhotoPaths);
            }

            // Append new comments
            String updatedComment = existingComment;
            if (additionalComment != null && !additionalComment.trim().isEmpty()) {
                updatedComment = existingComment.isEmpty()
                        ? additionalComment
                        : existingComment + "\n" + additionalComment;
            }

            // Update record
            String sqlUpdate = "UPDATE RepairRequest SET IssueDescription = ?, Comment = ?, Photos = ?, RepairDate = ? WHERE RepairRequestID = ?";
            ps = conn.prepareStatement(sqlUpdate);
            ps.setString(1, issueDescription);
            ps.setString(2, updatedComment);
            ps.setString(3, updatedPhotos);
            ps.setString(4, repairDate);
            ps.setInt(5, Integer.parseInt(repairRequestId));

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                request.getSession().setAttribute("successMessage", "Repair request updated successfully.");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update repair request.");
            }

        } catch (SQLException e) {
            request.getSession().setAttribute("errorMessage", "Database error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }

        // Redirect back to customer landing page
        response.sendRedirect("customerlanding.jsp");
    }

    // Utility: extract filename from Part
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String cd : contentDisposition.split(";")) {
                if (cd.trim().startsWith("filename")) {
                    String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                    return fileName.substring(fileName.lastIndexOf('/') + 1)
                            .substring(fileName.lastIndexOf('\\') + 1);
                }
            }
        }
        return null;
    }
}
