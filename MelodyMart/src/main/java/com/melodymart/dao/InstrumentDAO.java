package com.melodymart.dao;

import com.melodymart.model.Instrument;
import com.melodymart.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
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

        LOGGER.info("Adding instrument: " + instrument);

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DatabaseUtil.getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, instrument.getName());
            stmt.setString(2, instrument.getDescription());

            // Handle nullable BrandID
            if (instrument.getBrandId() != null) {
                stmt.setInt(3, instrument.getBrandId());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }

            stmt.setString(4, instrument.getModel());
            stmt.setString(5, instrument.getColor());
            stmt.setDouble(6, instrument.getPrice());
            stmt.setString(7, instrument.getSpecifications());
            stmt.setString(8, instrument.getWarranty());
            stmt.setString(9, instrument.getImageUrl());
            stmt.setInt(10, instrument.getQuantity());
            stmt.setString(11, instrument.getStockLevel());

            // Handle nullable ManufacturerID
            if (instrument.getManufacturerId() != null) {
                stmt.setInt(12, instrument.getManufacturerId());
            } else {
                stmt.setNull(12, Types.INTEGER);
            }

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Adding instrument failed, no rows affected.");
            }

            LOGGER.info("Instrument added successfully. Rows affected: " + rowsAffected);

        } catch (SQLException e) {
            LOGGER.severe("Database error while adding instrument: " + e.getMessage());
            throw new SQLException("Database error while adding instrument: " + e.getMessage(), e);
        } finally {
            // Ensure resources are properly closed
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.warning("Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    LOGGER.warning("Error closing Connection: " + e.getMessage());
                }
            }
        }
    }

    // Read an instrument by ID
    public Instrument getInstrumentById(int id) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE InstrumentID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToInstrument(rs);
                }
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error while retrieving instrument by ID " + id + ": " + e.getMessage());
            throw new SQLException("Database error while retrieving instrument by ID: " + e.getMessage(), e);
        }
    }

    // Read all instruments
    public List<Instrument> getAllInstruments() throws SQLException {
        String sql = "SELECT * FROM Instrument ORDER BY InstrumentID DESC"; // Show newest first

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            List<Instrument> instruments = new ArrayList<>();
            while (rs.next()) {
                instruments.add(mapResultSetToInstrument(rs));
            }

            LOGGER.info("Retrieved " + instruments.size() + " instruments from database");
            return instruments;

        } catch (SQLException e) {
            LOGGER.severe("Database error while retrieving all instruments: " + e.getMessage());
            throw new SQLException("Database error while retrieving all instruments: " + e.getMessage(), e);
        }
    }

    // Update an existing instrument
    public void updateInstrument(Instrument instrument) throws SQLException {
        String sql = "UPDATE Instrument SET Name = ?, Description = ?, BrandID = ?, Model = ?, " +
                "Color = ?, Price = ?, Specifications = ?, Warranty = ?, ImageURL = ?, " +
                "Quantity = ?, StockLevel = ?, ManufacturerID = ? WHERE InstrumentID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, instrument.getName());
            stmt.setString(2, instrument.getDescription());

            // Handle nullable BrandID
            if (instrument.getBrandId() != null) {
                stmt.setInt(3, instrument.getBrandId());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }

            stmt.setString(4, instrument.getModel());
            stmt.setString(5, instrument.getColor());
            stmt.setDouble(6, instrument.getPrice());
            stmt.setString(7, instrument.getSpecifications());
            stmt.setString(8, instrument.getWarranty());
            stmt.setString(9, instrument.getImageUrl());
            stmt.setInt(10, instrument.getQuantity());
            stmt.setString(11, instrument.getStockLevel());

            // Handle nullable ManufacturerID
            if (instrument.getManufacturerId() != null) {
                stmt.setInt(12, instrument.getManufacturerId());
            } else {
                stmt.setNull(12, Types.INTEGER);
            }

            stmt.setInt(13, instrument.getInstrumentId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Updating instrument failed, no rows affected. Instrument ID: " + instrument.getInstrumentId());
            }

            LOGGER.info("Instrument updated successfully. ID: " + instrument.getInstrumentId());

        } catch (SQLException e) {
            LOGGER.severe("Database error while updating instrument: " + e.getMessage());
            throw new SQLException("Database error while updating instrument: " + e.getMessage(), e);
        }
    }

    // Delete an instrument by ID
    public void deleteInstrument(int id) throws SQLException {
        String sql = "DELETE FROM Instrument WHERE InstrumentID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Deleting instrument failed, no rows affected. Instrument ID: " + id);
            }

            LOGGER.info("Instrument deleted successfully. ID: " + id);

        } catch (SQLException e) {
            LOGGER.severe("Database error while deleting instrument ID " + id + ": " + e.getMessage());
            throw new SQLException("Database error while deleting instrument: " + e.getMessage(), e);
        }
    }

    // Get instruments with low stock (quantity below a threshold)
    public List<Instrument> getLowStockInstruments(int threshold) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE Quantity <= ? ORDER BY Quantity ASC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, threshold);

            try (ResultSet rs = stmt.executeQuery()) {
                List<Instrument> instruments = new ArrayList<>();
                while (rs.next()) {
                    instruments.add(mapResultSetToInstrument(rs));
                }

                LOGGER.info("Retrieved " + instruments.size() + " low stock instruments (threshold: " + threshold + ")");
                return instruments;
            }

        } catch (SQLException e) {
            LOGGER.severe("Database error while retrieving low stock instruments: " + e.getMessage());
            throw new SQLException("Database error while retrieving low stock instruments: " + e.getMessage(), e);
        }
    }

    // Get instruments by stock level
    public List<Instrument> getInstrumentsByStockLevel(String stockLevel) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE StockLevel = ? ORDER BY Name";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, stockLevel);

            try (ResultSet rs = stmt.executeQuery()) {
                List<Instrument> instruments = new ArrayList<>();
                while (rs.next()) {
                    instruments.add(mapResultSetToInstrument(rs));
                }
                return instruments;
            }

        } catch (SQLException e) {
            LOGGER.severe("Database error while retrieving instruments by stock level: " + e.getMessage());
            throw new SQLException("Database error while retrieving instruments by stock level: " + e.getMessage(), e);
        }
    }

    // Get instruments by brand ID
    public List<Instrument> getInstrumentsByBrand(int brandId) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE BrandID = ? ORDER BY Name";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, brandId);

            try (ResultSet rs = stmt.executeQuery()) {
                List<Instrument> instruments = new ArrayList<>();
                while (rs.next()) {
                    instruments.add(mapResultSetToInstrument(rs));
                }
                return instruments;
            }

        } catch (SQLException e) {
            LOGGER.severe("Database error while retrieving instruments by brand: " + e.getMessage());
            throw new SQLException("Database error while retrieving instruments by brand: " + e.getMessage(), e);
        }
    }

    // Search instruments by name (partial match)
    public List<Instrument> searchInstrumentsByName(String searchTerm) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE Name LIKE ? ORDER BY Name";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + searchTerm + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                List<Instrument> instruments = new ArrayList<>();
                while (rs.next()) {
                    instruments.add(mapResultSetToInstrument(rs));
                }
                return instruments;
            }

        } catch (SQLException e) {
            LOGGER.severe("Database error while searching instruments: " + e.getMessage());
            throw new SQLException("Database error while searching instruments: " + e.getMessage(), e);
        }
    }

    // Update stock level for an instrument
    public void updateStockLevel(int instrumentId, int newQuantity, String stockLevel) throws SQLException {
        String sql = "UPDATE Instrument SET Quantity = ?, StockLevel = ? WHERE InstrumentID = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, newQuantity);
            stmt.setString(2, stockLevel);
            stmt.setInt(3, instrumentId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Updating stock level failed, no rows affected. Instrument ID: " + instrumentId);
            }

            LOGGER.info("Stock level updated successfully. ID: " + instrumentId + ", Quantity: " + newQuantity + ", Level: " + stockLevel);

        } catch (SQLException e) {
            LOGGER.severe("Database error while updating stock level: " + e.getMessage());
            throw new SQLException("Database error while updating stock level: " + e.getMessage(), e);
        }
    }

    // Helper method to map ResultSet to Instrument object
    private Instrument mapResultSetToInstrument(ResultSet rs) throws SQLException {
        Instrument instrument = new Instrument();
        instrument.setInstrumentId(rs.getInt("InstrumentID"));
        instrument.setName(rs.getString("Name"));
        instrument.setDescription(rs.getString("Description"));

        // Handle nullable BrandID
        Integer brandId = rs.getObject("BrandID", Integer.class);
        instrument.setBrandId(brandId);

        instrument.setModel(rs.getString("Model"));
        instrument.setColor(rs.getString("Color"));
        instrument.setPrice(rs.getDouble("Price"));
        instrument.setSpecifications(rs.getString("Specifications"));
        instrument.setWarranty(rs.getString("Warranty"));
        instrument.setImageUrl(rs.getString("ImageURL"));
        instrument.setQuantity(rs.getInt("Quantity"));
        instrument.setStockLevel(rs.getString("StockLevel"));

        // Handle nullable ManufacturerID
        Integer manufacturerId = rs.getObject("ManufacturerID", Integer.class);
        instrument.setManufacturerId(manufacturerId);

        return instrument;
    }

    // Get instruments by category (mapped to Model for this schema)
    public List<Instrument> getInstrumentsByCategory(String category) throws SQLException {
        String sql = "SELECT * FROM Instrument WHERE Model = ? ORDER BY Name";

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
            LOGGER.severe("Database error while retrieving instruments by category: " + e.getMessage());
            throw new SQLException("Database error while retrieving instruments by category: " + e.getMessage(), e);
        }
    }
}