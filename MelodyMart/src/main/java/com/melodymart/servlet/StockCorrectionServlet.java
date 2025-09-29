package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Handles corrections or disputes in stock levels.
 */
@WebServlet("/StockCorrectionServlet")
public class StockCorrectionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String instrumentIdStr = request.getParameter("instrumentId");
        String correctedQuantityStr = request.getParameter("correctedQuantity");
        String reason = request.getParameter("reason");

        if (instrumentIdStr == null || correctedQuantityStr == null || reason == null ||
                instrumentIdStr.isEmpty() || correctedQuantityStr.isEmpty() || reason.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters.");
            return;
        }

        int instrumentId;
        int correctedQuantity;
        try {
            instrumentId = Integer.parseInt(instrumentIdStr);
            correctedQuantity = Integer.parseInt(correctedQuantityStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format.");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        PreparedStatement auditLog = null;

        try {
            conn = DBConnection.getConnection();

            // Update stock with corrected value
            String stockLevel;
            if (correctedQuantity == 0) {
                stockLevel = "Out of Stock";
            } else if (correctedQuantity < 5) {
                stockLevel = "Low Stock";
            } else {
                stockLevel = "In Stock";
            }

            String updateSql = "UPDATE Instrument SET Quantity = ?, StockLevel = ? WHERE InstrumentID = ?";
            ps = conn.prepareStatement(updateSql);
            ps.setInt(1, correctedQuantity);
            ps.setString(2, stockLevel);
            ps.setInt(3, instrumentId);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Log the correction for audit purposes
                String logSql = "INSERT INTO StockCorrections (InstrumentID, CorrectedQuantity, Reason, CorrectionDate) VALUES (?, ?, ?, GETDATE())";
                auditLog = conn.prepareStatement(logSql);
                auditLog.setInt(1, instrumentId);
                auditLog.setInt(2, correctedQuantity);
                auditLog.setString(3, reason);
                auditLog.executeUpdate();

                request.getSession().setAttribute("message", "Stock correction applied successfully.");
            } else {
                request.getSession().setAttribute("error", "Instrument not found.");
            }

            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-override");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error applying correction: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-override");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (auditLog != null) auditLog.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
