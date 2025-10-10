use MelodyMartDB

CREATE TABLE Delivery (
    DeliveryID VARCHAR(10) PRIMARY KEY,
    id INT NOT NULL,
    DeliveryStatus NVARCHAR(50) DEFAULT 'Processing',
    EstimatedDeliveryDate DATETIME,
    ActualDeliveryDate DATETIME,
    CurrentLocation NVARCHAR(100),
    TrackingNumber NVARCHAR(50),
    EstimatedCost DECIMAL(8,2),
    DeliveryDate DATETIME DEFAULT GETDATE(),
    DeliveryCase NVARCHAR(100),
    FOREIGN KEY (id) REFERENCES Orders(id)
);


CREATE TRIGGER trg_DeliveryID_Generator
ON Delivery
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @NextID NVARCHAR(10);
    DECLARE @LastID NVARCHAR(10);
    DECLARE @NewNumber INT;

    -- Get the last DeliveryID
    SELECT @LastID = MAX(DeliveryID) FROM Delivery;

    IF @LastID IS NULL
        SET @NextID = 'D001';
    ELSE
    BEGIN
        SET @NewNumber = CAST(SUBSTRING(@LastID, 2, LEN(@LastID)) AS INT) + 1;
        SET @NextID = 'D' + RIGHT('000' + CAST(@NewNumber AS VARCHAR(3)), 3);
    END

    -- Insert with matching columns count
    INSERT INTO Delivery (
        DeliveryID, id, DeliveryStatus, EstimatedDeliveryDate,
        ActualDeliveryDate, CurrentLocation, TrackingNumber,
        EstimatedCost, DeliveryDate, DeliveryCase
    )
    SELECT 
        @NextID, i.id, i.DeliveryStatus, i.EstimatedDeliveryDate,
        i.ActualDeliveryDate, i.CurrentLocation, i.TrackingNumber,
        i.EstimatedCost, i.DeliveryDate, i.DeliveryCase
    FROM inserted i;
END;



INSERT INTO Delivery (
     DeliveryID, id, DeliveryStatus, EstimatedDeliveryDate, ActualDeliveryDate,
    CurrentLocation, TrackingNumber, EstimatedCost, DeliveryDate, DeliveryCase
)
VALUES
(1001, 201, 'Pending', '2025-10-10', NULL, 'Colombo Warehouse', 'TRK001', 2500.00, '2025-10-05', 'Standard Delivery'),
(1002, 202, 'In Transit', '2025-10-12', NULL, 'Kurunegala', 'TRK002', 1800.00, '2025-10-06', 'Express Delivery'),
(1003, 203, 'Delivered', '2025-10-07', '2025-10-07', 'Kandy', 'TRK003', 2200.00, '2025-10-04', 'Standard Delivery'),
(1004, 204, 'Delayed', '2025-10-09', NULL, 'Galle', 'TRK004', 2000.00, '2025-10-05', 'Fragile Package'),
(1005, 205, 'Out for Delivery', '2025-10-08', NULL, 'Matara', 'TRK005', 2300.00, '2025-10-06', 'Express Delivery');





