--_-_1_-_--
CREATE DATABASE Lab8;
--_-_2_-_--
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4, 2)
);

INSERT INTO salesman VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'Rome', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO customers VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 300, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO orders VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760.0, '2012-09-10', 3002, 5001);
--_-_3_-_--
CREATE ROLE junior_dev WITH LOGIN;
--_-_4_-_--
CREATE VIEW NewYorkSales AS
SELECT * FROM salesman
WHERE city = 'New York';
--_-_5_-_--
CREATE VIEW Order_Customer_Saleman AS
    SELECT
        o.ord_no, c.cust_name, s.name as salesman_name
    FROM
        orders as o
    JOIN customers as c on o.customer_id = c.customer_id
        JOIN salesman as s on s.salesman_id = o.salesman_id;

SELECT * FROM Order_Customer_Saleman;
GRANT ALL PRIVILEGES ON Order_Customer_Saleman TO junior_dev;
--_-_6_-_--
CREATE VIEW Customers_HG as
    SELECT
        c.cust_name, c.grade
    FROM
        customers as c
    WHERE grade = (SELECT max(grade) FROM customers);
SELECT * FROM Customers_HG;
GRANT SELECT on Customers_HG to junior_dev;
--_-_7_-_--
CREATE VIEW num_of_salesman as
    SELECT
        s.city, count(s.name) as count_of_salesmans
    FROM
        salesman as s
    GROUP BY s.city;
SELECT * FROM num_of_salesman;
--_-_8_-_--
CREATE VIEW saleman_with_customers AS
SELECT
    s.name AS salesman_name,
FROM
    salesman AS s
JOIN
    customers AS c
    ON s.salesman_id = c.salesman_id;

SELECT * FROM saleman_with_customers;
--_-_9_-_--
CREATE ROLE intern;
GRANT junior_dev TO intern;
