-- Random database and data
DROP TABLE IF EXISTS School;
CREATE DATABASE School;

USE School;

DROP TABLE IF EXISTS Classroom;
CREATE TABLE Classroom (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

DROP USER IF EXISTS 'admin'@'localhost';
DROP USER IF EXISTS 'B009066'@'localhost';
DROP USER IF EXISTS 'Manut'@'localhost';

FLUSH PRIVILEGES;

-- 1. Show all privilege and screenshot with queries.
SHOW PRIVILEGES;

-- 2. Show your database and screenshot with queries.
SHOW DATABASES;
SELECT DATABASE();

-- 3. Show your current user and screenshot with queries.
SELECT CURRENT_USER();

-- 4. Show grants for your user and screenshot with queries.
-- Create new user with some permissions
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'admin';

-- Show grants for that user
SHOW GRANTS FOR 'admin'@'localhost';

-- 5. Show all user in your local machine and screenshot with queries.
SELECT user FROM mysql.user;

-- 6. Create new user with your Student ID and screenshot with queries.
CREATE USER 'B009066'@'localhost'
IDENTIFIED BY 'Password';

-- Verify that the user was created
SELECT user FROM mysql.user
WHERE user = 'B009066';

-- 7. Rename the User to your name and screenshot with queries.
RENAME USER 'B009066'@'localhost' TO 'Hout Manut'@'localhost';

-- Verify that the user was renamed
SELECT user FROM mysql.user
WHERE user = 'B009066' OR user = 'Hout Manut';

-- 8. Grant Select to that user and screenshot with queries.
GRANT SELECT ON School.* to 'Hout Manut'@'localhost';

-- Verify that the permission was granted
SHOW GRANTS FOR 'Hout Manut'@'localhost';

-- 9. Connect and test the user that was created (test select queries on something for that
--    user and test the update) and show the current user and screenshot with queries.


-- 10. Change password of user to ‘admin’, then re-login again and screenshot with queries.
ALTER USER 'Hout Manut'@'localhost'
IDENTIFIED BY 'admin';

-- 11. Grant all permission to that user and screenshot with queries.
GRANT ALL ON School.* TO 'Hout Manut'@'localhost';

-- 12. Revoke Select permission from the user and screenshot with queries.
REVOKE SELECT ON movierating.* FROM 'Hout Manut'@'localhost';

-- 13. Re-do the quesQon 9 again with select, delete, update.
-- ...

-- 14. NoQfy the server to reload the privileges when you change it by using insert, update


-- or delete commands on privileges table.
