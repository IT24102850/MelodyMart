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





