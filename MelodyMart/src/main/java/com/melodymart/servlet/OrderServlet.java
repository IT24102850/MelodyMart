package main.java.com.melodymart.controller;

import main.java.com.melodymart.dao.OrderDAO;
import main.java.com.melodymart.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "view":
                    viewOrder(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "list":
                default:
                    listOrders(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "update":
                    updateOrder(request, response);
                    break;
                case "delete":
                    deleteOrder(request, response);
                    break;
                default:
                    listOrders(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
    
    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        int[] stats = orderDAO.getOrderStatistics();
        
        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", stats[0]);
        request.setAttribute("pendingOrders", stats[1]);
        request.setAttribute("processingOrders", stats[2]);
        request.setAttribute("deliveredOrders", stats[3]);
        
        request.getRequestDispatcher("/order-management.jsp").forward(request, response);
    }
    
    private void viewOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String orderId = request.getParameter("id");
        Order order = orderDAO.getOrderById(orderId);
        request.setAttribute("order", order);
        request.getRequestDispatcher("/order-details.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String orderId = request.getParameter("id");
        Order order = orderDAO.getOrderById(orderId);
        request.setAttribute("order", order);
        request.getRequestDispatcher("/edit-orders.jsp").forward(request, response);
    }
    
    private void updateOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        String street = request.getParameter("street");
        String postalCode = request.getParameter("postalCode");
        
        Order order = new Order();
        order.setOrderID(orderId);
        order.setStatus(status);
        order.setStreet(street);
        order.setPostalCode(postalCode);
        
        orderDAO.updateOrder(order);
        response.sendRedirect("orders?action=list");
    }
    
    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String orderId = request.getParameter("id");
        orderDAO.deleteOrder(orderId);
        response.sendRedirect("orders?action=list");
    }
}