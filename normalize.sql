CREATE TABLE students (
    id serial PRIMARY KEY,
    name varchar(30)
);

CREATE TABLE teachers (
    id serial PRIMARY KEY,
    name varchar(30),
    subject varchar(50) REFERENCES subjects(name)
);

CREATE TABLE subjects (
    name varchar(50) PRIMARY KEY
)

CREATE TABLE students_to_teachers(
    teacher_id int REFERENCES teachers(id),
    student_id int REFERENCES students(id),
    PRIMARY KEY (teacher_id, student_id)
);

INSERT INTO students_to_teachers VALUES
(5, 1),
(5, 2),
(6, 1)

INSERT INTO students (name) VALUES 
('Ivanon'),
('Petrov'),
('Sidorov')

INSERT INTO teachers (name, subject) VALUES 
('Smirnov', 'Системы ИИ'),
('Petrenko', 'Облачное программирование')

INSERT INTO subjects VALUES
('Системы ИИ'),
('Облачное программирование')

SELECT students.id, students.name, teachers.name, teachers.subject FROM 
students JOIN students_to_teachers
ON students.id = students_to_teachers.student_id
JOIN teachers
ON students_to_teachers.teacher_id = teachers.id

