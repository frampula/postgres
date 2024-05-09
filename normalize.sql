DROP TABLE employees;

CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(200),
    position varchar(300) REFERENCES positions(name)
);

INSERT INTO employees (name, position) VALUES
('John', 'JS developer'),
('Jane', 'Sales manager'),
('Jake', 'Bodyguard for developers'),
('Andrew', 'Driver');

INSERT INTO employees (name, position) VALUES
('Milena', 'CFO'),
('Jane', 'CEO'),
('Jake', 'SMM/PR division'),
('Andrew', 'Accountant');

CREATE TABLE positions(
    name varchar(300) PRIMARY KEY,
    department varchar(300),
    car_aviability boolean
);

INSERT INTO positions (name, car_aviability) VALUES
('JS developer', false),
('Sales manager', false),
('Bodyguard for developers', true),
('Driver', true);

INSERT INTO positions (name, car_aviability) VALUES
('CFO', true),
('CEO', true),
('SMM/PR division', false),
('Accountant', false);

-------------

CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(200),
    department varchar(300),
    position varchar(300),
    car_aviability boolean
);

