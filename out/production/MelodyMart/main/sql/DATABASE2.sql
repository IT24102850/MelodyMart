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


use MelodyMartDB



select * from Instrument

select * from Brand

select * from Manufacturer

select * from cart

select * from Person


select * from customer



USE MelodyMartDB

CREATE TABLE Customer (
    CustomerID NVARCHAR(10) PRIMARY KEY,          -- 'CU001'
    PersonID NVARCHAR(10) NOT NULL UNIQUE,        -- must match Person.PersonID datatype
    LoyaltyPoints INT DEFAULT 0,
    PreferredPaymentMethod NVARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);
GO





SELECT 
    c.name AS ColumnName,
    t.name AS DataType
FROM sys.columns c
JOIN sys.types t ON c.user_type_id = t.user_type_id
WHERE c.object_id = OBJECT_ID('Person')
   OR c.object_id = OBJECT_ID('Customer');










CREATE TABLE Cart (
    CartID NVARCHAR(10) PRIMARY KEY,               -- manual ID like C001
    CustomerID NVARCHAR(10) NOT NULL,              -- matches Person/Customer NIC
    InstrumentID NVARCHAR(10) NOT NULL,            -- matches Instrument.InstrumentID
    Quantity INT NOT NULL DEFAULT 1,
    AddedDate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);
GO


DELETE FROM person
WHERE PersonID = 'P005';


SELECT 'CustomerID Exists' AS Check1
WHERE EXISTS (SELECT 1 FROM Customer WHERE CustomerID = 'CU001');

SELECT 'InstrumentID Exists' AS Check2
WHERE EXISTS (SELECT 1 FROM Instrument WHERE InstrumentID = 'I001');


sp_help Cart;


SELECT * FROM Customer WHERE CustomerID = 'CU001';

INSERT INTO Cart (CartID, CustomerID, InstrumentID, Quantity, AddedDate)
VALUES ('CA001', 'CU001', 'I001', 1, GETDATE());

EXEC sp_help 'Cart';


SELECT CustomerID FROM dbo.Customer WHERE CustomerID = 'CU001';
SELECT InstrumentID FROM dbo.Instrument WHERE InstrumentID = 'I001';


INSERT INTO dbo.Customer (CustomerID, PersonID, LoyaltyPoints, PreferredPaymentMethod)
VALUES ('CU001', 'P001', 0, 'Credit Card');


INSERT INTO dbo.Person (PersonID, FirstName, LastName, Email, Password)
VALUES ('P001', 'Demo', 'User', 'demo@gmail.com', '12345');


INSERT INTO dbo.Person 
(PersonID, FirstName, LastName, Email, Phone, Password, Street, City, State, ZipCode, Country, RegistrationDate, LastLogin, role)
VALUES 
('P001', 'Demo', 'User', 'demo@gmail.com', '0712345678', 'demo123', '123 Main St', 'Colombo', 'Western', '10000', 'Sri Lanka', GETDATE(), NULL, 'Customer');

INSERT INTO dbo.Person 
(PersonID, FirstName, LastName, Email, Phone, Password, Street, City, State, ZipCode, Country, RegistrationDate, LastLogin, role)
VALUES 
('P002', 'Demo', 'User', 'demo2@gmail.com', '0712345678', 'demo123', '123 Main St', 'Colombo', 'Western', '10000', 'Sri Lanka', GETDATE(), NULL, 'Customer');


INSERT INTO dbo.Customer (CustomerID, PersonID, LoyaltyPoints, PreferredPaymentMethod)
VALUES ('CU001', 'P002', 0, 'Credit Card');



INSERT INTO dbo.Customer (CustomerID, PersonID, LoyaltyPoints, PreferredPaymentMethod)
VALUES ('CU001', 'P001', 0, 'Credit Card');



SELECT PersonID, Email FROM dbo.Person;


INSERT INTO dbo.Customer (CustomerID, PersonID, LoyaltyPoints, PreferredPaymentMethod)
VALUES ('CU001', 'P003', 0, 'Credit Card');


SELECT * FROM dbo.Customer;

select * from Cart


INSERT INTO dbo.Cart (CartID, CustomerID, InstrumentID, Quantity, AddedDate)
VALUES ('CA001', 'CU001', 'I001', 1, GETDATE());



select * 