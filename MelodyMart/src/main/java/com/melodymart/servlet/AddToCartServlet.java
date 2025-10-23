package com.melodymart.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import main.java.com.melodymart.util.DBConnection;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    // ✅ Handles GET (redirects to POST for safety)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    // ✅ Handles POST form submission from shop.jsp
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== AddToCartServlet Triggered ===");
        HttpSession session = request.getSession();

        // ✅ Ensure customer is logged in
        String customerId = (String) session.getAttribute("customerId");
        if (customerId == null) {
            System.out.println("⚠ No customer in session, redirecting to sign-in.jsp");
            response.sendRedirect("sign-in.jsp");
            return;
        }

        // ✅ Get product details from form
        String instrumentId = request.getParameter("instrumentId");
        String quantityParam = request.getParameter("quantity");
        int quantity = 1;
        try {
            if (quantityParam != null) quantity = Integer.parseInt(quantityParam);
        } catch (NumberFormatException e) {
            quantity = 1;
        }

        System.out.println("CustomerID: " + customerId +
                " | InstrumentID: " + instrumentId +
                " | Quantity: " + quantity);

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            System.out.println("✅ Database connected successfully.");

            // ✅ Check if item already exists in user's cart
            String checkSql = "SELECT * FROM Cart WHERE CustomerID = ? AND InstrumentID = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, customerId);
            checkStmt.setString(2, instrumentId);
            rs = checkStmt.executeQuery();

            if (rs.next()) {
                // ✅ Update existing item quantity
                int existingQuantity = rs.getInt("Quantity");
                int newQuantity = existingQuantity + quantity;
                String cartId = rs.getString("CartID");

                String updateSql = "UPDATE Cart SET Quantity = ?, AddedDate = ? WHERE CartID = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setInt(1, newQuantity);
                stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                stmt.setString(3, cartId);

                int updatedRows = stmt.executeUpdate();
                if (updatedRows > 0) {
                    System.out.println("🟢 Cart item updated successfully.");
                    updateSessionCart(session, instrumentId, quantity, true);
                    response.sendRedirect("shop.jsp?added=success");
                } else {
                    System.out.println("❌ Failed to update cart item.");
                    response.sendRedirect("shop.jsp?added=fail");
                }

            } else {
                // ✅ Insert new item into cart
                if (!isInstrumentAvailable(conn, instrumentId, quantity)) {
                    System.out.println("⚠ Instrument not available / out of stock.");
                    response.sendRedirect("shop.jsp?added=fail&reason=out_of_stock");
                    return;
                }

                String cartId = generateCartId();
                String insertSql = "INSERT INTO Cart (CartID, CustomerID, InstrumentID, Quantity, AddedDate) VALUES (?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(insertSql);
                stmt.setString(1, cartId);
                stmt.setString(2, customerId);
                stmt.setString(3, instrumentId);
                stmt.setInt(4, quantity);
                stmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));

                int insertedRows = stmt.executeUpdate();
                if (insertedRows > 0) {
                    System.out.println("🟢 New cart item added successfully.");
                    updateSessionCart(session, instrumentId, quantity, false);
                    response.sendRedirect("shop.jsp?added=success");
                } else {
                    System.out.println("❌ Failed to insert new cart item.");
                    response.sendRedirect("shop.jsp?added=fail");
                }
            }

        } catch (SQLException e) {
            System.out.println("💥 SQL Exception: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("shop.jsp?added=error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            System.out.println("=== AddToCartServlet Completed ===");
        }
    }

    // ✅ Generate unique Cart ID
    private String generateCartId() {
        long timestamp = System.currentTimeMillis() % 1000000; // last 6 digits only
        return "CA" + timestamp;
    }


    // ✅ Check product stock availability
    private boolean isInstrumentAvailable(Connection conn, String instrumentId, int quantity) throws SQLException {
        String sql = "SELECT Quantity FROM Instrument WHERE InstrumentID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, instrumentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int availableQty = rs.getInt("Quantity");
                    return availableQty >= quantity;
                }
            }
        }
        return false;
    }

    // ✅ Maintain session cart info
    private void updateSessionCart(HttpSession session, String instrumentId, int quantity, boolean isUpdate) {
        List<String> cartItems = (List<String>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }

        if (isUpdate) {
            Integer currentCount = (Integer) session.getAttribute("cartCount");
            if (currentCount == null) currentCount = 0;
            session.setAttribute("cartCount", currentCount + quantity);
        } else {
            for (int i = 0; i < quantity; i++) {
                cartItems.add(instrumentId);
            }
            session.setAttribute("cartItems", cartItems);
            session.setAttribute("cartCount", cartItems.size());
        }

        System.out.println("🛒 Session cart updated → Count: " + session.getAttribute("cartCount"));
    }
}
