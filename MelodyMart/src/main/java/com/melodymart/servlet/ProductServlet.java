package main.java.com.melodymart.servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/eyetracker";  // Update DB name
    private static final String DB_USER = "root";  // Your DB credentials
    private static final String DB_PASS = "password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ID");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            stmt = conn.prepareStatement("SELECT * FROM instruments WHERE id = ?");
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Set attributes for JSP
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("category", rs.getString("category"));
                request.setAttribute("price", rs.getDouble("price"));
                request.setAttribute("original_price", rs.getDouble("original_price"));
                request.setAttribute("image_url", rs.getString("image_url"));
                request.setAttribute("description", rs.getString("description"));
                request.setAttribute("specs", rs.getString("specs"));
                request.setAttribute("rating", rs.getDouble("rating"));
                request.setAttribute("rating_count", rs.getInt("rating_count"));
                request.setAttribute("badge", rs.getString("badge"));
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Instrument not found");
                return;
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database error", e);
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }

        request.getRequestDispatcher("/product.jsp").forward(request, response);
    }
}