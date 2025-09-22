package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import main.java.com.melodymart.util.DBConnection;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet  {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId"); // Assume customer is logged in
        if (customerId == null) {
            response.sendRedirect("sign-in.jsp");
            return;
        }

        int instrumentId = Integer.parseInt(request.getParameter("instrumentId"));
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                conn = DBConnection.getConnection();
                // Check if item exists in cart
                String checkSql = "SELECT Quantity FROM Cart WHERE CustomerID = ? AND InstrumentID = ?";
                pstmt = conn.prepareStatement(checkSql);
                pstmt.setInt(1, customerId);
                pstmt.setInt(2, instrumentId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    int quantity = rs.getInt("Quantity") + 1;
                    String updateSql = "UPDATE Cart SET Quantity = ? WHERE CustomerID = ? AND InstrumentID = ?";
                    pstmt = conn.prepareStatement(updateSql);
                    pstmt.setInt(1, quantity);
                    pstmt.setInt(2, customerId);
                    pstmt.setInt(3, instrumentId);
                    pstmt.executeUpdate();
                } else {
                    String insertSql = "INSERT INTO Cart (CustomerID, InstrumentID, Quantity, AddedDate) VALUES (?, ?, 1, GETDATE())";
                    pstmt = conn.prepareStatement(insertSql);
                    pstmt.setInt(1, customerId);
                    pstmt.setInt(2, instrumentId);
                    pstmt.executeUpdate();
                }
                response.sendRedirect("shop.jsp");
            } catch (SQLException e) {
                response.getWriter().println("Error adding to cart: " + e.getMessage());
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        }
    }
}