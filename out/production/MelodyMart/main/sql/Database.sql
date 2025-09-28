-- Create database
CREATE DATABASE MelodyMartDB;
GO

USE MelodyMartDB;
GO
USE MelodyMartDB;
GO

-- Person table (central entity for users)
CREATE TABLE Person (
    PersonID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(20),
    Password NVARCHAR(255) NOT NULL,  -- Hash passwords in production
    Street NVARCHAR(100),
    City NVARCHAR(50),
    State NVARCHAR(50),
    ZipCode NVARCHAR(10),
    Country NVARCHAR(50),
    RegistrationDate DATETIME DEFAULT GETDATE(),
    LastLogin DATETIME
);

-- Address table (for delivery addresses, linked to Person)
CREATE TABLE Address (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    Street NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    State NVARCHAR(50),
    ZipCode NVARCHAR(10) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    PersonID INT,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Customer table (inherits from Person)
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    PersonID INT NOT NULL UNIQUE,
    LoyaltyPoints INT DEFAULT 0,
    PreferredPaymentMethod NVARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Person(PersonID)
);

-- Seller table (inherits from Person)
CREATE TABLE Seller (
    SellerID INT PRIMARY KEY,
    PersonID INT NOT NULL UNIQUE,
    CompanyName NVARCHAR(100),
    LicenseNo NVARCHAR(50),
    FOREIGN KEY (SellerID) REFERENCES Person(PersonID)
);

-- Admin table (inherits from Person)
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY,
    PersonID INT NOT NULL UNIQUE,
    ClearanceLevel NVARCHAR(20),
    JoinDate DATE DEFAULT GETDATE(),
    LastLogin DATETIME,
    FOREIGN KEY (AdminID) REFERENCES Person(PersonID)
);

-- Supervisor table (inherits from Person)
CREATE TABLE Supervisor (
    SupervisorID INT PRIMARY KEY,
    PersonID INT NOT NULL UNIQUE,
    FOREIGN KEY (SupervisorID) REFERENCES Person(PersonID)
);

-- Manufacturer table
CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Website NVARCHAR(200),
    Country NVARCHAR(50),
    Description NVARCHAR(500)
);

-- Brand table (if separate from Manufacturer; assuming it's a lookup)
CREATE TABLE Brand (
    BrandID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    ManufacturerID INT,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
);









-- Instrument table
CREATE TABLE Instrument (
    InstrumentID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    BrandID INT,  -- Link to Brand
    Model NVARCHAR(50),
    Color NVARCHAR(30),
    Price DECIMAL(10,2) NOT NULL,
    Specifications NVARCHAR(500),
    Warranty NVARCHAR(100),
    ImageURL NVARCHAR(255),
    Quantity INT DEFAULT 0,
    StockLevel NVARCHAR(20) DEFAULT 'In Stock',  -- e.g., 'In Stock', 'Low Stock', 'Out of Stock'
    ManufacturerID INT,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);

-- Category table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200)
);

-- InstrumentCategory junction (N:M relationship)
CREATE TABLE InstrumentCategory (
    InstrumentID INT NOT NULL,
    CategoryID INT NOT NULL,
    PRIMARY KEY (InstrumentID, CategoryID),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE CASCADE
);

-- Cart table (for shopping cart)
CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    InstrumentID INT NOT NULL,
    Quantity INT DEFAULT 1,
    AddedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    SellerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(50) DEFAULT 'Pending',  -- e.g., 'Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'
    DeliveryAddressID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
    FOREIGN KEY (DeliveryAddressID) REFERENCES Address(AddressID)
);

-- OrderItem table (N:M for Orders and Instruments)
CREATE TABLE OrderItem (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    InstrumentID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);

-- Payment table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,  -- e.g., 'Card', 'Bank Transfer SLIP', 'Cash on Delivery'
    TransactionID NVARCHAR(100) UNIQUE,
    CVV NVARCHAR(4),  -- DO NOT STORE IN PRODUCTION
    Status NVARCHAR(50) DEFAULT 'Pending',  -- e.g., 'Paid', 'Failed'
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Delivery table
CREATE TABLE Delivery (
    DeliveryID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    DeliveryStatus NVARCHAR(50) DEFAULT 'Processing',  -- e.g., 'Ready for Delivery', 'Shipped', 'Delivered'
    EstimatedDeliveryDate DATETIME,
    ActualDeliveryDate DATETIME,
    CurrentLocation NVARCHAR(100),
    TrackingNumber NVARCHAR(50),
    EstimatedCost DECIMAL(8,2),
    DeliveryDate DATETIME DEFAULT GETDATE(),
    DeliveryCase NVARCHAR(100),  -- e.g., 'Normal', 'Delayed'
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Review table
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    OrderItemID INT NOT NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comment NVARCHAR(500),
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OrderItemID) REFERENCES OrderItem(OrderItemID)
);

-- RepairRequest table
CREATE TABLE RepairRequest (
    RepairRequestID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    IssueDescription NVARCHAR(500) NOT NULL,
    Photos NVARCHAR(MAX),  -- JSON or comma-separated URLs
    Status NVARCHAR(50) DEFAULT 'Submitted',  -- e.g., 'Submitted', 'Approved', 'In Progress', 'Completed', 'Rejected'
    Approved BIT DEFAULT 0,
    Comment NVARCHAR(500),
    EstimatedCost DECIMAL(8,2),
    RepairDate DATETIME,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- ServiceProvider table (base for Repair and Delivery providers)
CREATE TABLE ServiceProvider (
    ServiceProviderID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20),
    ContactEmail NVARCHAR(100),
    Description NVARCHAR(500)
);

-- RepairServiceProvider (subtype of ServiceProvider)
CREATE TABLE RepairServiceProvider (
    RepairServiceProviderID INT PRIMARY KEY IDENTITY(1,1),
    ServiceProviderID INT NOT NULL UNIQUE,
    FOREIGN KEY (ServiceProviderID) REFERENCES ServiceProvider(ServiceProviderID)
);

-- DeliveryServiceProvider (subtype of ServiceProvider)
CREATE TABLE DeliveryServiceProvider (
    DeliveryServiceProviderID INT PRIMARY KEY IDENTITY(1,1),
    ServiceProviderID INT NOT NULL UNIQUE,
    FOREIGN KEY (ServiceProviderID) REFERENCES ServiceProvider(ServiceProviderID)
);

-- Optional: SellerServiceProvider junction if sellers manage providers
CREATE TABLE SellerServiceProvider (
    SellerID INT NOT NULL,
    ServiceProviderID INT NOT NULL,
    PRIMARY KEY (SellerID, ServiceProviderID),
    FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
    FOREIGN KEY (ServiceProviderID) REFERENCES ServiceProvider(ServiceProviderID)
);

-- Indexes for performance (optional but recommended)
CREATE INDEX IX_Orders_CustomerID ON Orders(CustomerID);
CREATE INDEX IX_Instrument_Quantity ON Instrument(Quantity);
CREATE INDEX IX_RepairRequest_Status ON RepairRequest(Status);
GO

-- Sample data inserts for testing
INSERT INTO Category (Name, Description) VALUES 
(N'Guitars', N'String instruments like electric and acoustic guitars'),
(N'Pianos', N'Keyboard instruments including digital pianos'),
(N'Drums', N'Percussion instruments'),
(N'Woodwind', N'Wind instruments like saxophones'),
(N'Brass', N'Brass instruments like trumpets'),
(N'Accessories', N'Musical accessories and parts');

INSERT INTO Manufacturer (Name, Website, Country, Description) VALUES 
(N'Fender', N'https://www.fender.com', N'USA', N'Leading manufacturer of guitars'),
(N'Yamaha', N'https://www.yamaha.com', N'Japan', N'Global producer of musical instruments'),
(N'Pearl', N'https://www.pearl.com', N'USA', N'Specialists in drums and percussion');

INSERT INTO Brand (Name, ManufacturerID) VALUES 
(N'Stratocaster', 1),
(N'P-125', 2),
(N'Export Series', 3);

-- Example Instrument insert
INSERT INTO Instrument (Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, ImageURL, Quantity, ManufacturerID) VALUES 
(N'Fender American Professional II Stratocaster', N'High-quality electric guitar', 1, N'Stratocaster', N'Sunburst', 1499.99, N'Body: Alder, Neck: Maple', N'2 Years', N'https://example.com/fender.jpg', 10, 1);
GO



ALTER TABLE Person
ADD role NVARCHAR(50) NULL;
GO


UPDATE Person
SET role = 'customer'
WHERE role IS NULL;
GO

SELECT all * FROM Person;





SELECT * FROM Instrument 


ALTER TABLE Instrument DROP CONSTRAINT FK__Instrumen__Manuf__47A6A41B;

INSERT INTO Instrument (Name, ManufacturerID, Price)
VALUES ('Guitar', 10, 5000);

ALTER TABLE Instrument
DROP CONSTRAINT FK__Instrumen__Manuf__47A6A41B;

ALTER TABLE Instrument
ALTER COLUMN BrandID INT NULL;




INSERT INTO Instrument (Name, Description, Price)
VALUES ('Guitar', 'Standard acoustic guitar', 5000);



ALTER TABLE Instrument
ALTER COLUMN BrandID INT NULL;

ALTER TABLE Instrument
ALTER COLUMN ManufacturerID INT NULL;

SELECT * FROM Brand;
SELECT * FROM Manufacturer;

USE MelodyMartDB;
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '%Instrument%';

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '%Instrument%';

SELECT BrandID, 
FROM Brand;


INSERT INTO Instrument (Name, ManufacturerID, Price)
VALUES ('Guitar', 10, 5000);







USE MelodyMartDB;
GO

INSERT INTO Instrument (Name, Description, BrandID, Price)
VALUES ('Guitar', 'Standard acoustic guitar', 10, 5000);

SELECT * FROM sys.foreign_keys WHERE name = 'FK__Instrumen__Brand__489AC854';

SELECT DB_NAME() AS CurrentDatabase;

SELECT BrandID, Name, ManufacturerID FROM Brand;

INSERT INTO Instrument (Name, Description, BrandID, Price)
VALUES ('Guitar', 'Standard acoustic guitar', 10, 5000.00);

INSERT INTO Instrument (Name, Description, BrandID, Price)
VALUES ('Guitar', 'Standard acoustic guitar', 1, 5000.00); -- Using BrandID 1 (Stratocaster)

SELECT * FROM Instrument WHERE Name = 'Guitar';

SELECT * FROM Instrument WHERE Name = 'Guitar';

INSERT INTO Instrument (Name, Description, BrandID, Price)
VALUES ('Guitar', 'Standard acoustic guitar', 10, 5000.00);

INSERT INTO Brand (Name, ManufacturerID) VALUES ('Stratocaster', 1);
INSERT INTO Brand (Name, ManufacturerID) VALUES ('P-125', 2);
SELECT * FROM Brand;

INSERT INTO Instrument (Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, ImageURL, Quantity) VALUES
('Fender American Professional II Stratocaster', 'High-quality electric guitar with maple neck', 1, 'Stratocaster', 'Sunburst', 1499.99, 'Body: Alder, Neck: Maple, Pickups: V-Mod II', '2 Years', 'https://example.com/fender_strat.jpg', 10),
('Yamaha P-125 Digital Piano', 'Compact digital piano with weighted keys', 2, 'P-125', 'Black', 799.99, 'Keys: 88, Polyphony: 192, Power: 12W', '1 Year', 'https://example.com/yamaha_p125.jpg', 15),
('Pearl Export Series Drum Kit', 'Versatile drum set for beginners', 3, 'Export Series', 'Mahogany', 1299.95, 'Shells: 6-Ply, Sizes: 22x18, 10x8, 12x9, 16x16', '2 Years', 'https://example.com/pearl_export.jpg', 8),
('Acoustic Guitar', 'Standard acoustic guitar for learners', 0, 'Classic', 'Natural', 299.99, 'Top: Spruce, Back/Sides: Mahogany', '1 Year', 'https://example.com/acoustic_guitar.jpg', 20);
GO

USE MelodyMartDB;
GO
SELECT * FROM Brand;

INSERT INTO Brand (Name, ManufacturerID) VALUES
('Stratocaster', 1),  -- Fender
('P-125', 2),         -- Yamaha
('Export Series', 3); -- Pearl
GO

INSERT INTO Instrument (Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, ImageURL, Quantity) VALUES
('Fender American Professional II Stratocaster', 'High-quality electric guitar with maple neck', 1, 'Stratocaster', 'Sunburst', 1499.99, 'Body: Alder, Neck: Maple, Pickups: V-Mod II', '2 Years', 'https://example.com/fender_strat.jpg', 10),
('Yamaha P-125 Digital Piano', 'Compact digital piano with weighted keys', 2, 'P-125', 'Black', 799.99, 'Keys: 88, Polyphony: 192, Power: 12W', '1 Year', 'https://example.com/yamaha_p125.jpg', 15),
('Pearl Export Series Drum Kit', 'Versatile drum set for beginners', 3, 'Export Series', 'Mahogany', 1299.95, 'Shells: 6-Ply, Sizes: 22x18, 10x8, 12x9, 16x16', '2 Years', 'https://example.com/pearl_export.jpg', 8),
('Acoustic Guitar', 'Standard acoustic guitar for learners', NULL, 'Classic', 'Natural', 299.99, 'Top: Spruce, Back/Sides: Mahogany', '1 Year', 'https://example.com/acoustic_guitar.jpg', 20);
GO

SELECT * FROM Instrument;

ALTER TABLE Instrument
DROP CONSTRAINT FK__Instrumen__Brand__489AC854;
ALTER TABLE Instrument
ADD CONSTRAINT FK__Instrumen__Brand__489AC854
FOREIGN KEY (BrandID) REFERENCES Brand(BrandID) ON DELETE SET NULL;

INSERT INTO Instrument (Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, ImageURL, Quantity) VALUES
('Fender American Professional II Stratocaster', 'High-quality electric guitar with maple neck', 1, 'Stratocaster', 'Sunburst', 1499.99, 'Body: Alder, Neck: Maple, Pickups: V-Mod II', '2 Years', 'https://example.com/fender_strat.jpg', 10),
('Yamaha P-125 Digital Piano', 'Compact digital piano with weighted keys', 2, 'P-125', 'Black', 799.99, 'Keys: 88, Polyphony: 192, Power: 12W', '1 Year', 'https://example.com/yamaha_p125.jpg', 15),
('Pearl Export Series Drum Kit', 'Versatile drum set for beginners', 3, 'Export Series', 'Mahogany', 1299.95, 'Shells: 6-Ply, Sizes: 22x18, 10x8, 12x9, 16x16', '2 Years', 'https://example.com/pearl_export.jpg', 8),
('Acoustic Guitar', 'Standard acoustic guitar for learners', NULL, 'Classic', 'Natural', 299.99, 'Top: Spruce, Back/Sides: Mahogany', '1 Year', 'https://example.com/acoustic_guitar.jpg', 20);
GO

SELECT * FROM Instrument;

INSERT INTO Instrument (Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, ImageURL, Quantity, ManufacturerID) VALUES
('Fender American Professional II Stratocaster', 'High-quality electric guitar with maple neck', 1, 'Stratocaster', 'Sunburst', 1499.99, 'Body: Alder, Neck: Maple, Pickups: V-Mod II', '2 Years', 'https://example.com/fender_strat.jpg', 10, 1),
('Yamaha P-125 Digital Piano', 'Compact digital piano with weighted keys', 2, 'P-125', 'Black', 799.99, 'Keys: 88, Polyphony: 192, Power: 12W', '1 Year', 'https://example.com/yamaha_p125.jpg', 15, 2),
('Pearl Export Series Drum Kit', 'Versatile drum set for beginners', 3, 'Export Series', 'Mahogany', 1299.95, 'Shells: 6-Ply, Sizes: 22x18, 10x8, 12x9, 16x16', '2 Years', 'https://example.com/pearl_export.jpg', 8, 3),
('Acoustic Guitar', 'Standard acoustic guitar for learners', NULL, 'Classic', 'Natural', 299.99, 'Top: Spruce, Back/Sides: Mahogany', '1 Year', 'https://example.com/acoustic_guitar.jpg', 20, NULL);
GO

SELECT BrandID FROM Brand;
SELECT ManufacturerID FROM Manufacturer;

CREATE TABLE Instrument (
    InstrumentID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    BrandID INT,  -- Link to Brand
    Model NVARCHAR(50),
    Color NVARCHAR(30),
    Price DECIMAL(10,2) NOT NULL,
    Specifications NVARCHAR(500),
    Warranty NVARCHAR(100),
    ImageURL NVARCHAR(255),
    Quantity INT DEFAULT 0,
    StockLevel NVARCHAR(20) DEFAULT 'In Stock',  -- e.g., 'In Stock', 'Low Stock', 'Out of Stock'
    ManufacturerID INT,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);

SELECT * FROM Instrument;

-- Insert new instrument from manufacturer with brand and category
INSERT INTO Instrument
(Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, ImageURL, Quantity, StockLevel, ManufacturerID)
VALUES
(N'Yamaha FG800 Acoustic Guitar', 
 N'Solid spruce top with nato/okume back and sides', 
 2,                               -- BrandID (Yamaha)
 N'FG800', 
 N'Natural', 
 299.99, 
 N'Top: Spruce, Back: Nato, Fretboard: Rosewood', 
 N'1 Year', 
 N'https://example.com/yamaha_fg800.jpg', 
 25, 
 N'In Stock', 
 2);                              -- ManufacturerID (Yamaha)

-- Link the instrument to a category (e.g., Guitars)
INSERT INTO InstrumentCategory (InstrumentID, CategoryID)
VALUES (SCOPE_IDENTITY(), 1);     -- CategoryID = 1 (Guitars)


-- Read stock levels with brand and manufacturer info
SELECT i.InstrumentID, i.Name, i.Quantity, i.StockLevel,
       b.Name AS BrandName, m.Name AS ManufacturerName, 
       c.Name AS CategoryName
FROM Instrument i
LEFT JOIN Brand b ON i.BrandID = b.BrandID
LEFT JOIN Manufacturer m ON i.ManufacturerID = m.ManufacturerID
LEFT JOIN InstrumentCategory ic ON i.InstrumentID = ic.InstrumentID
LEFT JOIN Category c ON ic.CategoryID = c.CategoryID
ORDER BY i.Quantity DESC;


select * from Category

CREATE TABLE StockCorrections (
    CorrectionID INT PRIMARY KEY IDENTITY(1,1),
    InstrumentID INT NOT NULL,
    CorrectedQuantity INT NOT NULL,
    Reason NVARCHAR(255) NOT NULL,
    CorrectionDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);
