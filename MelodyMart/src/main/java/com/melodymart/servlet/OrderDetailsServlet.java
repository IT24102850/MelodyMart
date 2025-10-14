package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/OrderDetailsServlet")
public class OrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String orderId = request.getParameter("orderId");
        Integer customerId = (Integer) session.getAttribute("userId");

        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect("orders.jsp?error=Order ID required");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT OrderID, TotalAmount, Status FROM Orders WHERE OrderID = ? AND CustomerID = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(orderId));
                ps.setInt(2, customerId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("orderId", rs.getInt("OrderID"));
                        request.setAttribute("amount", rs.getDouble("TotalAmount"));
                        request.setAttribute("orderStatus", rs.getString("Status"));
                        request.getRequestDispatcher("payment-gateway.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("orders.jsp?error=Order not found or access denied");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("orders.jsp?error=Database error: " + e.getMessage());
        }
    }
}
