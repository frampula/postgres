SELECT * FROM users;


--------


SELECT id, first_name, last_name, email FROM users;



-----------


SELECT id, first_name, last_name, email FROM users
WHERE id > 5995;



SELECT first_name, last_name FROM users
WHERE gender = 'female';


SELECT email FROM users
WHERE is_subscribe = true;

SELECT email FROM users
WHERE is_subscribe;


-----------



/*

Задача: знайти всіх користувачів, у яких висота (height) не NULL

*/

SELECT * FROM users
WHERE height IS NOT NULL;


/*

Задача: знайти всіх користувачів, які не підписались на розсилку

*/

SELECT first_name, last_name, email, is_subscribe FROM users
WHERE is_subscribe IS false;



--------------------------

SELECT first_name, last_name, email FROM users
WHERE first_name = 'William';

/*

У нас є діапазон імен ('William', 'John', 'Jason')
Задача: знайти всіх юзерів, які входять у цей діапазон

*/

SELECT first_name, last_name, email FROM users
WHERE first_name IN ('William', 'John', 'Jason');


--------------------------


/*

Задача: знайти всіх юзерів, у яких id між 4100 і 4200

*/

-- варіант 1
SELECT first_name, last_name, id FROM users
WHERE id >= 4100 AND id <= 4200;


--варіант 2
SELECT first_name, last_name, id FROM users
WHERE id BETWEEN 4100 AND 4200;


--------------------------


/*

Задача: Знайти всіх юзерів, ім'я яких починається на букву 'К'

% - будь-яку кількість будь-яких символів
_ - 1 будь-який символ

*/

SELECT first_name, last_name FROM users
WHERE first_name LIKE 'K%';

/*

Задача: Знайти всіх юзерів, у яких рівно 8 символів у імені

*/

SELECT first_name, last_name FROM users
WHERE first_name LIKE '________';


/*

Задача: знайти всіх юзерів, у яких ім'я складається з 3 символів і починається на букву 'A'

*/

SELECT first_name, last_name FROM users
WHERE first_name LIKE 'A__';


/*

Задача: Знайти всіх юзерів, у яких ім'я закінчується на літеру 'f'

*/

SELECT first_name, last_name FROM users
WHERE first_name LIKE '%f';



---------------------------


ALTER TABLE users
ADD COLUMN weight int CHECK(weight != 0 AND weight > 0);

--------------------------

UPDATE users
SET weight = 60;

--------------------------

UPDATE users
SET weight = 100
WHERE id BETWEEN 4000 AND 5000;

--------------------------

UPDATE users
SET weight = 95
WHERE id = 4040;


SELECT * FROM users
WHERE id = 4040;


/*

ДЗ.

+ 1. Потрібно створити невеличку таблицю співробітників (employees):
    - id
    - name
    - salary
    - work_hours    (кількість відпрацьованих за місяць годин)

+ 2. Вставити дані (INSERT) про 3-х співробітників

3. Всім співробітникам, які відпрацювали за місяць більше 150 годин, збільшити зарплату на 20% (UPDATE)

*/

--- 1

CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK(name != ''),
    salary int NOT NULL CHECK(salary >= 0),
    work_hours int NOT NULL CHECK(work_hours >= 0)
);

--- 2

INSERT INTO employees(name, salary, work_hours) VALUES
('Ivanov', 400, 80),
('Petrov', 750, 185),
('Sidorov', 0, 0);


--- 3 

UPDATE employees
SET salary = salary * 1.2
WHERE work_hours > 150;



-----

INSERT INTO users (first_name, last_name, email, gender, birthday, is_subscribe) VALUES
('Test', 'Testovich', 'test@gmail.com', 'gender', '1800-12-12', false) RETURNING *;


SELECT * FROM users
WHERE id = 6001;

DELETE FROM users
WHERE id = 6001;



-------------------

-- Задача: вивести всіх користувачів з інфою про них + вік


SELECT id, first_name, last_name, birthday, extract("years" from age(birthday)) FROM users;


UPDATE users
SET birthday = '2005-01-01'
WHERE (gender = 'female' AND is_subscribe);


----------------
-- make_interval([years], [months], [days]) - функція, яка створює власний інтервал

SELECT id, first_name, last_name, make_interval(40, 8) FROM users;


-----------

-- Аліаси - псевдоніми
-- Якщо кирилиця - обов'язково беріть у лапки
-- Якщо латиниця - можна і з лапками і без лапок
SELECT first_name AS "Ім'я", last_name AS "Прізвище", id AS "Особистий номер" FROM users;


SELECT id, first_name, last_name, birthday, extract("years" from age(birthday)) AS years FROM users
WHERE extract("years" from age(birthday)) BETWEEN 2 AND 10;

SELECT id, first_name, last_name, birthday, extract("years" from age(birthday)) AS "years old" FROM users
WHERE extract("years" from age(birthday)) BETWEEN 2 AND 10;


-----------------

/*

Пагінація - спосіб розділити великий об'єм інформації на менші частини

1) Нам потрібні сторінки
2) Нам потрібно знати, яка кількість результатів буде відображатись на кожній сторінці

*/

-- LIMIT - задає кількість результатів, яку я хочу отримати
--          (кількість результатів на сторінці)

SELECT * FROM users
LIMIT 50
OFFSET 200; -- 50 * 4

-- Як нам дізнатись, скільки потрібно відступати (формула для розрахунку OFFSET)
/*

У цій формулі, перша сторінка буде вважатись нульовою

OFFSET = LIMIT * сторінку_яку_ми_запитуємо - 1

*/



--------------------


SELECT id, first_name || ' ' || last_name AS "full name", gender, email FROM users;

SELECT id, concat(first_name, ' ', last_name) AS "full name", gender, email FROM users;


/*

Задача: Знайти всіх користувачів, повне ім'я яких (ім'я + прізвище) < 10 символів


*/

-- варіант 1

SELECT id, concat(first_name, ' ', last_name) AS "full name", gender, email FROM users
WHERE char_length(concat(first_name, ' ', last_name)) < 10;


-- варіант 2
SELECT * FROM -- основний запит
( -- підзапит
    SELECT id, concat(first_name, ' ', last_name) AS "full name", gender, email FROM users
) AS "FN"
WHERE char_length("FN"."full name") < 10; -- фільтрація відбувається у основному запиті



/*


Створити таблицю workers:
- id
- name
- salary
- birthday

*/

CREATE TABLE workers(
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL CHECK (name != ''),
    salary int NOT NULL CHECK (salary >= 0),
    birthday date NOT NULL CHECK (birthday < current_date)
);

/*

1. Додайте робітника з ім'ям Олег, з/п 300

*/

INSERT INTO workers(name, salary, birthday) VALUES
('Oleg', 300, '1968-03-26');

/*

2. Додайте робітницю Ярославу, з/п 500

*/

INSERT INTO workers(name, salary, birthday) VALUES
('Jaroslava', 500, '1958-09-12');


/*

3. Додайте двох нових працівників одним запитом -
Сашу, з/п 1000
Машу, з/п 200

*/

INSERT INTO workers(name, salary, birthday) VALUES
('Sasha', 1000, '1990-12-30'),
('Masha', 200, '1985-11-01');

/*

4. Встановити Олегу з/п 500

*/

UPDATE workers
SET salary = 500
WHERE id = 1;

/*

5. Всім, у кого з/п більше 500, врізати з/п до 400

*/

UPDATE workers
SET salary = 400
WHERE salary > 500;

/*

6. Вибрати (SELECT) всіх робітників, чия з/п більше 400

*/

SELECT * FROM workers
WHERE salary > 400;

/*

7. Вибрати робітника з id = 4

*/

SELECT * FROM workers
WHERE id = 4;

/*

8. Дізнатися (SELECT) з/п та вік Олега

*/

SELECT *, extract('years' from age(birthday)) FROM workers
WHERE id = 1;

/*

9. Спробувати знайти робітника з ім'ям "Jaroslava"

*/

SELECT * FROM workers
WHERE name = 'Jaroslava';


/*

10. Вибрати робітників у віці 30 років АБО з з/п > 800
WHERE _кількість_років_ = 30 OR salary > 800;

*/

SELECT * FROM workers
WHERE extract('years' from age(birthday)) = 30 OR salary > 800;

/*

11. Вибрати всіх робітників у віці від 25 до 28 років

*/

SELECT *, extract('years' from age(birthday)) AS "age" FROM workers
WHERE extract('years' from age(birthday)) BETWEEN 25 AND 28;

/*

12. Вибрати всіх співробітників, що народились у вересні

*/

SELECT *, extract('month' from birthday) FROM workers
WHERE extract('month' from birthday) = 9;

/*

13. Видалити робітника з id = 4

*/

DELETE FROM workers
WHERE id = 4;

/*

14. Видалити Олега

*/

DELETE FROM workers
WHERE name = 'Oleg';

/*

15. Видалити всіх робітників старших за 30 років

*/

DELETE FROM workers
WHERE extract('years' from age(birthday)) > 30;



--- Агрегатні функції - функції, які виконують якусь операцію над групою рядків і повертають одне-єдине значення
-- COUNT, SUM, AVG, MIN, MAX

SELECT max(weight) FROM users;

SELECT min(weight) FROM users;

SELECT sum(weight) FROM users;

SELECT avg(weight) FROM users;

-- Підрахувати кількість записів в таблиці

SELECT count(id) FROM users;

-- Знайти середню вагу чоловіків і жінок. Окремо чоловіків, окремо жінок

SELECT gender, avg(weight) FROM users
GROUP BY gender;

/* ОСЬ ТУТ БУДЕ ПОМИЛКА! Запитувати в SELECT ми можемо тільки ті стовпці, які приймають участь у групуванні
SELECT id, gender, avg(weight) FROM users
GROUP BY gender;
*/

-- Знайти середню вагу чоловіків

SELECT avg(weight) FROM users
WHERE gender = 'male';


-- Знайти середню вагу всіх користувачів, старших за 10 років

SELECT avg(weight) FROM users
WHERE extract('years' from age(birthday)) > 10;


SELECT brand, avg(price) FROM products
GROUP BY brand;


-- Сортування - впорядкування даних за якимись ознаками

-- ASC - за збільшенням (default)
-- DESC - за зменшенням

SELECT * FROM users
ORDER BY birthday ASC,
            first_name ASC;

UPDATE users
SET birthday = '2002-09-14'
WHERE id BETWEEN 4038 AND 4046;

-- Вивести топ-3 телефони, яких в нас залишилось найменше

SELECT * FROM products
ORDER BY quantity DESC
LIMIT 3;



-- Фільтрація груп

/*

Знайти кількість користувачів у кожній віковій групі

*/

SELECT count(*) AS "кількість", extract('years' from age(birthday)) AS "вікова група"
FROM users
GROUP BY "вікова група"
ORDER BY "вікова група";

/*

Модифікувати запит таким чином, щоб залишились тільки вікові групи, де < 500 користувачів

*/

SELECT count(*), extract('years' from age(birthday)) AS "вікова група"
FROM users
GROUP BY "вікова група"
HAVING count(*) < 500;



/*

ДЗ

Всі дії виконуються над таблицею products

*/

/*

1. Порахувати загальну кількість товарів

*/

SELECT count(*)
FROM products;

/*

2. Порахувати середню ціну товарів

*/

SELECT avg(price)
FROM products;

/*

3. Порахувати середню ціну кожного бренду
(створити групу по бренду)

*/

SELECT brand, avg(price)
FROM products
GROUP BY brand;

/*

4. Порахувати кількість моделей кожного бренду
(по суті, той же запит, що в 3 завданні, тільки агрегатна функція тут буде count)

*/

SELECT brand, count(price)
FROM products
GROUP BY brand;

/*

5. Середня ціна бренду Huawei

*/

SELECT avg(price)
FROM products
WHERE brand = 'Huawei';

/*

6. Це завдання для таблиці users
Відсортувати юзерів за віком (спочатку за збільшенням, потім за зменшенням)

*/

SELECT *
FROM users
ORDER BY birthday DESC;

/*

7. Відсортуйте телефони за ціною, від найдорожчого до найдешевшого

*/

SELECT *
FROM products
ORDER BY price DESC;

/*

8. Виведіть топ-5 найдорожчих телефонів

*/

SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;



--- РЕЛЯЦІЙНІ ОПЕРАЦІЇ

CREATE TABLE A (
    v char(3),
    t int
);

CREATE TABLE B (
    v char(3)
);

INSERT INTO A VALUES
('XXX', 1),
('XXY', 1),
('XXZ', 1),
('XYX', 2),
('XYY', 2),
('XYZ', 2),
('YXX', 3),
('YXY', 3),
('YXZ', 3);

INSERT INTO B VALUES
('ZXX'),
('XXX'), -- A
('ZXZ'),
('YXZ'), -- A
('YXY'); -- А


SELECT * FROM A, B;

-- UNION - об'єднання
-- (все те, що в А + все те, що в B. А те, що є і там і там - в 1 екземплярі)

-- INTERSECT - перетин множин
-- (все те, що є і в А і в B в єдиному екземплярі)

-- Різниця - не комутативна:
---- А мінус B - все з А мінус спільні елементи для А і В
---- В мінус А - все з В мінус спільні елементи для А і В


SELECT v FROM A
UNION
SELECT * FROM B; -- ОТРИМАЄМО ВСІ УНІКАЛЬНІ ЗАПИСИ З ДВОХ ТАБЛИЦЬ БЕЗ ДУБЛЮВАНЬ

SELECT v FROM A
INTERSECT
SELECT * FROM B; -- ОТРИМАЛИ 3 ЕЛЕМЕНТИ, ЯКІ ПОВТОРЮЮТЬ В ДВОХ ТАБЛИЦЯХ

SELECT * FROM B
EXCEPT
SELECT v FROM A; -- ОТРИМАЄМО ВСІ ЕЛЕМЕНТИ З ТАБЛИЦІ B, МІНУС СПІЛЬНІ ЕЛЕМЕНТИ З ТАБЛИЦЬ А І В





INSERT INTO users (first_name, last_name, email, gender, is_subscribe, birthday)
VALUES 
('User 1', 'Test 1', 'email1@gmail.com', 'male', true, '1990-09-10'), 
('User 2', 'Test 2', 'email2@gmail.com', 'female', true, '1990-09-10'), 
('User 3', 'Test 3', 'email3@gmail.com', 'male', false, '1990-09-10');





-- Задача: знайти id юзерів, які робили замовлення

SELECT id FROM users
INTERSECT
SELECT customer_id FROM orders;

-- Задача: знайти id юзерів, які не робили замовлень

SELECT id FROM users
EXCEPT
SELECT customer_id FROM orders;



------ Поєднання множин
/*

Поєднання множин - операція, яка об'єднує дві або більше множин в одну множину.

*/


SELECT A.v AS "id", A.t AS "price", B.v AS "phone.id"
FROM a, b
WHERE A.v = B.v;


---


SELECT A.v AS "id", A.t AS "price", B.v AS "phone.id"
FROM A JOIN B
ON A.v = B.v;


-- Задача: знайти всі замовлення юзера, у якого id = 4053

SELECT * 
FROM users JOIN orders
ON orders.customer_id = users.id
WHERE users.id = 4053;

-------

SELECT u.*, o.id AS "order_id"
FROM users AS u JOIN orders AS o
ON o.customer_id = u.id
WHERE u.id = 4053;

-----

SELECT *
FROM A JOIN B ON A.v = B.v
JOIN products ON A.t = products.id;


--- Знайти id всіх замовлень, де були замовлені телефони Samsung
SELECT *
FROM products AS p JOIN orders_to_products AS otp
ON p.id = otp.products_id
WHERE p.brand = 'Samsung';

-- Модифікуйте попередній запит. Порахуйте, скільки замовлень бренду Самсунг

SELECT count(*)
FROM products AS p JOIN orders_to_products AS otp
ON p.id = otp.products_id
WHERE p.brand = 'Samsung';

-- Зробити топ продажів. Який бренд найчастіше купували?

SELECT p.brand, count(*) AS "quantity"
FROM products AS p JOIN orders_to_products AS otp
ON p.id = otp.products_id
GROUP BY p.brand
ORDER BY "quantity" DESC;

--- Задача: знайти юзерів, які нічого не замовляли

-- варіант 1

SELECT * FROM
users AS u LEFT JOIN orders AS o
ON u.id = o.customer_id
WHERE o.customer_id IS NULL;


-- варіант 2

SELECT * FROM users
WHERE id IN (
    SELECT id FROM users
    EXCEPT
    SELECT customer_id FROM orders
);




-- Задача: знайти всіх юзерів і сумарну кількість їх замовлень

SELECT u.*, count(*) FROM
users AS u JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id;



INSERT INTO products (brand, model, category, price, quantity)
VALUES ('Microsoft', '12345', 'phones', 200, 2);

/*

Задача 1.
Знайдіть телефони, які ніхто ніколи не купував.
Підказка. Об'єднуйте таблицю orders_to_products і таблицю products.

*/

SELECT * FROM
products AS p LEFT JOIN orders_to_products AS otp
ON p.id = otp.products_id
WHERE otp.order_id IS NULL;

/*

Задача 2.
Кількість позицій у кожному замовленні.
Підказка. 
Тут не потрібно JOIN. Працюємо з таблицею orders_to_products.
Потрібно створити групу по order_id, та запустити на цій групі агрегатну функцію count

*/

SELECT order_id, count(*) FROM orders_to_products
GROUP BY order_id;

/*

Задача 3 (***).
Знайти найпопулярніший товар.
Підказка.
Учасники: products; orders_to_products
Створити групу по id з таблиці products.
Запустити агрегатну функцію sum по полю quantity з таблиці orders_to_products.

*/

SELECT p.id, p.brand, p.model, sum(otp.quantity) AS "customer_sum" FROM
products AS p JOIN orders_to_products AS otp
ON p.id = otp.products_id
GROUP BY p.id
ORDER BY customer_sum DESC
LIMIT 1;


/*

1. Порахувати середній чек по всьому магазину

2. Витягти всі замовлення вище середнього чека

3. Витягти всіх користувачів, в яких кількість замовлень вище середнього

4. Витягти користувачів та кількість товарів, які вони замовляли (кількість замовлень * quantity)

*/

-- 1

SELECT avg(owc.cost) FROM (
    -- запит знаходить суму кожного замовлення
    SELECT otp.order_id, sum(p.price * otp.quantity) AS cost FROM
    orders_to_products AS otp JOIN products AS p
    ON otp.products_id = p.id
    GROUP BY otp.order_id
) AS owc;

-- 2 -- variant 1

SELECT owc.* FROM ( -- orders with cost
    -- запит знаходить суму кожного замовлення
    SELECT otp.order_id, sum(p.price * otp.quantity) AS cost FROM
    orders_to_products AS otp JOIN products AS p
    ON otp.products_id = p.id
    GROUP BY otp.order_id
) AS owc
WHERE owc.cost > (
        SELECT avg(owc.cost) FROM (
        -- запит знаходить суму кожного замовлення
        SELECT otp.order_id, sum(p.price * otp.quantity) AS cost FROM
        orders_to_products AS otp JOIN products AS p
        ON otp.products_id = p.id
        GROUP BY otp.order_id
    ) AS owc
);

-- 2 -- variant 2

/*

WITH ...alias... AS table
SELECT ....

*/

WITH orders_with_cost AS (
    -- запит знаходить суму кожного замовлення
    SELECT otp.order_id, sum(p.price * otp.quantity) AS cost FROM
    orders_to_products AS otp JOIN products AS p
    ON otp.products_id = p.id
    GROUP BY otp.order_id
)

SELECT * FROM orders_with_cost
WHERE orders_with_cost.cost > (
    -- запит, який знаходить середній чек по всьому магазину
    SELECT avg(orders_with_cost.cost) FROM orders_with_cost
);