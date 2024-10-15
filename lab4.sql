--1
Create DATABASE lab4;
--2
CREATE TABLE Warehouses (
    code INTEGER PRIMARY KEY,
    location VARCHAR(255),
    capacity INTEGER
);
--(3)
INSERT INTO Warehouses (code, location, capacity)
VALUES
(1, 'Chicago', 3),
(2, 'Chicago', 4),
(3, 'New York', 7),
(4, 'Los Angeles', 2),
(5, 'San Francisco', 8);

CREATE TABLE Boxes (
    code CHAR(4) PRIMARY KEY,
    contents VARCHAR(255),
    value REAL,
    warehouse INTEGER,
    FOREIGN KEY (warehouse) REFERENCES Warehouses(code)
);
--(3)
INSERT INTO Boxes (code, contents, value, warehouse)
VALUES
('0MN7', 'Rocks', 180, 3),
('4H8P', 'Rocks', 250, 1),
('4RT3', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('8JN6', 'Papers', 75, 1),
('8Y6U', 'Papers', 50, 3),
('9J6F', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);
--4
SELECT * from warehouses;
--5
SELECT *
FROM boxes
WHERE value > 150;
--6
SELECT DISTINCT ON (contents) code, contents, value, warehouse
FROM boxes;
--7
SELECT warehouses.code AS warehouse_code, COUNT(boxes.code) AS box_count
FROM warehouses
LEFT JOIN boxes ON warehouses.code = boxes.warehouse
GROUP BY warehouses.code;
--8
SELECT warehouses.code AS warehouse_code, COUNT(boxes.code) AS box_count
FROM warehouses
LEFT JOIN boxes ON warehouses.code = boxes.warehouse
GROUP BY warehouses.code
HAVING COUNT(boxes.code) > 2;
--9
INSERT INTO warehouses (code, location, capacity)
VALUES ('1234', 'New York', 3);
--10
INSERT INTO boxes (code, contents, value, warehouse)
VALUES ('H5RT', 'Papers', 200, 2);
--11
WITH third_largest_box AS (
    SELECT code, value
    FROM boxes
    ORDER BY value DESC
    LIMIT 1 OFFSET 2
)
UPDATE boxes
SET value = value * 0.85
WHERE code = (SELECT code FROM third_largest_box);
--12
DELETE FROM boxes where value < 150;
--13
DELETE FROM boxes
USING warehouses
WHERE boxes.warehouse = warehouses.code
AND warehouses.location = 'New York'
RETURNING boxes.code, boxes.contents, boxes.value, boxes.warehouse;