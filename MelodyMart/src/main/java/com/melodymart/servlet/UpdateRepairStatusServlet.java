package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.com.melodymart.util.DBConnection;

@WebServlet("/UpdateRepairStatusServlet")
public class UpdateRepairStatusServlet extends HttpServlet {

    // ✅ Add serialVersionUID (recommended for HttpServlet)
    private static final long serialVersionUID = 1L;

    // ✅ Simple doGet() to satisfy HttpServlet
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().println("GET not supported for this servlet.");
    }

    // ✅ Your main POST logic
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String repairRequestID = request.getParameter("repairRequestID");
        String comment = request.getParameter("comment");
        String estimatedCostStr = request.getParameter("estimatedCost");
        String repairDateStr = request.getParameter("repairDate");
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        java.sql.Date repairDate = null;
        if (repairDateStr != null && !repairDateStr.isEmpty()) {
            repairDate = java.sql.Date.valueOf(repairDateStr);
        }

        double estimatedCost = 0.0;
        if (estimatedCostStr != null && !estimatedCostStr.isEmpty()) {
            estimatedCost = Double.parseDouble(estimatedCostStr);
        }

        String newStatus = action.equalsIgnoreCase("Approve") ? "Approved" : "Rejected";

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE RepairRequest " +
                    "SET Comment = ?, EstimatedCost = ?, RepairDate = ?, Status = ? " +
                    "WHERE RepairRequestID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, comment);
            ps.setDouble(2, estimatedCost);
            ps.setDate(3, repairDate);
            ps.setString(4, newStatus);
            ps.setString(5, repairRequestID);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                request.getSession().setAttribute("successMessage",
                        "Repair request " + newStatus.toLowerCase() + " successfully!");
            } else {
                request.getSession().setAttribute("errorMessage",
                        "Failed to update repair request.");
            }

            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage",
                    "Database error: " + e.getMessage());
        }

        response.sendRedirect(contextPath + "/repairRequests.jsp");
    }
}
