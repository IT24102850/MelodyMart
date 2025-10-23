package com.melodymart.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import main.java.com.melodymart.util.DBConnection;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerId");

        // ✅ Security: ensure logged in
        if (customerId == null || customerId.trim().isEmpty()) {
            out.print("ERROR:User not logged in");
            return;
        }

        String instrumentId = request.getParameter("instrumentId");
        String action = request.getParameter("action");
        String qtyParam = request.getParameter("quantity");

        if (instrumentId == null || action == null) {
            out.print("ERROR:Missing parameters");
            return;
        }

        int quantity = 0;
        try {
            quantity = Integer.parseInt(qtyParam);
        } catch (Exception e) {
            quantity = 0;
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();

            if ("update".equalsIgnoreCase(action)) {
                // ✅ Update quantity (if > 0)
                if (quantity > 0) {
                    String sql = "UPDATE Cart SET Quantity = ?, AddedDate = GETDATE() WHERE CustomerID = ? AND InstrumentID = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setInt(1, quantity);
                        stmt.setString(2, customerId);
                        stmt.setString(3, instrumentId);
                        stmt.executeUpdate();
                    }
                } else {
                    // If quantity <= 0, delete the item
                    String del = "DELETE FROM Cart WHERE CustomerID = ? AND InstrumentID = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(del)) {
                        stmt.setString(1, customerId);
                        stmt.setString(2, instrumentId);
                        stmt.executeUpdate();
                    }
                }

            } else if ("remove".equalsIgnoreCase(action)) {
                // ✅ Remove item from cart
                String sql = "DELETE FROM Cart WHERE CustomerID = ? AND InstrumentID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, customerId);
                    stmt.setString(2, instrumentId);
                    stmt.executeUpdate();
                }
            }

            // ✅ Calculate new total
            double total = 0;
            String totalQuery =
                    "SELECT SUM(I.Price * C.Quantity) AS Total " +
                            "FROM Cart C JOIN Instrument I ON C.InstrumentID = I.InstrumentID " +
                            "WHERE C.CustomerID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(totalQuery)) {
                stmt.setString(1, customerId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) total = rs.getDouble("Total");
                }
            }

            // ✅ Send plain text back
            out.print("OK:" + total);

        } catch (SQLException e) {
            e.printStackTrace();
            out.print("ERROR:" + e.getMessage());
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // ✅ Handle GET requests (redirect to POST)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
