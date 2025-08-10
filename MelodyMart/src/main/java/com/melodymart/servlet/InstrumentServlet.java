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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        InstrumentDAO instrumentDAO = new InstrumentDAO();
        List<Instrument> instruments = instrumentDAO.getAllInstruments();

        ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(response.getWriter(), instruments);
    }
}