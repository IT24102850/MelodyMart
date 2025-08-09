package com.melodymart.servlet;

import com.melodymart.dao.UserDAO;
import com.melodymart.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String fullName = request.getParameter("fullName").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim(); // In production, hash this password
        String country = request.getParameter("country").trim();

        // Initialize DAO
        UserDAO userDAO = new UserDAO();

        // Validate input (basic server-side validation)
        if (fullName == null || fullName.isEmpty()) {
            request.setAttribute("errorMessage", "Full name is required.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);
            return;
        }
        if (email == null || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.setAttribute("errorMessage", "Please enter a valid email address.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);
            return;
        }
        if (password == null || password.length() < 8) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);
            return;
        }
        if (country == null || country.isEmpty()) {
            request.setAttribute("errorMessage", "Please select your country.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);
            return;
        }

        // Check for existing email
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("errorMessage", "Email already exists. Please use a different email.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);
            return;
        }

        // Create new user
        User user = new User(fullName, email, password, "customer", country);
        userDAO.registerUser(user);

        // Set success message and redirect
        request.setAttribute("successMessage", "Account created successfully! Please sign in.");
        response.sendRedirect("sign-in.jsp");
    }
}