-- Use the database
USE MelodyMartDB
GO

-- Create users table
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    role NVARCHAR(50) NOT NULL CHECK (role IN ('customer', 'seller', 'admin')),
    country NVARCHAR(10) NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE()
)
GO

ALTER LOGIN sa WITH PASSWORD = 'H@5iru2004';

