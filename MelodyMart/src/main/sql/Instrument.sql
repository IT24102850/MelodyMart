use MelodyMartDB

CREATE TABLE Instrument (
    InstrumentID NVARCHAR(10) PRIMARY KEY,           -- e.g. INS001
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    BrandID NVARCHAR(20),                            -- match your Brand table type
    Model NVARCHAR(50),
    Color NVARCHAR(30),
    Price DECIMAL(10,2) NOT NULL,
    Specifications NVARCHAR(500),
    Warranty NVARCHAR(100),
    ImageURLs NVARCHAR(MAX),                         -- store multiple image URLs (comma-separated)
    Quantity INT DEFAULT 0,
    StockLevel NVARCHAR(20) DEFAULT 'In Stock',
    ManufacturerID NVARCHAR(20),                     -- match ManufacturerID type exactly
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);
GO



DROP TABLE Instrument;
GO
-- then run the corrected CREATE TABLE script


sp_help 'Manufacturer';


select * from Instrument




DROP TABLE IF EXISTS Instrument;
GO

CREATE TABLE Instrument (
    InstrumentID NVARCHAR(10) PRIMARY KEY,           -- e.g. INS001
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    BrandID NVARCHAR(20),                            -- must match Brand.BrandID
    Model NVARCHAR(50),
    Color NVARCHAR(30),
    Price DECIMAL(10,2) NOT NULL,
    Specifications NVARCHAR(500),
    Warranty NVARCHAR(100),
    ImageURLs NVARCHAR(MAX),
    Quantity INT DEFAULT 0,
    StockLevel NVARCHAR(20) DEFAULT 'In Stock',
    ManufacturerID NVARCHAR(20),                     -- ✅ matches Manufacturer.ManufacturerID exactly
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);
GO



ALTER TABLE Instrument DROP CONSTRAINT FK__Instrumen__Manuf__4830B400;
GO

USE MelodyMartDB;
GO


SELECT * FROM sys.tables WHERE name = 'Instrument';




USE MelodyMartDB;
GO

CREATE TABLE Instrument (
    InstrumentID NVARCHAR(10) PRIMARY KEY,           -- e.g. INS001
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    BrandID NVARCHAR(20),                            -- matches Brand.BrandID
    Model NVARCHAR(50),
    Color NVARCHAR(30),
    Price DECIMAL(10,2) NOT NULL,
    Specifications NVARCHAR(500),
    Warranty NVARCHAR(100),
    ImageURLs NVARCHAR(MAX),
    Quantity INT DEFAULT 0,
    StockLevel NVARCHAR(20) DEFAULT 'In Stock',
    ManufacturerID NVARCHAR(20),                     -- matches Manufacturer.ManufacturerID
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);
GO



select * from Instrument

DROP TABLE IF EXISTS Instrument;
GO

CREATE TABLE Instrument (
    InstrumentID NVARCHAR(10) PRIMARY KEY,           -- e.g. INS001
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    BrandID NVARCHAR(20),                            -- ✅ matches Brand.BrandID
    Model NVARCHAR(50),
    Color NVARCHAR(30),
    Price DECIMAL(10,2) NOT NULL,
    Specifications NVARCHAR(500),
    Warranty NVARCHAR(100),
    ImageURLs NVARCHAR(MAX),
    Quantity INT DEFAULT 0,
    StockLevel NVARCHAR(20) DEFAULT 'In Stock',
    ManufacturerID NVARCHAR(20),                     -- ✅ matches Manufacturer.ManufacturerID
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);
GO


SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ManufacturerID';


CREATE TABLE Instrument (
    InstrumentID NVARCHAR(10) PRIMARY KEY,           -- e.g. INS001
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    BrandID NVARCHAR(10),                            -- matches Brand.BrandID
    Model NVARCHAR(50),
    Color NVARCHAR(30),
    Price DECIMAL(10,2) NOT NULL,
    Specifications NVARCHAR(500),
    Warranty NVARCHAR(100),
    ImageURLs NVARCHAR(MAX),
    Quantity INT DEFAULT 0,
    StockLevel NVARCHAR(20) DEFAULT 'In Stock',
    ManufacturerID NVARCHAR(10),                     -- ✅ matches Manufacturer.ManufacturerID
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);
GO


-- Drop old trigger if exists
IF OBJECT_ID('trg_AutoGenerateInstrumentID', 'TR') IS NOT NULL
    DROP TRIGGER trg_AutoGenerateInstrumentID;
GO

-- Trigger to auto-generate InstrumentID (text-based)
CREATE TRIGGER trg_AutoGenerateInstrumentID
ON Instrument
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NextID NVARCHAR(10);

    SELECT @NextID = 'INS' + RIGHT('000' + 
        CAST(ISNULL(MAX(CAST(SUBSTRING(InstrumentID, 4, 10) AS INT)), 0) + 1 AS VARCHAR(3)), 3)
    FROM Instrument;

    INSERT INTO Instrument (
        InstrumentID, Name, Description, BrandID, Model, Color, Price,
        Specifications, Warranty, ImageURLs, Quantity, StockLevel, ManufacturerID, IsActive
    )
    SELECT 
        @NextID, Name, Description, BrandID, Model, Color, Price,
        Specifications, Warranty, ImageURLs, Quantity, StockLevel, ManufacturerID, IsActive
    FROM INSERTED;
END;
GO
