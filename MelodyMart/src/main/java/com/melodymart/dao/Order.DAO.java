package com.melodymart.dao;

import com.melodymart.model.Instrument;
import com.melodymart.model.Order;
import com.melodymart.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDAO {
    // Create a new order in the database
    public void addOrder(Order order) throws SQLException {
        String sql = "INSERT INTO orders (user_id, total_price, order_date, status, delivery_address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, order.getUserId());
            stmt.setDouble(2, order.getTotalPrice());
            stmt.setDate(3, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setString(4, order.getStatus());
            stmt.setString(5, order.getDeliveryAddress());
            stmt.executeUpdate();

            // Get the generated order ID
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                int orderId = rs.getInt(1);
                order.setId(orderId);
                // Associate instruments with the order in a separate table (order_items)
                addOrderItems(orderId, order.getInstruments());
            }
        }
    }

    // Read an order by ID
    public Order getOrderById(int id) throws SQLException {
        String sql = "SELECT * FROM orders WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
            return null;
        }
    }

    // Read all orders for a user
    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE user_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            List<Order> orders = new ArrayList<>();
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
            return orders;
        }
    }

    // Update an existing order
    public void updateOrder(Order order) throws SQLException {
        String sql = "UPDATE orders SET user_id = ?, total_price = ?, order_date = ?, status = ?, delivery_address = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, order.getUserId());
            stmt.setDouble(2, order.getTotalPrice());
            stmt.setDate(3, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setString(4, order.getStatus());
            stmt.setString(5, order.getDeliveryAddress());
            stmt.setInt(6, order.getId());
            stmt.executeUpdate();

            // Update associated instruments in order_items table
            updateOrderItems(order.getId(), order.getInstruments());
        }
    }

    // Delete an order by ID
    public void deleteOrder(int id) throws SQLException {
        String sql = "DELETE FROM orders WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // Update order status
    public void updateOrderStatus(int id, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        }
    }

    // Helper method to map ResultSet to Order object
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setTotalPrice(rs.getDouble("total_price"));
        order.setOrderDate(rs.getDate("order_date"));
        order.setStatus(rs.getString("status"));
        order.setDeliveryAddress(rs.getString("delivery_address"));
        // Fetch associated instruments from order_items table
        order.setInstruments(getOrderInstruments(order.getId()));
        return order;
    }

    // Helper method to add order items (instruments) to a separate table
    private void addOrderItems(int orderId, List<Instrument> instruments) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, instrument_id) VALUES (?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (Instrument instrument : instruments) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, instrument.getId());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    // Helper method to update order items
    private void updateOrderItems(int orderId, List<Instrument> instruments) throws SQLException {
        // First delete existing items
        String deleteSql = "DELETE FROM order_items WHERE order_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
            deleteStmt.setInt(1, orderId);
            deleteStmt.executeUpdate();
        }
        // Then add new items
        addOrderItems(orderId, instruments);
    }

    // Helper method to get instruments for an order
    private List<Instrument> getOrderInstruments(int orderId) throws SQLException {
        String sql = "SELECT i.* FROM instruments i JOIN order_items oi ON i.id = oi.instrument_id WHERE oi.order_id = ?";
        List<Instrument> instruments = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                instruments.add(new InstrumentDAO().mapResultSetToInstrument(rs));
            }
        }
        return instruments;
    }
}