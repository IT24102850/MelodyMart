package main.java.com.melodymart.servlet;

import com.melodymart.util.DatabaseUtil;
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
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String paymentId = request.getParameter("paymentId");

        System.out.println("DeletePaymentServlet - Payment ID: " + paymentId);

        if (paymentId == null || paymentId.trim().isEmpty()) {
            response.sendRedirect("PaymentManagementServlet?status=error&msg=Payment ID required");
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            try {
                // First delete from CardPayment if exists
                String deleteCardPaymentSql = "DELETE FROM CardPayment WHERE PaymentID = ?";
                try (PreparedStatement ps = conn.prepareStatement(deleteCardPaymentSql)) {
                    ps.setString(1, paymentId);
                    ps.executeUpdate();
                }

                // Then delete from Payment
                String deletePaymentSql = "DELETE FROM Payment WHERE PaymentID = ?";
                try (PreparedStatement ps = conn.prepareStatement(deletePaymentSql)) {
                    ps.setString(1, paymentId);
                    int rows = ps.executeUpdate();

                    if (rows > 0) {
                        conn.commit(); // Commit transaction
                        System.out.println("Successfully deleted payment: " + paymentId);
                        response.sendRedirect("PaymentManagementServlet?status=success&msg=Payment deleted successfully");
                    } else {
                        conn.rollback(); // Rollback if no payment found
                        System.out.println("Payment not found: " + paymentId);
                        response.sendRedirect("PaymentManagementServlet?status=error&msg=Payment not found");
                    }
                }
            } catch (Exception e) {
                conn.rollback(); // Rollback on error
                throw e;
            }
        } catch (Exception e) {
            System.out.println("Error deleting payment: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("PaymentManagementServlet?status=error&msg=Error deleting payment: " + e.getMessage());
        }
    }
}