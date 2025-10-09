package com.melodymart.servlet.inventory;

import com.melodymart.util.DatabaseUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.logging.Logger;

@WebServlet("/SaveInstrument")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 25 * 1024 * 1024)
public class SaveInstrument extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SaveInstrument.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        // Retrieve basic parameters (no instrumentId input!)
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String brandId = request.getParameter("brandId");
        String model = request.getParameter("model");
        String color = request.getParameter("color");
        String priceStr = request.getParameter("price");
        String specifications = request.getParameter("specifications");
        String warranty = request.getParameter("warranty");
        String quantityStr = request.getParameter("quantity");
        String manufacturerId = request.getParameter("manufacturerId");

        if (name == null || priceStr == null || brandId == null || manufacturerId == null) {
            response.getWriter().println("<h3 style='color:red;'>Missing required fields!</h3>");
            return;
        }

        double price = Double.parseDouble(priceStr);
        int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 0;

        // ✅ Step 1: Generate the next available InstrumentID (e.g., I001, I002)
        String instrumentId = generateNextInstrumentId();
        LOGGER.info("Generated Instrument ID: " + instrumentId);

        // ✅ Step 2: Handle image uploads (multiple files)
        List<String> imagePaths = new ArrayList<>();
        String uploadDirPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator + "instruments";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        int imgCount = 1;
        for (Part part : request.getParts()) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String extension = ".jpg";
                if (part.getContentType().contains("png")) extension = ".png";
                else if (part.getContentType().contains("gif")) extension = ".gif";

                String fileName = instrumentId + "_IMG" + imgCount + extension;
                String fullPath = uploadDirPath + File.separator + fileName;
                try (InputStream input = part.getInputStream();
                     FileOutputStream output = new FileOutputStream(fullPath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }
                imagePaths.add("images/instruments/" + fileName);
                imgCount++;
            }
        }

        // ✅ Step 3: Insert into Instrument and InstrumentImage tables
        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);

            // Insert instrument
            String sql = "INSERT INTO Instrument (InstrumentID, Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, Quantity, ManufacturerID, ImageURL) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, instrumentId);
                ps.setString(2, name);
                ps.setString(3, description);
                ps.setString(4, brandId);
                ps.setString(5, model);
                ps.setString(6, color);
                ps.setDouble(7, price);
                ps.setString(8, specifications);
                ps.setString(9, warranty);
                ps.setInt(10, quantity);
                ps.setString(11, manufacturerId);
                ps.setString(12, imagePaths.isEmpty() ? null : imagePaths.get(0)); // First image as main
                ps.executeUpdate();
            }

            // Insert multiple images
            String sqlImg = "INSERT INTO InstrumentImage (ImageID, InstrumentID, ImageURL) VALUES (?, ?, ?)";
            try (PreparedStatement psImg = conn.prepareStatement(sqlImg)) {
                int i = 1;
                for (String path : imagePaths) {
                    String imgId = String.format("IMG%03d", i++);
                    psImg.setString(1, imgId);
                    psImg.setString(2, instrumentId);
                    psImg.setString(3, path);
                    psImg.addBatch();
                }
                psImg.executeBatch();
            }

            conn.commit();
            response.sendRedirect("sellerdashboard.jsp?success=1");

        } catch (SQLException e) {
            LOGGER.severe("SQL Error: " + e.getMessage());
            response.getWriter().println("<h3 style='color:red;'>Database Error: " + e.getMessage() + "</h3>");
        }
    }

    // ✅ Utility method to get next Instrument ID from DB
    private String generateNextInstrumentId() {
        String nextId = "I001";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT MAX(InstrumentID) FROM Instrument");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next() && rs.getString(1) != null) {
                String lastId = rs.getString(1);
                int num = Integer.parseInt(lastId.substring(1)); // Remove 'I' prefix
                nextId = String.format("I%03d", num + 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return nextId;
    }
}
