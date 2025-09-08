CREATE DATABASE Students;
USE Students;

CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50),
    credits INT
);

CREATE TABLE Semesters (
    sem_id INT PRIMARY KEY AUTO_INCREMENT,
    sem_name VARCHAR(20)
);

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    sem_id INT,
    marks INT,
    FOREIGN KEY(student_id) REFERENCES Student(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id),
    FOREIGN KEY(sem_id) REFERENCES Semesters(sem_id)
);

INSERT INTO Student (name, department) VALUES
('Arun', 'CSE'),
('Priya', 'ECE'),
('Karthik', 'EEE'),
('Divya', 'IT'),
('Ravi', 'CSE');

INSERT INTO Courses (course_name, credits) VALUES
('DBMS', 4),
('OOPS', 3),
('Networks', 3);

INSERT INTO Semesters (sem_name) VALUES
('Sem1'),
('Sem2');

INSERT INTO Grades (student_id, course_id, sem_id, marks) VALUES
(1, 1, 1, 85),
(1, 2, 1, 78),
(2, 1, 1, 65),
(2, 3, 1, 72),
(3, 2, 2, 90),
(4, 1, 2, 55),
(5, 3, 1, 88);

SELECT s.name, c.course_name, g.marks
FROM Grades g
JOIN Student s ON g.student_id = s.student_id
JOIN Courses c ON g.course_id = c.course_id;

SELECT s.name, g.marks 
FROM Grades g
JOIN Student s ON g.student_id = s.student_id
WHERE g.marks > 80;

SELECT c.course_name, AVG(g.marks) AS avg_marks
FROM Grades g
JOIN Courses c ON g.course_id = c.course_id
GROUP BY c.course_name;

SELECT sem.sem_name, s.name, g.marks,
RANK() OVER(PARTITION BY sem.sem_name ORDER BY g.marks DESC) AS rank_no
FROM Grades g
JOIN Student s ON g.student_id = s.student_id
JOIN Semesters sem ON g.sem_id = sem.sem_id;


CREATE VIEW TopStudents AS
SELECT sem.sem_name, s.name, g.marks
FROM Grades g
JOIN Student s ON g.student_id = s.student_id
JOIN Semesters sem ON g.sem_id = sem.sem_id
WHERE g.marks >= 80;

