package com.melodymart.servlet;

import com.melodymart.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
//update
@WebServlet("/DeleteInstrumentServlet")
public class DeleteInstrumentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String instrumentId = request.getParameter("instrumentId");

        try (Connection conn = DatabaseUtil.getConnection()) {
            int id = Integer.parseInt(instrumentId);

            // ✅ Step 1: Delete from Cart (child table)
            String deleteCart = "DELETE FROM Cart WHERE InstrumentID = ?";
            try (PreparedStatement ps1 = conn.prepareStatement(deleteCart)) {
                ps1.setInt(1, id);
                ps1.executeUpdate();
            }

            // ✅ Step 2: Delete from StockCorrections (child table)
            String deleteCorrections = "DELETE FROM StockCorrections WHERE InstrumentID = ?";
            try (PreparedStatement ps2 = conn.prepareStatement(deleteCorrections)) {
                ps2.setInt(1, id);
                ps2.executeUpdate();
            }

            // ✅ Step 3: Delete from Instrument (parent table)
            String deleteInstrument = "DELETE FROM Instrument WHERE InstrumentID = ?";
            try (PreparedStatement ps3 = conn.prepareStatement(deleteInstrument)) {
                ps3.setInt(1, id);
                ps3.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error deleting instrument: " + e.getMessage());
        }

        // Redirect back to dashboard
        response.sendRedirect(request.getContextPath() + "/sellerdashboard.jsp#Inventory");
    }
}
