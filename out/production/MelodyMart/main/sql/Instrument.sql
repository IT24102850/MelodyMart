use MelodyMartDB



CREATE TABLE Manufacturer (
    ManufacturerID NVARCHAR(10) PRIMARY KEY,
    ManufacturerName NVARCHAR(100) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Website NVARCHAR(200)
);
GO

CREATE TRIGGER trg_AutoGenerateManufacturerID
ON Manufacturer
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nextID NVARCHAR(10);

    SELECT @nextID = 'M' + RIGHT('000' + CAST(ISNULL(MAX(CAST(SUBSTRING(ManufacturerID, 2, LEN(ManufacturerID)) AS INT)), 0) + 1 AS NVARCHAR), 3)
    FROM Manufacturer;

    INSERT INTO Manufacturer (ManufacturerID, ManufacturerName, Country, Website)
    SELECT @nextID, ManufacturerName, Country, Website
    FROM inserted;
END;
GO



CREATE TABLE Brand (
    BrandID NVARCHAR(10) PRIMARY KEY,
    BrandName NVARCHAR(100) NOT NULL,
    ManufacturerID NVARCHAR(10) NOT NULL,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
);
GO

CREATE TRIGGER trg_AutoGenerateBrandID
ON Brand
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nextID NVARCHAR(10);

    SELECT @nextID = 'B' + RIGHT('000' + CAST(ISNULL(MAX(CAST(SUBSTRING(BrandID, 2, LEN(BrandID)) AS INT)), 0) + 1 AS NVARCHAR), 3)
    FROM Brand;

    INSERT INTO Brand (BrandID, BrandName, ManufacturerID)
    SELECT @nextID, BrandName, ManufacturerID
    FROM inserted;
END;
GO




CREATE TABLE Specification (
    SpecificationID NVARCHAR(10) PRIMARY KEY,
    Body NVARCHAR(100) NOT NULL,
    Neck NVARCHAR(100) NOT NULL,
    Fretboard NVARCHAR(100) NOT NULL,
    Strings INT NOT NULL,
    Power NVARCHAR(50),
    Features NVARCHAR(300)
);
GO

CREATE TRIGGER trg_AutoGenerateSpecificationID
ON Specification
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nextID NVARCHAR(10);

    SELECT @nextID = 'S' + RIGHT('000' + CAST(ISNULL(MAX(CAST(SUBSTRING(SpecificationID, 2, LEN(SpecificationID)) AS INT)), 0) + 1 AS NVARCHAR), 3)
    FROM Specification;

    INSERT INTO Specification (SpecificationID, Body, Neck, Fretboard, Strings, Power, Features)
    SELECT @nextID, Body, Neck, Fretboard, Strings, Power, Features
    FROM inserted;
END;
GO


CREATE TABLE Warranty (
    WarrantyID NVARCHAR(10) PRIMARY KEY,
    DurationYears INT NOT NULL,
    Description NVARCHAR(100)
);
GO

CREATE TRIGGER trg_AutoGenerateWarrantyID
ON Warranty
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nextID NVARCHAR(10);

    SELECT @nextID = 'W' + RIGHT('000' + CAST(ISNULL(MAX(CAST(SUBSTRING(WarrantyID, 2, LEN(WarrantyID)) AS INT)), 0) + 1 AS NVARCHAR), 3)
    FROM Warranty;

    INSERT INTO Warranty (WarrantyID, DurationYears, Description)
    SELECT @nextID, DurationYears, Description
    FROM inserted;
END;
GO


CREATE TABLE InstrumentImage (
    ImageID NVARCHAR(10) PRIMARY KEY,
    ImageURL NVARCHAR(200) NOT NULL
);
GO

CREATE TRIGGER trg_AutoGenerateInstrumentImageID
ON InstrumentImage
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nextID NVARCHAR(10);

    SELECT @nextID = 'IM' + RIGHT('000' + CAST(ISNULL(MAX(CAST(SUBSTRING(ImageID, 3, LEN(ImageID)) AS INT)), 0) + 1 AS NVARCHAR), 3)
    FROM InstrumentImage;

    INSERT INTO InstrumentImage (ImageID, ImageURL)
    SELECT @nextID, ImageURL
    FROM inserted;
END;
GO


CREATE TABLE Stock (
    StockID NVARCHAR(10) PRIMARY KEY,
    Quantity INT NOT NULL CHECK (Quantity >= 0)
);
GO

CREATE TRIGGER trg_AutoGenerateStockID
ON Stock
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nextID NVARCHAR(10);

    SELECT @nextID = 'ST' + RIGHT('000' + CAST(ISNULL(MAX(CAST(SUBSTRING(StockID, 3, LEN(StockID)) AS INT)), 0) + 1 AS NVARCHAR), 3)
    FROM Stock;

    INSERT INTO Stock (StockID, Quantity)
    SELECT @nextID, Quantity
    FROM inserted;
END;
GO



CREATE TABLE Instrument (
    InstrumentID NVARCHAR(10) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    Model NVARCHAR(100) NOT NULL,
    Color NVARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    BrandID NVARCHAR(10) NOT NULL,
    SpecificationID NVARCHAR(10) NOT NULL,
    WarrantyID NVARCHAR(10) NOT NULL,
    ImageID NVARCHAR(10) NOT NULL,
    StockID NVARCHAR(10) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID),
    FOREIGN KEY (SpecificationID) REFERENCES Specification(SpecificationID),
    FOREIGN KEY (WarrantyID) REFERENCES Warranty(WarrantyID),
    FOREIGN KEY (ImageID) REFERENCES InstrumentImage(ImageID),
    FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);
GO

CREATE TRIGGER trg_AutoGenerateInstrumentID
ON Instrument
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nextID NVARCHAR(10);

    SELECT @nextID = 'I' + RIGHT('000' + CAST(ISNULL(MAX(CAST(SUBSTRING(InstrumentID, 2, LEN(InstrumentID)) AS INT)), 0) + 1 AS NVARCHAR), 3)
    FROM Instrument;

    INSERT INTO Instrument (InstrumentID, Name, Description, Model, Color, Price, BrandID, SpecificationID, WarrantyID, ImageID, StockID, IsActive)
    SELECT @nextID, Name, Description, Model, Color, Price, BrandID, SpecificationID, WarrantyID, ImageID, StockID, IsActive
    FROM inserted;
END;
GO

select * from Instrument



