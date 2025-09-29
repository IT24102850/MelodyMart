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

@WebServlet("/DeleteDeliveryServlet")
public class DeleteDeliveryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String deliveryId = request.getParameter("deliveryId");

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "DELETE FROM Delivery WHERE DeliveryID = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(deliveryId));
                ps.executeUpdate();
            }
        } catch (Exception e) {
            throw new ServletException("Error deleting delivery", e);
        }

        response.sendRedirect("sellerdashboard.jsp#deliveries");
    }
}
