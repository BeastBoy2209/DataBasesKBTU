--__1__--
create database Lab5;
--__2__--
create table salesmans(
    salesman_id int primary key,
    name varchar(255),
    city varchar(255),
    commission float
);
create table customers(
    customer_id int primary key,
    cust_name varchar(255),
    city varchar(255),
    grade int,
    salesman_id int,
    foreign key(salesman_id) references salesmans(salesman_id)
);
create table orders(
    ord_no int primary key,
    purch_amt float,
    ord_date date,
    customer_id int,
    salesman_id int,
    FOREIGN KEY(customer_id) References customers(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesmans(salesman_id)
);

INSERT INTO salesmans (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);
--__3__--
SELECT SUM(purch_amt) AS total_purchase_amount FROM orders;
--__4__--
SELECT AVG(purch_amt) AS average_purchase_amount FROM orders;
--__5__--
SELECT COUNT(*) AS customer_count FROM customers WHERE cust_name IS NOT NULL;
--__6__--
SELECT MIN(purch_amt) AS minimum_purchase_amount FROM orders;
--__7__--
SELECT * FROM customers WHERE cust_name LIKE '%b';
--__8__--
SELECT ord_no AS Orders_From_NY FROM orders
JOIN customers ON customers.customer_id = orders.customer_id
WHERE customers.city = 'New York';
--__9__--
SELECT DISTINCT customers.* FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.purch_amt > 10;
--__10__--
SELECT SUM(grade) AS total_grade FROM customers;
--__11__--
SELECT * FROM customers WHERE cust_name IS NOT NULL;
--__12__--
SELECT MAX(grade) AS maximum_grade FROM customers;
