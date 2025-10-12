package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/GetInstrumentServlet")
public class GetInstrumentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String instrumentId = request.getParameter("instrumentId");
        System.out.println("DEBUG: GetInstrumentServlet called with ID: " + instrumentId);
        
        if (instrumentId == null || instrumentId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM Instrument WHERE InstrumentID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, instrumentId); // Use setString
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Build JSON manually
                StringBuilder json = new StringBuilder();
                json.append("{");
                json.append("\"instrumentId\":\"").append(rs.getString("InstrumentID")).append("\",");
                json.append("\"name\":\"").append(escapeJson(rs.getString("Name"))).append("\",");
                json.append("\"description\":\"").append(escapeJson(rs.getString("Description"))).append("\",");
                json.append("\"brandId\":\"").append(escapeJson(rs.getString("BrandID"))).append("\",");
                json.append("\"model\":\"").append(escapeJson(rs.getString("Model"))).append("\",");
                json.append("\"color\":\"").append(escapeJson(rs.getString("Color"))).append("\",");
                json.append("\"price\":").append(rs.getDouble("Price")).append(",");
                json.append("\"quantity\":").append(rs.getInt("Quantity")).append(",");
                json.append("\"warranty\":\"").append(escapeJson(rs.getString("Warranty"))).append("\",");
                json.append("\"specifications\":\"").append(escapeJson(rs.getString("Specifications"))).append("\",");
                json.append("\"manufacturerId\":\"").append(escapeJson(rs.getString("ManufacturerID"))).append("\",");
                json.append("\"imageUrl\":\"").append(escapeJson(rs.getString("ImageURL"))).append("\"");
                json.append("}");
                
                System.out.println("DEBUG: Sending JSON response for instrument: " + rs.getString("Name"));
                response.getWriter().write(json.toString());
            } else {
                System.out.println("DEBUG: No instrument found with ID: " + instrumentId);
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Instrument not found\"}");
            }
            
        } catch (Exception e) {
            System.out.println("DEBUG: Error in GetInstrumentServlet: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error: " + e.getMessage() + "\"}");
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}