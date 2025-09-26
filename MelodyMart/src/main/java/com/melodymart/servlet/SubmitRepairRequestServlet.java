package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.com.melodymart.util.DBConnection;

@WebServlet("/SubmitRepairRequestServlet")
public class SubmitRepairRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        // ✅ safely parse orderId
        int orderId = -1;
        try {
            orderId = Integer.parseInt(request.getParameter("orderId"));
        } catch (NumberFormatException e) {
            response.sendRedirect("customerlanding.jsp?error=invalidOrder");
            return;
        }

        String issueDescription = request.getParameter("issueDescription");
        String repairDate = request.getParameter("repairDate");
        String photos = request.getParameter("photos"); // later: handle real file uploads

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO RepairRequest (OrderID, IssueDescription, Photos, RepairDate) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            stmt.setString(2, issueDescription);
            stmt.setString(3, photos);
            stmt.setString(4, repairDate);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                // ✅ success redirect
                response.sendRedirect("customerlanding.jsp?success=repair");
            } else {
                response.sendRedirect("customerlanding.jsp?error=repair");
            }

        } catch (SQLException e) {
            e.printStackTrace(); // log to Tomcat console
            // ✅ show DB error
            response.sendRedirect("customerlanding.jsp?error=db");
        }
    }
}
