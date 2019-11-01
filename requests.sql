CREATE TABLE products (
  id       INTEGER PRIMARY KEY AUTOINCREMENT,
  category TEXT NOT NULL,
  name     TEXT NOT NULL,
  status   TEXT NOT NULL       DEFAULT 'available', -- else can be 'absent', 'discontinued'
  actual_price  NOT NULL CHECK (actual_price > 0)
);

INSERT INTO products (category, name, actual_price)
VALUES ('tablets', 'Планшет Apple iPad Pro 12.9 1 TB WI-FI', 151700);

INSERT INTO products (category, name, actual_price)
VALUES ('tablets', 'Ультрабук Lenovo IdealPad 720s - 131KB, 81A8000SRK', 79360);

INSERT INTO products (category, name, actual_price)
VALUES ('smartphones', 'Смартфон Redmi 4x 64GB', 19360);

INSERT INTO products (category, name, actual_price)
VALUES ('smartphones', 'Смартфон Apple 11Pro 128GB', 120360);

CREATE TABLE users (
  id    INTEGER PRIMARY KEY  AUTOINCREMENT,
  login TEXT NOT NULL UNIQUE DEFAULT 'unknown',
  name  TEXT NOT NULL        DEFAULT 'unnamed'
);

INSERT INTO users (login, name) VALUES ('first user', 'Vasya');
INSERT INTO users (login, name) VALUES ('second user', 'Petya');
INSERT INTO users (login, name) VALUES ('third user', 'Ivan');

CREATE TABLE orders (
  id             INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id        INTEGER REFERENCES users,
  product_status TEXT NOT NULL       DEFAULT 'selected' --else can be 'paid', 'canceled'
);

INSERT INTO orders(user_id, product_status) VALUES (1, 'selected');
INSERT INTO orders(user_id, product_status) VALUES (2, 'paid');
INSERT INTO orders(user_id, product_status) VALUES (3, 'paid');

CREATE TABLE order_status_for_registered_users (
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  order_id     INTEGER REFERENCES orders,
  order_status TEXT NOT NULL       DEFAULT 'current' --else can be 'completed', 'unredeemed'
);

INSERT INTO order_status_for_registered_users (order_id, order_status) VALUES (1, 'completed');
INSERT INTO order_status_for_registered_users (order_id, order_status) VALUES (2, 'completed');
INSERT INTO order_status_for_registered_users (order_id, order_status) VALUES (3, 'unredeemed');

CREATE TABLE sales (
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  order_id     INTEGER REFERENCES orders,
  product_id   INTEGER REFERENCES products NOT NULL,
  quantity     INTEGER                     NOT NULL CHECK (quantity > 0),
  actual_price INTEGER REFERENCES products NOT NULL CHECK (actual_price > 0),
  total_price  INTEGER                     NOT NULL CHECK ( total_price > 0)
);

INSERT INTO sales (order_id, product_id, quantity, actual_price, total_price) VALUES (1, 1, 1, 151700, 151700);
INSERT INTO sales (order_id, product_id, quantity, actual_price, total_price) VALUES (2, 2, 2, 79360, 158720);
INSERT INTO sales (order_id, product_id, quantity, actual_price, total_price) VALUES (3, 3, 1, 19360, 19360);
INSERT INTO sales (order_id, product_id, quantity, actual_price, total_price) VALUES (4, 4, 1, 120360, 120360);
INSERT INTO sales (order_id, product_id, quantity, actual_price, total_price) VALUES (5, 1, 1, 151700, 151700);
DROP TABLE sales;