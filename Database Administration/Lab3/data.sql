-- Create a database
DROP DATABASE IF EXISTS School;
CREATE DATABASE School;

-- Use the created database
USE School;

-- Create a table for Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    Gender ENUM('Male', 'Female'),
    EnrollmentDate DATE
);

-- Create a table for Teachers
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE,
    Department VARCHAR(50)
);

-- Create a table for Courses
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100),
    Description TEXT,
    Credits INT
);

-- Create a table for Classrooms
CREATE TABLE Classrooms (
    ClassroomID INT PRIMARY KEY AUTO_INCREMENT,
    RoomNumber VARCHAR(10),
    Capacity INT
);

-- Create a table for Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create a table for CourseAssignments
CREATE TABLE CourseAssignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    TeacherID INT,
    ClassroomID INT,
    Semester VARCHAR(20),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
    FOREIGN KEY (ClassroomID) REFERENCES Classrooms(ClassroomID)
);

-- Insert sample data into Students
INSERT INTO Students (FirstName, LastName, BirthDate, Gender, EnrollmentDate)
VALUES
('John', 'Doe', '2005-05-15', 'Male', '2020-09-01'),
('Jane', 'Smith', '2006-08-22', 'Female', '2021-09-01'),
('Emily', 'Johnson', '2007-11-30', 'Female', '2022-09-01');

-- Insert sample data into Teachers
INSERT INTO Teachers (FirstName, LastName, HireDate, Department)
VALUES
('Alice', 'Brown', '2015-03-12', 'Mathematics'),
('Robert', 'Davis', '2017-06-23', 'Science'),
('Michael', 'Wilson', '2019-08-15', 'History');

-- Insert sample data into Courses
INSERT INTO Courses (CourseName, Description, Credits)
VALUES
('Mathematics 101', 'Basic Mathematics', 3),
('Science 101', 'Introduction to Science', 4),
('History 101', 'World History Overview', 3);

-- Insert sample data into Classrooms
INSERT INTO Classrooms (RoomNumber, Capacity)
VALUES
('A101', 30),
('B202', 25),
('C303', 20);

-- Insert sample data into Enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, '2020-09-10'),
(2, 2, '2021-09-15'),
(3, 3, '2022-09-20');

-- Insert sample data into CourseAssignments
INSERT INTO CourseAssignments (CourseID, TeacherID, ClassroomID, Semester)
VALUES
(1, 1, 1, 'Fall 2023'),
(2, 2, 2, 'Spring 2024'),
(3, 3, 3, 'Fall 2024');

-- Query to verify data
SELECT * FROM Students;
SELECT * FROM Teachers;
SELECT * FROM Courses;
SELECT * FROM Classrooms;
SELECT * FROM Enrollments;
SELECT * FROM CourseAssignments;
