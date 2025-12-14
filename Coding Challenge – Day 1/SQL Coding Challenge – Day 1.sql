CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50)
);
desc Customers;
INSERT INTO Customers (customer_id, name, city) VALUES
(1, 'Arjun', 'Bengaluru'),
(2, 'Sneha', 'Hyderabad'),
(3, 'Rahul', 'Chennai'),
(4, 'Priya', 'Bengaluru'),
(5, 'Kiran', 'Mumbai'),
(6, 'Divya', 'Bengaluru'),
(7, 'Vikram', 'Hyderabad'),
(8, 'Asha', 'Chennai'),
(9, 'Manoj', 'Pune'),
(10, 'Swathi', 'Bengaluru');
select * from Customers;
CREATE TABLE Orders (
order_id INT PRIMARY KEY,
customer_id INT,
restaurant VARCHAR(50),
amount DECIMAL(10,2),
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
select * from Orders; 
INSERT INTO Orders (order_id, customer_id, restaurant, amount, order_date) VALUES
(101, 1, 'Meghana Foods', 550.00, '2025-01-01'),
(102, 2, 'Paradise Biryani', 780.00, '2025-01-03'),
(103, 3, 'KFC', 420.00, '2025-01-05'),
(104, 1, 'Empire Restaurant', 300.00, '2025-01-08'),
(105, 4, 'Meghana Foods', 950.00, '2025-01-10'),
(106, 6, 'Truffles', 1100.00, '2025-01-11'),
(107, 7, 'Kritunga', 650.00, '2025-01-12'),
(108, 4, 'KFC', 350.00, '2025-01-14'),
(109, 9, 'Burger King', 270.00, '2025-01-15'),
(110, 10, 'Meghana Foods', 1250.00, '2025-01-16');

select customer_id, name from Customers where Customers.customer_id in (select distinct customer_id from Orders); 

SELECT c.customer_id, c.name, SUM(o.amount) AS total_order_value
FROM Customers c JOIN Orders o ON c.customer_id = o.customer_id GROUP BY c.customer_id;

SELECT c.customer_id, c.name, SUM(o.amount) AS total_order_value
FROM Customers c JOIN Orders o ON c.customer_id = o.customer_id GROUP BY c.customer_id order by total_order_value desc limit 3;

SELECT * FROM Orders where order_date >((select max(order_date) FROM Orders) - INTERVAL 7 DAY) order by order_date;

SELECT c.customer_id, c.name FROM Customers c LEFT JOIN Orders o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;
    
SELECT restaurant FROM Orders o GROUP BY restaurant order by count(restaurant) desc limit 1;

SELECT c.customer_id, c.name, c.city, SUM(o.amount) AS total_order_value FROM Customers c JOIN Orders o 
ON c.customer_id = o.customer_id  where city = "Bengaluru" GROUP BY c.customer_id having SUM(o.amount) > 1000;

SELECT  distinct c.city, Count(c.city) AS City_Orders FROM Customers c JOIN Orders o ON c.customer_id = o.customer_id group by c.city;

SELECT  distinct restaurant, AVG(amount) AS City_Amount FROM Orders group by restaurant;

SELECT  distinct c.customer_id, c.name, Count(o.order_id) AS Customer_Orders FROM Customers c JOIN Orders o ON c.customer_id = o.customer_id group by c.customer_id having count(order_id) > 5;

