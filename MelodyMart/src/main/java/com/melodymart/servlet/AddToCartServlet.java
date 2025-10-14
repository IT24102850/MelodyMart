package com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.melodymart.util.DatabaseUtil;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String customerIdStr = (String) session.getAttribute("CustomerID");

        // Check if user is logged in
        if (customerIdStr == null || customerIdStr.isEmpty()) {
            response.sendRedirect("sign-in.jsp?error=Please login to add items to cart");
            return;
        }

        // Get parameters
        String instrumentId = request.getParameter("instrumentId");
        String quantityStr = request.getParameter("quantity");

        // Validate parameters
        if (instrumentId == null || instrumentId.isEmpty()) {
            response.sendRedirect("shop.jsp?error=Invalid instrument selection");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            int quantity = 1; // Default quantity

            if (quantityStr != null && !quantityStr.isEmpty()) {
                quantity = Integer.parseInt(quantityStr);
            }

            if (quantity < 1) {
                response.sendRedirect("shop.jsp?error=Invalid quantity");
                return;
            }

            conn = DatabaseUtil.getConnection();

            // Check if instrument exists and has sufficient stock
            String checkStockSql = "SELECT Name, Quantity FROM Instrument WHERE InstrumentID = ?";
            ps = conn.prepareStatement(checkStockSql);
            ps.setString(1, instrumentId);
            rs = ps.executeQuery();

            if (!rs.next()) {
                response.sendRedirect("shop.jsp?error=Instrument not found");
                return;
            }

            String instrumentName = rs.getString("Name");
            int availableStock = rs.getInt("Quantity");

            if (availableStock < quantity) {
                response.sendRedirect("shop.jsp?error=Insufficient stock for " + instrumentName);
                return;
            }

            rs.close();
            ps.close();

            // Check if item already exists in cart
            String checkCartSql = "SELECT CartID, Quantity FROM Cart " +
                    "WHERE CustomerID = ? AND InstrumentID = ?";
            ps = conn.prepareStatement(checkCartSql);
            ps.setString(1, customerIdStr);
            ps.setString(2, instrumentId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Item exists, update quantity
                int existingQty = rs.getInt("Quantity");
                int newQty = existingQty + quantity;

                // Check if new quantity exceeds available stock
                if (newQty > availableStock) {
                    response.sendRedirect("shop.jsp?error=Cannot add more. Only " +
                            availableStock + " items available");
                    return;
                }

                rs.close();
                ps.close();

                String updateSql = "UPDATE Cart SET Quantity = ? " +
                        "WHERE CustomerID = ? AND InstrumentID = ?";
                ps = conn.prepareStatement(updateSql);
                ps.setInt(1, newQty);
                ps.setString(2, customerIdStr);
                ps.setString(3, instrumentId);
                ps.executeUpdate();

                response.sendRedirect("shop.jsp?message=" +
                        java.net.URLEncoder.encode(instrumentName + " quantity updated in cart!", "UTF-8"));

            } else {
                // Item doesn't exist, insert new record
                rs.close();
                ps.close();

                // Generate CartID (auto-increment approach)
                String maxIdSql = "SELECT MAX(CAST(SUBSTRING(CartID, 2, LEN(CartID)-1) AS INT)) as MaxNum " +
                        "FROM Cart WHERE CartID LIKE 'C%'";
                ps = conn.prepareStatement(maxIdSql);
                rs = ps.executeQuery();

                int nextNum = 1;
                if (rs.next()) {
                    Integer maxNum = (Integer) rs.getObject("MaxNum");
                    if (maxNum != null) {
                        nextNum = maxNum + 1;
                    }
                }

                String cartId = String.format("C%03d", nextNum);

                rs.close();
                ps.close();

                String insertSql = "INSERT INTO Cart (CartID, CustomerID, InstrumentID, Quantity, AddedDate) " +
                        "VALUES (?, ?, ?, ?, GETDATE())";
                ps = conn.prepareStatement(insertSql);
                ps.setString(1, cartId);
                ps.setString(2, customerIdStr);
                ps.setString(3, instrumentId);
                ps.setInt(4, quantity);
                ps.executeUpdate();

                response.sendRedirect("shop.jsp?message=" +
                        java.net.URLEncoder.encode(instrumentName + " added to cart successfully!", "UTF-8"));
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("shop.jsp?error=Invalid input format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("shop.jsp?error=" +
                    java.net.URLEncoder.encode("Error adding to cart: " + e.getMessage(), "UTF-8"));
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("shop.jsp");
    }
}