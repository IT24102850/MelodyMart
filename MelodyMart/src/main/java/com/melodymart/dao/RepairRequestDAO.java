package com.melodymart.dao;

import com.melodymart.model.RepairRequest;
import com.melodymart.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RepairRequestDAO {
    public boolean createRepairRequest(RepairRequest request) {
        String sql = "INSERT INTO RepairRequests (customer_id, instrument_id, issue_description, status, estimated_cost) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, request.getCustomerId());
            stmt.setInt(2, request.getInstrumentId());
            stmt.setString(3, request.getIssueDescription());
            stmt.setString(4, request.getStatus());
            stmt.setBigDecimal(5, request.getEstimatedCost() != null ? new java.math.BigDecimal(request.getEstimatedCost()) : null);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<RepairRequest> getRepairRequestsByCustomer(int customerId) {
        List<RepairRequest> requests = new ArrayList<>();
        String sql = "SELECT * FROM RepairRequests WHERE customer_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                RepairRequest request = new RepairRequest();
                request.setId(rs.getInt("id"));
                request.setCustomerId(rs.getInt("customer_id"));
                request.setInstrumentId(rs.getInt("instrument_id"));
                request.setIssueDescription(rs.getString("issue_description"));
                request.setStatus(rs.getString("status"));
                request.setEstimatedCost(rs.getBigDecimal("estimated_cost") != null ? rs.getBigDecimal("estimated_cost").doubleValue() : null);
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
}
