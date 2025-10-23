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
import java.sql.*;
import java.time.LocalDate;

@WebServlet("/SubmitRepairRequestServlet")
@MultipartConfig
public class SubmitRepairRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- Retrieve parameters ---
        String orderId = request.getParameter("orderId");
        String issueDescription = request.getParameter("issueDescription");
        String repairDateStr = request.getParameter("repairDate");

        java.sql.Date repairDate = null;
        if (repairDateStr != null && !repairDateStr.isEmpty()) {
            repairDate = java.sql.Date.valueOf(repairDateStr); // convert from HTML date input
        }

        Part photoPart = request.getPart("photos");
        String photoPath = null;

        // --- Handle optional photo upload ---
        if (photoPart != null && photoPart.getSize() > 0) {
            String fileName = getFileName(photoPart);
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            photoPart.write(uploadPath + File.separator + fileName);
            photoPath = "uploads/" + fileName;
        }

        // --- Generate custom RepairRequestID like RR001 ---
        String newRequestId = null;

        try (Connection conn = DBConnection.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT MAX(RepairRequestID) FROM RepairRequest");
            if (rs.next() && rs.getString(1) != null) {
                int lastNum = Integer.parseInt(rs.getString(1).substring(2));
                newRequestId = "RR" + String.format("%03d", lastNum + 1);
            } else {
                newRequestId = "RR001";
            }
            rs.close();
            stmt.close();

            // --- Insert record ---
            String sql = "INSERT INTO RepairRequest (RepairRequestID, OrderID, IssueDescription, Photos, Status, RepairDate) " +
                    "VALUES (?, ?, ?, ?, 'Submitted', ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newRequestId);
            ps.setString(2, orderId);
            ps.setString(3, issueDescription);
            ps.setString(4, photoPath);
            ps.setDate(5, repairDate);
            ps.executeUpdate();

            request.getSession().setAttribute("successMessage", "Repair request submitted successfully!");
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error submitting repair request: " + e.getMessage());
        }

        // --- Redirect back to repair.jsp ---
        response.sendRedirect(request.getContextPath() + "/repair.jsp");
    }

    // --- Prevent abstract method error ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().println("GET not supported for SubmitRepairRequestServlet.");
    }

    // --- Extract file name for javax servlet (safe) ---
    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String content : header.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
