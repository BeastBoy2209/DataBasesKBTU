CREATE TABLE books(
    book_id Int primary key,
    title varchar(255),
    author varchar(255),
    price decimal(10, 3),
    quantity INT
);
CREATE TABLE orders(
    oreder_id int primary key,
    book_id int references books,
    customer_id int,
    order_name date,
    quatity int
);
CREATE TABLE customers(
    customer_id int primary key,
    name varchar(255),
    email varchar(255)
);
INSERT INTO books(book_id, title, author, price, quantity)
VALUES (1, 'Database 101', 'A. Smith', 40.000, 10),
       (2, 'Learn SQL', 'B. Johnson', 35.00, 15),
       (3, 'Advanced DB', 'C. Lee', 50.00, 5);
INSERT INTO customers(customer_id, name, email)
Values(101, 'John Doe', 'johndoe@gmail.com'),
      (102, 'Jane Doe', 'janedoe@mail.ru');
--------Tasks----------
---1----
BEGIN TRANSACTION;
INSERT INTO orders(oreder_id, book_id, customer_id, order_name, quatity)
VALUES (1, 1, 101, 'nameex', 2);

UPDATE books
set quantity = quantity -2
where book_id = 1;
COMMIT;

---2---
--тестировка
UPDATE books
SET quantity = 5
WHERE book_id = 3;
--не работает
BEGIN;
DO $$
DECLARE
    available_quantity INTEGER;
BEGIN
    SELECT quantity INTO available_quantity FROM Books WHERE book_id = 3;

    IF available_quantity < 10 THEN
        RAISE NOTICE 'Not enough stock for the order. Transaction rolled back.';
        ROLLBACK;
    ELSE
        INSERT INTO Orders (oreder_id, book_id, customer_id, order_name, quatity)
        VALUES (3, 102, CURRENT_DATE, 10);

        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;

        COMMIT;
    END IF;
END $$;



--работает, но не используется rollback
BEGIN;
SAVEPOINT savetest;
DO $$
    DECLARE amount INT := (SELECT quantity FROM books WHERE book_id = 3);
BEGIN
    IF amount < 10 THEN
        RAISE NOTICE 'amount of books not enough';
    ELSE
        INSERT INTO orders (oreder_id, book_id, customer_id, order_name, quatity)
        VALUES (2, 3, 102, 'nameeeee', 10);

        UPDATE books
        SET quantity = quantity - 10
        WHERE book_id = 3;
        END IF;
END;
$$;
COMMIT;

---3---
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE Books
SET price = 55.00
WHERE book_id = 3;

------(2)-------
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT price FROM Books WHERE book_id = 3;

COMMIT;
SELECT price FROM Books WHERE book_id = 3;

---4---
BEGIN;
UPDATE customers
SET email = 'asdadasdadxc@gmail.com'
WHERE customer_id = 101;

COMMIT;

SELECT customer_id, email
FROM customers
WHERE customer_id = 101;