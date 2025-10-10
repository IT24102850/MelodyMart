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
    InstrumentID NVARCHAR(10) PRIMARY KEY,          -- e.g., 'I001', 'I002'
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    BrandID NVARCHAR(10),
    Model NVARCHAR(50),
    Color NVARCHAR(30),
    Price DECIMAL(10,2) NOT NULL,
    Specifications NVARCHAR(500),
    Warranty NVARCHAR(100),
    Quantity INT DEFAULT 0,
    StockLevel NVARCHAR(20) DEFAULT 'In Stock',
    ManufacturerID NVARCHAR(10),
    ImageURL NVARCHAR(255),
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);
GO



-- Separate table for multiple images (also manual IDs)
CREATE TABLE InstrumentImage (
    ImageID NVARCHAR(10) PRIMARY KEY,               -- e.g., 'IMG001', 'IMG002'
    InstrumentID NVARCHAR(10) NOT NULL,
    ImageURL NVARCHAR(255) NOT NULL,
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);
GO


drop table InstrumentImage


ALTER TABLE Instrument
ADD CONSTRAINT FK__Instrumen__Manuf__0AF29B96
FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID);


DROP TABLE Instrument;


SELECT * FROM sys.tables WHERE name = 'Instrument';


SELECT permission_name
FROM fn_my_permissions(NULL, 'DATABASE')
WHERE permission_name LIKE '%DROP%';

select * from Manufacturer


SELECT * FROM sys.tables WHERE name = 'Instrument';
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_NAME LIKE '%Instrumen__Manuf%';




ALTER TABLE Instrument
ADD CONSTRAINT FK__Instrumen__Manuf__025D5595
FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID);


SELECT * FROM Instrument




SELECT ManufacturerID
FROM Instrument
WHERE ISNUMERIC(ManufacturerID) = 0;




drop table Instrument