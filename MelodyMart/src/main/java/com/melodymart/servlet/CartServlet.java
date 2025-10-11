// AddToCartServlet.java
package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import main.java.com.melodymart.util.DBConnection;

@WebServlet("/AddToCartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String customerID = (String) session.getAttribute("customerID");

        // For demo purposes, if no user is logged in, use a default customer ID
        // In production, you should redirect to login page
        if (customerID == null) {
            customerID = "10"; // Default customer ID for demo
        }

        String instrumentID = request.getParameter("instrumentID");
        String quantity = request.getParameter("quantity");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO Cart (CustomerID, InstrumentID, Quantity, AddedDate) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, customerID);
            pstmt.setString(2, instrumentID);
            pstmt.setInt(3, Integer.parseInt(quantity));

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("error");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}