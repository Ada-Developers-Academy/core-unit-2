CREATE TABLE products (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  description TEXT,
  publisher_id INT
);

INSERT INTO products (
  name,
  description,
  publisher_id
)
VALUES ('product 1', 'some description 1', 1);

INSERT INTO products (
  name,
  description,
  publisher_id
)
VALUES ('product 2', 'some description 2', 1);

INSERT INTO products (
  name,
  description,
  publisher_id
)
VALUES ('product 3', 'some description 3', 2);

INSERT INTO products (
  name,
  description,
  publisher_id
)
VALUES ('product 4', 'some description 4', 3);

INSERT INTO products (
  name,
  description,
  publisher_id
)
VALUES ('product 5', 'some description 5', 3);

INSERT INTO products (
  name,
  description,
  publisher_id
)
VALUES ('product 6', 'some description 6', 103);

INSERT INTO products (
  name,
  description,
  publisher_id
)
VALUES ('product 7', 'some description 7', 105);

