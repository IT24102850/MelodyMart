-- Create the MelodyMartDB database
CREATE DATABASE MelodyMartDB;
GO

-- Use the MelodyMartDB database
USE MelodyMartDB;
GO

-- Table for Users (Customers, Sellers, Admins)
CREATE TABLE Users (
                       id INT PRIMARY KEY IDENTITY(1,1),
                       name NVARCHAR(100) NOT NULL,
                       email NVARCHAR(100) UNIQUE NOT NULL,
                       password NVARCHAR(100) NOT NULL, -- Plain text for prototype; use hashed passwords in production
                       role NVARCHAR(20) NOT NULL CHECK (role IN ('customer', 'seller', 'admin')),
                       address NVARCHAR(255),
                       phone NVARCHAR(20),
                       country NVARCHAR(50), -- Added to support country field from sign-up form
                       created_at DATETIME DEFAULT GETDATE()
);
GO

-- Table for Instruments (Product Catalog)
CREATE TABLE Instruments (
                             id INT PRIMARY KEY IDENTITY(1,1),
                             name NVARCHAR(100) NOT NULL,
                             description NVARCHAR(500),
                             price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
                             category NVARCHAR(50) NOT NULL,
                             stock INT NOT NULL CHECK (stock >= 0),
                             seller_id INT NOT NULL,
                             created_at DATETIME DEFAULT GETDATE(),
                             FOREIGN KEY (seller_id) REFERENCES Users(id) ON DELETE CASCADE
);
GO

-- Table for Orders
CREATE TABLE Orders (
                        id INT PRIMARY KEY IDENTITY(1,1),
                        customer_id INT NOT NULL,
                        instrument_id INT NOT NULL,
                        quantity INT NOT NULL CHECK (quantity > 0),
                        total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
                        status NVARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'shipped', 'delivered', 'cancelled')),
                        order_date DATETIME DEFAULT GETDATE(),
                        delivery_address NVARCHAR(255) NOT NULL,
                        FOREIGN KEY (customer_id) REFERENCES Users(id) ON DELETE CASCADE,
                        FOREIGN KEY (instrument_id) REFERENCES Instruments(id) ON DELETE CASCADE
);
GO

-- Table for Repair Requests
CREATE TABLE RepairRequests (
                                id INT PRIMARY KEY IDENTITY(1,1),
                                customer_id INT NOT NULL,
                                instrument_id INT NOT NULL,
                                issue_description NVARCHAR(500) NOT NULL,
                                status NVARCHAR(20) NOT NULL CHECK (status IN ('submitted', 'in_progress', 'completed', 'cancelled')),
                                request_date DATETIME DEFAULT GETDATE(),
                                estimated_cost DECIMAL(10,2),
                                FOREIGN KEY (customer_id) REFERENCES Users(id) ON DELETE CASCADE,
                                FOREIGN KEY (instrument_id) REFERENCES Instruments(id) ON DELETE CASCADE
);
GO

-- Table for Delivery Statuses
CREATE TABLE DeliveryStatuses (
                                  id INT PRIMARY KEY IDENTITY(1,1),
                                  order_id INT NOT NULL,
                                  status NVARCHAR(20) NOT NULL CHECK (status IN ('dispatched', 'in_transit', 'delivered', 'returned')),
                                  update_date DATETIME DEFAULT GETDATE(),
                                  notes NVARCHAR(255),
                                  FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE
);
GO

-- Table for Customer Feedback
CREATE TABLE Feedback (
                          id INT PRIMARY KEY IDENTITY(1,1),
                          customer_id INT NOT NULL,
                          instrument_id INT NOT NULL,
                          rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
                          comment NVARCHAR(500),
                          feedback_date DATETIME DEFAULT GETDATE(),
                          FOREIGN KEY (customer_id) REFERENCES Users(id) ON DELETE CASCADE,
                          FOREIGN KEY (instrument_id) REFERENCES Instruments(id) ON DELETE CASCADE
);
GO