package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/CreateOrderServlet")
public class CreateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response content type
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get form parameters with null checks
            String customerName = request.getParameter("customerName");
            String phoneNumber = request.getParameter("phoneNumber");
            String province = request.getParameter("province");
            String district = request.getParameter("district");
            String city = request.getParameter("city");
            String address = request.getParameter("address");
            String deliveryLabel = request.getParameter("deliveryLabel");
            String totalAmountStr = request.getParameter("totalAmount");

            // Debug: Print received parameters
            System.out.println("Received order data:");
            System.out.println("Customer Name: " + customerName);
            System.out.println("Phone: " + phoneNumber);
            System.out.println("Province: " + province);
            System.out.println("District: " + district);
            System.out.println("City: " + city);
            System.out.println("Address: " + address);
            System.out.println("Delivery Label: " + deliveryLabel);
            System.out.println("Total Amount: " + totalAmountStr);

            // Validate required parameters
            if (customerName == null || customerName.trim().isEmpty() ||
                    phoneNumber == null || phoneNumber.trim().isEmpty() ||
                    province == null || province.trim().isEmpty() ||
                    district == null || district.trim().isEmpty() ||
                    city == null || city.trim().isEmpty() ||
                    address == null || address.trim().isEmpty() ||
                    totalAmountStr == null || totalAmountStr.trim().isEmpty()) {

                throw new Exception("Missing required form parameters");
            }

            // Convert totalAmount to double
            double totalAmount = Double.parseDouble(totalAmountStr);

            // Get database connection
            Connection conn = DBConnection.getConnection();
            if (conn == null) {
                throw new Exception("Failed to get database connection");
            }

            // SQL insert statement
            String sql = "INSERT INTO OrderNow (CustomerName, PhoneNumber, Province, District, City, Address, DeliveryLabel, TotalAmount, Status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, customerName);
            pstmt.setString(2, phoneNumber);
            pstmt.setString(3, province);
            pstmt.setString(4, district);
            pstmt.setString(5, city);
            pstmt.setString(6, address);
            pstmt.setString(7, deliveryLabel != null ? deliveryLabel : "HOME");
            pstmt.setDouble(8, totalAmount);

            int rowsAffected = pstmt.executeUpdate();

            // Close resources
            pstmt.close();
            conn.close();

            if (rowsAffected > 0) {
                System.out.println("Order saved successfully! Rows affected: " + rowsAffected);
                // Success - redirect to confirmation page
                response.sendRedirect("order-confirmation.jsp?success=true");
            } else {
                System.out.println("No rows affected - order failed to save");
                // Error - redirect back with error message
                response.sendRedirect("ordernow.jsp?error=Order failed to save to database");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
            response.sendRedirect("ordernow.jsp?error=Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.out.println("Number Format Error: " + e.getMessage());
            response.sendRedirect("ordernow.jsp?error=Invalid total amount format");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("General Error: " + e.getMessage());
            response.sendRedirect("ordernow.jsp?error=" + e.getMessage());
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
}