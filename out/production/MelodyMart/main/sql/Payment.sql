use MelodyMartDB


select * from Payment
select * from Orders
select * from Customer
select * from Person
select * from Seller

-- 1. Create PaymentMethods table
CREATE TABLE PaymentMethods (
    PaymentMethodID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    PaymentMethodType VARCHAR(20) NOT NULL DEFAULT 'Credit Card',
    CardHolderName NVARCHAR(100),
    LastFourDigits CHAR(4),
    ExpiryDate DATE,
    PaymentProviderToken VARCHAR(255) UNIQUE,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 2. Remove CVV column (SECURITY FIX)
ALTER TABLE Payment DROP COLUMN cvv;

-- 3. Add PaymentMethodID reference
ALTER TABLE Payment 
ADD PaymentMethodID INT NULL,
    CONSTRAINT FK_Payment_PaymentMethods 
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID);

-- 4. Create payment methods for existing customers
INSERT INTO PaymentMethods (CustomerID, PaymentMethodType, CardHolderName, LastFourDigits, ExpiryDate, PaymentProviderToken)
SELECT DISTINCT 
    o.CustomerID,
    'Credit Card' as PaymentMethodType,
    p.FirstName + ' ' + p.LastName as CardHolderName,
    '0000' as LastFourDigits, -- Placeholder
    DATEADD(YEAR, 1, GETDATE()) as ExpiryDate, -- Placeholder
    NEWID() as PaymentProviderToken
FROM Payment pm
INNER JOIN Orders o ON pm.OrderID = o.OrderID
INNER JOIN Customer c ON o.CustomerID = c.CustomerID
INNER JOIN Person p ON c.PersonID = p.PersonID
WHERE NOT EXISTS (
    SELECT 1 FROM PaymentMethods pm2 
    WHERE pm2.CustomerID = o.CustomerID
);

-- 5. Link existing payments to payment methods
UPDATE Payment 
SET PaymentMethodID = (
    SELECT TOP 1 PaymentMethodID 
    FROM PaymentMethods pm 
    INNER JOIN Orders o ON pm.CustomerID = o.CustomerID 
    WHERE o.OrderID = Payment.OrderID
)
WHERE PaymentMethodID IS NULL;

-- Test queries to verify normalization worked
SELECT * FROM PaymentMethods; -- Should show new payment methods
SELECT * FROM Payment; -- Should show PaymentMethodID populated



select CustomerId from Customer

-- First, check what customers exist
SELECT CustomerID FROM Customer;

-- Then use the correct CustomerID (replace 1 with actual ID from above query)
INSERT INTO PaymentMethods 
(CustomerID, PaymentMethodType, CardHolderName, LastFourDigits, ExpiryDate, PaymentProviderToken)
VALUES 
(2, 'Credit Card', 'Amandee Jayasinghe', '1234', '2025-12-01', 'tok_1A2b3C4d5E6f7G8h9');

-- First, make sure the PaymentMethods record was created successfully
SELECT * FROM PaymentMethods;

-- 1. First, create a PaymentMethod for your actual CustomerID (which is 2)
INSERT INTO PaymentMethods 
(CustomerID, PaymentMethodType, CardHolderName, LastFourDigits, ExpiryDate, PaymentProviderToken)
VALUES 
(2, 'Credit Card', 'Jainadu Jayasinghe', '1234', '2025-12-01', NEWID());

-- Check the PaymentMethod was created
SELECT * FROM PaymentMethods;
-------------------------------
-- 2. Create an Order (DON'T specify OrderID - let identity column auto-generate)
INSERT INTO Orders 
(CustomerID, SellerID, OrderDate, TotalAmount, Status )
VALUES 
(2, 1, GETDATE(), 99.99, 'Pending' );

-- Get the auto-generated OrderID
DECLARE @NewOrderID INT = SCOPE_IDENTITY();
PRINT 'New Order created with ID: ' + CAST(@NewOrderID AS VARCHAR);
---------------
-- All in one batch
DECLARE @NewOrderID INT;

INSERT INTO Orders 
(CustomerID, SellerID, OrderDate, TotalAmount, Status)
VALUES 
(2, 1, GETDATE(), 99.99, 'Pending');

SET @NewOrderID = SCOPE_IDENTITY();

INSERT INTO Payment 
(OrderID, PaymentDate, Amount, PaymentMethod, TransactionID, Status, PaymentMethodID)
VALUES 
(@NewOrderID, GETDATE(), 99.99, 'Visa', 'txn_123456789', 'Completed', 2);

-- 4. Verify everything worked
SELECT 
    p.PaymentID,
    p.OrderID,
    p.PaymentMethod,
    p.Status,
    pm.CardHolderName,
    pm.LastFourDigits,
    c.CustomerID,
    per.FirstName + ' ' + per.LastName as CustomerName
FROM Payment p
INNER JOIN PaymentMethods pm ON p.PaymentMethodID = pm.PaymentMethodID
INNER JOIN Orders o ON p.OrderID = o.OrderID
INNER JOIN Customer c ON o.CustomerID = c.CustomerID
INNER JOIN Person per ON c.PersonID = per.PersonID;

select * from Payment
select * from Customer
select * from Orders
SELECT * FROM PaymentMethods