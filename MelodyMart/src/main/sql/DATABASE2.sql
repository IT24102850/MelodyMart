use MelodyMartDB

USE MelodyMartDB;
GO

CREATE TABLE Person (
    PersonID INT PRIMARY KEY,   
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(20),
    Password NVARCHAR(255) NOT NULL,
    Street NVARCHAR(100),
    City NVARCHAR(50),
    State NVARCHAR(50),
    ZipCode NVARCHAR(10),
    Country NVARCHAR(50),
    RegistrationDate DATETIME DEFAULT GETDATE(),
    LastLogin DATETIME
);




CREATE TABLE Address (
    AddressID INT PRIMARY KEY,  
    Street NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    State NVARCHAR(50),
    ZipCode NVARCHAR(10) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    PersonID INT,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY,   -- manual PK
    Name NVARCHAR(100) NOT NULL,
    Website NVARCHAR(200),
    Country NVARCHAR(50),
    Description NVARCHAR(500)
);

ALTER TABLE Brand 
    ADD CONSTRAINT FK_Brand_Manufacturer 
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID);




CREATE TABLE Brand (
    BrandID NVARCHAR(10) PRIMARY KEY,   -- manual IDs like 'B001'
    Name NVARCHAR(50) NOT NULL,
    ManufacturerID NVARCHAR(10),
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
);
GO



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
