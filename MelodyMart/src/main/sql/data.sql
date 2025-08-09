-- Insert sample data into the users table
INSERT INTO users (username, password, email, role, is_approved) VALUES
('john_doe', 'password123', 'john@example.com', 'customer', 1),
('jane_seller', 'sellerpass', 'jane@example.com', 'seller', 0),
('admin_user', 'adminpass', 'admin@example.com', 'admin', 1);

-- Insert sample data into the instruments table
INSERT INTO instruments (name, brand, price, category, description, image_url, stock, available) VALUES
('Acoustic Guitar', 'Yamaha', 299.99, 'guitars', 'A high-quality acoustic guitar for beginners.', '/images/acoustic_guitar.jpg', 10, 1),
('Electric Keyboard', 'Casio', 199.99, 'keyboards', 'Portable keyboard with 61 keys.', '/images/electric_keyboard.jpg', 5, 1),
('Drum Set', 'Pearl', 499.99, 'drums', 'Professional drum set with cymbals.', '/images/drum_set.jpg', 3, 1);

-- Insert sample data into the orders table
INSERT INTO orders (user_id, total_price, order_date, status, delivery_address) VALUES
(1, 299.99, '2025-08-01', 'shipped', '123 Music Lane, Colombo, Sri Lanka'),
(1, 199.99, '2025-08-05', 'processing', '123 Music Lane, Colombo, Sri Lanka');

-- Insert sample data into the order_items table
INSERT INTO order_items (order_id, instrument_id) VALUES
(1, 1), -- John Doe ordered an Acoustic Guitar
(2, 2); -- John Doe ordered an Electric Keyboard