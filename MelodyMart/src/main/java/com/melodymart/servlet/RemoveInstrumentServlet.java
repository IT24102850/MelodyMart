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
import java.sql.SQLException;

/**
 * Removes instrument from sale (soft delete or mark discontinued).
 */
@WebServlet("/RemoveInstrumentServlet")
public class RemoveInstrumentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String instrumentIdStr = request.getParameter("instrumentId");
        if (instrumentIdStr == null || instrumentIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing Instrument ID");
            return;
        }

        int instrumentId;
        try {
            instrumentId = Integer.parseInt(instrumentIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Instrument ID");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();

            // Try soft delete with IsActive column
            String sql = "UPDATE Instrument SET IsActive = 0 WHERE InstrumentID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, instrumentId);

            int rows = 0;
            try {
                rows = ps.executeUpdate();
            } catch (SQLException colEx) {
                // Fallback: if IsActive column doesn't exist, mark as Discontinued
                if (colEx.getMessage().contains("Invalid column name 'IsActive'")) {
                    if (ps != null) ps.close();
                    sql = "UPDATE Instrument SET StockLevel = 'Discontinued' WHERE InstrumentID = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, instrumentId);
                    rows = ps.executeUpdate();
                } else {
                    throw colEx; // rethrow unexpected errors
                }
            }

            if (rows > 0) {
                request.getSession().setAttribute("message", "Instrument removed from sale successfully.");
            } else {
                request.getSession().setAttribute("error", "Instrument not found.");
            }

            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-reports");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error removing instrument: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-reports");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
