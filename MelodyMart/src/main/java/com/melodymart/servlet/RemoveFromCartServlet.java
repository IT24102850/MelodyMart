package com.melodymart.servlet;

import com.melodymart.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int instrumentId = Integer.parseInt(request.getParameter("instrumentId"));
        int qty = Integer.parseInt(request.getParameter("quantity"));

        try (Connection conn = DatabaseUtil.getConnection()) {

            // 1. Restore quantity back to Instrument
            String updateInstrumentSql = "UPDATE Instrument SET Quantity = Quantity + ? WHERE InstrumentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateInstrumentSql)) {
                ps.setInt(1, qty);
                ps.setInt(2, instrumentId);
                ps.executeUpdate();
            }

            // 2. Remove from Cart
            String deleteCartSql = "DELETE FROM Cart WHERE CartID = ?";
            try (PreparedStatement ps = conn.prepareStatement(deleteCartSql)) {
                ps.setInt(1, cartId);
                ps.executeUpdate();
            }

            response.sendRedirect("cart.jsp");

        } catch (Exception e) {
            throw new ServletException("Error removing item from cart", e);
        }
    }
}
