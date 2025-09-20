package com.melodymart.servlet.inventory;

import com.melodymart.dao.InstrumentDAO;
import com.melodymart.model.Instrument;
import com.melodymart.util.DatabaseUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet("/SaveInstrument")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max file size
public class SaveInstrument extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SaveInstrument.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        LOGGER.info("Received POST request to SaveInstrument");

        // Retrieve form parameters
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String brandIdStr = request.getParameter("brandId");
        String model = request.getParameter("model");
        String color = request.getParameter("color");
        String priceStr = request.getParameter("price");
        String specifications = request.getParameter("specifications");
        String warranty = request.getParameter("warranty");
        String quantityStr = request.getParameter("quantity");
        String stockLevel = request.getParameter("stockLevel");
        String manufacturerIdStr = request.getParameter("manufacturerId");
        LOGGER.info("Form parameters: name=" + name + ", brandId=" + brandIdStr + ", price=" + priceStr + ", quantity=" + quantityStr + ", stockLevel=" + stockLevel);

        // Validation
        if (name == null || name.trim().isEmpty() || priceStr == null || quantityStr == null) {
            LOGGER.warning("Validation failed: Missing required fields");
            request.setAttribute("addStatus", "Name, price, and quantity are required.");
            request.getRequestDispatcher("/sellerdashboard.jsp").forward(request, response);
            return;
        }

        Integer brandId = (brandIdStr != null && !brandIdStr.isEmpty()) ? Integer.parseInt(brandIdStr) : null;
        Integer manufacturerId = (manufacturerIdStr != null && !manufacturerIdStr.isEmpty()) ? Integer.parseInt(manufacturerIdStr) : 1;
        double price = 0.0;
        int quantity = 0;

        try {
            price = Double.parseDouble(priceStr);
            quantity = Integer.parseInt(quantityStr);
            if (price <= 0 || quantity < 0) {
                LOGGER.warning("Validation failed: Invalid price or quantity");
                request.setAttribute("addStatus", "Price must be positive, and quantity cannot be negative.");
                request.getRequestDispatcher("/sellerdashboard.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            LOGGER.severe("Number format exception: " + e.getMessage());
            request.setAttribute("addStatus", "Invalid price or quantity format.");
            request.getRequestDispatcher("/sellerdashboard.jsp").forward(request, response);
            return;
        }

        // Handle image upload
        String imageUrl = null;
        try {
            Part imagePart = request.getPart("imageFile");

            if (imagePart != null && imagePart.getSize() > 0) {
                LOGGER.info("Processing image upload, file size: " + imagePart.getSize() + " bytes");

                // Validate file type
                String contentType = imagePart.getContentType();
                if (contentType == null ||
                        (!contentType.startsWith("image/jpeg") &&
                                !contentType.startsWith("image/png") &&
                                !contentType.startsWith("image/gif") &&
                                !contentType.startsWith("image/jpg"))) {
                    LOGGER.warning("Invalid file type: " + contentType);
                    request.setAttribute("addStatus", "Please upload a valid image file (JPG, PNG, GIF).");
                    request.getRequestDispatcher("/sellerdashboard.jsp").forward(request, response);
                    return;
                }

                // Validate file size (5MB max)
                if (imagePart.getSize() > 5 * 1024 * 1024) {
                    LOGGER.warning("File size too large: " + imagePart.getSize() + " bytes");
                    request.setAttribute("addStatus", "File size should not exceed 5MB.");
                    request.getRequestDispatcher("/sellerdashboard.jsp").forward(request, response);
                    return;
                }

                // Generate unique filename
                String originalFileName = imagePart.getName();
                String fileExtension = "";
                if (originalFileName != null && originalFileName.contains(".")) {
                    fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                } else {
                    // Default extension based on content type
                    if (contentType.contains("jpeg") || contentType.contains("jpg")) {
                        fileExtension = ".jpg";
                    } else if (contentType.contains("png")) {
                        fileExtension = ".png";
                    } else if (contentType.contains("gif")) {
                        fileExtension = ".gif";
                    } else {
                        fileExtension = ".jpg"; // default
                    }
                }

                String fileName = "instrument_" + System.currentTimeMillis() + fileExtension;
                LOGGER.info("Generated filename: " + fileName);

                // Set the image URL for database storage (relative path)
                imageUrl = "images/instruments/" + fileName;

                // Create the upload directory path
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images" +
                        File.separator + "instruments";

                // Create directory if it doesn't exist
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    boolean created = uploadDir.mkdirs();
                    LOGGER.info("Upload directory created: " + created + " at path: " + uploadPath);
                }

                // Save the file
                String filePath = uploadPath + File.separator + fileName;
                LOGGER.info("Saving file to: " + filePath);

                try (InputStream inputStream = imagePart.getInputStream();
                     FileOutputStream outputStream = new FileOutputStream(filePath)) {

                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    long totalBytes = 0;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                        totalBytes += bytesRead;
                    }
                    LOGGER.info("File saved successfully. Total bytes written: " + totalBytes);
                } catch (IOException e) {
                    LOGGER.severe("Error saving file: " + e.getMessage());
                    request.setAttribute("addStatus", "Error saving image file: " + e.getMessage());
                    request.getRequestDispatcher("/sellerdashboard.jsp").forward(request, response);
                    return;
                }
            } else {
                LOGGER.info("No image file uploaded or file is empty");
            }
        } catch (Exception e) {
            LOGGER.severe("Error processing image upload: " + e.getMessage());
            request.setAttribute("addStatus", "Error processing image upload: " + e.getMessage());
            request.getRequestDispatcher("/sellerdashboard.jsp").forward(request, response);
            return;
        }

        // Create Instrument object
        Instrument instrument = new Instrument();
        instrument.setName(name);
        instrument.setDescription(description);
        instrument.setBrandId(brandId);
        instrument.setModel(model);
        instrument.setColor(color);
        instrument.setPrice(price);
        instrument.setSpecifications(specifications);
        instrument.setWarranty(warranty);
        instrument.setImageUrl(imageUrl); // Set the image URL
        instrument.setQuantity(quantity);
        instrument.setStockLevel(stockLevel != null ? stockLevel : "In Stock");
        instrument.setManufacturerId(manufacturerId);
        LOGGER.info("Instrument object created: " + instrument + ", imageUrl: " + imageUrl);

        // Save to database
        InstrumentDAO dao = new InstrumentDAO();
        String addStatus = null;
        try {
            dao.addInstrument(instrument);
            LOGGER.info("Instrument added to database successfully");
            addStatus = "Instrument added successfully!";

            // Redirect to dashboard with success parameter to show success message
            response.sendRedirect(request.getContextPath() + "/sellerdashboard.jsp?success=1");
            return;

        } catch (SQLException e) {
            LOGGER.severe("Database error while adding instrument: " + e.getMessage());
            addStatus = "Database error: " + e.getMessage();
            if (e.getMessage().contains("Cannot find db.properties") || e.getMessage().contains("The url cannot be null")) {
                addStatus += " Please ensure db.properties is in src/main/resources with valid database settings.";
            }

            // If database save failed and we uploaded a file, clean up the file
            if (imageUrl != null) {
                try {
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images" +
                            File.separator + "instruments";
                    String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
                    File fileToDelete = new File(uploadPath + File.separator + fileName);
                    if (fileToDelete.exists()) {
                        boolean deleted = fileToDelete.delete();
                        LOGGER.info("Cleanup: Image file deleted due to database error: " + deleted);
                    }
                } catch (Exception cleanupError) {
                    LOGGER.warning("Error cleaning up uploaded file: " + cleanupError.getMessage());
                }
            }

        } catch (Exception e) {
            LOGGER.severe("Unexpected error: " + e.getMessage());
            addStatus = "Unexpected error: " + e.getMessage();

            // Cleanup uploaded file if there was an unexpected error
            if (imageUrl != null) {
                try {
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images" +
                            File.separator + "instruments";
                    String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
                    File fileToDelete = new File(uploadPath + File.separator + fileName);
                    if (fileToDelete.exists()) {
                        boolean deleted = fileToDelete.delete();
                        LOGGER.info("Cleanup: Image file deleted due to unexpected error: " + deleted);
                    }
                } catch (Exception cleanupError) {
                    LOGGER.warning("Error cleaning up uploaded file: " + cleanupError.getMessage());
                }
            }
        }

        // Ensure response is always provided
        if (addStatus != null) {
            request.setAttribute("addStatus", addStatus);
            try {
                request.getRequestDispatcher("/sellerdashboard.jsp").forward(request, response);
            } catch (Exception e) {
                LOGGER.severe("Failed to forward to JSP: " + e.getMessage());
                response.setContentType("text/html");
                try (PrintWriter out = response.getWriter()) {
                    out.println("<html><body><h1>Error</h1><p>" + addStatus + "</p></body></html>");
                }
            }
        } else {
            LOGGER.severe("No addStatus set, providing default error");
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body><h1>Error</h1><p>Unknown error occurred. Check server logs.</p></body></html>");
            }
        }
    }
}