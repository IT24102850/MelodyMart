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

-- 4. Update existing payments to link with PaymentMethods (if you have existing data)
UPDATE Payment 
SET PaymentMethodID = (
    SELECT TOP 1 PaymentMethodID 
    FROM PaymentMethods pm 
    INNER JOIN Orders o ON pm.CustomerID = o.CustomerID 
    WHERE o.OrderID = Payment.OrderID
)
WHERE PaymentMethodID IS NULL;