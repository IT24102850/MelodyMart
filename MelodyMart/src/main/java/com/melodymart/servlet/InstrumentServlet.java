/*

package com.melodymart.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.melodymart.dao.InstrumentDAO;
import com.melodymart.model.Instrument;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/instruments")
public class InstrumentServlet extends HttpServlet {
    private static final ObjectMapper mapper = new ObjectMapper();
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Configure response
        configureCorsHeaders(response);
        response.setContentType("application/json");

        InstrumentDAO instrumentDAO = new InstrumentDAO();

        try {
            // Parse and validate parameters
            String category = request.getParameter("category");
            int page = parseIntParameter(request.getParameter("page"), 1);
            int size = parseIntParameter(request.getParameter("size"), 10);
            String sort = request.getParameter("sort");

            // Validate pagination parameters
            if (page < 1 || size < 1 || size > 100) {
                sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid pagination parameters. Page must be ≥1, size between 1-100");
                return;
            }

            // Fetch instruments
            List<Instrument> instruments;
            long totalItems;

            if (category != null && !category.trim().isEmpty()) {
                instruments = instrumentDAO.getInstrumentsByCategory(category, page, size, sort);
                totalItems = instrumentDAO.getTotalInstruments(category);
            } else {
                instruments = instrumentDAO.getAllInstruments(page,size,sort);
                totalItems = instrumentDAO.getTotalInstruments(null);
            }

            // Handle no results
            if (instruments == null || instruments.isEmpty()) {
                sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND,
                        "No instruments found" + (category != null ? " for category: " + category : ""));
                return;
            }

            // Build response
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("data", instruments);
            responseData.put("meta", buildPaginationMeta(page, size, totalItems));

            // Send response
            sendJsonResponse(response, HttpServletResponse.SC_OK, responseData);

        } catch (Exception e) {
            handleException(response, e);
        }
    }

    private void configureCorsHeaders(HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
    }

    private Map<String, Object> buildPaginationMeta(int page, int size, long totalItems) {
        Map<String, Object> meta = new HashMap<>();
        meta.put("page", page);
        meta.put("size", size);
        meta.put("totalItems", totalItems);
        meta.put("totalPages", (int) Math.ceil((double) totalItems / size));
        return meta;
    }

    private int parseIntParameter(String param, int defaultValue) {
        try {
            return param != null ? Integer.parseInt(param) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private void sendJsonResponse(HttpServletResponse response, int status, Object data)
            throws IOException {
        response.setStatus(status);
        mapper.writeValue(response.getWriter(), data);
    }

    private void sendErrorResponse(HttpServletResponse response, int status, String message)
            throws IOException {
        Map<String, String> error = new HashMap<>();
        error.put("error", message);
        sendJsonResponse(response, status, error);
    }

    private void handleException(HttpServletResponse response, Exception e)
            throws IOException {
        e.printStackTrace();
        sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Server error: " + e.getMessage());
    }
}

 */