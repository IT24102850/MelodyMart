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
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 25 * 1024 * 1024) // Allow up to 5MB per image
public class SaveInstrument extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SaveInstrument.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        LOGGER.info("🎵 Received POST request to SaveInstrument");

        // ========== Step 1: Read Form Fields ==========
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

        // Validate required fields
        if (name == null || name.isEmpty() || priceStr == null || brandId == null || manufacturerId == null) {
            response.getWriter().println("<h3 style='color:red;'>Missing required fields!</h3>");
            return;
        }

        double price = 0;
        int quantity = 0;
        try {
            price = Double.parseDouble(priceStr);
            if (quantityStr != null && !quantityStr.isEmpty()) {
                quantity = Integer.parseInt(quantityStr);
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("<h3 style='color:red;'>Invalid number format for price or quantity.</h3>");
            return;
        }

        // ========== Step 2: Generate New Instrument ID ==========
        String instrumentId = generateNextInstrumentId();
        LOGGER.info("Generated Instrument ID: " + instrumentId);

        // ========== Step 3: Handle Multiple Image Uploads ==========
        List<String> uploadedImages = new ArrayList<>();
        String uploadDirPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator + "instruments";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        for (Part part : request.getParts()) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String contentType = part.getContentType();
                if (!contentType.startsWith("image/")) continue;

                String ext = ".jpg";
                if (contentType.contains("png")) ext = ".png";
                else if (contentType.contains("gif")) ext = ".gif";

                String fileName = instrumentId + "_" + System.currentTimeMillis() + ext;
                String fullPath = uploadDirPath + File.separator + fileName;

                try (InputStream input = part.getInputStream();
                     FileOutputStream output = new FileOutputStream(fullPath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }

                uploadedImages.add("images/instruments/" + fileName);
                LOGGER.info("Saved image: " + fileName);
            }
        }

        // ========== Step 4: Insert into Database ==========
        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);

            // Insert Instrument
            String insertInstrument = "INSERT INTO Instrument (InstrumentID, Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, Quantity, ManufacturerID, ImageURL) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertInstrument)) {
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
                ps.setString(12, uploadedImages.isEmpty() ? null : uploadedImages.get(0)); // first image = main
                ps.executeUpdate();
            }

            // Insert Multiple Images
            String insertImage = "INSERT INTO InstrumentImage (ImageID, InstrumentID, ImageURL) VALUES (?, ?, ?)";
            try (PreparedStatement psImg = conn.prepareStatement(insertImage)) {
                for (String imagePath : uploadedImages) {
                    String imageId = generateNextImageId(conn); // ✅ Fetch next global image ID
                    psImg.setString(1, imageId);
                    psImg.setString(2, instrumentId);
                    psImg.setString(3, imagePath);
                    psImg.addBatch();
                }
                psImg.executeBatch();
            }

            conn.commit();
            LOGGER.info("✅ Instrument and all images saved successfully!");
            response.sendRedirect("sellerdashboard.jsp?success=1");

        } catch (SQLException e) {
            LOGGER.severe("❌ SQL Error: " + e.getMessage());
            response.getWriter().println("<h3 style='color:red;'>Database Error: " + e.getMessage() + "</h3>");
        } catch (Exception e) {
            LOGGER.severe("❌ Unexpected Error: " + e.getMessage());
            response.getWriter().println("<h3 style='color:red;'>Unexpected Error: " + e.getMessage() + "</h3>");
        }
    }

    // ========== Helper: Generate Next Instrument ID ==========
    private String generateNextInstrumentId() {
        String nextId = "I001";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT MAX(InstrumentID) FROM Instrument");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next() && rs.getString(1) != null) {
                String lastId = rs.getString(1);
                int num = Integer.parseInt(lastId.substring(1));
                nextId = String.format("I%03d", num + 1);
            }
        } catch (SQLException e) {
            LOGGER.warning("Error generating Instrument ID: " + e.getMessage());
        }
        return nextId;
    }

    // ========== Helper: Generate Next Global Image ID ==========
    private String generateNextImageId(Connection conn) throws SQLException {
        String nextId = "IMG001";
        String query = "SELECT MAX(ImageID) FROM InstrumentImage";
        try (PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next() && rs.getString(1) != null) {
                String lastId = rs.getString(1);
                int num = Integer.parseInt(lastId.substring(3)); // Remove 'IMG'
                nextId = String.format("IMG%03d", num + 1);
            }
        }
        return nextId;
    }
}
