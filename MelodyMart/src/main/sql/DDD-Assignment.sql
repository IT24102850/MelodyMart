use MelodyMartDatabase




-- ======================================================
--  1. PERSON SUPERCLASS AND SUBCLASSES
-- ======================================================

CREATE TABLE Person (
    NIC VARCHAR(15) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    RegistrationDate DATE NOT NULL,
    isActive BIT DEFAULT 1
);

select * from Person

CREATE TABLE Admin (
    AdminNIC VARCHAR(15) PRIMARY KEY,
    ClearanceLevel INT NOT NULL,
    LastLogin DATETIME,
    FOREIGN KEY (AdminNIC) REFERENCES Person(NIC)
);

select * from Admin


CREATE TABLE Customer (
    CustomerNIC VARCHAR(15) PRIMARY KEY,
    PreferredPaymentMethod VARCHAR(50),
    LoyaltyPoints INT DEFAULT 0,
    Street VARCHAR(100),
    PostalCode VARCHAR(10),
    CartID INT,
    FOREIGN KEY (CustomerNIC) REFERENCES Person(NIC),
    FOREIGN KEY (PostalCode) REFERENCES Location(PostalCode)
);


select * from Customer


drop table Customer

CREATE TABLE Seller (
    SellerNIC VARCHAR(15) PRIMARY KEY,
    TaxID VARCHAR(20) UNIQUE NOT NULL,
    JoinDate DATE NOT NULL,
    LicenseNo VARCHAR(30) UNIQUE NOT NULL,
    FOREIGN KEY (SellerNIC) REFERENCES Person(NIC)
);

select * from Seller

-- ======================================================
--  2. LOCATION / CART / ORDERS
-- ======================================================

CREATE TABLE Location (
    PostalCode VARCHAR(10) PRIMARY KEY,
    City VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

select * from Location

UPDATE C
SET 
    C.State = L.Country,   -- replacing State with the Country from Location
    C.PostalCode = L.PostalCode
FROM Customer C
JOIN Location L 
    ON C.PostalCode = L.PostalCode;




CREATE TABLE Cart (
    CartID INT PRIMARY KEY,
    Quantity INT CHECK (Quantity >= 0)
);

CREATE TABLE OrderTable (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0),
    Status VARCHAR(50),
    Street VARCHAR(100),
    PostalCode VARCHAR(10),
    CustomerNIC VARCHAR(15),
    FOREIGN KEY (PostalCode) REFERENCES Location(PostalCode),
    FOREIGN KEY (CustomerNIC) REFERENCES Customer(CustomerNIC)
);


-- ======================================================
--  3. MANUFACTURER / CATEGORY / INSTRUMENTS
-- ======================================================

CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50) UNIQUE
);

CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    CountryID INT,
    Website VARCHAR(255),
    WarrantyPolicy TEXT,
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);


CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT
);

CREATE TABLE Instrument (
    InstrumentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Model VARCHAR(50),
    Brand VARCHAR(50),
    Description TEXT,
    Weight DECIMAL(10,2),
    Material VARCHAR(50),
    Dimensions VARCHAR(50),
    Price DECIMAL(10,2),
    ManufacturerID INT,
    CategoryID INT,
    SellerNIC VARCHAR(15),
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (SellerNIC) REFERENCES Seller(SellerNIC)
);

CREATE TABLE InstrumentColor (
    InstrumentID INT,
    Color VARCHAR(50),
    PRIMARY KEY (InstrumentID, Color),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);

CREATE TABLE InstrumentImage (
    InstrumentID INT,
    ImageURL VARCHAR(255),
    PRIMARY KEY (InstrumentID, ImageURL),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);

CREATE TABLE CartInstrument (
    CartID INT,
    InstrumentID INT,
    Quantity INT CHECK (Quantity >= 0),
    PRIMARY KEY (CartID, InstrumentID),
    FOREIGN KEY (CartID) REFERENCES Cart(CartID),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)
);

CREATE TABLE OrderContains (
    InstrumentID INT,
    OrderID INT,
    Quantity INT CHECK (Quantity >= 0),
    PRIMARY KEY (InstrumentID, OrderID),
    FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID),
    FOREIGN KEY (OrderID) REFERENCES OrderTable(OrderID)
);

-- ======================================================
--  4. PAYMENT / REVIEW SYSTEM
-- ======================================================

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(50),
    CardCVV CHAR(3),
    TransactionStatus VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES OrderTable(OrderID)
);

CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    IsApproved BIT DEFAULT 0,
    CustomerNIC VARCHAR(15),
    AdminNIC VARCHAR(15),
    FOREIGN KEY (CustomerNIC) REFERENCES Customer(CustomerNIC),
    FOREIGN KEY (AdminNIC) REFERENCES Admin(AdminNIC)
);

-- ======================================================
--  5. SERVICE PROVIDERS / REPAIR / DELIVERY
-- ======================================================


CREATE TABLE ServiceType (
    TypeID INT PRIMARY KEY,
    TypeName VARCHAR(50) -- e.g. 'Repair', 'Delivery'
);



CREATE TABLE ServiceProvider (
    ServiceProviderID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
    ContactPhone VARCHAR(20),
    ContactEmail VARCHAR(100)
);





CREATE TABLE ProviderServiceType (
    ServiceProviderID INT,
    TypeID INT,
    PRIMARY KEY (ServiceProviderID, TypeID),
    FOREIGN KEY (ServiceProviderID) REFERENCES ServiceProvider(ServiceProviderID),
    FOREIGN KEY (TypeID) REFERENCES ServiceType(TypeID)
);




CREATE TABLE RepairRequest (
    RequestID INT PRIMARY KEY,
    RequestDate DATE,
    Status VARCHAR(50),
    IssueDescription TEXT,
    EstimatedCost DECIMAL(10,2),
    CustomerNIC VARCHAR(15),
    ServiceProviderID INT,
    FOREIGN KEY (CustomerNIC) REFERENCES Customer(CustomerNIC),
    FOREIGN KEY (ServiceProviderID) REFERENCES ServiceProvider(ServiceProviderID)
);

CREATE TABLE DeliveryStatus (
    DeliveryID INT PRIMARY KEY,
    CurrentStatus VARCHAR(50),
    ActualDeliveryDate DATE,
    EstimatedDeliveryDate DATE,
    ServiceProviderID INT,
    FOREIGN KEY (ServiceProviderID) REFERENCES ServiceProvider(ServiceProviderID)
);

-- ======================================================
--  6. TRIGGERS FOR PRIMARY KEY AUTO-GENERATION
-- ======================================================

CREATE TRIGGER trg_Order_ID
ON OrderTable
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(OrderID),0) + 1 FROM OrderTable;
    INSERT INTO OrderTable (OrderID, OrderDate, TotalAmount, Status, Street, City, PostalCode, CustomerNIC)
    SELECT @NextID, OrderDate, TotalAmount, Status, Street, City, PostalCode, CustomerNIC FROM inserted;
END;
GO

CREATE TRIGGER trg_Payment_ID
ON Payment
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(PaymentID),0) + 1 FROM Payment;
    INSERT INTO Payment (PaymentID, OrderID, PaymentDate, PaymentMethod, CardCVV, TransactionStatus)
    SELECT @NextID, OrderID, PaymentDate, PaymentMethod, CardCVV, TransactionStatus FROM inserted;
END;
GO

-- ======================================================
--  7. SAMPLE DATA
-- ======================================================

INSERT INTO Manufacturer VALUES (1, 'Yamaha', 'Japan', 'www.yamaha.com', '1 Year Warranty');
INSERT INTO Category VALUES (1, 'Guitar', 'String Instrument');
INSERT INTO Location VALUES ('10001', 'Colombo', 'Sri Lanka');

INSERT INTO Person VALUES ('990011223V', 'Sasnuka', 'sasnuka@gmail.com', '1234', '2024-03-01', 1);
INSERT INTO Person VALUES ('980045612V', 'Nethmika', 'nethmika@gmail.com', 'abcd', '2024-03-02', 1);

INSERT INTO Seller VALUES ('980045612V', 'TAX998', '2023-01-10', 'LIC001');
INSERT INTO Cart VALUES (1, 2);
INSERT INTO Customer VALUES ('990011223V', 'Card', 100, 'Main Street', 'Colombo', 'Western', '10001', 1);

INSERT INTO Instrument VALUES (1, 'Acoustic Guitar', 'F310', 'Yamaha', 'Wooden guitar', 3.2, 'Wood', '100x30', 55000, 1, 1, '980045612V');
INSERT INTO InstrumentColor VALUES (1, 'Brown');
INSERT INTO InstrumentImage VALUES (1, 'https://melodymart.com/images/guitar1.jpg');

INSERT INTO OrderTable (OrderDate, TotalAmount, Status, Street, City, PostalCode, CustomerNIC)
VALUES ('2024-04-01', 55000, 'Pending', 'Main Street', 'Colombo', '10001', '990011223V');

INSERT INTO Payment (OrderID, PaymentDate, PaymentMethod, CardCVV, TransactionStatus)
VALUES (1, '2024-04-02', 'Card', '123', 'Completed');

-- ======================================================
--  8. EXAMPLE QUERIES (5 TYPES)
-- ======================================================

-- 1️⃣ Simple SELECT
SELECT * FROM Instrument;

-- 2️⃣ INNER JOIN
SELECT C.CustomerNIC, P.Name, O.OrderID, O.TotalAmount
FROM Customer C
JOIN Person P ON C.CustomerNIC = P.NIC
JOIN OrderTable O ON O.CustomerNIC = C.CustomerNIC;

-- 3️⃣ Aggregation
SELECT COUNT(OrderID) AS TotalOrders, SUM(TotalAmount) AS TotalRevenue FROM OrderTable;

-- 4️⃣ GROUP BY / HAVING
SELECT City, COUNT(OrderID) AS OrderCount
FROM OrderTable
GROUP BY City
HAVING COUNT(OrderID) > 0;

-- 5️⃣ Subquery
SELECT Name FROM Person
WHERE NIC IN (SELECT CustomerNIC FROM Customer WHERE LoyaltyPoints > 50);

-- ======================================================
--  9. STORED PROCEDURE
-- ======================================================
CREATE PROCEDURE UpdateLoyalty
    @CustomerNIC VARCHAR(15),
    @EarnedPoints INT
AS
BEGIN
    UPDATE Customer
    SET LoyaltyPoints = LoyaltyPoints + @EarnedPoints
    WHERE CustomerNIC = @CustomerNIC;
END;
GO

EXEC UpdateLoyalty '990011223V', 20;
GO

-- ======================================================
-- 10. TRIGGER FOR LOGGING PAYMENTS
-- ======================================================
CREATE TABLE PaymentLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentID INT,
    LogDate DATETIME DEFAULT GETDATE(),
    Message NVARCHAR(255)
);

CREATE TRIGGER trg_PaymentLog
ON Payment
AFTER INSERT
AS
BEGIN
    INSERT INTO PaymentLog (PaymentID, Message)
    SELECT PaymentID, 'New Payment Recorded' FROM inserted;
END;
GO

INSERT INTO Payment (OrderID, PaymentDate, PaymentMethod, CardCVV, TransactionStatus)
VALUES (1, '2024-04-05', 'Cash', '333', 'Pending');

SELECT * FROM PaymentLog;
GO






