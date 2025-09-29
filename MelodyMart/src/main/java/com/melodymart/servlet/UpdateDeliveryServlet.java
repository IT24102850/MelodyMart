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

@WebServlet("/UpdateDeliveryServlet")
public class UpdateDeliveryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String deliveryId = request.getParameter("deliveryId");
        String status = request.getParameter("status");

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "UPDATE Delivery SET DeliveryStatus = ?, ActualDeliveryDate = " +
                    "CASE WHEN ? = 'Delivered' THEN GETDATE() ELSE ActualDeliveryDate END " +
                    "WHERE DeliveryID = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setString(2, status);
                ps.setInt(3, Integer.parseInt(deliveryId));

                ps.executeUpdate();
            }
        } catch (Exception e) {
            throw new ServletException("Error updating delivery", e);
        }

        response.sendRedirect("sellerdashboard.jsp#deliveries");
    }
}
