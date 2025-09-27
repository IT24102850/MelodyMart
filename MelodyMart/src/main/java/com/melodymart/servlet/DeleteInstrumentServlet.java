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

import main.java.com.melodymart.util.DBConnection;

@WebServlet("/DeleteInstrument")
public class DeleteInstrumentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Validate instrument ID
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid or missing instrument ID");
            return;
        }

        int instrumentId;
        try {
            instrumentId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid instrument ID format");
            return;
        }

        // Database operation
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM Instrument WHERE InstrumentID = ?")) {

            conn.setAutoCommit(false);

            pstmt.setInt(1, instrumentId);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                conn.commit();
                sendSuccessResponse(response, "Instrument deleted successfully");
            } else {
                conn.rollback();
                sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND,
                        "No instrument found with ID: " + instrumentId);
            }

        } catch (SQLException e) {
            sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Database error: " + e.getMessage());
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_OK);
        String jsonResponse = "{\"success\": true, \"message\": \"" + escapeJson(message) + "\"}";
        response.getWriter().write(jsonResponse);
    }

    private void sendErrorResponse(HttpServletResponse response, int statusCode, String message) throws IOException {
        response.setStatus(statusCode);
        String jsonResponse = "{\"success\": false, \"message\": \"" + escapeJson(message) + "\"}";
        response.getWriter().write(jsonResponse);
    }

    private String escapeJson(String message) {
        return message.replace("\"", "\\\"");
    }
}
