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
 * Servlet for updating stock quantity of instruments.
 */
@WebServlet("/UpdateStockServlet")
public class UpdateStockServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String instrumentIdStr = request.getParameter("instrumentId");
        String stockQuantityStr = request.getParameter("stockQuantity");

        if (instrumentIdStr == null || stockQuantityStr == null ||
                instrumentIdStr.isEmpty() || stockQuantityStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters.");
            return;
        }

        int instrumentId;
        int newQuantity;
        try {
            instrumentId = Integer.parseInt(instrumentIdStr);
            newQuantity = Integer.parseInt(stockQuantityStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format.");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();

            // Auto-update StockLevel based on Quantity
            String stockLevel;
            if (newQuantity == 0) {
                stockLevel = "Out of Stock";
            } else if (newQuantity < 5) { // threshold can be adjusted
                stockLevel = "Low Stock";
            } else {
                stockLevel = "In Stock";
            }

            String sql = "UPDATE Instrument SET Quantity = ?, StockLevel = ? WHERE InstrumentID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, newQuantity);
            ps.setString(2, stockLevel);
            ps.setInt(3, instrumentId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                request.getSession().setAttribute("message", "Stock updated successfully.");
            } else {
                request.getSession().setAttribute("error", "Instrument not found.");
            }

            // Redirect back to inventory/stock management page
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-management");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error updating stock: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#stock-management");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
