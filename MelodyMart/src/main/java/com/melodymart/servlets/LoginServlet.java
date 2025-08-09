package com.melodymart.servlet;

import com.melodymart.dao.UserDAO;
import com.melodymart.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            User user = userDAO.getUserByUsername(username);
            if (user != null && user.getPassword().equals(password)) { // In a real app, use hashed password comparison
                if (user.isApproved() || "customer".equals(user.getRole())) { // Only approved users or customers can log in
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    String role = user.getRole();
                    if ("admin".equals(role)) {
                        response.sendRedirect("admin-dashboard.html");
                    } else if ("seller".equals(role)) {
                        response.sendRedirect("seller-dashboard.html");
                    } else {
                        response.sendRedirect("user-dashboard.html");
                    }
                } else {
                    request.setAttribute("error", "Account not approved yet.");
                    request.getRequestDispatcher("/sign-in.html").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Invalid username or password.");
                request.getRequestDispatcher("/sign-in.html").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error during login", e);
        }
    }
}