CREATE TABLE users(
    first_name VARCHAR(64) NOT NULL CHECK (first_name != ''),
    last_name VARCHAR(64) NOT NULL CHECK (last_name != ''),
    biography text,
    gender VARCHAR(30) NOT NULL CHECK (gender != ''),
    is_subscribed boolean NOT NULL,
    birthday date,
    foot_size smallint,
    height numeric(5, 2)
)

INSERT INTO users VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
 
 INSERT INTO users VALUES
('Susan', 'Doe', 'Тут може бути якась неймовірно велика розповідь про Сьюзан', 'female', true, '1994-09-14', 40, 1.65),
('Peter', 'Doe', 'Тут може бути якась неймовірно велика розповідь про Пітера', 'male', false, '1990-09-14', 46, 1.95);

DROP TABLE users;