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

import main.java.com.melodymart.util.DBConnection; // Import your DBConnection class

@WebServlet("/DeleteInstrument")
public class DeleteInstrumentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set response content type
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Get the instrument ID from the request
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            sendErrorResponse(response, "Invalid or missing instrument ID");
            return;
        }

        int instrumentId;
        try {
            instrumentId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            sendErrorResponse(response, "Invalid instrument ID format");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Get database connection using your DBConnection class
            conn = DBConnection.getConnection();

            // Begin transaction
            conn.setAutoCommit(false);

            // Prepare SQL statement to delete the instrument
            String sql = "DELETE FROM Instrument WHERE InstrumentID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, instrumentId);

            // Execute the delete operation
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Commit transaction if deletion is successful
                conn.commit();
                String jsonResponse = "{\"success\": true, \"message\": \"Instrument deleted successfully\"}";
                response.getWriter().write(jsonResponse);
            } else {
                // Roll back if no rows were affected
                conn.rollback();
                sendErrorResponse(response, "No instrument found with ID: " + instrumentId);
            }
        } catch (SQLException e) {
            // Roll back transaction on error
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            sendErrorResponse(response, "Database error: " + e.getMessage());
        } finally {
            // Clean up resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset auto-commit
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        String jsonResponse = "{\"success\": false, \"message\": \"" + message.replace("\"", "\\\"") + "\"}";
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write(jsonResponse);
    }
}