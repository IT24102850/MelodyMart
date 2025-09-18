package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.mindrot.jbcrypt.BCrypt;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import main.java.com.melodymart.util.DBConnection;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipCode");
        String country = request.getParameter("country");
        String role = request.getParameter("role");

        if (firstName == null || lastName == null || email == null || password == null || role == null || country == null ||
                firstName.trim().isEmpty() || lastName.trim().isEmpty() || email.trim().isEmpty() || password.length() < 8 || role.trim().isEmpty() || country.trim().isEmpty()) {
            response.sendRedirect("sign-up.jsp?error=All fields required");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Insert into Person
            String personSql = "INSERT INTO Person (FirstName, LastName, Email, Phone, Password, Street, City, State, ZipCode, Country, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(personSql, Statement.RETURN_GENERATED_KEYS);
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            ps.setString(1, firstName.trim());
            ps.setString(2, lastName.trim());
            ps.setString(3, email.trim().toLowerCase());
            ps.setString(4, phone);
            ps.setString(5, hashedPassword);
            ps.setString(6, street);
            ps.setString(7, city);
            ps.setString(8, state);
            ps.setString(9, zipCode);
            ps.setString(10, country);
            ps.setString(11, role.toLowerCase());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                int personId = 0;
                if (rs.next()) {
                    personId = rs.getInt(1);
                }
                rs.close();

                // Insert into subtype
                if ("customer".equalsIgnoreCase(role)) {
                    String customerSql = "INSERT INTO Customer (CustomerID, PersonID) VALUES (?, ?)";
                    PreparedStatement customerPs = con.prepareStatement(customerSql);
                    customerPs.setInt(1, personId);
                    customerPs.setInt(2, personId);
                    customerPs.executeUpdate();
                    customerPs.close();
                } else if ("seller".equalsIgnoreCase(role)) {
                    String sellerSql = "INSERT INTO Seller (SellerID, PersonID) VALUES (?, ?)";
                    PreparedStatement sellerPs = con.prepareStatement(sellerSql);
                    sellerPs.setInt(1, personId);
                    sellerPs.setInt(2, personId);
                    sellerPs.executeUpdate();
                    sellerPs.close();
                } else if ("admin".equalsIgnoreCase(role)) {
                    String adminSql = "INSERT INTO Admin (AdminID, PersonID) VALUES (?, ?)";
                    PreparedStatement adminPs = con.prepareStatement(adminSql);
                    adminPs.setInt(1, personId);
                    adminPs.setInt(2, personId);
                    adminPs.executeUpdate();
                    adminPs.close();
                }

                con.commit();

                // Set session
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email.trim().toLowerCase());
                session.setAttribute("userRole", role.toLowerCase());
                session.setAttribute("userFullName", firstName.trim() + " " + lastName.trim());
                response.sendRedirect("sign-in.jsp");
            } else {
                con.rollback();
                response.sendRedirect("sign-up.jsp?error=Registration failed");
            }
        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            System.err.println("Error in RegisterServlet: " + e.getMessage());
            response.sendRedirect("sign-up.jsp?error=Database error: " + e.getMessage());
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}