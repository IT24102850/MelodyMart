package main.java.com.melodymart.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import main.java.com.melodymart.util.DBConnection;

@WebServlet("/InstrumentManagementServlet")
@MultipartConfig(maxFileSize = 10485760) // 10MB limit per file
public class InstrumentManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";
    private static final int MAX_IMAGES = 5;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Connection conn = null;
        PrintWriter out = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            response.setContentType("text/plain");
            out = response.getWriter();

            if ("list".equals(action)) {
                List<Instrument> instruments = new ArrayList<>();
                // SQL Server compatible query using STRING_AGG
                String sql = "SELECT i.InstrumentID, i.Name, i.Description, i.BrandID, i.Model, i.Color, " +
                        "i.Price, i.Specifications, i.Warranty, i.Quantity, i.StockLevel, i.ManufacturerID, " +
                        "STRING_AGG(ii.ImageURL, ',') WITHIN GROUP (ORDER BY ii.ImageID) as images " +
                        "FROM Instrument i " +
                        "LEFT JOIN InstrumentImages ii ON i.InstrumentID = ii.InstrumentID " +
                        "GROUP BY i.InstrumentID, i.Name, i.Description, i.BrandID, i.Model, i.Color, " +
                        "i.Price, i.Specifications, i.Warranty, i.Quantity, i.StockLevel, i.ManufacturerID";

                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    Instrument instrument = new Instrument(
                            rs.getString("InstrumentID"),
                            rs.getString("Name"),
                            rs.getString("Description"),
                            rs.getString("BrandID"),
                            rs.getString("Model"),
                            rs.getString("Color"),
                            rs.getDouble("Price"),
                            rs.getString("Specifications"),
                            rs.getString("Warranty"),
                            rs.getInt("Quantity"),
                            rs.getString("StockLevel"),
                            rs.getString("ManufacturerID")
                    );
                    String images = rs.getString("images");
                    if (images != null) {
                        instrument.setImages(images.split(","));
                    }
                    instruments.add(instrument);
                }

                StringBuilder result = new StringBuilder();
                for (Instrument inst : instruments) {
                    result.append(String.join("|",
                            inst.instrumentID != null ? inst.instrumentID : "",
                            inst.name != null ? inst.name : "",
                            inst.description != null ? inst.description : "",
                            inst.brandID != null ? inst.brandID : "",
                            inst.model != null ? inst.model : "",
                            inst.color != null ? inst.color : "",
                            String.valueOf(inst.price),
                            inst.specifications != null ? inst.specifications : "",
                            inst.warranty != null ? inst.warranty : "",
                            String.valueOf(inst.quantity),
                            inst.stockLevel != null ? inst.stockLevel : "",
                            inst.manufacturerID != null ? inst.manufacturerID : "",
                            inst.images != null ? String.join(",", inst.images) : "")
                    ).append("\n");
                }
                out.write(result.toString());

            } else if ("get".equals(action)) {
                String id = request.getParameter("id");
                if (id != null && !id.trim().isEmpty()) {
                    Instrument instrument = getInstrumentById(conn, id);
                    if (instrument != null) {
                        out.write(String.join("|",
                                "SUCCESS",
                                instrument.instrumentID != null ? instrument.instrumentID : "",
                                instrument.name != null ? instrument.name : "",
                                instrument.description != null ? instrument.description : "",
                                instrument.brandID != null ? instrument.brandID : "",
                                instrument.model != null ? instrument.model : "",
                                instrument.color != null ? instrument.color : "",
                                String.valueOf(instrument.price),
                                instrument.specifications != null ? instrument.specifications : "",
                                instrument.warranty != null ? instrument.warranty : "",
                                String.valueOf(instrument.quantity),
                                instrument.stockLevel != null ? instrument.stockLevel : "",
                                instrument.manufacturerID != null ? instrument.manufacturerID : "",
                                instrument.images != null ? String.join(",", instrument.images) : ""));
                    } else {
                        out.write("ERROR|Instrument not found");
                    }
                } else {
                    out.write("ERROR|Invalid instrument ID");
                }
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("ERROR|Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs, out);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Connection conn = null;
        PrintWriter out = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            response.setContentType("text/plain");
            out = response.getWriter();

            if ("save".equals(action)) {
                // Session validation
                String userRole = (String) request.getSession().getAttribute("userRole");
                if (userRole == null || !userRole.equalsIgnoreCase("seller")) {
                    response.sendRedirect(request.getContextPath() + "/sign-in.jsp?status=error&message=" +
                            java.net.URLEncoder.encode("Access denied. Please log in as a seller.", "UTF-8"));
                    return;
                }

                String instrumentID = request.getParameter("instrumentID");
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String brandID = request.getParameter("brandID");
                String model = request.getParameter("model");
                String color = request.getParameter("color");
                double price = Double.parseDouble(request.getParameter("price"));
                String specifications = request.getParameter("specifications");
                String warranty = request.getParameter("warranty");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String stockLevel = request.getParameter("stockLevel");
                String manufacturerID = request.getParameter("manufacturerID");

                // Validate required fields
                if (name == null || name.trim().isEmpty() || brandID == null || brandID.trim().isEmpty() ||
                        manufacturerID == null || manufacturerID.trim().isEmpty()) {
                    throw new IllegalArgumentException("Required fields are missing");
                }

                if (instrumentID == null || instrumentID.isEmpty()) {
                    // Generate new instrument ID
                    String newInstrumentID = generateInstrumentID(conn);

                    String sql = "INSERT INTO Instrument (InstrumentID, Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, Quantity, StockLevel, ManufacturerID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, newInstrumentID);
                    ps.setString(2, name);
                    ps.setString(3, description);
                    ps.setString(4, brandID);
                    ps.setString(5, model);
                    ps.setString(6, color);
                    ps.setDouble(7, price);
                    ps.setString(8, specifications);
                    ps.setString(9, warranty);
                    ps.setInt(10, quantity);
                    ps.setString(11, stockLevel);
                    ps.setString(12, manufacturerID);
                    ps.executeUpdate();
                    instrumentID = newInstrumentID;
                } else {
                    String sql = "UPDATE Instrument SET Name = ?, Description = ?, BrandID = ?, Model = ?, Color = ?, Price = ?, Specifications = ?, Warranty = ?, Quantity = ?, StockLevel = ?, ManufacturerID = ? WHERE InstrumentID = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, name);
                    ps.setString(2, description);
                    ps.setString(3, brandID);
                    ps.setString(4, model);
                    ps.setString(5, color);
                    ps.setDouble(6, price);
                    ps.setString(7, specifications);
                    ps.setString(8, warranty);
                    ps.setInt(9, quantity);
                    ps.setString(10, stockLevel);
                    ps.setString(11, manufacturerID);
                    ps.setString(12, instrumentID);
                    ps.executeUpdate();

                    // Delete existing images
                    PreparedStatement deleteImages = conn.prepareStatement("DELETE FROM InstrumentImages WHERE InstrumentID = ?");
                    deleteImages.setString(1, instrumentID);
                    deleteImages.executeUpdate();
                    deleteImages.close();
                }

                // Handle image uploads
                if (instrumentID != null) {
                    int imageCount = 0;
                    for (Part part : request.getParts()) {
                        if (part.getName().equals("imageFile") && part.getSize() > 0 && imageCount < MAX_IMAGES) {
                            if (!part.getContentType().startsWith("image/")) {
                                throw new IOException("Invalid file type. Only images are allowed.");
                            }
                            String imageURL = uploadImage(request, part);
                            String imageSql = "INSERT INTO InstrumentImages (InstrumentID, ImageURL) VALUES (?, ?)";
                            PreparedStatement imagePs = conn.prepareStatement(imageSql);
                            imagePs.setString(1, instrumentID);
                            imagePs.setString(2, imageURL);
                            imagePs.executeUpdate();
                            imagePs.close();
                            imageCount++;
                        }
                    }
                }

                conn.commit(); // Commit transaction
                out.write("SUCCESS|Instrument saved successfully");

            }
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("ERROR|Database error: " + e.getMessage());
            e.printStackTrace();
        } catch (NumberFormatException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("ERROR|Invalid number format: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("ERROR|" + e.getMessage());
        } catch (IOException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("ERROR|File error: " + e.getMessage());
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("ERROR|Unexpected error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            closeResources(conn, ps, rs, out);
        }
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Connection conn = null;
        PrintWriter out = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            response.setContentType("text/plain");
            out = response.getWriter();

            if ("delete".equals(action)) {
                String id = request.getParameter("id");
                if (id != null && !id.trim().isEmpty()) {
                    // Delete images first
                    ps = conn.prepareStatement("DELETE FROM InstrumentImages WHERE InstrumentID = ?");
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    // Delete instrument
                    ps = conn.prepareStatement("DELETE FROM Instrument WHERE InstrumentID = ?");
                    ps.setString(1, id);
                    int rowsAffected = ps.executeUpdate();

                    if (rowsAffected > 0) {
                        conn.commit();
                        out.write("SUCCESS|Instrument deleted successfully");
                    } else {
                        conn.rollback();
                        out.write("ERROR|Instrument not found");
                    }
                } else {
                    out.write("ERROR|Invalid instrument ID");
                }
            }
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("ERROR|Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            closeResources(conn, ps, null, out);
        }
    }

    private Instrument getInstrumentById(Connection conn, String id) throws SQLException {
        Instrument instrument = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // SQL Server compatible query using STRING_AGG
            String sql = "SELECT i.InstrumentID, i.Name, i.Description, i.BrandID, i.Model, i.Color, " +
                    "i.Price, i.Specifications, i.Warranty, i.Quantity, i.StockLevel, i.ManufacturerID, " +
                    "STRING_AGG(ii.ImageURL, ',') WITHIN GROUP (ORDER BY ii.ImageID) as images " +
                    "FROM Instrument i " +
                    "LEFT JOIN InstrumentImages ii ON i.InstrumentID = ii.InstrumentID " +
                    "WHERE i.InstrumentID = ? " +
                    "GROUP BY i.InstrumentID, i.Name, i.Description, i.BrandID, i.Model, i.Color, " +
                    "i.Price, i.Specifications, i.Warranty, i.Quantity, i.StockLevel, i.ManufacturerID";

            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                instrument = new Instrument(
                        rs.getString("InstrumentID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getString("BrandID"),
                        rs.getString("Model"),
                        rs.getString("Color"),
                        rs.getDouble("Price"),
                        rs.getString("Specifications"),
                        rs.getString("Warranty"),
                        rs.getInt("Quantity"),
                        rs.getString("StockLevel"),
                        rs.getString("ManufacturerID")
                );
                String images = rs.getString("images");
                if (images != null) {
                    instrument.setImages(images.split(","));
                }
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        }
        return instrument;
    }

    private String generateInstrumentID(Connection conn) throws SQLException {
        String sql = "SELECT MAX(InstrumentID) as maxID FROM Instrument WHERE InstrumentID LIKE 'I%'";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                String maxID = rs.getString("maxID");
                if (maxID != null) {
                    int nextNum = Integer.parseInt(maxID.substring(1)) + 1;
                    return String.format("I%03d", nextNum);
                }
            }
            return "I001";
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        }
    }

    private String uploadImage(HttpServletRequest request, Part part) throws IOException {
        String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName = System.currentTimeMillis() + "_" + getFileName(part);
        String filePath = uploadPath + File.separator + fileName;
        part.write(filePath);

        return request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs, PrintWriter out) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (out != null) out.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Instrument class
    private class Instrument {
        String instrumentID, name, description, brandID, model, color, specifications, warranty, stockLevel, manufacturerID;
        double price;
        int quantity;
        String[] images;

        Instrument(String instrumentID, String name, String description, String brandID, String model, String color,
                   double price, String specifications, String warranty, int quantity, String stockLevel, String manufacturerID) {
            this.instrumentID = instrumentID;
            this.name = name;
            this.description = description;
            this.brandID = brandID;
            this.model = model;
            this.color = color;
            this.price = price;
            this.specifications = specifications;
            this.warranty = warranty;
            this.quantity = quantity;
            this.stockLevel = stockLevel;
            this.manufacturerID = manufacturerID;
        }

        void setImages(String[] images) {
            this.images = images;
        }
    }
}