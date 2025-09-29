package com.melodymart.servlet;

import com.melodymart.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int instrumentId = Integer.parseInt(request.getParameter("instrumentId"));
        int newQty = Integer.parseInt(request.getParameter("quantity"));

        try (Connection conn = DatabaseUtil.getConnection()) {
            // 1. Get old quantity from Cart
            String getOldQtySql = "SELECT Quantity FROM Cart WHERE CartID = ?";
            int oldQty = 0;

            try (PreparedStatement ps = conn.prepareStatement(getOldQtySql)) {
                ps.setInt(1, cartId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        oldQty = rs.getInt("Quantity");
                    }
                }
            }

            int difference = newQty - oldQty;

            // 2. Update cart quantity
            String updateCartSql = "UPDATE Cart SET Quantity = ? WHERE CartID = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateCartSql)) {
                ps.setInt(1, newQty);
                ps.setInt(2, cartId);
                ps.executeUpdate();
            }

            // 3. Update Instrument stock (decrease if more added, increase if reduced)
            String updateInstrumentSql = "UPDATE Instrument SET Quantity = Quantity - ? WHERE InstrumentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateInstrumentSql)) {
                ps.setInt(1, difference);
                ps.setInt(2, instrumentId);
                ps.executeUpdate();
            }

            response.sendRedirect("cart.jsp");

        } catch (Exception e) {
            throw new ServletException("Error updating cart", e);
        }
    }
}
