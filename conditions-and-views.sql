ALTER TABLE orders
ADD COLUMN status boolean

UPDATE orders
SET status = true
WHERE id % 2 = 0

UPDATE orders
SET status = false
WHERE id % 2 = 1

SELECT id, created_at, customer_id, status AS order_status
 FROM orders