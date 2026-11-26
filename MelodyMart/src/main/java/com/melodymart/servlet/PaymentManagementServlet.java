package com.melodymart.servlet;

import com.melodymart.util.DBConnection;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/PaymentManagementServlet")
public class PaymentManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // -------------------------------
    // GET: Load all payment records
    // -------------------------------
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        System.out.println("🟢 [PaymentManagementServlet] doGet() triggered");

        HttpSession session = request.getSession(false);

        // ✅ Validate session and role
        if (session == null) {
            System.out.println("⚠️ No session found. Redirecting to sign-in.jsp");
            response.sendRedirect("sign-in.jsp");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");
        String customerId = (String) session.getAttribute("customerId");
        System.out.println("👤 UserRole=" + userRole + ", CustomerID=" + customerId);

        if (userRole == null) {
            response.sendRedirect("sign-in.jsp");
            return;
        }

        List<Map<String, Object>> payments = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            if (conn == null) {
                System.out.println("❌ DBConnection returned null!");
                request.setAttribute("msg", "Database connection failed.");
                request.setAttribute("status", "error");
            } else {
                String sql;
                PreparedStatement ps;

                if ("seller".equalsIgnoreCase(userRole)) {
                    sql = "SELECT p.PaymentID, p.OrderID, o.TotalAmount, p.MethodID, "
                            + "p.TransactionStatus, p.PaymentDate "
                            + "FROM Payment p JOIN OrderNow o ON p.OrderID = o.OrderID "
                            + "ORDER BY p.PaymentDate DESC";
                    ps = conn.prepareStatement(sql);
                } else {
                    sql = "SELECT p.PaymentID, p.OrderID, o.TotalAmount, p.MethodID, "
                            + "p.TransactionStatus, p.PaymentDate "
                            + "FROM Payment p JOIN OrderNow o ON p.OrderID = o.OrderID "
                            + "JOIN Person per ON CONCAT(per.FirstName,' ',per.LastName)=o.CustomerName "
                            + "WHERE per.PersonID = ? ORDER BY p.PaymentDate DESC";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, customerId);
                }

                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("paymentId", rs.getString("PaymentID"));
                    row.put("orderId", rs.getString("OrderID"));
                    row.put("totalAmount", rs.getDouble("TotalAmount"));
                    row.put("methodId", rs.getString("MethodID"));
                    row.put("transactionStatus", rs.getString("TransactionStatus"));
                    row.put("paymentDate", rs.getTimestamp("PaymentDate"));
                    payments.add(row);
                }

                rs.close();
                ps.close();
                System.out.println("✅ Loaded " + payments.size() + " payments.");
            }

        } catch (Exception e) {
            System.out.println("❌ Exception in doGet(): " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("msg", "Error loading payments: " + e.getMessage());
            request.setAttribute("status", "error");
        }

        request.setAttribute("payments", payments);

        // Always forward (no blank page)
        RequestDispatcher rd = request.getRequestDispatcher("payment.jsp");
        rd.forward(request, response);
    }

    // -------------------------------
    // POST: Handle Update / Return / Delete
    // -------------------------------
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        System.out.println("🟣 [PaymentManagementServlet] doPost() triggered");

        String action = request.getParameter("action");
        String paymentId = request.getParameter("paymentId");
        String newStatus = request.getParameter("status");

        System.out.println("➡️ Action=" + action + ", PaymentID=" + paymentId + ", NewStatus=" + newStatus);

        String msg;
        String status;

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                throw new SQLException("Database connection failed (null connection).");
            }

            conn.setAutoCommit(false);

            switch (action == null ? "" : action.toLowerCase()) {
                case "update":
                    msg = updatePaymentStatus(conn, paymentId, newStatus);
                    status = msg.startsWith("✅") ? "success" : "error";
                    break;

                case "return":
                    msg = returnPayment(conn, paymentId);
                    status = msg.startsWith("✅") ? "success" : "error";
                    break;

                case "delete":
                    msg = deletePayment(conn, paymentId);
                    status = msg.startsWith("✅") ? "success" : "error";
                    break;

                default:
                    msg = "⚠️ Unknown action requested.";
                    status = "error";
                    break;
            }

            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
            msg = "❌ Database error: " + e.getMessage();
            status = "error";
        }

        // Pass feedback to JSP
        request.setAttribute("msg", msg);
        request.setAttribute("status", status);

        // Reload payment list
        doGet(request, response);
    }

    // -------------------------------
    // Helper Methods
    // -------------------------------
    private String updatePaymentStatus(Connection conn, String paymentId, String newStatus) {
        String sql = "UPDATE Payment SET TransactionStatus=?, UpdatedAt=GETDATE() WHERE PaymentID=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, paymentId);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ Updated " + paymentId + " to " + newStatus);
                return "✅ Payment " + paymentId + " updated to " + newStatus + ".";
            } else {
                return "⚠️ No payment found for update (" + paymentId + ").";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "❌ Error updating payment: " + e.getMessage();
        }
    }

    private String returnPayment(Connection conn, String paymentId) {
        String sql = "UPDATE Payment SET TransactionStatus='Returned', RefundDate=GETDATE(), UpdatedAt=GETDATE() WHERE PaymentID=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, paymentId);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ Refunded payment " + paymentId);
                return "✅ Payment " + paymentId + " refunded successfully.";
            } else {
                return "⚠️ Refund failed for payment " + paymentId + ".";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "❌ Error processing refund: " + e.getMessage();
        }
    }

    private String deletePayment(Connection conn, String paymentId) {
        String sql = "DELETE FROM Payment WHERE PaymentID=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, paymentId);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ Deleted payment " + paymentId);
                return "✅ Payment " + paymentId + " deleted successfully.";
            } else {
                return "⚠️ Payment not found for delete (" + paymentId + ").";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "❌ Error deleting payment: " + e.getMessage();
        }
    }
}
