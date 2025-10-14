package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        String instrumentID = request.getParameter("instrumentID");
        String quantityStr = request.getParameter("quantity");

        System.out.println("=== AddToCartServlet Called ===");
        System.out.println("InstrumentID: " + instrumentID);
        System.out.println("Quantity: " + quantityStr);

        // Validate parameters
        if (instrumentID == null || instrumentID.trim().isEmpty()) {
            response.getWriter().write("error: Instrument ID is required");
            System.err.println("Error: Instrument ID is null or empty");
            return;
        }

        int quantity;
        try {
            quantity = Integer.parseInt(quantityStr);
        } catch (NumberFormatException e) {
            quantity = 1; // Default quantity
        }

        // Use the CustomerID from your database
        String customerID = "CU001"; // Changed from CUST001 to CU001

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            System.out.println("Database connection established");

            // Check if item already exists in cart for this customer
            String checkSql = "SELECT CartID, Quantity FROM Cart WHERE CustomerID = ? AND InstrumentID = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, customerID);
            pstmt.setString(2, instrumentID);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Update existing item
                int existingQuantity = rs.getInt("Quantity");
                int cartID = rs.getInt("CartID");
                pstmt.close();

                String updateSql = "UPDATE Cart SET Quantity = ?, AddedDate = GETDATE() WHERE CartID = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setInt(1, existingQuantity + quantity);
                pstmt.setInt(2, cartID);

                int rowsUpdated = pstmt.executeUpdate();
                if (rowsUpdated > 0) {
                    System.out.println("✅ Cart item updated successfully");
                    response.getWriter().write("success");
                } else {
                    System.err.println("❌ Failed to update cart item");
                    response.getWriter().write("error: Failed to update cart item");
                }
            } else {
                // Insert new item
                String insertSql = "INSERT INTO Cart (CustomerID, InstrumentID, Quantity, AddedDate) VALUES (?, ?, ?, GETDATE())";
                pstmt.close();

                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, customerID);
                pstmt.setString(2, instrumentID);
                pstmt.setInt(3, quantity);

                int rowsInserted = pstmt.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("✅ New item added to cart successfully");
                    response.getWriter().write("success");
                } else {
                    System.err.println("❌ Failed to add item to cart");
                    response.getWriter().write("error: Failed to add item to cart");
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ Database error: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("error: Database error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }
}