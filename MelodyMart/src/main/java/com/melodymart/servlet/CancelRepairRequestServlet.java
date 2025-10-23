package main.java.com.melodymart.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import main.java.com.melodymart.util.DBConnection;

@WebServlet("/CancelRepairRequestServlet")
public class CancelRepairRequestServlet extends HttpServlet {

    // ✅ required for HttpServlet
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/repair.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String repairRequestID = request.getParameter("repairRequestID");
        String contextPath = request.getContextPath();

        try (Connection conn = DBConnection.getConnection()) {
            // ✅ Delete instead of update
            String sql = "DELETE FROM RepairRequest WHERE RepairRequestID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, repairRequestID);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                request.getSession().setAttribute("successMessage", "Repair request deleted successfully.");
            } else {
                request.getSession().setAttribute("errorMessage", "No matching request found to delete.");
            }

            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Database error while deleting: " + e.getMessage());
        }

        // ✅ Redirect safely back to repair.jsp
        response.sendRedirect(contextPath + "/repair.jsp");
    }
}
