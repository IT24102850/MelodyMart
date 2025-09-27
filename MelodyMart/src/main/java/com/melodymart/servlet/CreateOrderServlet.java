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
import java.sql.SQLException;

@WebServlet("/CreateOrderServlet")
public class CreateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String customerName = request.getParameter("customerName");
        String phoneNumber = request.getParameter("phoneNumber");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String city = request.getParameter("city");
        String address = request.getParameter("address");
        String deliveryLabel = request.getParameter("deliveryLabel");
        String totalAmountStr = request.getParameter("totalAmount");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Convert totalAmount to BigDecimal
            double totalAmount = Double.parseDouble(totalAmountStr);

            // Get database connection
            conn = DBConnection.getConnection();

            // SQL insert statement
            String sql = "INSERT INTO OrderNow (CustomerName, PhoneNumber, Province, District, City, Address, DeliveryLabel, TotalAmount, Status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, customerName);
            pstmt.setString(2, phoneNumber);
            pstmt.setString(3, province);
            pstmt.setString(4, district);
            pstmt.setString(5, city);
            pstmt.setString(6, address);
            pstmt.setString(7, deliveryLabel);
            pstmt.setDouble(8, totalAmount);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Success - redirect to confirmation page
                response.sendRedirect("order-confirmation.jsp?success=true");
            } else {
                // Error - redirect back with error message
                response.sendRedirect("order-now.jsp?error=Order failed to save");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("order-now.jsp?error=Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("order-now.jsp?error=Invalid total amount");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("order-now.jsp?error=Unexpected error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}