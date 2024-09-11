create database Lab1;
create table users(
    ID serial,
    FirstName varchar(50),
    LastName varchar(50)
);

ALTER TABLE users
Add isadmin int;

Alter TABLE users
Alter column isadmin SET DATA TYPE boolean
USING isadmin=1;

ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT FALSE;

ALTER TABLE users
ADD PRIMARY KEY (ID);

CREATE TABLE tasks(
    id serial,
    name varchar(50),
    user_id int
);

INSERT INTO users(FirstName,LastName)
values ('Timur', 'Kharitonov'),('Alikhan', 'Amangeldiev');

drop table tasks;
drop database lab1;