package main.java.com.melodymart.dao;

import main.java.com.melodymart.model.Order;
import main.java.com.melodymart.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    
    // Get all orders
    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT OrderID, OrderDate, TotalAmount, Status, Street, PostalCode, CustomerID FROM OrderTable ORDER BY OrderDate DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getString("OrderID"));
                order.setOrderDate(rs.getDate("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                order.setStreet(rs.getString("Street"));
                order.setPostalCode(rs.getString("PostalCode"));
                order.setCustomerID(rs.getString("CustomerID"));
                orders.add(order);
            }
        }
        return orders;
    }
    
    // Get order by ID
    public Order getOrderById(String orderId) throws SQLException {
        String sql = "SELECT OrderID, OrderDate, TotalAmount, Status, Street, PostalCode, CustomerID FROM OrderTable WHERE OrderID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setOrderID(rs.getString("OrderID"));
                    order.setOrderDate(rs.getDate("OrderDate"));
                    order.setTotalAmount(rs.getDouble("TotalAmount"));
                    order.setStatus(rs.getString("Status"));
                    order.setStreet(rs.getString("Street"));
                    order.setPostalCode(rs.getString("PostalCode"));
                    order.setCustomerID(rs.getString("CustomerID"));
                    return order;
                }
            }
        }
        return null;
    }
    
    // Update order
    public boolean updateOrder(Order order) throws SQLException {
        String sql = "UPDATE OrderTable SET Status = ?, Street = ?, PostalCode = ? WHERE OrderID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, order.getStatus());
            stmt.setString(2, order.getStreet());
            stmt.setString(3, order.getPostalCode());
            stmt.setString(4, order.getOrderID());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    // Delete order
    public boolean deleteOrder(String orderId) throws SQLException {
        String sql = "DELETE FROM OrderTable WHERE OrderID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, orderId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    // Get order statistics
    public int[] getOrderStatistics() throws SQLException {
        int[] stats = new int[4]; // total, pending, processing, delivered
        
        String sql = "SELECT " +
                     "COUNT(*) as total, " +
                     "SUM(CASE WHEN Status = 'Pending' THEN 1 ELSE 0 END) as pending, " +
                     "SUM(CASE WHEN Status = 'Processing' THEN 1 ELSE 0 END) as processing, " +
                     "SUM(CASE WHEN Status = 'Delivered' THEN 1 ELSE 0 END) as delivered " +
                     "FROM OrderTable";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                stats[0] = rs.getInt("total");
                stats[1] = rs.getInt("pending");
                stats[2] = rs.getInt("processing");
                stats[3] = rs.getInt("delivered");
            }
        }
        return stats;
    }
}