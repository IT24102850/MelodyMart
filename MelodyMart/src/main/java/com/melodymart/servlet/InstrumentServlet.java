package com.melodymart.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.melodymart.dao.InstrumentDAO;
import com.melodymart.model.Instrument;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/instruments")
public class InstrumentServlet extends HttpServlet {
    private static final ObjectMapper mapper = new ObjectMapper(); // Reusable ObjectMapper instance

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set CORS headers for cross-origin requests
        response.setHeader("Access-Control-Allow-Origin", "*"); // Adjust in production (e.g., specific domain)
        response.setHeader("Access-Control-Allow-Methods", "GET");
        response.setContentType("application/json");

        InstrumentDAO instrumentDAO = new InstrumentDAO();

        try {
            // Parse query parameters
            String category = request.getParameter("category");
            int page = parseIntParameter(request.getParameter("page"), 1); // Default to page 1
            int size = parseIntParameter(request.getParameter("size"), 10); // Default to 10 items
            String sort = request.getParameter("sort"); // e.g., "price,asc" or "price,desc"

            // Fetch instruments with pagination and sorting
            List<Instrument> instruments;
            if (category != null && !category.trim().isEmpty()) {
                instruments = instrumentDAO.getInstrumentsByCategory(category, page, size, sort);
            } else {
                instruments = instrumentDAO.getAllInstruments(page, size, sort);
            }

            long totalItems = instrumentDAO.getTotalInstruments(category); // Assume DAO method exists
            if (instruments == null || instruments.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
                response.getWriter().write("{\"message\": \"No instruments found for category: " + (category != null ? category : "all") + "\"}");
                return;
            }

            // Prepare response with metadata
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("instruments", instruments);
            responseData.put("totalItems", totalItems);
            responseData.put("page", page);
            responseData.put("size", size);
            responseData.put("totalPages", (int) Math.ceil((double) totalItems / size));

            // Convert to JSON
            String jsonResponse = mapper.writeValueAsString(responseData);
            response.setContentLength(jsonResponse.length());
            response.setStatus(HttpServletResponse.SC_OK); // 200
            response.getWriter().write(jsonResponse);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
            String errorMsg = "Failed to retrieve instruments: " + e.getMessage();
            response.getWriter().write("{\"error\": \"" + errorMsg + "\"}");
            e.printStackTrace();
        }
    }

    // Helper method to parse integer parameters with default values
    private int parseIntParameter(String param, int defaultValue) {
        try {
            return param != null ? Integer.parseInt(param) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}