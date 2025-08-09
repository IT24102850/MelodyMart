-- Creating the MelodyMart database
CREATE DATABASE MelodyMartDB;
GO

-- Use the MelodyMartDB database
USE MelodyMartDB;
GO

-- Table for Users (Customers, Sellers, Admins)
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('customer', 'seller', 'admin')),
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    created_date DATETIME DEFAULT GETDATE()
);
GO

-- Table for Instruments
CREATE TABLE Instruments (
    instrument_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(50) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    stock INT NOT NULL DEFAULT 0,
    available BIT NOT NULL DEFAULT 1,
    seller_id INT NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
GO

-- Table for Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('processing', 'shipped', 'delivered', 'cancelled')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
GO

-- Table for Order Items (linking Instruments to Orders)
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    instrument_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (instrument_id) REFERENCES Instruments(instrument_id) ON DELETE CASCADE
);
GO

-- Table for Repair Requests
CREATE TABLE RepairRequests (
    request_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    instrument_id INT NOT NULL,
    description TEXT NOT NULL,
    request_date DATETIME DEFAULT GETDATE(),
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'scheduled', 'in_progress', 'completed')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (instrument_id) REFERENCES Instruments(instrument_id) ON DELETE CASCADE
);
GO

-- Table for Delivery Status
CREATE TABLE DeliveryStatus (
    delivery_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('in_transit', 'delivered', 'returned')),
    update_date DATETIME DEFAULT GETDATE(),
    tracking_number VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
GO