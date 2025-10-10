package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/RemoveInstrumentServlet")
public class RemoveInstrumentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String instrumentIdStr = request.getParameter("instrumentId");

        if (instrumentIdStr == null || instrumentIdStr.isEmpty()) {
            response.sendRedirect("admin-dashboard.jsp?error=InstrumentIDMissing");
            return;
        }

        int instrumentId = Integer.parseInt(instrumentIdStr);

        try (Connection conn = DBConnection.getConnection()) {
            // Delete from InstrumentCategory first (to avoid FK constraint issues)
            String deleteCategory = "DELETE FROM InstrumentCategory WHERE InstrumentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(deleteCategory)) {
                ps.setInt(1, instrumentId);
                ps.executeUpdate();
            }

            // Delete from Cart
            String deleteCart = "DELETE FROM Cart WHERE InstrumentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(deleteCart)) {
                ps.setInt(1, instrumentId);
                ps.executeUpdate();
            }

            // Delete from OrderItem
            String deleteOrderItem = "DELETE FROM OrderItem WHERE InstrumentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(deleteOrderItem)) {
                ps.setInt(1, instrumentId);
                ps.executeUpdate();
            }

            // Finally delete instrument itself
            String deleteInstrument = "DELETE FROM Instrument WHERE InstrumentID = ?";
            try (PreparedStatement ps = conn.prepareStatement(deleteInstrument)) {
                ps.setInt(1, instrumentId);
                int rows = ps.executeUpdate();

                if (rows > 0) {
                    // ✅ Redirect with success message
                    response.sendRedirect("admin-dashboard.jsp?success=InstrumentRemoved");
                } else {
                    response.sendRedirect("admin-dashboard.jsp?error=InstrumentNotFound");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?error=ServerError");
        }
    }
}
