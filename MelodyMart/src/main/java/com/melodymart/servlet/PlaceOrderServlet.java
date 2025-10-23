
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import main.java.com.melodymart.util.DBConnection;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        // ✅ Ensure user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerId") == null) {
            System.out.println("⚠️ No valid session → redirecting to sign-in.jsp");
            response.sendRedirect("sign-in.jsp");
            return;
        }

        String customerId = (String) session.getAttribute("customerId");
        double totalAmount = 0.0;

        try {
            String totalParam = request.getParameter("total");
            if (totalParam != null && !totalParam.trim().isEmpty()) {
                totalAmount = Double.parseDouble(totalParam.trim());
            } else {
                System.out.println("⚠️ Missing or empty total value → using 0.0");
            }
        } catch (NumberFormatException e) {
            System.out.println("⚠️ Invalid total value → using 0.0: " + e.getMessage());
            totalAmount = 0.0;
        }

        String orderId = "ORD001";
        String customerName = "", phone = "", province = "", city = "", address = "";
        String deliveryLabel = "HOME";
        String status = "Pending";
        Timestamp createdAt = new Timestamp(System.currentTimeMillis());
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();

            // ✅ Generate next OrderID safely
            String getLastIdSQL = "SELECT TOP 1 OrderID FROM OrderNow ORDER BY OrderID DESC";
            PreparedStatement ps1 = conn.prepareStatement(getLastIdSQL);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                String lastId = rs1.getString("OrderID");
                if (lastId != null && lastId.startsWith("ORD") && lastId.length() > 3) {
                    try {
                        int num = Integer.parseInt(lastId.substring(3)) + 1;
                        orderId = String.format("ORD%03d", num);
                    } catch (NumberFormatException e) {
                        System.out.println("⚠️ Invalid last OrderID format, starting from ORD001");
                        orderId = "ORD001";
                    }
                }
            }
            rs1.close();
            ps1.close();

            // ✅ Fetch customer info
            String getCustomerSQL = "SELECT FirstName, LastName, Phone, State AS Province, City, Street AS Address FROM Person WHERE PersonID = ?";
            PreparedStatement ps2 = conn.prepareStatement(getCustomerSQL);
            ps2.setString(1, customerId.replaceAll("[^a-zA-Z0-9]", "")); // Basic sanitization
            ResultSet rs2 = ps2.executeQuery();

            if (rs2.next()) {
                String first = rs2.getString("FirstName");
                String last = rs2.getString("LastName");
                customerName = ((first != null ? first.trim() : "") + " " + (last != null ? last.trim() : "")).trim();
                phone = rs2.getString("Phone") != null ? rs2.getString("Phone").trim() : "";
                province = rs2.getString("Province") != null ? rs2.getString("Province").trim() : "";
                city = rs2.getString("City") != null ? rs2.getString("City").trim() : "";
                address = rs2.getString("Address") != null ? rs2.getString("Address").trim() : "";
            }
            rs2.close();
            ps2.close();

            // ✅ Validate customer data before inserting
            if (customerName.isEmpty() || phone.isEmpty() || province.isEmpty() || city.isEmpty() || address.isEmpty()) {
                System.out.println("❌ Incomplete customer data. Cancelling order placement.");
                response.sendRedirect("order-summary.jsp?status=fail&error=incompleteInfo");
                return;
            }

            // ✅ Insert order with transaction protection
            conn.setAutoCommit(false);

            String insertSQL = "INSERT INTO OrderNow (OrderID, CustomerName, PhoneNumber, Province, City, Address, DeliveryLabel, TotalAmount, Status, CreatedAt) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps3 = conn.prepareStatement(insertSQL);
            ps3.setString(1, orderId);
            ps3.setString(2, customerName.replaceAll("[^a-zA-Z\\s]", "")); // Basic sanitization
            ps3.setString(3, phone.replaceAll("[^0-9\\-\\+]", "")); // Sanitize phone
            ps3.setString(4, province.replaceAll("[^a-zA-Z\\s]", ""));
            ps3.setString(5, city.replaceAll("[^a-zA-Z\\s]", ""));
            ps3.setString(6, address.replaceAll("[^a-zA-Z0-9\\s#,\\-]", ""));
            ps3.setString(7, deliveryLabel);
            ps3.setDouble(8, totalAmount);
            ps3.setString(9, status);
            ps3.setTimestamp(10, createdAt);

            int inserted = ps3.executeUpdate();
            ps3.close();

            if (inserted > 0) {
                conn.commit();
                System.out.println("✅ Order placed successfully: " + orderId);
                response.sendRedirect("payment-method.jsp?status=success&orderId=" + orderId + "&amount=" + totalAmount);
            } else {
                conn.rollback();
                System.out.println("⚠️ No rows inserted — rolling back");
                response.sendRedirect("orderConfirmation.jsp?status=fail");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
                System.out.println("❌ SQL Error: " + e.getMessage());
                response.sendRedirect("orderConfirmation.jsp?status=fail&error=sqlError");
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // ✅ Redirect GET requests safely
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("payment-method.jsp");
    }
}
