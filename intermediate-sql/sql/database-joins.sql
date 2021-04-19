
CREATE TABLE departments (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(32)
);

INSERT INTO departments (name) VALUES ('IT');
INSERT INTO departments (name) VALUES ('Sales');
INSERT INTO departments (name) VALUES ('Service');
INSERT INTO departments (name) VALUES ('Engineering');
INSERT INTO departments (name) VALUES ('Accounting');


CREATE TABLE employees (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(32),
    last_name VARCHAR(32),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Preston', 'Findlay', 1);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Caspian', 'Bell', 1);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Shuaib', 'Sharples', 3);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Scarlett-Rose', 'Kaufman', 2);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Elle-May', 'Read', 4);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Abu', 'Chamberlain', 5);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Lukas', 'Carey', 3);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Cheryl', 'Hughes', 2);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Fahmida', 'Wang', 5);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Iestyn', 'Mueller', 1);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Patryk', 'Clegg', 2);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Elara', 'Holman', 3);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Kairo', 'Lake', 3);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Darcie', 'Olsen', 2);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Saara', 'Churchill', 4);

INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Piotr', 'Arnold', 5);
