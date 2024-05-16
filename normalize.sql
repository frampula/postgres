CREATE TABLE products(
    id serial PRIMARY KEY,
    name varchar(300), CHECK (name != '') NOT NULL
)

CREATE TABLE manufacturers(
    id serial PRIMARY KEY,
    name varchar(400) CHECK (name != '') NOT NULL,
    adress text CHECK (adress != '') NOT NULL,
    tel_number varchar(15) CHECK (tel_number != '') NOT NULL
)

CREATE TABLE orders (
    id serial PRIMARY KEY,
    product_id int REFERENCES products(id),
    quantity_plan int CHECK (quantity_plan > 0) NOT NULL,
    product_price decimal(10, 2),
    contract_number varchar(30) NOT NULL,
    contract_adress text CHECK (contract_adress != '') NOT NULL,
    contract_date date NOT NULL,
    manufacturer_id int REFERENCES manufacturers(id)
)

CREATE TABLE shipments (
    id serial PRIMARY KEY,
    order_id int REFERENCES orders(id),
    shipment_date timestamp NOT NULL
)

CREATE TABLE products_to_shipments(
    product_id int REFERENCES products(id),
    shipment_id int REFERENCES shipments(id),
    product_quantity int NOT NULL
)