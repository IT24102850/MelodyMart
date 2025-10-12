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
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;

@WebServlet("/RemoveInstrumentServlet")
public class RemoveInstrumentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String instrumentIdStr = request.getParameter("instrumentId");
        System.out.println("DEBUG: RemoveInstrumentServlet called with instrumentId: " + instrumentIdStr);

        if (instrumentIdStr == null || instrumentIdStr.trim().isEmpty()) {
            System.out.println("ERROR: Instrument ID is null or empty");
            response.sendRedirect("addInstrument.jsp?error=InstrumentIDMissing");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("DEBUG: Database connection established");

            // Check if instrument exists first
            int instrumentId;
            try {
                instrumentId = Integer.parseInt(instrumentIdStr);
                System.out.println("DEBUG: Parsed instrumentId as integer: " + instrumentId);
            } catch (NumberFormatException e) {
                System.out.println("ERROR: Invalid Instrument ID format: " + instrumentIdStr);
                response.sendRedirect("addInstrument.jsp?error=InvalidInstrumentID");
                return;
            }

            // Verify instrument exists before attempting deletion
            if (!instrumentExists(conn, instrumentId)) {
                System.out.println("ERROR: Instrument with ID " + instrumentId + " does not exist");
                response.sendRedirect("addInstrument.jsp?error=InstrumentNotFound");
                return;
            }

            // Start transaction
            conn.setAutoCommit(false);
            System.out.println("DEBUG: Transaction started");

            try {
                // Delete from dependent tables first
                String[] deleteQueries = {
                        "DELETE FROM InstrumentCategory WHERE InstrumentID = ?",
                        "DELETE FROM Cart WHERE InstrumentID = ?",
                        "DELETE FROM OrderItem WHERE InstrumentID = ?",
                        "DELETE FROM Wishlist WHERE InstrumentID = ?"
                };

                for (String query : deleteQueries) {
                    if (tableExists(conn, getTableNameFromQuery(query))) {
                        try (PreparedStatement ps = conn.prepareStatement(query)) {
                            ps.setInt(1, instrumentId);
                            int affectedRows = ps.executeUpdate();
                            System.out.println("DEBUG: Executed: " + query + " - Affected rows: " + affectedRows);
                        } catch (Exception e) {
                            System.out.println("WARN: Error executing " + query + " - " + e.getMessage());
                            // Continue with other queries
                        }
                    } else {
                        System.out.println("INFO: Table does not exist, skipping: " + getTableNameFromQuery(query));
                    }
                }

                // Finally delete the instrument itself
                String deleteInstrument = "DELETE FROM Instrument WHERE InstrumentID = ?";
                System.out.println("DEBUG: Attempting to delete instrument with query: " + deleteInstrument);

                try (PreparedStatement ps = conn.prepareStatement(deleteInstrument)) {
                    ps.setInt(1, instrumentId);
                    int rows = ps.executeUpdate();
                    System.out.println("DEBUG: Instrument delete affected rows: " + rows);

                    if (rows > 0) {
                        conn.commit();
                        System.out.println("DEBUG: Transaction committed successfully");
                        response.sendRedirect("addInstrument.jsp?success=InstrumentRemoved");
                    } else {
                        conn.rollback();
                        System.out.println("ERROR: Failed to delete instrument with ID: " + instrumentId);
                        response.sendRedirect("addInstrument.jsp?error=DeleteFailed");
                    }
                }

            } catch (Exception e) {
                conn.rollback();
                System.out.println("ERROR: Transaction rolled back due to error: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("addInstrument.jsp?error=DeleteFailed&message=" +
                        e.getMessage().replace(" ", "%20"));
            } finally {
                conn.setAutoCommit(true);
            }

        } catch (Exception e) {
            System.out.println("ERROR: Database connection error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("addInstrument.jsp?error=ServerError&message=" +
                    e.getMessage().replace(" ", "%20"));
        }
    }

    private boolean instrumentExists(Connection conn, int instrumentId) {
        String checkQuery = "SELECT 1 FROM Instrument WHERE InstrumentID = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkQuery)) {
            ps.setInt(1, instrumentId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            System.out.println("ERROR checking if instrument exists: " + e.getMessage());
            return false;
        }
    }

    private boolean tableExists(Connection conn, String tableName) {
        try {
            DatabaseMetaData dbm = conn.getMetaData();
            try (ResultSet tables = dbm.getTables(null, null, tableName, null)) {
                return tables.next();
            }
        } catch (Exception e) {
            System.out.println("ERROR checking if table exists: " + e.getMessage());
            return false;
        }
    }

    private String getTableNameFromQuery(String query) {
        // Extract table name from DELETE FROM query
        if (query.toUpperCase().startsWith("DELETE FROM")) {
            String[] parts = query.split(" ");
            if (parts.length >= 3) {
                return parts[2];
            }
        }
        return "";
    }
}