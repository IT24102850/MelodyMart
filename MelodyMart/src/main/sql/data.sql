USE MelodyMartDB;
GO



-- Insert sample Users
INSERT INTO Users (name, email, password, role, address, phone, country) VALUES
('John Doe', 'john@example.com', 'password123', 'customer', '123 Main St, Colombo', '0711234567', 'SL'),
('Jane Seller', 'jane@example.com', 'seller123', 'seller', '456 Market Rd, Kandy', '0779876543', 'SL'),
('Admin User', 'admin@example.com', 'admin123', 'admin', '789 Admin Ave, Galle', '0701112233', 'SL'),
('Alice Smith', 'alice@example.com', 'alice123', 'customer', '321 Park Lane, Negombo', '0765554433', 'SL');
GO

-- Insert sample Instruments
INSERT INTO Instruments (name, description, price, category, stock, seller_id) VALUES
('Acoustic Guitar', 'High-quality spruce top acoustic guitar', 299.99, 'Guitar', 10, 2),
('Electric Keyboard', '61-key digital keyboard with MIDI support', 199.99, 'Keyboard', 15, 2),
('Drum Set', '5-piece drum kit with cymbals', 499.99, 'Drums', 5, 2),
('Electric Guitar', 'Solid body electric guitar with dual humbuckers', 399.99, 'Guitar', 8, 2);
GO

-- Insert sample Orders
INSERT INTO Orders (customer_id, instrument_id, quantity, total_price, status, delivery_address) VALUES
(1, 1, 1, 299.99, 'pending', '123 Main St, Colombo'),
(4, 2, 2, 399.98, 'confirmed', '321 Park Lane, Negombo'),
(1, 3, 1, 499.99, 'shipped', '123 Main St, Colombo');
GO

-- Insert sample Repair Requests
INSERT INTO RepairRequests (customer_id, instrument_id, issue_description, status, estimated_cost) VALUES
(1, 1, 'String buzzing on 3rd fret', 'submitted', 50.00),
(4, 2, 'Key not responding', 'in_progress', 75.00);
GO

-- Insert sample Delivery Statuses
INSERT INTO DeliveryStatuses (order_id, status, notes) VALUES
(1, 'dispatched', 'Package handed to courier'),
(3, 'in_transit', 'Expected delivery in 2 days');
GO

-- Insert sample Feedback
INSERT INTO Feedback (customer_id, instrument_id, rating, comment) VALUES
(1, 1, 4, 'Great sound quality, but setup was tricky'),
(4, 2, 5, 'Perfect for beginners, easy to use');
GO