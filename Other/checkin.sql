DROP TABLE IF EXISTS fitness;
CREATE DATABASE fitness;
USE fitness;


CREATE TABLE
    MEMBER (
        id INT PRIMARY KEY,
        name VARCHAR(50),
        sex ENUM ('Male', 'Female'),
        age INT
    );


INSERT INTO
    MEMBER (id, name, sex, age)
VALUES
    (1, 'John', 'Male', 21),
    (2, 'Alice', 'Female', 32),
    (3, 'Bob', 'Male', 41),
    (4, 'Emma', 'Female', 52),
    (5, 'David', 'Male', 31),
    (6, 'Eve', 'Female', 44);


CREATE TABLE
    Checkin (
        member_id INT,
        DATE DATE,
        TIME TIME,
        FOREIGN KEY (member_id) REFERENCES MEMBER (id)
    );

-- Insert some sample data into the Checkin table
INSERT INTO
    Checkin (member_id, DATE, TIME)
VALUES
    (1, '2024-03-01', '09:00:00'),
    (2, '2024-03-01', '10:30:00'),
    (3, '2024-03-02', '11:15:00'),
    (4, '2024-03-08', '12:30:00'),
    (4, '2024-03-08', '17:00:00'),
    (5, '2024-03-09', '14:15:00'),
    (2, '2024-03-09', '15:30:00'),
    (1, '2024-03-10', '09:15:00'),
    (2, '2024-03-10', '10:00:00'),
    (4, '2024-03-11', '11:00:00'),
    (4, '2024-03-11', '12:45:00'),
    (4, '2024-03-12', '14:45:00'),
    (6, '2024-03-12', '15:00:00'),
    (1, '2024-03-13', '09:00:00'),
    (2, '2024-03-13', '10:30:00'),
    (3, '2024-03-14', '11:15:00'),
    (4, '2024-03-14', '12:00:00'),
    (5, '2024-03-15', '14:30:00'),
    (6, '2024-03-15', '15:45:00'),
    (1, '2024-03-16', '09:30:00'),
    (1, '2024-03-16', '14:00:00'),
    (2, '2024-03-16', '10:45:00'),
    (3, '2024-03-17', '11:30:00'),
    (4, '2024-03-17', '12:15:00'),
    (5, '2024-03-18', '14:00:00'),
    (6, '2024-03-18', '15:15:00'),
    (1, '2024-03-19', '09:45:00'),
    (2, '2024-03-19', '10:15:00'),
    (3, '2024-03-20', '11:45:00'),
    (3, '2024-03-20', '16:00:00'),
    (4, '2024-03-20', '12:30:00'),
    (4, '2024-03-20', '17:00:00'),
    (5, '2024-03-21', '14:15:00'),
    (6, '2024-03-21', '15:30:00');


DELIMITER //
CREATE FUNCTION CountCurrentEmployeesByDept(dept_name VARCHAR(100))
RETURNS INT
READS SQL DATA
BEGIN
    SELECT COUNT(e.emp_id)
    FROM employee e JOIN dept_emp de ON e.emp_id = de.emp_id
    JOIN department d ON de.dept_id = d.dept_id
    WHERE d.dept_name = dept_name
END//
DELIMITER ;

2
4
3
3