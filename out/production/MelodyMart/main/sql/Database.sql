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
    InstrumentID INT PRIMARY KEY 
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


select * from StockCorrections

CREATE TABLE StockCorrections (
    CorrectionID INT PRIMARY KEY IDENTITY(1,1),
    InstrumentID INT NOT NULL,
    CorrectedQuantity INT NOT NULL,
    Reason NVARCHAR(255) NOT NULL,
    CorrectionDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);


CREATE TABLE InstrumentRemovals (
    RemovalID INT PRIMARY KEY IDENTITY(1,1),
    InstrumentID INT NOT NULL,
    Reason NVARCHAR(255),
    RemovalDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);

select * from Delivery
select * from Orders
use MelodyMartDB

USE MelodyMartDB;
GO

INSERT INTO Delivery 
(OrderID, DeliveryStatus, EstimatedDeliveryDate, ActualDeliveryDate, CurrentLocation, TrackingNumber, EstimatedCost, DeliveryDate, DeliveryCase)
VALUES
-- For OrderID 2
(2, 'Processing', '2025-10-01', NULL, 'Colombo Warehouse', 'TRK10001', 500.00, GETDATE(), 'Normal'),
(2, 'Shipped', '2025-10-02', NULL, 'Kurunegala Hub', 'TRK10002', 550.00, GETDATE(), 'Normal'),
(2, 'In Transit', '2025-10-03', NULL, 'Kandy Distribution', 'TRK10003', 600.00, GETDATE(), 'Normal'),
(2, 'Delivered', '2025-10-04', '2025-10-04', 'Customer Address', 'TRK10004', 650.00, GETDATE(), 'On Time'),
(2, 'Processing', '2025-10-05', NULL, 'Colombo Warehouse', 'TRK10005', 500.00, GETDATE(), 'Normal'),
(2, 'Shipped', '2025-10-06', NULL, 'Negombo Hub', 'TRK10006', 550.00, GETDATE(), 'Normal'),
(2, 'In Transit', '2025-10-07', NULL, 'Kurunegala Hub', 'TRK10007', 600.00, GETDATE(), 'Normal'),
(2, 'Delivered', '2025-10-08', '2025-10-08', 'Customer Address', 'TRK10008', 650.00, GETDATE(), 'Delayed'),
(2, 'Processing', '2025-10-09', NULL, 'Colombo Warehouse', 'TRK10009', 500.00, GETDATE(), 'Normal'),
(2, 'Shipped', '2025-10-10', NULL, 'Galle Hub', 'TRK10010', 550.00, GETDATE(), 'Normal'),

-- For OrderID 3
(3, 'Processing', '2025-10-01', NULL, 'Colombo Warehouse', 'TRK20001', 500.00, GETDATE(), 'Normal'),
(3, 'Shipped', '2025-10-02', NULL, 'Jaffna Hub', 'TRK20002', 600.00, GETDATE(), 'Normal'),
(3, 'In Transit', '2025-10-03', NULL, 'Anuradhapura Hub', 'TRK20003', 650.00, GETDATE(), 'Normal'),
(3, 'Delivered', '2025-10-04', '2025-10-04', 'Customer Address', 'TRK20004', 700.00, GETDATE(), 'On Time'),
(3, 'Processing', '2025-10-05', NULL, 'Colombo Warehouse', 'TRK20005', 500.00, GETDATE(), 'Normal'),
(3, 'Shipped', '2025-10-06', NULL, 'Matara Hub', 'TRK20006', 600.00, GETDATE(), 'Normal'),
(3, 'In Transit', '2025-10-07', NULL, 'Kegalle Hub', 'TRK20007', 650.00, GETDATE(), 'Normal'),
(3, 'Delivered', '2025-10-08', '2025-10-08', 'Customer Address', 'TRK20008', 700.00, GETDATE(), 'Delayed'),
(3, 'Processing', '2025-10-09', NULL, 'Colombo Warehouse', 'TRK20009', 500.00, GETDATE(), 'Normal'),
(3, 'Shipped', '2025-10-10', NULL, 'Hambantota Hub', 'TRK20010', 600.00, GETDATE(), 'Normal');
GO


select * from Instrument

USE MelodyMartDB;
GO

INSERT INTO Instrument (InstrumentID, Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, ImageURL, Quantity, StockLevel, ManufacturerID)
VALUES
(1, 'Fender Stratocaster', 'Electric Guitar', 1, 'American Professional II', 'Sunburst', 1499.99, 'Body: Alder, Neck: Maple', '2 Years', 'http://via.placeholder.com/40', 15, 'In Stock', 1),
(2, 'Yamaha HS8', 'Studio Monitor', 2, 'HS8', 'Black', 349.99, 'Body: Alder, Neck: Maple, Pickups: V-Mod II', '2 Years', 'images/instruments/instrument_1759081552398.jpg', 3, 'Low Stock', NULL),
(3, 'Electric Guitar', 'Solid-body electric guitar, versatile for rock, blues, jazz', NULL, 'Pacifica 112V', 'Red', 349.99, 'Body: Alder, 3 pickups, Rosewood fretboard, 22 frets', '1 Year', 'images/instruments/instrument_1759082326121.jpg', 25, 'In Stock', 2),
(4, 'Classical Guitar', 'Nylon-stringed classical guitar with cedar top', 2, 'C5', 'Brown', 150.00, 'Nylon strings, Cedar top, Mahogany back/sides, 650mm scale', '6 months', 'images/instruments/instrument_1759084004040.jpg', 12, 'Low Stock', 3),
(5, 'Synthesizer', 'Lightweight 88-key synthesizer / arranger', NULL, 'KROSS 2', 'Black', 880.00, '88 keys, 1000+ sounds, 16-track sequencer, MIDI, USB', '1 Year', 'images/instruments/instrument_1759084188587.jpg', 9, 'Low Stock', 1),
(6, 'Violin', '4/4 size violin, solid spruce top, excellent for beginners', NULL, 'Student II', 'Natural', 129.99, '4/4 size, Solid spruce top, Ebony fittings, Maple back', '3 months', 'images/instruments/instrument_1759084452452.jpg', 20, 'In Stock', 2),
(7, 'Viola', '15” viola with fine tuning pegs, suited for learners', NULL, 'Viola 15', 'Brown', 199.00, '4/4 size, Maple back, Spruce top, Ebony fingerboard', '9 months', 'images/instruments/instrument_1759085188577.jpg', 13, 'In Stock', 3),
(8, 'Cello', 'Full size 4/4 cello, laminated wood, with bow and rosin', NULL, 'CCO-100', 'Brown', 700.00, '4/4 size, Laminated maple, Spruce top, Alloy tailpiece', '2 years', 'images/instruments/instrument_1759085188577.jpg', 8, 'In Stock', 1),
(9, 'Upright Bass', '3/4 size upright bass for concert and jazz use', NULL, 'Roadshow', 'Natural', 1199.99, '3/4 size, Adjustable bridge, Ebony fittings, Solid spruce top', '1 year', 'images/instruments/instrument_1759085308369.jpg', 6, 'In Stock', 2),
(10, 'Drum Kit', '5-piece acoustic drum set with cymbals and hardware', NULL, 'Roadshow', 'Black', 549.00, '5-piece set: Bass, Snare, 2 Toms, Floor Tom, Cymbals', '3 months', 'images/instruments/instrument_1759088369139.jpg', 10, 'In Stock', 3),
(11, 'Electronic Drum Kit', 'Mesh snare, 4 pads, 3 cymbals, Coaching mode', NULL, 'TD-1K', 'Black', 600.00, 'Compact digital drum kit with mesh pads and training', '6 months', 'images/instruments/instrument_1759088725179.jpg', 4, 'Low Stock', 2),
(12, 'Flute', 'Open hole, C foot, Offset G, Silver plated keys', 3, 'YFL-222', 'Silver', 300.00, 'Closed-hole C foot. Offset G. Silver plated headjoint and keys', '1 Year', 'images/instruments/instrument_1759089337359.jpg', 8, 'Low Stock', 1),
(13, 'Clarinet', 'Intermediate B♭ clarinet, silver plated keys', NULL, 'E11', 'Black', 1000.00, 'B♭ clarinet, African Blackwood, Silver plated keys', '5 months', 'images/instruments/instrument_1759089633217.jpg', 17, 'In Stock', 3),
(14, 'Saxophone', 'Alto saxophone, nickel silver keys, body lacquered', NULL, 'YAS-280', 'Gold', 899.00, 'Alto sax, Brass body, Gold lacquer, High F# key', '9 months', 'images/instruments/instrument_1759089818974.jpg', 14, 'In Stock', 1),
(15, 'Trumpet', 'Student model trumpet, durable and responsive', NULL, 'TR300HD2', 'Silver', 799.00, 'Student trumpet, 0.459" bore, 4.8" bell, Silver plate', '2 months', 'images/instruments/instrument_1759089866763.jpg', 26, 'In Stock', 2),
(16, 'Trombone', 'Tenor trombone with F-attachment', NULL, 'YSL-354', 'Gold', 500.00, 'Bore: 0.500". Bell: 8". F-attachment trigger', '3 months', 'images/instruments/instrument_1759090276541.jpg', 11, 'In Stock', 3),
(17, 'Ukulele', 'Concert ukulele with soprano scale and open-gear tuners', NULL, 'KA-15S', 'Natural', 200.00, 'Soprano size. Mahogany body, 12 frets, Nylon strings', '1 Year', 'images/instruments/instrument_1759090354151.jpg', 19, 'In Stock', 1),
(18, 'Banjo', '5-string open back banjo, great for folk/bluegrass', NULL, 'Goodtime 2', 'Natural', 300.00, '5-string, Maple rim, Resonator back, Geared tuners', '3 months', 'images/instruments/instrument_1759090375469.jpg', 4, 'Low Stock', 2),
(19, 'Mandolin', 'A-style mandolin with spruce top, maple back/sides', NULL, 'KM-150', 'Sunburst', 250.00, 'A-style mandolin, Spruce top, Maple back/sides', '2 years', 'images/instruments/instrument_1759090467403.jpg', 0, 'Out of Stock', 3),
(20, 'Hurdy-Gurdy', 'Stringed instrument with crank and drone strings', NULL, 'Mini Hurdy', 'Brown', 1000.00, '3 melody strings, 2 drone strings, Crank handle', '2 years', 'images/instruments/instrument_1759090622643.jpg', 9, 'In Stock', 1),
(21, 'Geta Beraya (Traditional Drum)', 'Traditional Kandyan drum used in cultural events', NULL, 'Standard', 'Brown', 200.00, 'Double-headed drum, Wooden body, Cowhide heads', '6 months', 'images/instruments/instrument_1759090662906.jpg', 12, 'In Stock', 2),
(22, 'Thammattama (Traditional Drum)', 'Played with sticks in processions, often in ensembles', NULL, 'Standard', 'Brown', 150.00, 'Pair of twin drums. Wooden body. Cowhide drumheads', '6 months', 'images/instruments/instrument_1759090662906.jpg', 15, 'In Stock', 3);


USE MelodyMartDB;
GO

INSERT INTO Instrument 
(Name, Description, BrandID, Model, Color, Price, Specifications, Warranty, ImageURL, Quantity, StockLevel, ManufacturerID)
VALUES
('Fender Stratocaster', 'Electric Guitar', 1, 'American Professional II', 'Sunburst', 1499.99, 'Body: Alder, Neck: Maple', '2 Years', 'http://via.placeholder.com/40', 15, 'In Stock', 1),
('Yamaha HS8', 'Studio Monitor', 2, 'HS8', 'Black', 349.99, 'Body: Alder, Neck: Maple, Pickups: V-Mod II', '2 Years', 'images/instruments/instrument_1759081552398.jpg', 3, 'Low Stock', NULL),
('Electric Guitar', 'Solid-body electric guitar, versatile for rock, blues, jazz', NULL, 'Pacifica 112V', 'Red', 349.99, 'Body: Alder, 3 pickups, Rosewood fretboard, 22 frets', '1 Year', 'images/instruments/instrument_1759082326121.jpg', 25, 'In Stock', 2),
('Classical Guitar', 'Nylon-stringed classical guitar with cedar top', 2, 'C5', 'Brown', 150.00, 'Nylon strings, Cedar top, Mahogany back/sides, 650mm scale', '6 months', 'images/instruments/instrument_1759084004040.jpg', 12, 'Low Stock', 3),
('Synthesizer', 'Lightweight 88-key synthesizer / arranger', NULL, 'KROSS 2', 'Black', 880.00, '88 keys, 1000+ sounds, 16-track sequencer, MIDI, USB', '1 Year', 'images/instruments/instrument_1759084188587.jpg', 9, 'Low Stock', 1),
('Violin', '4/4 size violin, solid spruce top, excellent for beginners', NULL, 'Student II', 'Natural', 129.99, '4/4 size, Solid spruce top, Ebony fittings, Maple back', '3 months', 'images/instruments/instrument_1759084452452.jpg', 20, 'In Stock', 2),
('Viola', '15” viola with fine tuning pegs, suited for learners', NULL, 'Viola 15', 'Brown', 199.00, '4/4 size, Maple back, Spruce top, Ebony fingerboard', '9 months', 'images/instruments/instrument_1759085188577.jpg', 13, 'In Stock', 3),
('Cello', 'Full size 4/4 cello, laminated wood, with bow and rosin', NULL, 'CCO-100', 'Brown', 700.00, '4/4 size, Laminated maple, Spruce top, Alloy tailpiece', '2 years', 'images/instruments/instrument_1759085188577.jpg', 8, 'In Stock', 1),
('Upright Bass', '3/4 size upright bass for concert and jazz use', NULL, 'Roadshow', 'Natural', 1199.99, '3/4 size, Adjustable bridge, Ebony fittings, Solid spruce top', '1 year', 'images/instruments/instrument_1759085308369.jpg', 6, 'In Stock', 2),
('Drum Kit', '5-piece acoustic drum set with cymbals and hardware', NULL, 'Roadshow', 'Black', 549.00, '5-piece set: Bass, Snare, 2 Toms, Floor Tom, Cymbals', '3 months', 'images/instruments/instrument_1759088369139.jpg', 10, 'In Stock', 3),
('Electronic Drum Kit', 'Mesh snare, 4 pads, 3 cymbals, Coaching mode', NULL, 'TD-1K', 'Black', 600.00, 'Compact digital drum kit with mesh pads and training', '6 months', 'images/instruments/instrument_1759088725179.jpg', 4, 'Low Stock', 2),
('Flute', 'Open hole, C foot, Offset G, Silver plated keys', 3, 'YFL-222', 'Silver', 300.00, 'Closed-hole C foot. Offset G. Silver plated headjoint and keys', '1 Year', 'images/instruments/instrument_1759089337359.jpg', 8, 'Low Stock', 1),
('Clarinet', 'Intermediate B♭ clarinet, silver plated keys', NULL, 'E11', 'Black', 1000.00, 'B♭ clarinet, African Blackwood, Silver plated keys', '5 months', 'images/instruments/instrument_1759089633217.jpg', 17, 'In Stock', 3),
('Saxophone', 'Alto saxophone, nickel silver keys, body lacquered', NULL, 'YAS-280', 'Gold', 899.00, 'Alto sax, Brass body, Gold lacquer, High F# key', '9 months', 'images/instruments/instrument_1759089818974.jpg', 14, 'In Stock', 1),
('Trumpet', 'Student model trumpet, durable and responsive', NULL, 'TR300HD2', 'Silver', 799.00, 'Student trumpet, 0.459"" bore, 4.8"" bell, Silver plate', '2 months', 'images/instruments/instrument_1759089866763.jpg', 26, 'In Stock', 2),
('Trombone', 'Tenor trombone with F-attachment', NULL, 'YSL-354', 'Gold', 500.00, 'Bore: 0.500"". Bell: 8"". F-attachment trigger', '3 months', 'images/instruments/instrument_1759090276541.jpg', 11, 'In Stock', 3),
('Ukulele', 'Concert ukulele with soprano scale and open-gear tuners', NULL, 'KA-15S', 'Natural', 200.00, 'Soprano size. Mahogany body, 12 frets, Nylon strings', '1 Year', 'images/instruments/instrument_1759090354151.jpg', 19, 'In Stock', 1),
('Banjo', '5-string open back banjo, great for folk/bluegrass', NULL, 'Goodtime 2', 'Natural', 300.00, '5-string, Maple rim, Resonator back, Geared tuners', '3 months', 'images/instruments/instrument_1759090375469.jpg', 4, 'Low Stock', 2),
('Mandolin', 'A-style mandolin with spruce top, maple back/sides', NULL, 'KM-150', 'Sunburst', 250.00, 'A-style mandolin, Spruce top, Maple back/sides', '2 years', 'images/instruments/instrument_1759090467403.jpg', 0, 'Out of Stock', 3),
('Hurdy-Gurdy', 'Stringed instrument with crank and drone strings', NULL, 'Mini Hurdy', 'Brown', 1000.00, '3 melody strings, 2 drone strings, Crank handle', '2 years', 'images/instruments/instrument_1759090622643.jpg', 9, 'In Stock', 1),
('Geta Beraya (Traditional Drum)', 'Traditional Kandyan drum used in cultural events', NULL, 'Standard', 'Brown', 200.00, 'Double-headed drum, Wooden body, Cowhide heads', '6 months', 'images/instruments/instrument_1759090662906.jpg', 12, 'In Stock', 2),
('Thammattama (Traditional Drum)', 'Played with sticks in processions, often in ensembles', NULL, 'Standard', 'Brown', 150.00, 'Pair of twin drums. Wooden body. Cowhide drumheads', '6 months', 'images/instruments/instrument_1759090662906.jpg', 15, 'In Stock', 3);

select * from Orders
select * from Payment

select * from Person


select * FROM Instrument



WHERE InstrumentID IN (1);

SELECT OrderID, CustomerID, Status, TotalAmount 
FROM Orders
ORDER BY OrderDate DESC;


DELETE FROM StockCorrections WHERE InstrumentID = 1;
DELETE FROM Instrument WHERE InstrumentID = 1;
ALTER TABLE StockCorrections
DROP CONSTRAINT FK__StockCorr__Instr__2334397B;

ALTER TABLE StockCorrections
ADD CONSTRAINT FK_StockCorrections_Instrument
FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
ON DELETE CASCADE;
ALTER TABLE Instrument ADD IsActive BIT DEFAULT 1;


The DELETE statement conflicted with the REFERENCE constraint "FK__OrderItem__Instr__5E8A0973".
The conflict occurred in table "dbo.OrderItem", column 'InstrumentID'.


CREATE TABLE OrderNow (
    OrderNowID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    SellerID INT NOT NULL,
    InstrumentID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    TotalAmount DECIMAL(10,2) NOT NULL,
    PaymentMethod NVARCHAR(50),
    Status NVARCHAR(20) DEFAULT 'Pending',
    OrderDate DATETIME DEFAULT GETDATE(),
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);


-- Add new columns to Payment table
ALTER TABLE Payment 
ADD CardNumber VARCHAR(20),
    ExpiryDate VARCHAR(7),
    CardName VARCHAR(100);

-- Or if you need to create a new table:
CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    TransactionID VARCHAR(50) NOT NULL,
    CVV VARCHAR(4) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    CardNumber VARCHAR(20) NOT NULL,
    ExpiryDate VARCHAR(7) NOT NULL,
    CardName VARCHAR(100) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES OrderNow(OrderID) -- Adjust based on your order table
);

use MelodyMartDB


select * from Person
select * from Orders
select * from Payment
select * from Cart
select * from Person
select * from RepairRequest
select * from OrderItem
select * from Delivery

select * FROM Instrument
select * from stockcorrections

DELETE FROM Person
WHERE PersonID <> 'P003';



CREATE OR ALTER TRIGGER trg_AutoGeneratePersonID
ON Person
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaxNum INT;

    -- Get the highest numeric suffix from existing PersonIDs
    SELECT @MaxNum = MAX(TRY_CAST(SUBSTRING(PersonID, 2, LEN(PersonID)) AS INT))
    FROM Person
    WHERE PersonID LIKE 'P%';

    IF @MaxNum IS NULL 
        SET @MaxNum = 0;

    DECLARE @RowCount INT = 0;

    -- Insert each new record with incremental PersonIDs
    INSERT INTO Person (
        PersonID, FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country, RegistrationDate, LastLogin, role
    )
    SELECT 
        'P' + RIGHT('000' + CAST(@MaxNum + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(3)), 3),
        i.FirstName, i.LastName, i.Email, i.Phone, i.Password,
        i.Street, i.City, i.State, i.ZipCode, i.Country,
        i.RegistrationDate, i.LastLogin, i.role
    FROM inserted i;
END;
GO


use MelodyMartDB

CREATE TABLE RepairRequest (
    RepairRequestID NVARCHAR(10) PRIMARY KEY,
    UserID NVARCHAR(10) NOT NULL,             -- FK to Person(PersonID)
    OrderID INT NOT NULL,                     -- FK to Orders(OrderID)
    IssueDescription NVARCHAR(255) NOT NULL,
    Status NVARCHAR(50) NOT NULL DEFAULT 'Submitted',
    Approved BIT NOT NULL DEFAULT 0,
    RequestDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Person(PersonID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

select * from RepairRequest

drop table RepairRequest

select * from RepairPhoto


CREATE TABLE RepairPhoto (
    PhotoID NVARCHAR(10) PRIMARY KEY,
    RepairRequestID NVARCHAR(10) NOT NULL,
    PhotoPath NVARCHAR(255) NOT NULL,
    UploadedDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (RepairRequestID) REFERENCES RepairRequest(RepairRequestID)
);


CREATE TABLE RepairStatusHistory (
    HistoryID NVARCHAR(10) PRIMARY KEY,
    RepairRequestID NVARCHAR(10) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    Comment NVARCHAR(255) NOT NULL DEFAULT 'No additional comment',
    UpdatedDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (RepairRequestID) REFERENCES RepairRequest(RepairRequestID)
);


CREATE TABLE RepairCost (
    CostID NVARCHAR(10) PRIMARY KEY,
    RepairRequestID NVARCHAR(10) NOT NULL,
    EstimatedCost DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    RepairDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (RepairRequestID) REFERENCES RepairRequest(RepairRequestID)
);


