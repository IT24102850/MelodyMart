package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/ApproveRepairRequestServlet")
public class ApproveRepairRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String repairRequestIdStr = request.getParameter("repairRequestId");

        if (repairRequestIdStr == null || repairRequestIdStr.trim().isEmpty()) {
            out.println("<p style='color:red;'>❌ Repair Request ID is required.</p>");
            return;
        }

        int repairRequestId = Integer.parseInt(repairRequestIdStr);

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();

            // ✅ Update Approved column and Status
            String sql = "UPDATE RepairRequest SET Approved = 1, Status = 'Approved' WHERE RepairRequestID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, repairRequestId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Redirect back to seller dashboard
                response.sendRedirect(request.getContextPath() + "/sellerdashboard.jsp#repairs");
            } else {
                out.println("<p style='color:red;'>⚠️ Failed to approve repair request. ID not found.</p>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>❌ Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
