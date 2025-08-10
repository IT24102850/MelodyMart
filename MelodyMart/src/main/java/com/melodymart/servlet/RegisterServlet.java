package com.melodymart.servlet;

import com.melodymart.dao.UserDAO;
import com.melodymart.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String country = request.getParameter("country");

        User user = new User(0, fullName, email, password, role, null, null, country);
        UserDAO userDAO = new UserDAO();

        try {
            if (userDAO.registerUser(user)) {
                request.setAttribute("successMessage", "Registration successful! Please sign in.");
                request.getRequestDispatcher("sign-in.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration failed. Email may already be in use.");
                request.getRequestDispatcher("sign-up.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);
        }
    }
}