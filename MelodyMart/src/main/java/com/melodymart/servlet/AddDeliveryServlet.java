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

@WebServlet("/AddDeliveryServlet")
public class AddDeliveryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        String trackingNumber = request.getParameter("trackingNumber");
        String currentLocation = request.getParameter("currentLocation");
        String estimatedDeliveryDate = request.getParameter("estimatedDeliveryDate");
        String estimatedCost = request.getParameter("estimatedCost");
        String deliveryCase = request.getParameter("deliveryCase");

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "INSERT INTO Delivery (OrderID, DeliveryStatus, TrackingNumber, " +
                    "CurrentLocation, EstimatedDeliveryDate, EstimatedCost, DeliveryCase, DeliveryDate) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(orderId));
                ps.setString(2, status);
                ps.setString(3, trackingNumber);
                ps.setString(4, currentLocation);
                ps.setString(5, estimatedDeliveryDate != null && !estimatedDeliveryDate.isEmpty() ? estimatedDeliveryDate : null);
                ps.setBigDecimal(6, estimatedCost != null && !estimatedCost.isEmpty() ? new java.math.BigDecimal(estimatedCost) : null);
                ps.setString(7, deliveryCase);

                ps.executeUpdate();
            }
        } catch (Exception e) {
            throw new ServletException("Error adding delivery", e);
        }

        response.sendRedirect("sellerdashboard.jsp#deliveries");
    }
}
