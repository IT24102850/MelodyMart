package main.java.com.melodymart.servlet;

import main.java.com.melodymart.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/PaymentSuccessServlet")
public class PaymentSuccessServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String paymentId = request.getParameter("paymentId");
        String orderId = request.getParameter("orderId");

        if (paymentId != null && orderId != null) {
            try (Connection conn = DBConnection.getConnection()) {
                // Get payment details
                String sql = "SELECT p.*, pm.MethodName, o.TotalAmount " +
                        "FROM Payment p " +
                        "JOIN PaymentMethod pm ON p.MethodID = pm.MethodID " +
                        "JOIN OrderTable o ON p.OrderID = o.OrderID " +
                        "WHERE p.PaymentID = ? AND p.OrderID = ?";

                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(paymentId));
                pstmt.setString(2, orderId);

                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    request.setAttribute("paymentId", paymentId);
                    request.setAttribute("orderId", orderId);
                    request.setAttribute("paymentDate", rs.getDate("PaymentDate"));
                    request.setAttribute("paymentMethod", rs.getString("MethodName"));
                    request.setAttribute("transactionStatus", rs.getString("TransactionStatus"));
                    request.setAttribute("totalAmount", rs.getDouble("TotalAmount"));

                    // If card payment, get card details
                    if (!"PM006".equals(rs.getString("MethodID"))) {
                        request.setAttribute("cardDetails", getCardDetails(conn, Integer.parseInt(paymentId)));
                    }

                    request.getRequestDispatcher("paymentSuccess.jsp").forward(request, response);
                } else {
                    response.sendRedirect("payment-not-found.jsp");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("invalid-parameters.jsp");
        }
    }

    private String getCardDetails(Connection conn, int paymentId) throws SQLException {
        String sql = "SELECT CardNumber, CardHolderName FROM CardPayment WHERE PaymentID = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, paymentId);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            String cardNumber = rs.getString("CardNumber");
            String lastFour = cardNumber.length() > 4 ?
                    cardNumber.substring(cardNumber.length() - 4) : cardNumber;
            return "Card ending with " + lastFour + " - " + rs.getString("CardHolderName");
        }
        return "Card details not available";
    }
}