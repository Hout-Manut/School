USE inventory;

INSERT INTO Customers (name, phone, email, address) VALUES
('Vannak Seng', '+855 97 123 4567', 'vannak.seng@example.kh', '123 Sisowath Quay, Daun Penh, Phnom Penh'),
('Chanrithy Lim', '+855 92 234 5678', 'chanrithy.lim@example.kh', '45Eo Street 308, BKK1, Chamkar Mon, Phnom Penh'),
('Sopheap Chea', '+855 93 345 6789', 'sopheap.chea@example.kh', '789 Russian Blvd, Toul Kork, Phnom Penh'),
('Malis Keo', '+855 96 456 7890', 'malis.keo@example.kh', '56AEo Mao Tse Toung Blvd, Boeng Keng Kang, Phnom Penh'),
('Bopha Sok', '+855 95 567 8901', 'bopha.sok@example.kh', '92B Street 432, Tumnup Teuk, Chamkar Mon, Phnom Penh');



INSERT INTO Suppliers (name, contactPerson, phone, email, address) VALUES
('Phnom Penh Supplies', 'Kosal Vann', '+855 98 765 4321', 'kosal.vann@ppsupplies.kh', '32 Preah Norodom Blvd, Phnom Penh'),
('Cambodia Agritech', 'Srey Pov', '+855 88 654 3210', 'sreypov@cambagritech.kh', '128Eo Mao Tse Toung Blvd, Phnom Penh'),
('Siem Reap Electronics', 'Chanthou Oum', '+855 77 543 2109', 'chanthou.oum@srelectronics.kh', '75 Sivutha Blvd, Siem Reap'),
('Kampot Builders Co.', 'Rithy Thon', '+855 89 432 1098', 'rithy.thon@kampotbuilders.kh', '12 Makara St, Kampot'),
('Angkor Textiles', 'Moni Mok', '+855 90 321 0987', 'moni.mok@angkortextiles.kh', '47 Charles de Gaulle, Siem Reap');


INSERT INTO Categories (name, type, description) VALUES
('Electronics', 'Gadgets', 'Electronic devices and gadgets'),
('Clothing', 'Apparel', 'Various kinds of apparel'),
('Groceries', 'Food', 'Daily essential food items'),
('Books', 'Literature', 'Different genres of books'),
('Furniture', 'Home Goods', 'Furniture for home and office');


INSERT INTO Products (idCategories, name, description, buyPrice, salePrice) VALUES
(1, 'Smartphone', 'Latest model with advanced features', 300.00, 450.00),
(1, 'Laptop', 'Lightweight and powerful for professionals', 700.00, 1000.00),
(2, 'Jeans', 'Comfortable and stylish for everyday wear', 20.00, 40.00),
(2, 'T-shirt', 'Casual wear with various designs', 10.00, 20.00),
(3, 'Rice', 'Staple food, 5kg bag', 5.00, 7.00),
(4, 'Mystery Novel', 'Thrilling mystery and suspense', 8.00, 15.00),
(4, 'Science Fiction', 'Exploring futuristic themes and possibilities', 10.00, 18.00),
(5, 'Coffee Table', 'Modern design, made of natural wood', 50.00, 80.00),
(5, 'Office Chair', 'Ergonomic design for comfort', 60.00, 120.00),
(4, 'Manga', 'Best selling', 4.00, 8.00);


INSERT INTO Warehouses (name, address, capacity) VALUES
('Warehouse A', '68 St. 130, Sangkat Phsar Thmei I, Khan Daun Penh, Phnom Penh, Cambodia', 1200.00),
('Warehouse B', '22AEo Sothearos Blvd, Tonle Bassac, Chamkar Mon, Phnom Penh, Cambodia', 800.00),
('Warehouse C', '199C Monivong Blvd, Boeng Keng Kang, Phnom Penh, Cambodia', 500.00),
('Warehouse D', '77 Street 240, Chaktomuk, Daun Penh, Phnom Penh, Cambodia', 1000.00),
('Warehouse E', '153 Preah Sisowath Quay, Wat Phnom, Daun Penh, Phnom Penh, Cambodia', 1500.00);


INSERT INTO Inventories (idProducts, idWarehouses, quantity) VALUES
(1, 1, 100), -- Smartphone in Warehouse 1
(2, 1, 50),  -- Laptop in Warehouse 1
(3, 2, 200), -- Jeans in Warehouse 2
(4, 2, 300), -- T-shirt in Warehouse 2
(5, 3, 500), -- Rice in Warehouse 3
(6, 4, 150), -- Mystery Novel in Warehouse 4
(7, 4, 150), -- Science Fiction in Warehouse 4
(8, 5, 80),  -- Coffee Table in Warehouse 5
(9, 5, 100), -- Office Chair in Warehouse 5
(10, 1, 50); -- Manga in Warehouse 1


INSERT INTO Employees (idWarehouses, name, position, gender, dateOfBirth, dateHired, phone, email) VALUES
(1, 'Sokha Chan', 'Warehouse Manager', 'Male', '1985-04-12', '2010-05-01', '+855 98 765 4321', 'sokha.chan@example.kh'),
(2, 'Maly Ly', 'Inventory Specialist', 'Female', '1990-08-23', '2015-03-15', '+855 92 345 6789', 'maly.ly@example.kh'),
(3, 'Vireak Bun', 'Operations Coordinator', 'Male', '1988-11-30', '2012-07-20', '+855 93 456 7890', 'vireak.bun@example.kh'),
(4, 'Chantou Rith', 'Logistics Analyst', 'Female', '1992-02-05', '2018-11-01', '+855 96 567 8901', 'chantou.rith@example.kh'),
(5, 'Pheakdey Sok', 'Quality Control Specialist', 'Male', '1987-05-17', '2009-09-04', '+855 95 678 9012', 'pheakdey.sok@example.kh');


INSERT INTO Purchases (idSuppliers, idEmployees, date, totalPrice) VALUES
(1, 1, '2024-03-01', 1200.00),
(2, 2, '2024-03-02', 800.00),
(3, 3, '2024-03-03', 1500.00),
(4, 4, '2024-03-04', 2300.00),
(5, 5, '2024-03-05', 500.00);


INSERT INTO PurchaseDetails (idPurchases, idProducts, quantity, pricePerItem) VALUES
(1, 1, 20, 50.00),  -- Buying 20 Smartphones at $50 each from Supplier 1 by Employee 1
(1, 2, 10, 70.00),  -- Buying 10 Laptops at $70 each from Supplier 1 by Employee 1
(2, 3, 40, 20.00),  -- Buying 40 Jeans at $20 each from Supplier 2 by Employee 2
(3, 4, 60, 15.00),  -- Buying 60 T-shirts at $15 each from Supplier 3 by Employee 3
(3, 7, 30, 10.00),  -- Buying 30 Science Fiction Books at $10 each from Supplier 3 by Employee 3
(4, 5, 100, 5.00),  -- Buying 100 Rice bags at $5 each from Supplier 4 by Employee 4
(4, 6, 50, 8.00),   -- Buying 50 Mystery Novels at $8 each from Supplier 4 by Employee 4
(5, 8, 15, 40.00),  -- Buying 15 Coffee Tables at $40 each from Supplier 5 by Employee 5
(5, 9, 10, 60.00),  -- Buying 10 Office Chairs at $60 each from Supplier 5 by Employee 5
(5, 10, 5, 4.00);   -- Buying 5 Mangas at $4 each from Supplier 5 by Employee 5


INSERT INTO Orders (idCustomers, idEmployees, date, totalPrice, status) VALUES
(1, 1, '2024-03-10', 1400.00, 'Completed'),
(2, 2, '2024-03-11', 900.00, 'Completed'),
(3, 3, '2024-03-12', 1600.00, 'Shipped'),
(4, 4, '2024-03-13', 2400.00, 'Processing'),
(5, 5, '2024-03-14', 600.00, 'Completed');


INSERT INTO OrderDetails (idOrders, idProducts, quantity, pricePerItem) VALUES
(1, 1, 10, 60.00),   -- Selling 10 Smartphones at $60 each in Order 1
(1, 10, 5, 8.00),    -- Selling 5 Manga at $8 each in Order 1
(2, 3, 20, 25.00),   -- Selling 20 Jeans at $25 each in Order 2
(2, 4, 30, 18.00),   -- Selling 30 T-shirts at $18 each in Order 2
(3, 5, 50, 7.00),    -- Selling 50 Rice bags at $7 each in Order 3
(3, 6, 10, 17.00),   -- Selling 10 Mystery Novels at $17 each in Order 3
(4, 7, 20, 20.00),   -- Selling 20 Science Fiction books at $20 each in Order 4
(4, 8, 8, 45.00),    -- Selling 8 Coffee Tables at $45 each in Order 4
(5, 9, 5, 65.00),    -- Selling 5 Office Chairs at $65 each in Order 5
(5, 1, 15, 55.00);   -- Selling 15 Smartphones at $55 each in Order 5


SELECT Orders.idOrders, Customers.name AS CustomerName, Employees.name AS EmployeeName FROM Orders INNER JOIN Customers ON Orders.idCustomer = Customers.idCustomer INNER JOIN Employees ON Orders.idEmployee = Employees.idEmployee;
