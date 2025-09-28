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

@WebServlet("/DeleteInstrumentServlet")
public class DeleteInstrumentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String instrumentId = request.getParameter("instrumentId");

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "DELETE FROM Instrument WHERE InstrumentID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(instrumentId));
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error deleting instrument: " + e.getMessage());
        }

        // Redirect back to dashboard
        response.sendRedirect(request.getContextPath() + "/sellerdashboard.jsp");
    }
}
