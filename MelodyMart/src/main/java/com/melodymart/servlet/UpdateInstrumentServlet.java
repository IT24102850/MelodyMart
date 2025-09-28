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

@WebServlet("/UpdateInstrumentServlet")
public class UpdateInstrumentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int instrumentId = Integer.parseInt(request.getParameter("instrumentId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String model = request.getParameter("model");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String stockLevel = request.getParameter("stockLevel");
        String imageUrl = request.getParameter("imageUrl");

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "UPDATE Instrument SET Name=?, Description=?, Model=?, Price=?, Quantity=?, StockLevel=?, ImageURL=? WHERE InstrumentID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, model);
            ps.setDouble(4, price);
            ps.setInt(5, quantity);
            ps.setString(6, stockLevel);
            ps.setString(7, imageUrl);
            ps.setInt(8, instrumentId);

            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating instrument: " + e.getMessage());
        }

        // Redirect back to dashboard
        response.sendRedirect(request.getContextPath() + "/sellerdashboard.jsp");
    }
}
