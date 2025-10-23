
use practice

SELECT dbo.TotalRepairCost('R002') AS TotalRepairCost;
  

  use MelodyMartDB

  select * from person

  EXEC sp_helpconstraint 'Customer';


  SELECT c.PersonID, p.FirstName, p.role
FROM Customer c
JOIN Person p ON c.PersonID = p.PersonID;


CREATE TABLE Customer (
    CustomerID NVARCHAR(10) PRIMARY KEY,          
    PersonID NVARCHAR(10) NOT NULL UNIQUE,        
    LoyaltyPoints INT DEFAULT 0,
    PreferredPaymentMethod NVARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);




DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Person;

CREATE TABLE Person (
    PersonID NVARCHAR(10) PRIMARY KEY,   
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
    LastLogin DATETIME,
    role NVARCHAR(20)
);

CREATE TABLE Customer (
    CustomerID NVARCHAR(10) PRIMARY KEY,          
    PersonID NVARCHAR(10) NOT NULL UNIQUE,        
    LoyaltyPoints INT DEFAULT 0,
    PreferredPaymentMethod NVARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);






-- Check who references CUSTOMER
EXEC sp_fkeys 'Customer';

-- Check who references PERSON
EXEC sp_fkeys 'Person';






































use MelodyMartDB

USE MelodyMartDB;
GO

CREATE TABLE Person (
    PersonID NVARCHAR(10) PRIMARY KEY,   -- e.g., 'P001', 'P002'
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
GO


USE MelodyMartDB;
GO


EXEC sp_help 'Person';
EXEC sp_help 'Customer';

SELECT * FROM Person;
SELECT * FROM Customer;






USE MelodyMartDB;
GO

-- Drop dependent tables first if needed
DROP TABLE IF EXISTS OrderTable;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Customer;
GO

-- Recreate Customer table with matching type
CREATE TABLE Customer (
    CustomerID NVARCHAR(10) PRIMARY KEY,          -- 'CU001'
    PersonID NVARCHAR(10) NOT NULL UNIQUE,        -- ✅ same type as Person.PersonID
    LoyaltyPoints INT DEFAULT 0,
    PreferredPaymentMethod NVARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);
GO

USE MelodyMartDB;
EXEC sp_fkeys 'Customer';


USE MelodyMartDB;
GO

ALTER TABLE OrderTable 
DROP CONSTRAINT FK__OrderTabl__Custo__4B973090;
GO

DROP TABLE IF EXISTS Customer;
GO

CREATE TABLE Customer (
    CustomerID NVARCHAR(10) PRIMARY KEY,          -- e.g., 'CU001'
    PersonID NVARCHAR(10) NOT NULL UNIQUE,        -- ✅ same type as Person.PersonID
    LoyaltyPoints INT DEFAULT 0,
    PreferredPaymentMethod NVARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);
GO


select * from person

INSERT INTO Person (FirstName, LastName, Email, Password, City, Country, role)
VALUES ('Suhas', 'Nimneth', 'suhas2004@gmail.com', 'pass123', 'Ahangama', 'Sri Lanka', 'customer');

INSERT INTO Person (FirstName, LastName, Email, Password, City, Country, role)
VALUES ('Himaka', 'Uthpala', 'himaka2004@gmail.com', 'pass123', 'Matara', 'Sri Lanka', 'seller');

SELECT * FROM Person;


USE MelodyMartDB;
GO

DROP TABLE IF EXISTS Person;
GO




USE MelodyMartDB;
EXEC sp_fkeys 'Person';

USE MelodyMartDB;
GO

-- Drop FKs referencing Person
ALTER TABLE Customer DROP CONSTRAINT FK__Customer__Person__515009E6;
ALTER TABLE RepairRequest DROP CONSTRAINT FK__RepairReq__UserI__6F7F8B4B;
GO


DROP TABLE IF EXISTS Person;
GO

CREATE TABLE Person (
    PersonID NVARCHAR(10) PRIMARY KEY,     -- e.g., 'P001', 'P002'
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
    role NVARCHAR(20)
);
GO







-- 🔹 Trigger: auto-generate next PersonID
CREATE TRIGGER trg_AutoPersonID
ON Person
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Prefix NVARCHAR(2) = 'P';
    DECLARE @LastID NVARCHAR(10);
    DECLARE @NextNum INT;

    SELECT @LastID = MAX(PersonID) FROM Person;

    IF @LastID IS NULL
        SET @NextNum = 1;
    ELSE
        SET @NextNum = CAST(SUBSTRING(@LastID, 2, LEN(@LastID)) AS INT) + 1;

    INSERT INTO Person (
        PersonID, FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country, RegistrationDate, LastLogin, role
    )
    SELECT
        @Prefix + RIGHT('000' + CAST(@NextNum AS NVARCHAR(3)), 3),
        FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country, RegistrationDate, LastLogin, role
    FROM inserted;
END;
GO


SELECT *FROM PERSON





USE MelodyMartDB;
GO

ALTER TABLE OrderTable DROP CONSTRAINT FK_OrderTable_CustomerID;
GO

DROP TABLE IF EXISTS Customer;
GO

USE MelodyMartDB;
EXEC sp_fkeys 'Customer';

select * from customer

CREATE TABLE Customer (
    CustomerID NVARCHAR(10) PRIMARY KEY,         -- e.g., 'CU001'
    PersonID NVARCHAR(10) NOT NULL UNIQUE,       -- FK → Person(PersonID)
    LoyaltyPoints INT DEFAULT 0,
    PreferredPaymentMethod NVARCHAR(50),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);
GO

-- 🔹 Trigger to auto-generate CustomerID (CU001, CU002, ...)
CREATE TRIGGER trg_AutoCustomerID
ON Customer
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Prefix NVARCHAR(3) = 'CU';
    DECLARE @LastID NVARCHAR(10);
    DECLARE @NextNum INT;

    SELECT @LastID = MAX(CustomerID) FROM Customer;

    IF @LastID IS NULL
        SET @NextNum = 1;
    ELSE
        SET @NextNum = CAST(SUBSTRING(@LastID, 3, LEN(@LastID)) AS INT) + 1;

    INSERT INTO Customer (CustomerID, PersonID, LoyaltyPoints, PreferredPaymentMethod)
    SELECT
        @Prefix + RIGHT('000' + CAST(@NextNum AS NVARCHAR(3)), 3),
        PersonID, LoyaltyPoints, PreferredPaymentMethod
    FROM inserted;
END;
GO


select * from customer

select * from person


EXEC sp_help 'Person';
EXEC sp_help 'Customer';



SELECT PersonID FROM Person ORDER BY PersonID;
SELECT PersonID FROM Customer ORDER BY PersonID;

EXEC sp_help 'Person';
EXEC sp_help 'Customer';


EXEC sp_help 'Person';
EXEC sp_help 'Customer';




ALTER TABLE Person
ADD State NVARCHAR(50),
    ZipCode NVARCHAR(10),
    Country NVARCHAR(50),
    RegistrationDate DATETIME DEFAULT GETDATE(),
    LastLogin DATETIME NULL,
    role NVARCHAR(20);
GO









INSERT INTO Person (PersonID, FirstName, LastName, Email, Password, City)
VALUES ('P001', 'Suhas', 'Nimneth', 'suhas2004@gmail.com', 'pass123', 'Ahangama');



SELECT name 
FROM sys.triggers 
WHERE parent_id = OBJECT_ID('Person');

INSERT INTO Customer (PersonID, LoyaltyPoints, PreferredPaymentMethod)
VALUES ('P001', 100, 'Credit Card');





















CREATE TABLE Person (
    PersonID NVARCHAR(10) PRIMARY KEY,     -- e.g., 'P001', 'P002'
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
    LastLogin DATETIME,
    role NVARCHAR(20)
);
GO

-- 🔹 TRIGGER to auto-generate PersonID (P001, P002, ...)
CREATE TRIGGER trg_AutoPersonID
ON Person
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Prefix NVARCHAR(2) = 'P';
    DECLARE @LastID NVARCHAR(10);
    DECLARE @NextNum INT;

    SELECT @LastID = MAX(PersonID) FROM Person;

    IF @LastID IS NULL
        SET @NextNum = 1;
    ELSE
        SET @NextNum = CAST(SUBSTRING(@LastID, 2, LEN(@LastID)) AS INT) + 1;

    INSERT INTO Person (
        PersonID, FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country, RegistrationDate, LastLogin, role
    )
    SELECT
        @Prefix + RIGHT('000' + CAST(@NextNum AS NVARCHAR(3)), 3),
        FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country, RegistrationDate, LastLogin, role
    FROM inserted;
END;
GO











ALTER TABLE OrderTable
ADD CONSTRAINT FK_OrderTable_CustomerID
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
GO




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


CREATE TABLE InstrumentImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    InstrumentID NVARCHAR(10) NOT NULL,
    ImageURL NVARCHAR(255) NOT NULL,
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID) ON DELETE CASCADE
);




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







   use MelodyMartDB


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



select * from Delivery

CREATE TABLE DeliveryStatus (
    DeliveryID INT PRIMARY KEY,
    CurrentStatus VARCHAR(50),
    ActualDeliveryDate DATE,
    EstimatedDeliveryDate DATE,
    ServiceProviderID INT,
    FOREIGN KEY (ServiceProviderID) REFERENCES ServiceProvider(ServiceProviderID)
);

drop table ServiceProvider

CREATE TABLE ServiceProvider (
    ServiceProviderID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
    ContactPhone VARCHAR(20),
    ContactEmail VARCHAR(100)
);



CREATE TABLE Location (
    PostalCode VARCHAR(10) PRIMARY KEY,
    City VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

INSERT INTO Location VALUES
('10100', 'Colombo', 'Sri Lanka'),
('20400', 'Toronto', 'Canada'),
('82000', 'Matara', 'Sri Lanka');

select * from Location



select * from DeliveryStatus

select * from Orders


SELECT * FROM Customer

DROP TABLE IF EXISTS OrderTable;
GO




DROP TABLE IF EXISTS OrderTable;
GO

DROP TABLE IF EXISTS Location;
GO

CREATE TABLE Location (
    PostalCode NVARCHAR(10) PRIMARY KEY,    -- changed from VARCHAR to NVARCHAR
    City NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL
);
GO

INSERT INTO Location VALUES
('10100', 'Colombo', 'Sri Lanka'),
('20400', 'Toronto', 'Canada'),
('82000', 'Matara', 'Sri Lanka');
GO











DROP TABLE IF EXISTS DeliveryStatus;
CREATE TABLE DeliveryStatus (
    DeliveryID NVARCHAR(10) NOT NULL,
    StatusDate DATETIME NOT NULL DEFAULT GETDATE(),
    CurrentStatus NVARCHAR(50) NOT NULL,
    ActualDeliveryDate DATETIME NULL,
    EstimatedDeliveryDate DATETIME NULL,
    ServiceProviderID NVARCHAR(100) NULL,
    CONSTRAINT PK_DeliveryStatus PRIMARY KEY (DeliveryID, StatusDate)
);


DECLARE @NextID NVARCHAR(10);
DECLARE @Prefix NVARCHAR(3) = 'DS';
DECLARE @LastID NVARCHAR(10);
DECLARE @NumPart INT;

-- Get the last used ID
SELECT @LastID = MAX(DeliveryID) FROM DeliveryStatus;

-- Generate the next one
IF @LastID IS NULL
    SET @NextID = @Prefix + '001';
ELSE
BEGIN
    SET @NumPart = CAST(SUBSTRING(@LastID, 3, LEN(@LastID)) AS INT) + 1;
    SET @NextID = @Prefix + RIGHT('000' + CAST(@NumPart AS NVARCHAR(3)), 3);
END;

-- Insert a new record
INSERT INTO DeliveryStatus (DeliveryID, CurrentStatus, ActualDeliveryDate, EstimatedDeliveryDate, ServiceProviderID)
VALUES (@NextID, 'Pending', NULL, DATEADD(DAY, 5, GETDATE()), 'FastShip Logistics');

PRINT 'Inserted record with DeliveryID = ' + @NextID;














CREATE TRIGGER trg_AutoDeliveryID
ON dbo.DeliveryStatus
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Prefix NVARCHAR(3) = 'DS';
    DECLARE @LastID NVARCHAR(10);
    DECLARE @StartNum INT;

    SELECT @LastID = MAX(DeliveryID) FROM dbo.DeliveryStatus;

    IF @LastID IS NULL
        SET @StartNum = 1;
    ELSE
        SET @StartNum = CAST(SUBSTRING(@LastID, 3, LEN(@LastID)) AS INT) + 1;

    INSERT INTO dbo.DeliveryStatus
        (DeliveryID, StatusDate, CurrentStatus, ActualDeliveryDate, EstimatedDeliveryDate, ServiceProviderID)
    SELECT
        @Prefix + RIGHT('000' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + @StartNum - 1 AS NVARCHAR(3)), 3),
        GETDATE(),
        i.CurrentStatus,
        i.ActualDeliveryDate,
        i.EstimatedDeliveryDate,
        i.ServiceProviderID
    FROM inserted i;
END;
GO





CREATE TABLE OrderTable (
    OrderID NVARCHAR(10) PRIMARY KEY,             
    OrderDate DATE NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount >= 0),
    Status NVARCHAR(50),
    Street NVARCHAR(100),
    PostalCode NVARCHAR(10) NOT NULL,
    CustomerID NVARCHAR(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    FOREIGN KEY (PostalCode) REFERENCES Location(PostalCode),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
GO



DROP TABLE IF EXISTS OrderTable;
GO
CREATE TABLE OrderTable (
    OrderID NVARCHAR(10) PRIMARY KEY,              -- e.g., '0R001'
    OrderDate DATE NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount >= 0),
    Status NVARCHAR(50),
    Street NVARCHAR(100),
    PostalCode NVARCHAR(10) NOT NULL,
    CustomerID NVARCHAR(20) NOT NULL,
    FOREIGN KEY (PostalCode) REFERENCES Location(PostalCode),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
GO

SELECT * FROM OrderTable

INSERT INTO OrderTable (OrderID, TotalAmount, Status, Street, PostalCode, CustomerID)
VALUES ('0R001', 25000.00, 'Pending', '45 Lake View Rd', '10100', 'CU001');
INSERT INTO OrderTable (OrderID, TotalAmount, Status, Street, PostalCode, CustomerID)
VALUES ('0R002', 18000.00, 'Processing', '12 Palm Grove', '20400', 'CU001');


SELECT * FROM Cart

SELECT * FROM INSTRUMENT

SELECT * FROM OrderTable



USE melodymartdb


USE MelodyMartDB;
GO

DROP TRIGGER IF EXISTS trg_AutoPersonID;
GO

CREATE TRIGGER trg_AutoPersonID
ON Person
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Prefix NVARCHAR(2) = 'P';
    DECLARE @PersonTemp TABLE (
        PersonID NVARCHAR(10),
        FirstName NVARCHAR(50),
        LastName NVARCHAR(50),
        Email NVARCHAR(100),
        Phone NVARCHAR(20),
        Password NVARCHAR(255),
        Street NVARCHAR(100),
        City NVARCHAR(50),
        State NVARCHAR(50),
        ZipCode NVARCHAR(20),
        Country NVARCHAR(50),
        RegistrationDate DATETIME,
        role NVARCHAR(20)
    );

    DECLARE @StartNum INT;
    SELECT @StartNum = ISNULL(MAX(CAST(SUBSTRING(PersonID, 2, 10) AS INT)), 0)
    FROM Person
    WHERE PersonID LIKE 'P%';

    -- Generate new IDs and stage data
    INSERT INTO @PersonTemp
    SELECT
        @Prefix + RIGHT('0000' + CAST(@StartNum + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10)), 4),
        i.FirstName, i.LastName, i.Email, i.Phone, i.Password,
        i.Street, i.City, i.State, i.ZipCode, i.Country,
        ISNULL(i.RegistrationDate, GETDATE()), i.role
    FROM inserted i;

    -- Insert into Person table
    INSERT INTO Person (
        PersonID, FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country, RegistrationDate, role
    )
    SELECT 
        PersonID, FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country, RegistrationDate, role
    FROM @PersonTemp;

    -- Insert into related role tables
    INSERT INTO Customer (PersonID, LoyaltyPoints, PreferredPaymentMethod)
    SELECT PersonID, 0, 'Card' FROM @PersonTemp WHERE LOWER(role) = 'customer';

    INSERT INTO Seller (PersonID)
    SELECT PersonID FROM @PersonTemp WHERE LOWER(role) = 'seller';

    INSERT INTO Admin (PersonID)
    SELECT PersonID FROM @PersonTemp WHERE LOWER(role) = 'admin';
END;
GO

INSERT INTO Person (FirstName,LastName,Email,Phone,Password,Street,City,State,ZipCode,Country,role)
VALUES ('Test','User','test@example.com','123','abc','Street','City','ST','00000','Country','customer');
DELETE FROM Person
WHERE PersonID = 'P0013';

DELETE FROM Customer WHERE PersonID IN ('P0013', 'P0014');
DELETE FROM Seller   WHERE PersonID IN ('P0013', 'P0014');
DELETE FROM Admin    WHERE PersonID IN ('P0013', 'P0014');

select * from person


DELETE FROM Person
WHERE PersonID IN ('P0013', 'P0014');

select * from RepairRequest

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'RepairRequest';
