use MelodyMartDB

CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY,   -- manual insert
    Name NVARCHAR(100) NOT NULL,
    Website NVARCHAR(200),
    Country NVARCHAR(50),
    Description NVARCHAR(500)
);
SELECT f.name AS FK_Name, OBJECT_NAME(f.parent_object_id) AS TableName
FROM sys.foreign_keys f
WHERE f.referenced_object_id = OBJECT_ID('Manufacturer');

ALTER TABLE Brand DROP CONSTRAINT FK__Brand__Manufactu__42E1EEFE;
DROP TABLE Manufacturer;


USE MelodyMartDB;
GO

-- 1. Drop Brand table (this removes data too ⚠️)
IF OBJECT_ID('Brand', 'U') IS NOT NULL
    DROP TABLE Brand;
GO

-- 2. Recreate Brand table (manual PK)
CREATE TABLE Brand (
    BrandID INT PRIMARY KEY,   -- manual insert (no IDENTITY)
    Name NVARCHAR(50) NOT NULL,
    ManufacturerID INT,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)
);
GO


SELECT f.name AS FK_Name, OBJECT_NAME(f.parent_object_id) AS TableName
FROM sys.foreign_keys f
WHERE f.referenced_object_id = OBJECT_ID('Brand');
