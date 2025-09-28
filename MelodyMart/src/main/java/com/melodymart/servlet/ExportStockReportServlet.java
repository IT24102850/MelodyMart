package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet for exporting stock report as CSV
 */
@WebServlet("/ExportStockReportServlet")
public class ExportStockReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=stock_report.csv");

        PrintWriter writer = response.getWriter();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT InstrumentID, Name, Model, Quantity, StockLevel, Price FROM Instrument ORDER BY StockLevel";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            // CSV Header
            writer.println("InstrumentID,Name,Model,Quantity,StockLevel,Price");

            // Write rows
            while (rs.next()) {
                int id = rs.getInt("InstrumentID");
                String name = rs.getString("Name");
                String model = rs.getString("Model");
                int quantity = rs.getInt("Quantity");
                String stockLevel = rs.getString("StockLevel");
                double price = rs.getDouble("Price");

                // Escape commas and quotes if needed
                String safeName = name != null ? name.replace("\"", "\"\"") : "";
                String safeModel = model != null ? model.replace("\"", "\"\"") : "";

                writer.printf("%d,\"%s\",\"%s\",%d,%s,%.2f%n",
                        id, safeName, safeModel, quantity, stockLevel, price);
            }

        } catch (Exception e) {
            e.printStackTrace();
            writer.println("Error generating report: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
            if (writer != null) writer.flush();
        }
    }
}
