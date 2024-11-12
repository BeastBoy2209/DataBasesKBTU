--_-_Creating tables for testing queries_-_--
CREATE TABLE countries(
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(25),
    capital VARCHAR(30)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE ,
    budget INTEGER,
    country_id INTEGER REFERENCES countries
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR (50),
    Last_name VARCHAR(50),
    email VARCHAR (50),
    phone_number VARCHAR (20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);
--_-_Inputing data for testing queries_-_--
INSERT INTO countries (country_name, capital) VALUES
    ('Kazakhstan', 'Astana'),
    ('USA', 'Washington D.C.'),
    ('Germany', 'Berlin'),
    ('France', 'Paris'),
    ('Japan', 'Tokyo');

INSERT INTO departments (department_name, budget, country_id) VALUES
    ('Finance', 1000000, 1),
    ('IT', 2000000, 2),
    ('Human Resources', 500000, 3),
    ('Sales', 1500000, 1),
    ('Marketing', 1200000, 2),
    ('Logistics', 700000, 4),
    ('Legal', 600000, 5);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
    ('Aliya', 'Amanova', 'a.amanova@gmail.com', '+7 701 123 4567', 500000, 1),
    ('John', 'Doe', 'j.doe@gmail.com', '+1 202 555 0189', 75000, 2),
    ('Mariya', 'Schmidt', 'm.schmidt@gmail.com', '+49 151 12345678', 55000, 3),
    ('Pierre', 'Dupont', 'p.dupont@gmail.com', '+33 1 234 5678', 65000, 4),
    ('Satoshi', 'Yamamoto', 's.yamamoto@gmail.com', '+81 3 1234 5678', 80000, 5),
    ('Dana', 'Kaidarova', 'd.kaidarova@gmail.com', '+7 702 234 5678', 470000, 1),
    ('Emily', 'Smith', 'e.smith@gmail.com', '+1 202 555 0190', 72000, 2),
    ('Nils', 'Becker', 'n.becker@gmail.com', '+49 151 98765432', 54000, 3),
    ('Isabelle', 'Martin', 'i.martin@gmail.com', '+33 1 876 5432', 66000, 4),
    ('Yuki', 'Tanaka', 'y.tanaka@gmail.com', '+81 3 8765 4321', 83000, 5);
--_-_1_-_--
CREATE INDEX county_name_index
ON countries(country_name);
DROP INDEX county_name_index;

SELECT *
FROM countries
WHERE country_name = 'Kazakhstan';
--_-_2_-_--
CREATE INDEX employee_name_surname_index
ON employees(first_name, Last_name);

SELECT *
FROM employees
WHERE first_name = 'Aliya'
  AND Last_name = 'Amanova';
--_-_3_-_--
CREATE UNIQUE INDEX salary_index
ON employees(salary);

SELECT *
FROM employees
WHERE salary < 100000
  AND salary > 80000;
--_-_4_-_--
CREATE INDEX name_substr_index
ON employees(substring(first_name from 1 for 4));

SELECT *
FROM employees
WHERE substring(first_name from 1 for 4) = 'Mari';
--_-_5_-_--
CREATE INDEX depatment_budget_index
    ON departments(budget);
CREATE INDEX employees_sallary_index
    ON employees(department_id, salary);

SELECT *
FROM employees as e
JOIN departments as d
on d.department_id = e.department_id
WHERE d.budget > 0
  AND d.budget < 10000000000;

--_-_test_-_--
