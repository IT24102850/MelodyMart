package com.melodymart.servlet;

import com.melodymart.dao.UserDAO;
import com.melodymart.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        try {
            // Check if username already exists
            User existingUser = userDAO.getUserByUsername(username);
            if (existingUser != null) {
                request.setAttribute("error", "Username already exists.");
                request.getRequestDispatcher("/sign-up.jsp").forward(request, response);
                return;
            }

            // Create new user
            User user = new User();
            user.setUsername(username);
            user.setPassword(password); // Consider hashing password in a real application
            user.setEmail(email);
            user.setRole(role);
            user.setApproved("seller".equals(role) ? false : true); // Sellers require approval, customers are auto-approved

            userDAO.addUser(user);
            request.setAttribute("message", "Registration successful. " + ("seller".equals(role) ? "Please wait for admin approval." : "You can now log in."));
            request.getRequestDispatcher("/sign-in.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error during registration", e);
        }
    }
}