package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
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

        System.out.println("DEBUG: UpdateInstrumentServlet called");

        String instrumentId = request.getParameter("instrumentId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String brandId = request.getParameter("brandId");
        String manufacturerId = request.getParameter("manufacturerId");
        String model = request.getParameter("model");
        String color = request.getParameter("color");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String warranty = request.getParameter("warranty");
        String specifications = request.getParameter("specifications");

        System.out.println("DEBUG: Updating instrument ID: " + instrumentId);
        System.out.println("DEBUG: Name: " + name);
        System.out.println("DEBUG: Price: " + priceStr);
        System.out.println("DEBUG: Quantity: " + quantityStr);

        // Validate required fields
        if (instrumentId == null || name == null || priceStr == null || quantityStr == null) {
            response.sendRedirect("addInstrument.jsp?error=MissingRequiredFields");
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);

            try (Connection conn = DBConnection.getConnection()) {
                String sql;
                PreparedStatement ps;

                // Check if new image is uploaded
                Part filePart = request.getPart("images");
                if (filePart != null && filePart.getSize() > 0) {
                    System.out.println("DEBUG: New image uploaded, updating with image");
                    // Handle image upload
                    String fileName = getFileName(filePart);
                    String uniqueFileName = "instrument_" + instrumentId + "_" + System.currentTimeMillis() + "_" + fileName;

                    // For now, just update the ImageURL field - you can add file saving logic later
                    String imageUrl = "images/instruments/" + uniqueFileName;

                    // Update with image
                    sql = "UPDATE Instrument SET Name=?, Description=?, BrandID=?, ManufacturerID=?, Model=?, Color=?, Price=?, Quantity=?, Warranty=?, Specifications=?, ImageURL=? WHERE InstrumentID=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, name);
                    ps.setString(2, description);
                    ps.setString(3, brandId);
                    ps.setString(4, manufacturerId);
                    ps.setString(5, model);
                    ps.setString(6, color);
                    ps.setDouble(7, price);
                    ps.setInt(8, quantity);
                    ps.setString(9, warranty);
                    ps.setString(10, specifications);
                    ps.setString(11, imageUrl);
                    ps.setString(12, instrumentId);
                } else {
                    System.out.println("DEBUG: No new image, updating without image");
                    // Update without changing image
                    sql = "UPDATE Instrument SET Name=?, Description=?, BrandID=?, ManufacturerID=?, Model=?, Color=?, Price=?, Quantity=?, Warranty=?, Specifications=? WHERE InstrumentID=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, name);
                    ps.setString(2, description);
                    ps.setString(3, brandId);
                    ps.setString(4, manufacturerId);
                    ps.setString(5, model);
                    ps.setString(6, color);
                    ps.setDouble(7, price);
                    ps.setInt(8, quantity);
                    ps.setString(9, warranty);
                    ps.setString(10, specifications);
                    ps.setString(11, instrumentId);
                }

                int rowsUpdated = ps.executeUpdate();
                System.out.println("DEBUG: Update affected rows: " + rowsUpdated);

                if (rowsUpdated > 0) {
                    response.sendRedirect("addInstrument.jsp?success=InstrumentUpdated");
                } else {
                    response.sendRedirect("addInstrument.jsp?error=UpdateFailed");
                }

            } catch (Exception e) {
                System.out.println("ERROR: Database error during update: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("addInstrument.jsp?error=ServerError");
            }

        } catch (NumberFormatException e) {
            System.out.println("ERROR: Invalid number format for price or quantity");
            response.sendRedirect("addInstrument.jsp?error=InvalidNumberFormat");
        } catch (Exception e) {
            System.out.println("ERROR: General error during update: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("addInstrument.jsp?error=UpdateError");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "unknown.jpg";
    }
}