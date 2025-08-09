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
            if ("list".equals(action)) {
                listInstruments(request, response);
            } else if ("view".equals(action)) {
                viewInstrument(request, response);
            } else {
                listInstruments(request, response); // Default to listing all instruments
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addInstrument(request, response);
            } else if ("update".equals(action)) {
                updateInstrument(request, response);
            } else if ("delete".equals(action)) {
                deleteInstrument(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // List all instruments
    private void listInstruments(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        List<Instrument> instruments = instrumentDAO.getAllInstruments();
        request.setAttribute("instruments", instruments);
        request.getRequestDispatcher("/instruments.jsp").forward(request, response);
    }

    // View a specific instrument
    private void viewInstrument(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        Instrument instrument = instrumentDAO.getInstrumentById(id);
        if (instrument != null) {
            request.setAttribute("instrument", instrument);
            request.getRequestDispatcher("/instrument-details.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    // Add a new instrument
    private void addInstrument(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Instrument instrument = new Instrument();
        instrument.setName(request.getParameter("name"));
        instrument.setBrand(request.getParameter("brand"));
        instrument.setPrice(Double.parseDouble(request.getParameter("price")));
        instrument.setCategory(request.getParameter("category"));
        instrument.setDescription(request.getParameter("description"));
        instrument.setImageUrl(request.getParameter("imageUrl"));
        instrument.setStock(Integer.parseInt(request.getParameter("stock")));
        instrument.setAvailable(Boolean.parseBoolean(request.getParameter("available")));

        instrumentDAO.addInstrument(instrument);
        response.sendRedirect("InstrumentServlet?action=list");
    }

    // Update an existing instrument
    private void updateInstrument(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Instrument instrument = instrumentDAO.getInstrumentById(id);
        if (instrument != null) {
            instrument.setName(request.getParameter("name"));
            instrument.setBrand(request.getParameter("brand"));
            instrument.setPrice(Double.parseDouble(request.getParameter("price")));
            instrument.setCategory(request.getParameter("category"));
            instrument.setDescription(request.getParameter("description"));
            instrument.setImageUrl(request.getParameter("imageUrl"));
            instrument.setStock(Integer.parseInt(request.getParameter("stock")));
            instrument.setAvailable(Boolean.parseBoolean(request.getParameter("available")));

            instrumentDAO.updateInstrument(instrument);
        }
        response.sendRedirect("InstrumentServlet?action=list");
    }

    // Delete an instrument
    private void deleteInstrument(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        instrumentDAO.deleteInstrument(id);
        response.sendRedirect("InstrumentServlet?action=list");
    }
}