CREATE DATABASE Lab9;
--_-_1_-_--
CREATE OR REPLACE FUNCTION increase_by_ten(value INT)
RETURNS INT AS $$
BEGIN
    RETURN value + 10;
end;$$
LANGUAGE plpgsql;

SELECT increase_by_ten(100);
--_-_2_-_--
CREATE OR REPLACE FUNCTION compare_to(value1 INT, value2 INT)
RETURNS varchar(30) AS $$
    BEGIN
        IF value1 > value2 THEN
        RETURN 'Greater';
    ELSIF value1 = value2 THEN
        RETURN 'Equal';
    ELSE
        RETURN 'Lesser';
    END IF;
    END; $$
LANGUAGE plpgsql;

SELECT compare_to(40, 40)
--_-_3_-_--
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TABLE(num INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT generate_series(1, n);
END;
$$ LANGUAGE plpgsql;

SELECT number_series(10);
--_-_4_-_--
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    "position" VARCHAR(100),
    salary NUMERIC
);

INSERT INTO employees (name, position, salary) VALUES
('John Doe', 'Manager', 50000),
('Jane Smith', 'Developer', 45000),
('Alice Johnson', 'Designer', 40000),
('Bob Brown', 'Developer', 46000);

CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS SETOF employees AS $$
BEGIN
    RETURN QUERY
    SELECT e.id, e.name, e."position", e.salary
    FROM employees e
    WHERE e.name = emp_name;
END;$$
LANGUAGE plpgsql;

SELECT * FROM find_employee('John Doe');
--_-_5_-_--
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(100),
    price NUMERIC
);
INSERT INTO products (name, category, price) VALUES
('Laptop', 'Electronics', 1000),
('Smartphone', 'Electronics', 500),
('Desk Chair', 'Furniture', 150),
('Table', 'Furniture', 200),
('Headphones', 'Electronics', 150),
('Sofa', 'Furniture', 700);

CREATE OR REPLACE FUNCTION list_products(cat VARCHAR)
RETURNS TABLE(id INT, name VARCHAR, category VARCHAR, price NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT p.id, p.name, p.category, p.price
    FROM products p
    WHERE p.category = cat;
END;$$
LANGUAGE plpgsql;

SELECT * FROM list_products('Furniture');
--_-_6_-_--
CREATE OR REPLACE FUNCTION calculate_bonus(emp_id INT)
RETURNS NUMERIC AS $$
DECLARE
    emp_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    --берем зп сотрудника
    SELECT salary INTO emp_salary
    FROM employees
    WHERE id = emp_id;

    --расчет бонуса
    bonus = emp_salary * 0.10;

    RETURN bonus;
END;$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(emp_id INT)
RETURNS VOID AS $$
DECLARE
    emp_bonus NUMERIC;
BEGIN
    --бонус для сотрудника
    emp_bonus = calculate_bonus(emp_id);

    --прибавляем бонус к зп
    UPDATE employees
    SET salary = salary + emp_bonus
    WHERE id = emp_id;
END;$$
LANGUAGE plpgsql;

SELECT update_salary(1);
--_-_7_-_--
CREATE OR REPLACE FUNCTION complex_calculation(input_number INTEGER, input_string VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
    result_string VARCHAR;
    result_number INTEGER;
    final_result VARCHAR;
BEGIN
    -- Subblock 1
    BEGIN
        result_string = UPPER(input_string);
    END;
    -- Subblock 2
    BEGIN
        result_number = input_number * input_number;
    END;
    -- Main Block
    final_result = result_string || ' - ' || result_number;
    RETURN final_result;
END;$$
LANGUAGE plpgsql;

SELECT * FROM complex_calculation(123, 'popugai');