CREATE TABLE products_2(
    id serial PRIMARY KEY,
    brand varchar(256) NOT NULL CHECK (brand != ''),
    model varchar(256) NOT NULL CHECK (model != ''),
    price numeric(8, 2) NOT NULL,
    is_luxury boolean GENERATED ALWAYS AS (price > 800) STORED
)

ALTER TABLE products
ADD COLUMN is_luxury boolean GENERATED ALWAYS AS (price > 800) STORED