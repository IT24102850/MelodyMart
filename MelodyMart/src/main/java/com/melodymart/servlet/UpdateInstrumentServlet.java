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
import java.nio.file.Paths;
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

        String imageUrl = null;

        try {
            // ✅ Handle uploaded file
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                // Get original file name
                String fileName = Paths.get(filePart.getName()).getFileName().toString();

                // ✅ Save into your project webapp/images/instruments folder
                String uploadPath = "C:\\Users\\hasir\\OneDrive\\Documents\\Git Hub\\MelodyMart\\MelodyMart\\src\\main\\webapp\\images\\instruments";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Save file to disk
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                // ✅ Save relative path in DB
                imageUrl = "images/instruments/" + fileName;
            } else {
                // No new file uploaded → keep existing value
                imageUrl = request.getParameter("imageUrl");
            }

            // ✅ Update DB
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

        // ✅ Redirect back to dashboard (Inventory tab)
        response.sendRedirect(request.getContextPath() + "/sellerdashboard.jsp#inventory");
    }
}
