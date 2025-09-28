package com.melodymart.dao;

import com.melodymart.model.Instrument;
import com.melodymart.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class InstrumentDAO {
    private static final Logger LOGGER = Logger.getLogger(InstrumentDAO.class.getName());

    // Create a new instrument in the database
    public void addInstrument(Instrument instrument) throws SQLException {
        String sql = "INSERT INTO Instrument (Name, Description, BrandID, Model, Color, Price, " +
                "Specifications, Warranty, ImageURL, Quantity, StockLevel, ManufacturerID) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, instrument.getName());
            stmt.setString(2, instrument.getDescription());

            if (instrument.getBrandId() != null) {
                stmt.setInt(3, instrument.getBrandId());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }

            stmt.setString(4, instrument.getModel());
            stmt.setString(5, instrument.getColor());
            stmt.setDouble(6, instrument.getPrice()); // ✅ double
            stmt.setString(7, instrument.getSpecifications());
            stmt.setString(8, instrument.getWarranty());
            stmt.setString(9, instrument.getImageUrl());
            stmt.setInt(10, instrument.getQuantity());
            stmt.setString(11, instrument.getStockLevel());

            if (instrument.getManufacturerId() != null) {
                stmt.setInt(12, instrument.getManufacturerId());
            } else {
                stmt.setNull(12, Types.INTEGER);
            }

            int rows = stmt.executeUpdate();
            LOGGER.info("✅ Instrument added. Rows affected: " + rows);

        } catch (SQLException e) {
            LOGGER.severe("❌ Error adding instrument: " + e.getMessage());
            throw e;
        }
    }

    // Get instrument by ID
    public Instrument getInstrumentById(int id) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE InstrumentID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? mapResultSetToInstrument(rs) : null;
            }
        }
    }

    // Get all instruments
    public List<Instrument> getAllInstruments() throws SQLException {
        String sql = "SELECT * FROM Instrument ORDER BY InstrumentID DESC";
        List<Instrument> instruments = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                instruments.add(mapResultSetToInstrument(rs));
            }
        }
        LOGGER.info("✅ Retrieved instruments: " + instruments.size());
        return instruments;
    }

    // Update instrument
    public void updateInstrument(Instrument instrument) throws SQLException {
        String sql = "UPDATE Instrument SET Name=?, Description=?, BrandID=?, Model=?, Color=?, " +
                "Price=?, Specifications=?, Warranty=?, ImageURL=?, Quantity=?, StockLevel=?, ManufacturerID=? " +
                "WHERE InstrumentID=?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, instrument.getName());
            stmt.setString(2, instrument.getDescription());

            if (instrument.getBrandId() != null) {
                stmt.setInt(3, instrument.getBrandId());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }

            stmt.setString(4, instrument.getModel());
            stmt.setString(5, instrument.getColor());
            stmt.setDouble(6, instrument.getPrice()); // ✅ double
            stmt.setString(7, instrument.getSpecifications());
            stmt.setString(8, instrument.getWarranty());
            stmt.setString(9, instrument.getImageUrl());
            stmt.setInt(10, instrument.getQuantity());
            stmt.setString(11, instrument.getStockLevel());

            if (instrument.getManufacturerId() != null) {
                stmt.setInt(12, instrument.getManufacturerId());
            } else {
                stmt.setNull(12, Types.INTEGER);
            }

            stmt.setInt(13, instrument.getInstrumentId());

            int rows = stmt.executeUpdate();
            LOGGER.info("✅ Instrument updated. Rows affected: " + rows);
        }
    }

    // Delete instrument
    public void deleteInstrument(int id) throws SQLException {
        String sql = "DELETE FROM Instrument WHERE InstrumentID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rows = stmt.executeUpdate();
            LOGGER.info("✅ Instrument deleted. Rows affected: " + rows);
        }
    }

    // Get low stock instruments
    public List<Instrument> getLowStockInstruments(int threshold) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE Quantity <= ? ORDER BY Quantity ASC";
        List<Instrument> instruments = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, threshold);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    instruments.add(mapResultSetToInstrument(rs));
                }
            }
        }
        return instruments;
    }

    // Get instruments by stock level
    public List<Instrument> getInstrumentsByStockLevel(String stockLevel) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE StockLevel = ? ORDER BY Name";
        List<Instrument> instruments = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, stockLevel);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    instruments.add(mapResultSetToInstrument(rs));
                }
            }
        }
        return instruments;
    }

    // Get instruments by brand
    public List<Instrument> getInstrumentsByBrand(int brandId) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE BrandID = ? ORDER BY Name";
        List<Instrument> instruments = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, brandId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    instruments.add(mapResultSetToInstrument(rs));
                }
            }
        }
        return instruments;
    }

    // Search instruments by name
    public List<Instrument> searchInstrumentsByName(String searchTerm) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE Name LIKE ? ORDER BY Name";
        List<Instrument> instruments = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + searchTerm + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    instruments.add(mapResultSetToInstrument(rs));
                }
            }
        }
        return instruments;
    }

    // Update stock level
    public void updateStockLevel(int instrumentId, int newQuantity, String stockLevel) throws SQLException {
        String sql = "UPDATE Instrument SET Quantity=?, StockLevel=? WHERE InstrumentID=?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, newQuantity);
            stmt.setString(2, stockLevel);
            stmt.setInt(3, instrumentId);

            int rows = stmt.executeUpdate();
            LOGGER.info("✅ Stock updated for InstrumentID " + instrumentId + ", rows affected: " + rows);
        }
    }

    // Map ResultSet → Instrument
    private Instrument mapResultSetToInstrument(ResultSet rs) throws SQLException {
        Instrument instrument = new Instrument();
        instrument.setInstrumentId(rs.getInt("InstrumentID"));
        instrument.setName(rs.getString("Name"));
        instrument.setDescription(rs.getString("Description"));
        instrument.setBrandId((Integer) rs.getObject("BrandID"));
        instrument.setModel(rs.getString("Model"));
        instrument.setColor(rs.getString("Color"));
        instrument.setPrice(rs.getDouble("Price")); // ✅ double
        instrument.setSpecifications(rs.getString("Specifications"));
        instrument.setWarranty(rs.getString("Warranty"));
        instrument.setImageUrl(rs.getString("ImageURL"));
        instrument.setQuantity(rs.getInt("Quantity"));
        instrument.setStockLevel(rs.getString("StockLevel"));
        instrument.setManufacturerId((Integer) rs.getObject("ManufacturerID"));
        return instrument;
    }
}
