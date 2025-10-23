package com.melodymart.servlet;

import com.melodymart.util.DatabaseUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.sql.*;

@WebServlet("/StockCorrectionServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 1024 * 1024 * 5,      // 5MB per file
        maxRequestSize = 1024 * 1024 * 25   // 25MB total
)
public class StockCorrectionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        String adminIdStr = (String) session.getAttribute("adminId");

        // ✅ Check admin login (now NVARCHAR(10))
//        if (adminIdStr == null || adminIdStr.trim().isEmpty()) {
//            session.setAttribute("error", "Please log in as admin to apply stock corrections.");
//            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-management");
//            return;
//        }

        // Get form data
        String instrumentIdStr = request.getParameter("instrumentId");
        String correctedQuantityStr = request.getParameter("correctedQuantity");
        String reason = request.getParameter("reason");
        String evidenceNote = request.getParameter("evidenceNote");
        String evidenceImages = request.getParameter("evidenceImages");

        // ✅ Validation
        if (instrumentIdStr == null || correctedQuantityStr == null || reason == null ||
                instrumentIdStr.trim().isEmpty() || correctedQuantityStr.trim().isEmpty() || reason.trim().isEmpty()) {
            session.setAttribute("error", "Please fill in all required fields.");
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-management");
            return;
        }

        int correctedQuantity;
        try {
            correctedQuantity = Integer.parseInt(correctedQuantityStr);
            if (correctedQuantity < 0) throw new NumberFormatException("negative quantity");
        } catch (NumberFormatException ex) {
            session.setAttribute("error", "Invalid quantity value.");
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-management");
            return;
        }

        // ✅ Calculate stock level
        String stockLevel = (correctedQuantity == 0) ? "Out of Stock"
                : (correctedQuantity < 5) ? "Low Stock" : "In Stock";

        Connection conn = null;
        PreparedStatement psUpdateInstrument = null;
        PreparedStatement psInsertCorrection = null;

        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false);

            // ✅ STEP 1: Update Instrument table (InstrumentID is NVARCHAR(10))
            String sqlUpdate = "UPDATE Instrument SET Quantity = ?, StockLevel = ? WHERE InstrumentID = ?";
            psUpdateInstrument = conn.prepareStatement(sqlUpdate);
            psUpdateInstrument.setInt(1, correctedQuantity);
            psUpdateInstrument.setString(2, stockLevel);
            psUpdateInstrument.setString(3, instrumentIdStr.trim());  // ✅ NVARCHAR(10)

            int updated = psUpdateInstrument.executeUpdate();
            if (updated == 0) {
                conn.rollback();
                session.setAttribute("error", "Instrument ID '" + instrumentIdStr + "' not found.");
                response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-management");
                return;
            }

            // ✅ STEP 2: Insert into StockCorrectionWithEvidence (TRIGGER auto-generates CorrectionID)
            String sqlCorrection = "INSERT INTO StockCorrectionWithEvidence " +
                    "(InstrumentID, CorrectedQuantity, Reason, EvidenceNote, AdminID) " +
                    "VALUES (?, ?, ?, ?, ?)";
            psInsertCorrection = conn.prepareStatement(sqlCorrection);
            psInsertCorrection.setString(1, instrumentIdStr.trim());     // ✅ NVARCHAR(10)
            psInsertCorrection.setInt(2, correctedQuantity);
            psInsertCorrection.setString(3, reason.trim());
            psInsertCorrection.setString(4, evidenceNote != null ? evidenceNote.trim() : null);      // ✅ NVARCHAR(10)
            psInsertCorrection.setString(5, "admin");          // ✅ NVARCHAR(10)

            int correctionRows = psInsertCorrection.executeUpdate();
            if (correctionRows == 0) {
                conn.rollback();
                session.setAttribute("error", "Failed to record stock correction.");
                response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-management");
                return;
            }

            // ✅ STEP 3: Save Images & Insert EvidenceImageURL (single field)
            String uploadsDir = request.getServletContext().getRealPath("/uploads/stock-corrections");
            File dir = new File(uploadsDir);
            if (!dir.exists()) dir.mkdirs();

            // Get CorrectionID from trigger (SCE001, SCE002, etc.)
            String correctionId = getLatestCorrectionId(conn);

            for (Part part : request.getParts()) {
                if ("evidenceImages".equals(part.getName()) && part.getSize() > 0) {
                    String originalName = getSubmittedFileName(part);
                    String safeName = System.currentTimeMillis() + "_" +
                            (originalName != null ? originalName.replaceAll("[^a-zA-Z0-9._-]", "_") : "evidence.jpg");

                    Path filePath = Paths.get(uploadsDir, safeName);
                    Files.copy(part.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                    String imageUrl = request.getContextPath() + "/uploads/stock-corrections/" + safeName;

                    // ✅ UPDATE EvidenceImageURL field (single field, comma-separated for multiple images)
                    String currentUrls = getCurrentImageUrls(conn, correctionId);
                    String newUrls = currentUrls.isEmpty() ? imageUrl : currentUrls + ", " + imageUrl;

                    String sqlUpdateImage = "UPDATE StockCorrectionWithEvidence SET EvidenceImageURL = ? WHERE CorrectionID = ?";
                    try (PreparedStatement psImage = conn.prepareStatement(sqlUpdateImage)) {
                        psImage.setString(1, newUrls);
                        psImage.setString(2, correctionId);
                        psImage.executeUpdate();
                    }
                }
            }

            conn.commit();
            session.setAttribute("message",
                    "✅ Stock correction SCE" + correctionId.substring(3) +
                            " applied successfully for " + instrumentIdStr + ". Quantity: " + correctedQuantity);

        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception ignored) {}
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
        } finally {
            closeQuietly(psInsertCorrection, conn);
            closeQuietly(psUpdateInstrument, null);
        }

        // ✅ Secure redirect
        response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-management");
    }

    // ✅ Helper: Get latest CorrectionID
    private String getLatestCorrectionId(Connection conn) throws SQLException {
        String sql = "SELECT TOP 1 CorrectionID FROM StockCorrectionWithEvidence ORDER BY CorrectionDate DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("CorrectionID");
            }
        }
        return "SCE001"; // fallback
    }

    // ✅ Helper: Get current image URLs
    private String getCurrentImageUrls(Connection conn, String correctionId) throws SQLException {
        String sql = "SELECT EvidenceImageURL FROM StockCorrectionWithEvidence WHERE CorrectionID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, correctionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("EvidenceImageURL") != null ? rs.getString("EvidenceImageURL") : "";
                }
            }
        }
        return "";
    }

    // ✅ Helper: Safe close
    private void closeQuietly(AutoCloseable... closeables) {
        for (AutoCloseable c : closeables) {
            if (c != null) try { c.close(); } catch (Exception ignored) {}
        }
    }

    // ✅ File name helper
    private String getSubmittedFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String segment : cd.split(";")) {
            if (segment.trim().startsWith("filename")) {
                return segment.substring(segment.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}