package com.melodymart.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/GetCartCountServlet")
public class GetCartCountServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerId");
        if (customerId == null) {
            customerId = (String) session.getAttribute("CustomerID");
        }
        
        if (customerId == null) {
            sendJsonResponse(response, 0);
            return;
        }
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            String sql = "SELECT SUM(Quantity) as total FROM Cart WHERE CustomerID = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, customerId);
            rs = ps.executeQuery();
            
            int count = 0;
            if (rs.next()) {
                count = rs.getInt("total");
            }
            
            // Update session
            session.setAttribute("cartCount", count);
            
            sendJsonResponse(response, count);
            
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonResponse(response, 0);
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
    
    private void sendJsonResponse(HttpServletResponse response, int cartCount) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        String jsonResponse = String.format("{\"cartCount\": %d}", cartCount);
        out.print(jsonResponse);
        out.flush();
    }
}