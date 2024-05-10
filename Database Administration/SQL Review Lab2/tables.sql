DROP DATABASE IF EXISTS MovieRating;
CREATE DATABASE MovieRating;

USE MovieRating;

DROP TABLE IF EXISTS Movie;
CREATE TABLE Movie(
    mid INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    year INT,
    director VARCHAR(255)
);

DROP TABLE IF EXISTS Reviewer;
CREATE TABLE Reviewer(
    rid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

DROP TABLE IF EXISTS Rating;
CREATE TABLE Rating(
    mid INT,
    rid INT,
    star INT,
    ratingDate DATE,
    FOREIGN KEY (rid) REFERENCES Reviewer(rid),
    FOREIGN KEY (mid) REFERENCES Movie(mid)
);