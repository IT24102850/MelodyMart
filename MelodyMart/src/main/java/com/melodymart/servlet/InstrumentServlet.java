package com.melodymart.servlet;

import com.melodymart.dao.InstrumentDAO;
import com.melodymart.model.Instrument;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/InstrumentServlet")
public class InstrumentServlet extends HttpServlet {
    private InstrumentDAO instrumentDAO;

    @Override
    public void init() throws ServletException {
        instrumentDAO = new InstrumentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "list") {
                case "list":
                    listInstruments(request, response);
                    break;
                case "view":
                    viewInstrument(request, response);
                    break;
                case "search":
                    searchInstruments(request, response);
                    break;
                default:
                    listInstruments(request, response); // Default action
                    break;
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "add":
                    addInstrument(request, response);
                    break;
                case "update":
                    updateInstrument(request, response);
                    break;
                case "delete":
                    deleteInstrument(request, response);
                    break;
                default:
                    response.sendRedirect("InstrumentServlet?action=list");
                    break;
            }
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input or database error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    // List all instruments
    private void listInstruments(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Instrument> instruments = instrumentDAO.getAllInstruments();
        request.setAttribute("instruments", instruments);
        request.getRequestDispatcher("/instruments.jsp").forward(request, response);
    }

    // View a specific instrument
    private void viewInstrument(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Instrument instrument = instrumentDAO.getInstrumentById(id);
            if (instrument != null) {
                request.setAttribute("instrument", instrument);
                request.getRequestDispatcher("/instrument-details.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Instrument not found.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid instrument ID.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    // Search instruments by keyword and filters
    private void searchInstruments(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        Double minPrice = request.getParameter("minPrice") != null ? Double.parseDouble(request.getParameter("minPrice")) : null;
        Double maxPrice = request.getParameter("maxPrice") != null ? Double.parseDouble(request.getParameter("maxPrice")) : null;

        List<Instrument> instruments = instrumentDAO.searchInstruments(keyword, category, brand, minPrice, maxPrice);
        request.setAttribute("instruments", instruments);
        request.setAttribute("keyword", keyword);
        request.setAttribute("category", category);
        request.setAttribute("brand", brand);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.getRequestDispatcher("/instruments.jsp").forward(request, response);
    }

    // Add a new instrument
    private void addInstrument(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        try {
            Instrument instrument = new Instrument();
            instrument.setName(validateString(request.getParameter("name"), "Name"));
            instrument.setBrand(validateString(request.getParameter("brand"), "Brand"));
            instrument.setPrice(validateDouble(request.getParameter("price"), "Price"));
            instrument.setCategory(validateString(request.getParameter("category"), "Category"));
            instrument.setDescription(validateString(request.getParameter("description"), "Description"));
            instrument.setImageUrl(validateString(request.getParameter("imageUrl"), "Image URL"));
            instrument.setStock(validateInt(request.getParameter("stock"), "Stock"));
            instrument.setAvailable(Boolean.parseBoolean(request.getParameter("available")));

            instrumentDAO.addInstrument(instrument);
            response.sendRedirect("InstrumentServlet?action=list");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    // Update an existing instrument
    private void updateInstrument(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        try {
            int id = validateInt(request.getParameter("id"), "ID");
            Instrument instrument = instrumentDAO.getInstrumentById(id);
            if (instrument != null) {
                instrument.setName(validateString(request.getParameter("name"), "Name"));
                instrument.setBrand(validateString(request.getParameter("brand"), "Brand"));
                instrument.setPrice(validateDouble(request.getParameter("price"), "Price"));
                instrument.setCategory(validateString(request.getParameter("category"), "Category"));
                instrument.setDescription(validateString(request.getParameter("description"), "Description"));
                instrument.setImageUrl(validateString(request.getParameter("imageUrl"), "Image URL"));
                instrument.setStock(validateInt(request.getParameter("stock"), "Stock"));
                instrument.setAvailable(Boolean.parseBoolean(request.getParameter("available")));

                instrumentDAO.updateInstrument(instrument);
            } else {
                throw new IllegalArgumentException("Instrument not found for update.");
            }
            response.sendRedirect("InstrumentServlet?action=list");
        } catch (IllegalArgumentException | NumberFormatException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    // Delete an instrument
    private void deleteInstrument(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        try {
            int id = validateInt(request.getParameter("id"), "ID");
            instrumentDAO.deleteInstrument(id);
            response.sendRedirect("InstrumentServlet?action=list");
        } catch (IllegalArgumentException | NumberFormatException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    // Helper method to validate string parameters
    private String validateString(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " is required.");
        }
        return value.trim();
    }

    // Helper method to validate integer parameters
    private int validateInt(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " is required.");
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(fieldName + " must be a valid number.");
        }
    }

    // Helper method to validate double parameters
    private double validateDouble(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " is required.");
        }
        try {
            return Double.parseDouble(value.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(fieldName + " must be a valid number.");
        }
    }
}