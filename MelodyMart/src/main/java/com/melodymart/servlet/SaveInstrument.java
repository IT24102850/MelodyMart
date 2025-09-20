package com.melodymart.servlet.inventory;

import com.melodymart.dao.InstrumentDAO;
import com.melodymart.model.Instrument;
import com.melodymart.util.DatabaseUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet("/SaveInstrument")
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
//        Integer manufacturerId = (manufacturerIdStr != null && !manufacturerIdStr.isEmpty()) ? Integer.parseInt(manufacturerIdStr) : null;
        Integer manufacturerId = 1;
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
        instrument.setQuantity(quantity);
        instrument.setStockLevel(stockLevel != null ? stockLevel : "In Stock"); // Use form value or default
        instrument.setManufacturerId(manufacturerId);
        LOGGER.info("Instrument object created: " + instrument);

        // Save to database
        InstrumentDAO dao = new InstrumentDAO();
        String addStatus = null;
        try {
            dao.addInstrument(instrument);
            LOGGER.info("Instrument added to database successfully");
            addStatus = "Instrument added successfully!";
        } catch (SQLException e) {
            LOGGER.severe("Database error while adding instrument: " + e.getMessage());
            addStatus = "Database error: " + e.getMessage();
            if (e.getMessage().contains("Cannot find db.properties") || e.getMessage().contains("The url cannot be null")) {
                addStatus += " Please ensure db.properties is in src/main/resources with valid database settings.";
            }
        } catch (Exception e) {
            LOGGER.severe("Unexpected error: " + e.getMessage());
            addStatus = "Unexpected error: " + e.getMessage();
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