import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import main.java.com.melodymart.util.DBConnection;


@WebServlet("/UpdateStockServlet")
public class UpdateStockServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String instrumentId = request.getParameter("instrumentId");
        String stockQuantityStr = request.getParameter("stockQuantity");
        HttpSession session = request.getSession();

        // Validate input
        if (instrumentId == null || instrumentId.trim().isEmpty() || stockQuantityStr == null || stockQuantityStr.trim().isEmpty()) {
            session.setAttribute("error", "Instrument ID and Quantity are required.");
            response.sendRedirect("admin-dashboard.jsp#stock-management");
            return;
        }

        int stockQuantity = 0;
        try {
            stockQuantity = Integer.parseInt(stockQuantityStr);
            if (stockQuantity < 0) {
                session.setAttribute("error", "Quantity cannot be negative.");
                response.sendRedirect("admin-dashboard.jsp#stock-management");
                return;
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid quantity value.");
            response.sendRedirect("admin-dashboard.jsp#stock-management");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Establish database connection
            conn = DBConnection.getConnection();

            // Check if the instrument exists
            String checkSql = "SELECT COUNT(*) FROM Instrument WHERE InstrumentID = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, instrumentId);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            if (rs.getInt(1) == 0) {
                session.setAttribute("error", "Instrument ID " + instrumentId + " not found.");
                response.sendRedirect("admin-dashboard.jsp#stock-management");
                return;
            }

            // Update the stock quantity
            String updateSql = "UPDATE Instrument SET Quantity = ? WHERE InstrumentID = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setInt(1, stockQuantity);
            pstmt.setString(2, instrumentId);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                session.setAttribute("message", "Stock updated successfully for Instrument ID " + instrumentId + " at " +
                        new java.util.Date() + ".");
            } else {
                session.setAttribute("error", "Failed to update stock for Instrument ID " + instrumentId + ".");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("error", "Database error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirect back to the dashboard with current date and time in the header
        response.sendRedirect("admin-dashboard.jsp#stock-management");
    }
}