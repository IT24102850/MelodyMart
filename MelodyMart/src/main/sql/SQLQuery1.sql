use MelodyMartDB

select * from Person

ALTER TABLE Person
ADD role NVARCHAR(50) NULL;



DROP TRIGGER IF EXISTS trg_AutoGeneratePersonID;
GO




CREATE OR ALTER TRIGGER trg_AutoGeneratePersonID
ON Person
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @NextID NVARCHAR(10);
    DECLARE @MaxNum INT;

    -- Extract numeric part safely from existing PersonIDs
    SELECT @MaxNum = MAX(TRY_CAST(
        RIGHT(PersonID, LEN(PersonID) - 1) AS INT)
    )
    FROM Person
    WHERE ISNUMERIC(RIGHT(PersonID, LEN(PersonID) - 1)) = 1;

    -- Generate next ID
    IF @MaxNum IS NULL
        SET @NextID = 'P001';  -- first record
    ELSE
        SET @NextID = 'P' + RIGHT('000' + CAST(@MaxNum + 1 AS NVARCHAR(3)), 3);

    -- Insert with new PersonID
    INSERT INTO Person (
        PersonID, FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country,
        RegistrationDate, LastLogin, role
    )
    SELECT 
        @NextID, FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country,
        RegistrationDate, LastLogin, role
    FROM inserted;
END;
GO


DELETE FROM Person;

INSERT INTO Person (FirstName, LastName, Email, Password, role)
VALUES ('John', 'Doe', 'john@example.com', 'secret', 'customer');

INSERT INTO Person (FirstName, LastName, Email, Password, role)
VALUES ('Jane', 'Smith', 'jane@example.com', 'secure', 'admin');

SELECT PersonID, FirstName, role FROM Person;





DROP TABLE  Person;
GO

CREATE TABLE Person (
    PersonID NVARCHAR(10) PRIMARY KEY,  -- string ID
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
    role NVARCHAR(50)
);
GO


SELECT 
    f.name AS FK_Name,
    OBJECT_NAME(f.parent_object_id) AS ReferencingTable
FROM sys.foreign_keys AS f
WHERE f.referenced_object_id = OBJECT_ID('Person');

ALTER TABLE Address DROP CONSTRAINT FK__Address__PersonI__32767D0B;


DROP TABLE Person;

CREATE OR ALTER TRIGGER trg_AutoGeneratePersonID
ON Person
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @NextID NVARCHAR(10);
    DECLARE @LastID NVARCHAR(10);
    DECLARE @NumPart INT;

    -- Find last PersonID in table (numeric part only)
    SELECT TOP 1 @LastID = PersonID
    FROM Person
    WHERE PersonID LIKE 'P%'
    ORDER BY TRY_CAST(SUBSTRING(PersonID, 2, LEN(PersonID)) AS INT) DESC;

    IF @LastID IS NULL
        SET @NextID = 'P001';
    ELSE
    BEGIN
        SET @NumPart = TRY_CAST(SUBSTRING(@LastID, 2, LEN(@LastID)) AS INT);
        SET @NextID = 'P' + RIGHT('000' + CAST(@NumPart + 1 AS NVARCHAR(3)), 3);
    END;

    INSERT INTO Person (
        PersonID, FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country, RegistrationDate, LastLogin, role
    )
    SELECT 
        @NextID, FirstName, LastName, Email, Phone, Password,
        Street, City, State, ZipCode, Country, RegistrationDate, LastLogin, role
    FROM inserted;
END;
GO


INSERT INTO Person (FirstName, LastName, Email, Password, role)
VALUES ('John', 'Doe', 'john@example.com', 'secret', 'customer'),
       ('Jane', 'Smith', 'jane@example.com', 'secure', 'admin');

SELECT PersonID, FirstName, role FROM Person;


DROP TRIGGER IF EXISTS trg_AutoGeneratePersonID;
GO



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



INSERT INTO Person (FirstName, LastName, Email, Password, role)
VALUES ('John', 'Doe', 'john@example.com', 'secret', 'customer');

INSERT INTO Person (FirstName, LastName, Email, Password, role)
VALUES ('Jane', 'Smith', 'jane@example.com', 'secure', 'admin');

SELECT PersonID, FirstName, role FROM Person;




SELECT PersonID, FirstName, Email, Password, role 
FROM Person;


String sql = "SELECT * FROM Person WHERE Email=? AND Password=?";


INSERT INTO Person (PersonID, FirstName, LastName, Email, Password, role)
VALUES 

('P004', 'Michael', 'Brown', 'michael.brown@gmail.com', 'mike123', 'seller'),
('P005', 'Emily', 'Davis', 'emily.davis@gmail.com', 'emily123', 'customer'),
('P006', 'Daniel', 'Johnson', 'daniel.johnson@gmail.com', 'dan123', 'seller'),
('P007', 'Sophia', 'Garcia', 'sophia.garcia@gmail.com', 'sophia123', 'customer'),
('P008', 'William', 'Martinez', 'will.martinez@gmail.com', 'will123', 'seller'),
('P009', 'Olivia', 'Lopez', 'olivia.lopez@gmail.com', 'olivia123', 'customer'),
('P010', 'James', 'Hernandez', 'james.hernandez@gmail.com', 'james123', 'seller'),
('P011', 'Ava', 'Gonzalez', 'ava.gonzalez@gmail.com', 'ava123', 'customer'),
('P012', 'Lucas', 'Wilson', 'lucas.wilson@gmail.com', 'lucas123', 'seller'),
('P013', 'Mia', 'Anderson', 'mia.anderson@gmail.com', 'mia123', 'customer'),
('P014', 'Ethan', 'Thomas', 'ethan.thomas@gmail.com', 'ethan123', 'seller'),
('P015', 'Isabella', 'Moore', 'isabella.moore@gmail.com', 'isabella123', 'customer'),
('P016', 'Benjamin', 'Taylor', 'benjamin.taylor@gmail.com', 'ben123', 'seller'),
('P017', 'Charlotte', 'Jackson', 'charlotte.jackson@gmail.com', 'charlotte123', 'customer'),
('P018', 'Henry', 'White', 'henry.white@gmail.com', 'henry123', 'seller'),
('P019', 'Amelia', 'Harris', 'amelia.harris@gmail.com', 'amelia123', 'customer'),
('P020', 'Alexander', 'Clark', 'alex.clark@gmail.com', 'alex123', 'seller');



-- Drop the old table if it exists
DROP TABLE IF EXISTS RepairRequest;
GO

-- ✅ Create the improved RepairRequest table
CREATE TABLE RepairRequest (
    RepairRequestID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,  -- Who submitted the request
    OrderID INT NULL,     -- Optional: may link to a previous order
    IssueDescription NVARCHAR(500) NOT NULL,
    Photos NVARCHAR(MAX) NULL,  -- JSON or comma-separated URLs
    Status NVARCHAR(50) DEFAULT 'Submitted',
    Approved BIT DEFAULT 0,
    Comment NVARCHAR(500) NULL,
    EstimatedCost DECIMAL(8,2) NULL CHECK (EstimatedCost >= 0),
    RepairDate DATETIME NULL,
    RequestDate DATETIME DEFAULT GETDATE(),

    -- 🔗 Foreign Keys
    CONSTRAINT FK_RepairRequest_User FOREIGN KEY (UserID)
        REFERENCES Person(PersonID) ON DELETE CASCADE,

    CONSTRAINT FK_RepairRequest_Order FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID) ON DELETE SET NULL,

    -- 🔒 Data Validation
    CONSTRAINT CHK_RepairStatus CHECK (Status IN ('Submitted', 'Approved', 'In Progress', 'Completed', 'Rejected'))
);
GO


DROP TABLE IF EXISTS RepairRequest;
GO

CREATE TABLE RepairRequest (
    RepairRequestID INT IDENTITY(1,1) PRIMARY KEY,
    UserID NVARCHAR(10) NOT NULL,  -- must match Person.PersonID type
    OrderID INT NULL,
    IssueDescription NVARCHAR(500) NOT NULL,
    Photos NVARCHAR(MAX) NULL,  -- JSON or comma-separated URLs
    Status NVARCHAR(50) DEFAULT 'Submitted',
    Approved BIT DEFAULT 0,
    Comment NVARCHAR(500) NULL,
    EstimatedCost DECIMAL(8,2) NULL CHECK (EstimatedCost >= 0),
    RepairDate DATETIME NULL,
    RequestDate DATETIME DEFAULT GETDATE(),

    -- 🔗 Foreign Keys
    CONSTRAINT FK_RepairRequest_User FOREIGN KEY (UserID)
        REFERENCES Person(PersonID) ON DELETE CASCADE,

    CONSTRAINT FK_RepairRequest_Order FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID) ON DELETE SET NULL,

    -- 🔒 Data Validation
    CONSTRAINT CHK_RepairStatus CHECK (Status IN ('Submitted', 'Approved', 'In Progress', 'Completed', 'Rejected'))
);
GO



















-- Drop table if exists
IF OBJECT_ID('RepairRequest', 'U') IS NOT NULL
    DROP TABLE RepairRequest;
GO

-- Create RepairRequest table
CREATE TABLE RepairRequest (
    RepairRequestID NVARCHAR(10) PRIMARY KEY,  -- Custom ID like 'RR001'
    UserID NVARCHAR(10) NOT NULL,
    OrderID INT NULL,
    IssueDescription NVARCHAR(500) NOT NULL,
    Photos NVARCHAR(MAX) NULL,
    Status NVARCHAR(50) DEFAULT 'Submitted',
    Approved BIT DEFAULT 0,
    Comment NVARCHAR(500) NULL,
    EstimatedCost DECIMAL(8,2) NULL CHECK (EstimatedCost >= 0),
    RepairDate DATETIME NULL,
    RequestDate DATETIME DEFAULT GETDATE(),

    -- 🔗 Foreign Keys
    CONSTRAINT FK_RepairRequest_User FOREIGN KEY (UserID)
        REFERENCES Person(PersonID) ON DELETE CASCADE,

    CONSTRAINT FK_RepairRequest_Order FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID) ON DELETE SET NULL,

    -- 🔒 Data Validation
    CONSTRAINT CHK_RepairStatus CHECK (Status IN ('Submitted', 'Approved', 'In Progress', 'Completed', 'Rejected'))
);
GO

-- 🔔 Trigger to auto-generate IDs like RR001, RR002, etc.
CREATE TRIGGER trg_AutoGenerate_RepairRequestID
ON RepairRequest
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @NextID NVARCHAR(10);
    DECLARE @NumPart INT;

    -- Get current max numeric part
    SELECT @NumPart = ISNULL(MAX(CAST(SUBSTRING(RepairRequestID, 3, LEN(RepairRequestID)) AS INT)), 0)
    FROM RepairRequest;


    -- Generate new ID
    SET @NextID = 'RR' + RIGHT('000' + CAST(@NumPart + 1 AS NVARCHAR(3)), 3);

    -- Insert the row with generated ID
    INSERT INTO RepairRequest (
        RepairRequestID, UserID, OrderID, IssueDescription, Photos, Status, Approved, Comment, EstimatedCost, RepairDate, RequestDate
    )
    SELECT
        @NextID, UserID, OrderID, IssueDescription, Photos, Status, Approved, Comment, EstimatedCost, RepairDate, RequestDate
    FROM inserted;
END;
GO

use MelodyMartDB
select * from RepairRequest


INSERT INTO RepairRequest (UserID, IssueDescription)
VALUES ('P003', 'Guitar string snapped');

INSERT INTO RepairRequest (UserID, IssueDescription)
VALUES ('P003', 'Amp not working');

SELECT RepairRequestID, UserID, IssueDescription FROM RepairRequest;

DELETE FROM RepairRequest
WHERE RepairRequestID IN ('RR001', 'RR002');
