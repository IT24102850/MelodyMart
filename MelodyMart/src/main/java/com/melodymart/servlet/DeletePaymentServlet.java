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

@WebServlet("/DeletePaymentServlet")
public class DeletePaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String paymentIdStr = request.getParameter("paymentId");

        if (paymentIdStr == null || paymentIdStr.trim().isEmpty()) {
            response.sendRedirect("sellerdashboard.jsp#Payments?status=error&msg=Payment ID required");
            return;
        }

        int paymentId = Integer.parseInt(paymentIdStr);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM Payment WHERE PaymentID = ?")) {

            ps.setInt(1, paymentId);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("sellerdashboard.jsp#Payments?status=success&msg=Payment deleted");
            } else {
                response.sendRedirect("sellerdashboard.jsp#Payments?status=error&msg=Payment not found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("sellerdashboard.jsp#Payments?status=error&msg=" + e.getMessage());
        }
    }
}
