package com.melodymart.servlet;

import com.melodymart.util.DatabaseUtil;

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

@WebServlet("/UpdateInstrumentServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10,  // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateInstrumentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int instrumentId = Integer.parseInt(request.getParameter("instrumentId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String model = request.getParameter("model");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String stockLevel = request.getParameter("stockLevel");

        // Old image path from hidden field
        String imageUrl = request.getParameter("imageUrl");

        try {
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                // ✅ Generate unique filename
                String extension = ".jpg"; // default extension
                String submittedName = filePart.getName();
                if (submittedName != null && submittedName.contains(".")) {
                    extension = submittedName.substring(submittedName.lastIndexOf("."));
                }
                String uniqueFileName = "instrument_" + System.currentTimeMillis() + extension;

                // ✅ Save into your project folder
                String uploadPath = "C:\\Users\\hasir\\OneDrive\\Documents\\Git Hub\\MelodyMart\\MelodyMart\\src\\main\\webapp\\images\\instruments";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + uniqueFileName;
                filePart.write(filePath);

                // ✅ Update DB with relative path
                imageUrl = "images/instruments/" + uniqueFileName;
            }

            // ✅ Update DB record
            try (Connection conn = DatabaseUtil.getConnection()) {
                String sql = "UPDATE Instrument SET Name=?, Description=?, Model=?, Price=?, Quantity=?, StockLevel=?, ImageURL=? WHERE InstrumentID=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, description);
                ps.setString(3, model);
                ps.setDouble(4, price);
                ps.setInt(5, quantity);
                ps.setString(6, stockLevel);
                ps.setString(7, imageUrl);
                ps.setInt(8, instrumentId);

                ps.executeUpdate();
                ps.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating instrument: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/sellerdashboard.jsp#inventory");
    }
}
