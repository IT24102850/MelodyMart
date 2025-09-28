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

@WebServlet("/DeleteRepairRequestServlet")
public class DeleteRepairRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String repairRequestId = request.getParameter("repairRequestId");

        if (repairRequestId == null || repairRequestId.isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Invalid repair request ID.");
            response.sendRedirect("customerlanding.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();

            // Only allow deletion if request is still in "Submitted" or "Pending"
            String sql = "DELETE FROM RepairRequest WHERE RepairRequestID = ? AND Status IN ('Submitted', 'Pending')";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(repairRequestId));

            int rows = ps.executeUpdate();

            if (rows > 0) {
                request.getSession().setAttribute("successMessage", "Repair request cancelled successfully.");
            } else {
                request.getSession().setAttribute("errorMessage", "Repair request cannot be cancelled (already processed).");
            }

        } catch (SQLException e) {
            request.getSession().setAttribute("errorMessage", "Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }

        // Redirect back to customer landing page
        response.sendRedirect("customerlanding.jsp");
    }
}
