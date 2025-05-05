CREATE DATABASE studentmanagement;
USE studentmanagement;
Show databases;
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender CHAR(1),
    email VARCHAR(100),
    phone VARCHAR(15)
);
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    credits INT
);
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    instructor_name VARCHAR(100),
    department VARCHAR(100)
);
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    instructor_id INT,
    enrollment_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);
CREATE TABLE EnrollmentLogs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id)
);
INSERT INTO Students(first_name, last_name, dob, gender, email, phone)
VALUES 
('Anu', 'S', '2000-05-21', 'F', 'anu@gmail.com', '9876543210'),
('Bala', 'K', '1999-11-15', 'M', 'bala@gmail.com', '9012345678'),
('Cathy', 'R', '2001-03-10', 'F', 'cathy.r@gmail.com', '9345612780'),
('David', 'M', '2000-07-22', 'M', 'davidm@gmail.com', '8123456789'),
('Esha', 'V', '2002-01-11', 'F', 'esha.v@gmail.com', '9090876543'),
('Farhan', 'A', '1999-10-05', 'M', 'farhan.a@gmail.com', '9678123456'),
('Geetha', 'L', '2001-08-15', 'F', 'geethal@gmail.com', '9345678123'),
('Hari', 'T', '2000-12-20', 'M', 'harit@gmail.com', '9123456790'),
('Isha', 'P', '2002-09-09', 'F', 'ishap@gmail.com', '9876501234'),
('Jay', 'S', '1998-05-25', 'M', 'jays@gmail.com', '9012567890');

INSERT INTO Courses(course_name, credits)
VALUES 
('Python Programming', 4),
('Database Systems', 3),
('Web Development', 4),
('Data Structures', 3),
('Machine Learning', 4);

INSERT INTO Instructors(instructor_name, department)
VALUES 
('Dr. Ramesh Kumar', 'Computer Science'),
('Ms. Priya Sharma', 'Information Technology'),
('Mr. Arjun Mehta', 'Data Science'),
('Mrs. Kavitha Nair', 'Software Engineering'),
('Mr. Vinod Raj', 'AI & ML');

INSERT INTO Enrollments(student_id, course_id, instructor_id, enrollment_date, grade)
VALUES 
(1, 1, 1, '2024-01-15', 'A'),
(2, 2, 2, '2024-01-16', 'B'),
(3, 3, 3, '2024-01-17', 'A'),
(4, 4, 4, '2024-01-18', 'B'),
(5, 5, 5, '2024-01-19', 'C'),
(6, 1, 1, '2024-01-20', 'A'),
(7, 2, 2, '2024-01-21', 'B'),
(8, 3, 3, '2024-01-22', 'C'),
(9, 4, 4, '2024-01-23', 'B'),
(10, 5, 5, '2024-01-24', 'A');

DELIMITER //
CREATE PROCEDURE EnrollStudent(
    IN student_id INT,
    IN course_id INT,
    IN instructor_id INT,
    IN enrollment_date DATE,
    IN grade CHAR(1)
)
BEGIN
    INSERT INTO Enrollments(student_id, course_id, instructor_id, enrollment_date, grade)
    VALUES (student_id, course_id, instructor_id, enrollment_date, grade);
END //
DELIMITER ;

CALL EnrollStudent(1, 2, 3, '2024-02-10', 'A');

CREATE VIEW StudentCoursePerformance AS
SELECT 
    s.first_name, 
    s.last_name, 
    c.course_name, 
    e.grade, 
    i.instructor_name
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Instructors i ON e.instructor_id = i.instructor_id;

SELECT * FROM StudentCoursePerformance;


DELIMITER //
CREATE TRIGGER LogEnrollmentChange
AFTER INSERT ON Enrollments
FOR EACH ROW
BEGIN
    INSERT INTO EnrollmentLogs(enrollment_id, student_id, course_id, enrollment_date)
    VALUES (NEW.enrollment_id, NEW.student_id, NEW.course_id, NEW.enrollment_date);
END //
DELIMITER ;


CALL EnrollStudent(10, 3, 2, '2024-02-15', 'B');
SELECT student_id FROM students;
SHOW CREATE TABLE enrollments;

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);
INSERT INTO departments (department_name)
VALUES 
('Computer Science'),
('Mathematics'),
('Physics'),
('English'),
('Commerce');
ALTER TABLE students
ADD COLUMN department_id INT,
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(department_id);

select * from students;

