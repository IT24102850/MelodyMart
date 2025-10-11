// AddToCartServlet.java
package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import main.java.com.melodymart.util.DBConnection;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Debug: Log all parameters
        System.out.println("=== SERVLET DEBUG ===");
        System.out.println("Request method: " + request.getMethod());

        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            System.out.println("Parameter: " + paramName + " = " + paramValue);
        }

        // Get session and validate customerID
        HttpSession session = request.getSession(false);
        Integer customerID = (session != null) ? (Integer) session.getAttribute("customerID") : null;

        if (customerID == null) {
            System.out.println("ERROR: No customerID in session");
            out.write("error: Please log in to add items to cart");
            return;
        }

        System.out.println("CustomerID from session: " + customerID);

        String instrumentID = request.getParameter("instrumentID");
        String quantityStr = request.getParameter("quantity");

        System.out.println("InstrumentID from request: '" + instrumentID + "'");
        System.out.println("Quantity from request: '" + quantityStr + "'");

        // Validate parameters
        if (instrumentID == null || instrumentID.trim().isEmpty()) {
            System.out.println("ERROR: InstrumentID is null or empty");
            out.write("error: Instrument ID is required");
            return;
        }

        int quantity = 1;
        if (quantityStr != null && !quantityStr.trim().isEmpty()) {
            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity <= 0) {
                    quantity = 1;
                }
            } catch (NumberFormatException e) {
                quantity = 1;
            }
        }

        System.out.println("Final quantity: " + quantity);

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            System.out.println("Database connection successful");

            // Validate instrument exists and has stock
            String validateSql = "SELECT Quantity FROM Instrument WHERE InstrumentID = ?";
            pstmt = conn.prepareStatement(validateSql);
            pstmt.setString(1, instrumentID); // Assuming InstrumentID is VARCHAR
            rs = pstmt.executeQuery();
            if (!rs.next() || rs.getInt("Quantity") < quantity) {
                out.write("error: Instrument not found or insufficient stock");
                return;
            }

            // Verify customer exists (optional but recommended)
            String checkCustomerSql = "SELECT CustomerID FROM Customer WHERE CustomerID = ?";
            pstmt.close();
            pstmt = conn.prepareStatement(checkCustomerSql);
            pstmt.setInt(1, customerID);
            rs.close();
            rs = pstmt.executeQuery();
            if (!rs.next()) {
                out.write("error: Invalid customer ID");
                return;
            }

            // Check if item already in cart
            String checkSql = "SELECT CartID, Quantity FROM Cart WHERE CustomerID = ? AND InstrumentID = ?";
            pstmt.close();
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setInt(1, customerID);
            pstmt.setString(2, instrumentID);
            rs.close();
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Item exists - update quantity
                int existingQuantity = rs.getInt("Quantity");
                int newQuantity = existingQuantity + quantity;
                System.out.println("Item exists. Old quantity: " + existingQuantity + ", New quantity: " + newQuantity);

                String updateSql = "UPDATE Cart SET Quantity = ? WHERE CustomerID = ? AND InstrumentID = ?";
                pstmt.close();
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setInt(1, newQuantity);
                pstmt.setInt(2, customerID);
                pstmt.setString(3, instrumentID);
            } else {
                // Item doesn't exist - insert new record
                System.out.println("Item doesn't exist, inserting new record");
                String insertSql = "INSERT INTO Cart (CustomerID, InstrumentID, Quantity, AddedDate) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
                pstmt.close();
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setInt(1, customerID);
                pstmt.setString(2, instrumentID);
                pstmt.setInt(3, quantity);
            }

            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

            if (rowsAffected > 0) {
                out.write("success");
                System.out.println("SUCCESS: Cart updated successfully");
            } else {
                out.write("error: Failed to update cart - no rows affected");
                System.out.println("ERROR: No rows affected when updating cart");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL ERROR: " + e.getMessage());
            out.write("error: Database error - " + e.getMessage());
        } finally {
            // Close resources with null check
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }

        System.out.println("=== SERVLET COMPLETE ===");
    }
}