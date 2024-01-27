-- Скрипт для создания базы данных и таблиц
CREATE DATABASE sales
CREATE TABLE Products(
	product_id integer PRIMARY KEY,
	name text NOT NULL,
	manufacturer text,
	price integer NOT NULL CHECK (price > 0),
	store_ids integer[]
);

CREATE TABLE Customers(
	customer_id integer PRIMARY KEY,
	gender char NOT NULL,
	address jsonb NOT NULL,
	reg_date date NOT NULL
);

CREATE TABLE Purchases(
	purchase_id integer PRIMARY KEY,
	customer_id integer NOT NULL REFERENCES Customers ON DELETE RESTRICT,
	purchase_date date
);

CREATE TABLE Purchases_Products(
	id integer PRIMARY KEY,
	purchase_id integer NOT NULL REFERENCES Purchases ON DELETE CASCADE,
	product_id integer NOT NULL REFERENCES Products ON DELETE CASCADE,
	UNIQUE(product_id,purchase_id)
);
CREATE TABLE Deliverymen(
	deliveryman_id integer PRIMARY KEY,
	name varchar NOT NULL,
	phone_number varchar NOT NULL UNIQUE
);

CREATE TABLE Deliveries(
	delivery_id integer PRIMARY KEY,
	purchase_id integer NOT NULL REFERENCES Purchases ON DELETE CASCADE,
	deliveryman_id integer REFERENCES Deliverymen ON DELETE SET NULL,
	delivery_days integer
);