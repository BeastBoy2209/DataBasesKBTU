--_-_1_-_--
CREATE DATABASE lab6;
--_-_2_-_--
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY ,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR (12)
) ;
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE ,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
) ;
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR (50),
    Last_name VARCHAR(50),
    email VARCHAR (50),
    phone_number VARCHAR (20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);
--_-_3_-_--
SELECT e.first_name, e.Last_name, e.department_id, d.department_name
FROM employees as e join departments d on d.department_id = e.department_id;
--_-_4_-_--
SELECT e.first_name, e.Last_name, e.department_id, d.department_name
FROM employees as e JOIN departments as d on  e.department_id = d.department_id
WHERE (d.department_id = 40) or (d.department_id = 80);
--_-_5_-_--
SELECT e.first_name, e.Last_name, d.department_name, l.city, l.state_province
FROM employees as e JOIN departments as d on d.department_id = e.department_id
    JOIN locations as l on l.location_id = d.location_id;
--_-_6_-_--
SELECT * FROM departments;
--_-_7_-_--
SELECT e.first_name, e.Last_name, e.department_id, d.department_name
FROM employees as e LEFT JOIN departments as d on e.department_id = d.department_id;




--_-_DATA INPUT FOR TESTING_-_--
--locations
INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('123 Main St', '10001', 'New York', 'NY'),
('456 Park Ave', '10002', 'New York', 'NY'),
('789 Ocean Dr', '33101', 'Miami', 'FL'),
('101 Broadway', '94105', 'San Francisco', 'CA'),
('202 Central Blvd', '30301', 'Atlanta', 'GA'),
('777 VineWood', '228336', 'Los Angeles', 'LA');
--departments
INSERT INTO departments (department_id, department_name, budget, location_id) VALUES
(40, 'Customer Service', 400000, 1),
(80, 'IT Support', 700000, 2),
(1, 'Sales', 500000, 3),
(2, 'Marketing', 300000, 4),
(3, 'Engineering', 800000, 5),
(52, 'Poproshaiki', 77777777, 6);
--employees
INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('Alice', 'Brown', 'alice.brown@example.com', '123-456-7890', 65000, 40),
('Bob', 'Smith', 'bob.smith@example.com', '234-567-8901', 70000, 80),
('John', 'Doe', 'jdoe@example.com', '345-678-9012', 75000, 1),
('Jane', 'Doe', 'janed@example.com', '456-789-0123', 80000, 2),
('Michael', 'Johnson', 'mjohnson@example.com', '567-890-1234', 85000, 3);
INSERT INTO employees (first_name, last_name, email, phone_number) VALUES
('Bobik', 'Bobrowich' , '1231231@gmail.com', '123123-123123')


