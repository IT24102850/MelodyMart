package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/GetCartCountServlet")
public class GetCartCountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        // Use the CustomerID from your database
        String customerID = "CU001"; // Changed from CUST001 to CU001

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT SUM(Quantity) as total FROM Cart WHERE CustomerID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, customerID);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("total");
                // If count is null (no items), return 0
                response.getWriter().write(String.valueOf(count));
                System.out.println("Cart count for customer " + customerID + ": " + count);
            } else {
                response.getWriter().write("0");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("0");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}