package com.melodymart.dao;

import com.melodymart.model.Instrument;
import com.melodymart.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InstrumentDAO {
    // Create a new instrument in the database
    public void addInstrument(Instrument instrument) throws SQLException {
        String sql = "INSERT INTO instruments (name, brand, price, category, description, image_url, stock, available) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, instrument.getName());
            stmt.setString(2, instrument.getBrand());
            stmt.setDouble(3, instrument.getPrice());
            stmt.setString(4, instrument.getCategory());
            stmt.setString(5, instrument.getDescription());
            stmt.setString(6, instrument.getImageUrl());
            stmt.setInt(7, instrument.getStock());
            stmt.setBoolean(8, instrument.isAvailable());
            stmt.executeUpdate();
        }
    }

    // Read an instrument by ID
    public Instrument getInstrumentById(int id) throws SQLException {
        String sql = "SELECT * FROM instruments WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToInstrument(rs);
            }
            return null;
        }
    }

    // Read all instruments
    public List<Instrument> getAllInstruments() throws SQLException {
        String sql = "SELECT * FROM instruments";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            List<Instrument> instruments = new ArrayList<>();
            while (rs.next()) {
                instruments.add(mapResultSetToInstrument(rs));
            }
            return instruments;
        }
    }

    // Update an existing instrument
    public void updateInstrument(Instrument instrument) throws SQLException {
        String sql = "UPDATE instruments SET name = ?, brand = ?, price = ?, category = ?, description = ?, image_url = ?, stock = ?, available = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, instrument.getName());
            stmt.setString(2, instrument.getBrand());
            stmt.setDouble(3, instrument.getPrice());
            stmt.setString(4, instrument.getCategory());
            stmt.setString(5, instrument.getDescription());
            stmt.setString(6, instrument.getImageUrl());
            stmt.setInt(7, instrument.getStock());
            stmt.setBoolean(8, instrument.isAvailable());
            stmt.setInt(9, instrument.getId());
            stmt.executeUpdate();
        }
    }

    // Delete an instrument by ID
    public void deleteInstrument(int id) throws SQLException {
        String sql = "DELETE FROM instruments WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // Helper method to map ResultSet to Instrument object
    private Instrument mapResultSetToInstrument(ResultSet rs) throws SQLException {
        Instrument instrument = new Instrument();
        instrument.setId(rs.getInt("id"));
        instrument.setName(rs.getString("name"));
        instrument.setBrand(rs.getString("brand"));
        instrument.setPrice(rs.getDouble("price"));
        instrument.setCategory(rs.getString("category"));
        instrument.setDescription(rs.getString("description"));
        instrument.setImageUrl(rs.getString("image_url"));
        instrument.setStock(rs.getInt("stock"));
        instrument.setAvailable(rs.getBoolean("available"));
        return instrument;
    }

    public List<Instrument> getInstrumentsByCategory(String category) throws SQLException {
        String sql = "SELECT * FROM instruments WHERE category = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            try (ResultSet rs = stmt.executeQuery()) {
                List<Instrument> instruments = new ArrayList<>();
                while (rs.next()) {
                    instruments.add(mapResultSetToInstrument(rs));
                }
                return instruments;
            }
        }
    }
}