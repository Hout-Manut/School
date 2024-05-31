-- Random database and data
DROP TABLE IF EXISTS School;
CREATE DATABASE School;

USE School;

DROP TABLE IF EXISTS Classroom;
CREATE TABLE Classroom (
    id INT PRIMARY KEY AUTO_INCREMENT,

);

DROP USER IF EXISTS 'admin'@'localhost';
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'admin';

DROP USER IF EXISTS 'A009066'@'localhost';

FLUSH PRIVILEGES;

-- 1. Show all privilege and screenshot with queries.
SHOW PRIVILEGES;

-- 2. Show your database and screenshot with queries.
SHOW DATABASES;

-- 3. Show your current user and screenshot with queries.
SELECT CURRENT_USER();

-- 4. Show grants for your user and screenshot with queries.
SHOW GRANTS FOR 'admin'@'localhost';

-- 5. Show all user in your local machine and screenshot with queries.
SELECT * FROM mysql.user;

-- 6. Create new user with your Student ID and screenshot with queries.
CREATE USER 'A009066'@'localhost' 
IDENTIFIED BY '0100';

-- 7. Rename the User to your name and screenshot with queries.
RENAME USER 'A009066'@'localhost' TO 'Manut'@'localhost';

-- 8. Grant Select to that user and screenshot with queries.
GRANT SELECT ON School.* to 'Manut'@'localhost';

-- 9. Connect and test the user that was created (test select queries on something for that
--    user and test the update) and show the current user and screenshot with queries.


-- 10. Change password of user to ‘admin’, then re-login again and screenshot with queries.
ALTER USER 'admin'@'localhost' 
IDENTIFIED BY '0010';

-- 11. Grant all permission to that user and screenshot with queries.
GRANT ALL PRIVILEGES ON School.* TO 'admin'@'localhost';

-- 12. Revoke Select permission from the user and screenshot with queries.


-- 13. Re-do the quesQon 9 again with select, delete, update.


-- 14. NoQfy the server to reload the privileges when you change it by using insert,
--     update or delete commands on privileges table.

