package main.java.com.melodymart.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import main.java.com.melodymart.util.DBConnection;

@MultipartConfig
@WebServlet("/UpdateRepairRequestServlet")
public class UpdateRepairRequestServlet extends HttpServlet {

    // ✅ Add this so IDE doesn't complain about abstract class
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/repair.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String repairRequestID = request.getParameter("repairRequestID");
        String issueDescription = request.getParameter("issueDescription");
        Part photoPart = null;
        String photoPath = null;
        String contextPath = request.getContextPath();

        try {
            photoPart = request.getPart("photo");
            if (photoPart != null && photoPart.getSize() > 0) {
                String header = photoPart.getHeader("content-disposition");
                String fileName = null;

                for (String cd : header.split(";")) {
                    if (cd.trim().startsWith("filename")) {
                        fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                    }
                }

                String appPath = request.getServletContext().getRealPath("");
                String uploadDir = appPath + File.separator + "uploads";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                photoPath = "uploads/" + fileName;
                photoPart.write(uploadDir + File.separator + fileName);
            }

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "UPDATE RepairRequest " +
                        "SET IssueDescription = ?, Photos = ISNULL(?, Photos) " +
                        "WHERE RepairRequestID = ? AND Status = 'Submitted'";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, issueDescription);
                ps.setString(2, photoPath);
                ps.setString(3, repairRequestID);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    request.getSession().setAttribute("successMessage", "Repair request updated successfully.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Unable to update. Only submitted requests can be edited.");
                }

                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Database error: " + e.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
        }

        response.sendRedirect(contextPath + "/repair.jsp");
    }
}
