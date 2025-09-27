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
        String idStr = request.getParameter("instrumentId");

        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("seller-dashboard.jsp?error=Missing+Instrument+ID");
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "DELETE FROM Instrument WHERE InstrumentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(idStr));
                ps.executeUpdate();
            }
            response.sendRedirect("seller-dashboard.jsp?success=Instrument+deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("seller-dashboard.jsp?error=" + e.getMessage());
        }
    }
}
