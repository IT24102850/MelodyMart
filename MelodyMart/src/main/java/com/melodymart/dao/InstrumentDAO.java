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
        String sql = "INSERT INTO Instrument (Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, ImageURL, Quantity, StockLevel, ManufacturerID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        System.out.println(instrument);
        try {
            System.out.println(instrument);
            Connection conn = DatabaseUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, instrument.getName());
            stmt.setString(2, instrument.getDescription());
            stmt.setObject(3, instrument.getBrandId(), java.sql.Types.INTEGER); // Handle null
            stmt.setString(4, instrument.getModel());
            stmt.setString(5, instrument.getColor());
            stmt.setDouble(6, instrument.getPrice());
            stmt.setString(7, instrument.getSpecifications());
            stmt.setString(8, instrument.getWarranty());
            stmt.setString(9, instrument.getImageUrl());
            stmt.setInt(10, instrument.getQuantity());
            stmt.setString(11, instrument.getStockLevel());
            stmt.setObject(12, instrument.getManufacturerId(), java.sql.Types.INTEGER); // Handle null
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Database error while adding instrument: " + e.getMessage(), e);
        }
    }

    // Read an instrument by ID
    public Instrument getInstrumentById(int id) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE InstrumentID = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToInstrument(rs);
            }
            return null;
        } catch (SQLException e) {
            throw new SQLException("Database error while retrieving instrument by ID: " + e.getMessage(), e);
        }
    }

    // Read all instruments
    public List<Instrument> getAllInstruments() throws SQLException {
        String sql = "SELECT * FROM Instrument";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            List<Instrument> instruments = new ArrayList<>();
            while (rs.next()) {
                instruments.add(mapResultSetToInstrument(rs));
            }
            return instruments;
        } catch (SQLException e) {
            throw new SQLException("Database error while retrieving all instruments: " + e.getMessage(), e);
        }
    }

    // Update an existing instrument
    public void updateInstrument(Instrument instrument) throws SQLException {
        String sql = "UPDATE Instrument SET Name = ?, Description = ?, BrandID = ?, Model = ?, Color = ?, Price = ?, Specifications = ?, Warranty = ?, ImageURL = ?, Quantity = ?, StockLevel = ?, ManufacturerID = ? WHERE InstrumentID = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, instrument.getName());
            stmt.setString(2, instrument.getDescription());
            stmt.setObject(3, instrument.getBrandId(), java.sql.Types.INTEGER); // Handle null
            stmt.setString(4, instrument.getModel());
            stmt.setString(5, instrument.getColor());
            stmt.setDouble(6, instrument.getPrice());
            stmt.setString(7, instrument.getSpecifications());
            stmt.setString(8, instrument.getWarranty());
            stmt.setString(9, instrument.getImageUrl());
            stmt.setInt(10, instrument.getQuantity());
            stmt.setString(11, instrument.getStockLevel());
            stmt.setObject(12, instrument.getManufacturerId(), java.sql.Types.INTEGER); // Handle null
            stmt.setInt(13, instrument.getInstrumentId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Database error while updating instrument: " + e.getMessage(), e);
        }
    }

    // Delete an instrument by ID
    public void deleteInstrument(int id) throws SQLException {
        String sql = "DELETE FROM Instrument WHERE InstrumentID = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Database error while deleting instrument: " + e.getMessage(), e);
        }
    }

    // Helper method to map ResultSet to Instrument object
    private Instrument mapResultSetToInstrument(ResultSet rs) throws SQLException {
        Instrument instrument = new Instrument();
        instrument.setInstrumentId(rs.getInt("InstrumentID"));
        instrument.setName(rs.getString("Name"));
        instrument.setDescription(rs.getString("Description"));
        instrument.setBrandId(rs.getObject("BrandID", Integer.class)); // Handle null
        instrument.setModel(rs.getString("Model"));
        instrument.setColor(rs.getString("Color"));
        instrument.setPrice(rs.getDouble("Price"));
        instrument.setSpecifications(rs.getString("Specifications"));
        instrument.setWarranty(rs.getString("Warranty"));
        instrument.setImageUrl(rs.getString("ImageURL"));
        instrument.setQuantity(rs.getInt("Quantity"));
        instrument.setStockLevel(rs.getString("StockLevel"));
        instrument.setManufacturerId(rs.getObject("ManufacturerID", Integer.class)); // Handle null
        return instrument;
    }

    // Get instruments by category (mapped to Model for this schema)
    public List<Instrument> getInstrumentsByCategory(String category) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE Model = ?";
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
        } catch (SQLException e) {
            throw new SQLException("Database error while retrieving instruments by category: " + e.getMessage(), e);
        }
    }
}