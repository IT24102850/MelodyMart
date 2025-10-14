package com.melodymart.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.melodymart.util.DatabaseUtil;

@WebServlet("/DeliveryServlet")
public class DeliveryServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        Connection conn = null;

        try {
            conn = DatabaseUtil.getConnection();

            if ("add".equalsIgnoreCase(action)) {
                addDelivery(request, conn);
                response.sendRedirect("deliveries.jsp?msg=added");
            } else if ("edit".equalsIgnoreCase(action)) {
                editDelivery(request, conn);
                response.sendRedirect("deliveries.jsp?msg=updated");
            } else if ("delete".equalsIgnoreCase(action)) {
                deleteDelivery(request, conn);
                response.sendRedirect("deliveries.jsp?msg=deleted");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("deliveries?error=" + e.getMessage());
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }

    private void addDelivery(HttpServletRequest request, Connection conn) throws SQLException {
        String nextId = generateNextDeliveryID(conn);
        String status = request.getParameter("status");
        String estimatedDate = request.getParameter("estimatedDate");
        String actualDate = request.getParameter("actualDate");
        String provider = request.getParameter("serviceProvider");

        String sql = "INSERT INTO DeliveryStatus (DeliveryID, CurrentStatus, EstimatedDeliveryDate, ActualDeliveryDate, ServiceProviderID) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, nextId);
        ps.setString(2, status);
        ps.setString(3, estimatedDate.isEmpty() ? null : estimatedDate);
        ps.setString(4, actualDate.isEmpty() ? null : actualDate);
        ps.setString(5, provider);
        ps.executeUpdate();
        ps.close();
    }

    private void editDelivery(HttpServletRequest request, Connection conn) throws SQLException {
        String deliveryId = request.getParameter("deliveryId");
        String status = request.getParameter("status");
        String estimatedDate = request.getParameter("estimatedDate");
        String actualDate = request.getParameter("actualDate");
        String provider = request.getParameter("serviceProvider");

        String sql = "UPDATE DeliveryStatus SET CurrentStatus=?, EstimatedDeliveryDate=?, ActualDeliveryDate=?, ServiceProviderID=? WHERE DeliveryID=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setString(2, estimatedDate.isEmpty() ? null : estimatedDate);
        ps.setString(3, actualDate.isEmpty() ? null : actualDate);
        ps.setString(4, provider);
        ps.setString(5, deliveryId);
        ps.executeUpdate();
        ps.close();
    }

    private void deleteDelivery(HttpServletRequest request, Connection conn) throws SQLException {
        String deliveryId = request.getParameter("deliveryId");
        String sql = "DELETE FROM DeliveryStatus WHERE DeliveryID=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, deliveryId);
        ps.executeUpdate();
        ps.close();
    }

    private String generateNextDeliveryID(Connection conn) throws SQLException {
        String prefix = "DS";
        String sql = "SELECT MAX(DeliveryID) FROM DeliveryStatus";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        String nextId = prefix + "001";

        if (rs.next() && rs.getString(1) != null) {
            String lastId = rs.getString(1);
            int num = Integer.parseInt(lastId.substring(2));
            nextId = String.format("%s%03d", prefix, num + 1);
        }

        rs.close();
        ps.close();
        return nextId;
    }
}
