CREATE TABLE vendors (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32)
);

INSERT INTO vendors (name)
VALUES('Widgetzilla');


INSERT INTO vendors (name)
VALUES('Addonsole');


INSERT INTO vendors (name)
VALUES('Widgetscity');


INSERT INTO vendors (name)
VALUES('iWidgets');


INSERT INTO vendors (name)
VALUES('Widgetsd');


INSERT INTO vendors (name)
VALUES('plugingx');

CREATE TABLE products (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(32),
    price DECIMAL,
    vendor_id INT,
    FOREIGN KEY (vendor_id) REFERENCES vendors(id) 
);

INSERT INTO products (name, price, vendor_id)
VALUES ('Widgetlance', 39.99, 1);

INSERT INTO products (name, price, vendor_id)
VALUES ('Widget Tsunami', 29.99, 2);

INSERT INTO products (name, price, vendor_id)
VALUES ('Heart Paper', 19.99, 1);

INSERT INTO products (name, price, vendor_id)
VALUES ('Computervio', 339.99, 3);

INSERT INTO products (name, price, vendor_id)
VALUES ('Ebony Computer', 3039.99, 4);


CREATE TABLE orders (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  customer_id INT,
  shipping_address VARCHAR(32)
);

INSERT INTO orders (
  customer_id,
  shipping_address
)
VALUES (
  1, 
  '1313 Elm Street'
);

INSERT INTO orders (
  customer_id,
  shipping_address
)
VALUES (
  14, 
  '2135 Creed Way'
);

INSERT INTO orders (
  customer_id,
  shipping_address
)
VALUES (
  37, 
  '1378 Del Rosio Ave'
);

INSERT INTO orders (
  customer_id,
  shipping_address
)
VALUES (
  1, 
  '2000 4th Ave'
);

INSERT INTO orders (
  customer_id,
  shipping_address
)
VALUES (
  37, 
  '1478 Italian Wy'
);

INSERT INTO orders (
  customer_id,
  shipping_address
)
VALUES (
  114, 
  '87 New Deal St'
);

CREATE TABLE ordersProducts (
  order_id INT,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  product_id INT,
  quantity INT,
  FOREIGN KEY (product_id) REFERENCES products(id),
  PRIMARY KEY (order_id, product_id)
);

INSERT INTO ordersProducts (
  order_id,
  product_id,
  quantity
) VALUES (
  1,
  1,
  3
);

INSERT INTO ordersProducts (
  order_id,
  product_id,
  quantity
) VALUES (
  1,
  4,
  1
);


INSERT INTO ordersProducts (
  order_id,
  product_id,
  quantity
) VALUES (
  3,
  1,
  2
);

INSERT INTO ordersProducts (
  order_id,
  product_id,
  quantity
) VALUES (
  1,
  5,
  1
);

INSERT INTO ordersProducts (
  order_id,
  product_id,
  quantity
) VALUES (
  1,
  2,
  5
);

