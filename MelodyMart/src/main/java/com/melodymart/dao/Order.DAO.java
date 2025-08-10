package com.melodymart.dao;

import com.melodymart.model.Order;
import com.melodymart.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    public boolean createOrder(Order order) {
        String sql = "INSERT INTO Orders (customer_id, instrument_id, quantity, total_price, status, delivery_address) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, order.getCustomerId());
            stmt.setInt(2, order.getInstrumentId());
            stmt.setInt(3, order.getQuantity());
            stmt.setDouble(4, order.getTotalPrice());
            stmt.setString(5, order.getStatus());
            stmt.setString(6, order.getDeliveryAddress());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Order> getOrdersByCustomer(int customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE customer_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setInstrumentId(rs.getInt("instrument_id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}