package main.java.com.melodymart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import main.java.com.melodymart.util.DBConnection;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🧩 Collect form data
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

        // 🚨 Basic validation
        if (firstName == null || lastName == null || email == null || password == null ||
                role == null || country == null || firstName.trim().isEmpty() ||
                lastName.trim().isEmpty() || email.trim().isEmpty() ||
                password.length() < 8 || role.trim().isEmpty() || country.trim().isEmpty()) {

            response.sendRedirect("sign-up.jsp?error=All fields are required, password must be at least 8 characters.");
            return;
        }

        Connection con = null;
        PreparedStatement psPerson = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // Start transaction

            // 🧠 Hash password
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // 1️⃣ Insert into Person (trigger handles PersonID + role tables)
            String insertPerson = "INSERT INTO Person " +
                    "(FirstName, LastName, Email, Phone, Password, Street, City, State, ZipCode, Country, role) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            psPerson = con.prepareStatement(insertPerson);
            psPerson.setString(1, firstName.trim());
            psPerson.setString(2, lastName.trim());
            psPerson.setString(3, email.trim().toLowerCase());
            psPerson.setString(4, phone);
            psPerson.setString(5, hashedPassword);
            psPerson.setString(6, street);
            psPerson.setString(7, city);
            psPerson.setString(8, state);
            psPerson.setString(9, zipCode);
            psPerson.setString(10, country);
            psPerson.setString(11, role.toLowerCase());

            psPerson.executeUpdate();
            con.commit();

            // 2️⃣ Retrieve the generated PersonID for confirmation/logging
            String newPersonID = null;
            String findID = "SELECT PersonID FROM Person WHERE Email = ?";
            try (PreparedStatement psGet = con.prepareStatement(findID)) {
                psGet.setString(1, email.trim().toLowerCase());
                ResultSet rs = psGet.executeQuery();
                if (rs.next()) {
                    newPersonID = rs.getString("PersonID");
                }
                rs.close();
            }

            System.out.println("✅ Registered new person with PersonID = " + newPersonID);

            // 🧾 Start user session and redirect
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email.trim().toLowerCase());
            session.setAttribute("userRole", role.toLowerCase());
            session.setAttribute("userFullName", firstName.trim() + " " + lastName.trim());

            response.sendRedirect("sign-in.jsp");

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            response.sendRedirect("sign-up.jsp?error=Database error: " + e.getMessage());
        } finally {
            try { if (psPerson != null) psPerson.close(); } catch (SQLException ignored) {}
            try { if (con != null) con.close(); } catch (SQLException ignored) {}
        }
    }
}
