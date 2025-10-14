package com.melodymart.servlet;

import com.melodymart.util.DatabaseUtil;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/PaymentManagementServlet")
public class PaymentManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("=== PaymentManagementServlet called at " + new java.util.Date() + " ===");

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        String customerId = (String) session.getAttribute("customerId");
        System.out.println("PaymentManagementServlet - Session ID: " + session.getId() + ", User Role: " + userRole + ", Customer ID: " + customerId);

        if (userRole == null) {
            System.out.println("Redirecting to login: Role is null");
            response.sendRedirect("sign-in.jsp");
            return;
        }

        List<Map<String, Object>> payments = null;
        try {
            if ("customer".equals(userRole) && customerId != null) {
                payments = getCustomerPayments(customerId);
            } else if ("seller".equals(userRole)) {
                payments = getAllPayments();
            }
            System.out.println("Retrieved " + (payments != null ? payments.size() : 0) + " payments");
        } catch (SQLException e) {
            System.out.println("Database error in PaymentManagementServlet: " + e.getMessage());
            e.printStackTrace();
        }

        if (payments == null) {
            payments = new ArrayList<>();
            System.out.println("Payments list initialized as empty due to null result");
        }
        request.setAttribute("payments", payments);

        String status = request.getParameter("status");
        String msg = request.getParameter("msg");
        if (status != null && msg != null) {
            request.setAttribute("status", status);
            request.setAttribute("msg", msg);
        } else if (payments.isEmpty()) {
            request.setAttribute("status", "info");
            request.setAttribute("msg", "No payment records found.");
        }

        request.setAttribute("userRole", userRole);

        request.getRequestDispatcher("payment.jsp").forward(request, response);
    }

    private List<Map<String, Object>> getAllPayments() throws SQLException {
        List<Map<String, Object>> payments = new ArrayList<>();
        String sql = "SELECT p.PaymentID, p.OrderID, o.TotalAmount AS Amount, p.PaymentMethod, " +
                "p.MethodID AS TransactionId, p.TransactionStatus AS Status, p.PaymentDate " +
                "FROM Payment p LEFT JOIN OrderTable o ON p.OrderID = o.OrderID " +
                "ORDER BY p.PaymentDate DESC";

        System.out.println("Executing SQL query: " + sql);

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> payment = new HashMap<>();
                payment.put("paymentId", rs.getString("PaymentID"));
                payment.put("orderId", rs.getString("OrderID"));
                payment.put("amount", rs.getDouble("Amount"));
                payment.put("paymentMethod", rs.getString("PaymentMethod"));
                payment.put("transactionId", rs.getString("TransactionId"));
                payment.put("status", rs.getString("Status"));
                payment.put("paymentDate", rs.getTimestamp("PaymentDate"));
                payments.add(payment);

                System.out.println("Payment retrieved: ID=" + payment.get("paymentId") + ", Amount=" + payment.get("amount"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
            throw e;
        }
        return payments;
    }

    private List<Map<String, Object>> getCustomerPayments(String customerId) throws SQLException {
        List<Map<String, Object>> payments = new ArrayList<>();
        String sql = "SELECT p.PaymentID, p.OrderID, o.TotalAmount AS Amount, p.PaymentMethod, " +
                "p.MethodID AS TransactionId, p.TransactionStatus AS Status, p.PaymentDate " +
                "FROM Payment p JOIN OrderTable o ON p.OrderID = o.OrderID " +
                "WHERE o.CustomerNIC = ? " +
                "ORDER BY p.PaymentDate DESC";

        System.out.println("Executing SQL query for customer: " + sql);

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> payment = new HashMap<>();
                    payment.put("paymentId", rs.getString("PaymentID"));
                    payment.put("orderId", rs.getString("OrderID"));
                    payment.put("amount", rs.getDouble("Amount"));
                    payment.put("paymentMethod", rs.getString("PaymentMethod"));
                    payment.put("transactionId", rs.getString("TransactionId"));
                    payment.put("status", rs.getString("Status"));
                    payment.put("paymentDate", rs.getTimestamp("PaymentDate"));
                    payments.add(payment);

                    System.out.println("Customer payment retrieved: ID=" + payment.get("paymentId") + ", Amount=" + payment.get("amount"));
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
            throw e;
        }
        return payments;
    }

    // Utility method to check if order belongs to customer
    public static boolean isOrderBelongsToCustomer(String customerId, String orderId) {
        if (customerId == null || orderId == null) return false;

        String sql = "SELECT COUNT(*) FROM OrderTable WHERE OrderID = ? AND CustomerNIC = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ps.setString(2, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error checking order ownership: " + e.getMessage());
        }
        return false;
    }
}