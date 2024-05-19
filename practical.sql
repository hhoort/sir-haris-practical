--create a database 
create database hoor
--create a table medicines
CREATE TABLE Medicines (
    medicine_id INT PRIMARY KEY,
    names VARCHAR(255),
    manufacturer VARCHAR(255),
    price DECIMAL(10),
    quantity_in_stock INT
);
--create a table Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    names VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255)
);
--create a table orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

--create a table orrder_deatails
CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    medicine_id INT,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
);

--recors of medicines
INSERT INTO Medicines (medicine_id, names, manufacturer, price, quantity_in_stock) VALUES
(1, 'Aspirin', 'PharmaCorp', 5.99, 100),
(2, 'Tylenol', 'HealthPlus', 7.99, 200),
(3, 'Amoxicillin', 'Antibiotix', 10.99, 150),
(4, 'Ibuprofen', 'PainFree', 6.99, 250),
(5, 'Cetirizine', 'AllerFree', 4.99, 300),
(6, 'Metformin', 'DiabeCare', 8.99, 120),
(7, 'Atorvastatin', 'CardioWell', 12.99, 180),
(8, 'Lisinopril', 'HeartHealth', 9.99, 90),
(9, 'Azithromycin', 'Antibiotix', 14.99, 110),
(10, 'Omeprazole', 'DigestWell', 11.99, 130);

-- records of customers
INSERT INTO Customers (customer_id, names, email, phone) VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890'),
(2, 'Jane Smith', 'jane.smith@example.com', '098-765-4321'),
(3, 'Alice Johnson', 'alice.johnson@example.com', '555-555-5555'),
(4, 'Robert Brown', 'robert.brown@example.com', '444-444-4444'),
(5, 'Maria Garcia', 'maria.garcia@example.com', '333-333-3333'),
(6, 'David Martinez', 'david.martinez@example.com', '222-222-2222'),
(7, 'Emily Davis', 'emily.davis@example.com', '111-111-1111'),
(8, 'Michael Wilson', 'michael.wilson@example.com', '777-777-7777'),
(9, 'Jessica Taylor', 'jessica.taylor@example.com', '888-888-8888'),
(10, 'Daniel Anderson', 'daniel.anderson@example.com', '999-999-9999');


--recods of orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1, 1, '2024-02-15'),
(2, 2, '2024-03-20'),
(3, 3, '2024-01-10'),
(4, 4, '2024-04-25'),
(5, 5, '2024-05-05'),
(6, 6, '2024-02-28'),
(7, 7, '2024-03-15'),
(8, 8, '2024-04-10'),
(9, 9, '2024-05-12'),
(10, 10, '2024-01-25');


--records of order_detals

INSERT INTO Order_Details (order_detail_id, order_id, medicine_id, quantity, total_price) VALUES
(1, 1, 1, 2, '11.98'),
(2, 1, 2, 1, '7.99'),
(3, 2, 3, 3, '32.97'),
(4, 3, 4, 1, '6.99'),
(5, 4, 5, 4, '19.96'),
(6, 5, 6, 2, '17.98'),
(7, 6, 7, 1, '12.99'),
(8, 7, 8, 2, '19.98'),
(9, 8, 9, 1, '14.99'),
(10, 9, 10, 2, '23.98'),
(11, 10, 1, 1, '5.99'),
(12, 10, 2, 2, '15.98');

--1)Create a view to display the names and prices of medicines in stock.

--CREATE VIEW 
--MedicinesInStock
--AS
--SELECT names, price
--FROM Medicines
--WHERE quantity_in_stock > 0;

--select names , price from MedicinesInStock;

--2)Retrieve the names of customers along with their email addresses who have placed an order after January 1, 2024.

--SELECT C.names, C.email
--FROM Customers C
--JOIN Orders O ON C.customer_id = O.customer_id
--WHERE O.order_date > '2024-01-01';


--3)List all orders with the total price of each order.

--SELECT O.order_id, SUM(OD.total_price) AS total_order_price
--FROM Orders O
--JOIN Order_Details OD ON O.order_id = OD.order_id
--GROUP BY O.order_id;


--4)Find the total number of orders placed by each customer.

--SELECT C.customer_id, C.names, COUNT(O.order_id) AS total_orders
--FROM Customers C
--JOIN Orders O ON C.customer_id = O.customer_id
--GROUP BY C.customer_id, C.names;


--5)Trigger to update the quantity of medicines in stock after an order is placed.

--CREATE TRIGGER UpdateMedicineStock
--AFTER INSERT ON Order_Details
--FOR EACH ROW
--BEGIN
--    UPDATE Medicines
--    SET quantity_in_stock = quantity_in_stock - NEW.quantity
--    WHERE medicine_id = NEW.medicine_id;
--END;

--6)Retrieve the total number of customers who have ordered more than 5 times.

SELECT COUNT(*)
FROM (
    SELECT customer_id
    FROM Orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 5
) AS FrequentCustomers;
