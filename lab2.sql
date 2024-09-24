--1
create database lab2;
--2
CREATE TABLE countries(
    ID serial PRIMARY KEY,
    country_name varchar(50),
    region_id  int,
    population int
);
--3
INSERT INTO countries(country_name, region_id, population)
values('Kazakhstan', 1, 23000000);
--4
INSERT INTO countries(ID, country_name, population)
values(22, 'Russia', 130000000);
--5
UPDATE countries
SET region_id = NULL
WHERE country_name = 'Russia';
--6
INSERT INTO countries(country_name, region_id, population)
values ('Czech Republic', '52', 2109309123),
       ('USA','228', 343102138),
       ('Jamaica','336', 123923);
--7
ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';
--8
INSERT INTO countries (region_id, population)
values (53, 1239212);
--9
INSERT INTO countries DEFAULT VALUES;
--10
CREATE TABLE countries_new AS TABLE countries WITH NO DATA;
--11
INSERT INTO countries_new
select * from countries;
--12
UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;
--13
SELECT country_name,
       population * 1.10 AS "New Population"
FROM countries;
--14
DELETE FROM countries
WHERE population < 100000;
--15
DELETE FROM countries_new
WHERE ID IN (SELECT ID FROM countries)
RETURNING *;
--16
DELETE FROM countries
RETURNING *;
