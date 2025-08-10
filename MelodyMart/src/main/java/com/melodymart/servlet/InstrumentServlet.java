```java
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
import java.util.List;

@WebServlet("/api/instruments")
public class InstrumentServlet extends HttpServlet {
    private static final ObjectMapper mapper = new ObjectMapper(); // Reusable ObjectMapper instance

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        InstrumentDAO instrumentDAO = new InstrumentDAO();

        try {
            // Get category filter from query parameter (optional)
            String category = request.getParameter("category");
            List<Instrument> instruments;

            if (category != null && !category.trim().isEmpty()) {
                instruments = instrumentDAO.getInstrumentsByCategory(category);
            } else {
                instruments = instrumentDAO.getAllInstruments();
            }

            if (instruments == null || instruments.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 if no instruments
                response.getWriter().write("{\"message\": \"No instruments found\"}");
                return;
            }

            // Convert to JSON and write to response
            String jsonResponse = mapper.writeValueAsString(instruments);
            response.setContentLength(jsonResponse.length());
            response.setStatus(HttpServletResponse.SC_OK); // 200 OK
            response.getWriter().write(jsonResponse);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Error
            response.getWriter().write("{\"error\": \"Failed to retrieve instruments: " + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }
}