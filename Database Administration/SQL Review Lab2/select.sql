USE MovieRating;


--1. Find the titles of all movies directed by “Steven Spielberg”.
SELECT
    title,
    director
FROM
    Movie
WHERE
    director="Steven Spielberg";

--2. Find all years that have a movie that received a rating of 4 or 5,
--   and sort them in increasing order.
SELECT
    DISTINCT year,
    COUNT(title) as titles
FROM
    Movie m
JOIN
    Rating r
ON
    m.mid = r.mid
WHERE
    star BETWEEN 4 AND 5
GROUP BY
    year
ORDER BY
    titles ASC;

--3. Find the titles of all movies that have no ratings.
SELECT
    title
FROM
    Movie m
LEFT JOIN
    Rating r
ON
    m.mid = r.mid
WHERE
    r.mid IS NULL;

--4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers
--   who have ratings with a NULL value for the date.
SELECT
    name
FROM
    Reviewer re
JOIN
    Rating r
ON
    re.rid = r.rid
WHERE
    r.ratingDate IS NULL;

--5. Write a query to return the ratings data in a more readable format: reviewer name,
--   movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by
--   movie title, and lastly by number of stars.
SELECT
    re.name AS Reviewer_Name,
    m.title AS Movie_Title,
    r.star AS Stars,
    r.ratingDate AS Rating_Date
FROM
    Reviewer re
JOIN
    Rating r
ON
    r.rid = re.rid
JOIN
    Movie m
ON
    m.mid = r.mid
ORDER BY
    Reviewer_Name ASC,
    Movie_Title ASC,
    Stars DESC;

--6. Find the names of all reviewers who rated “Gone with the Wind”.
SELECT
    name,
    star
FROM
    Reviewer re
JOIN
    Rating r
ON
    re.rid = r.rid
JOIN
    Movie m
ON
    m.mid = r.mid
WHERE
    m.title = "Gone with the Wind";

--7. For any rating where the reviewer is the same as the director of the movie,
--   return the reviewer name, movie title, and number of stars.
SELECT
    name,
    title,
    star
FROM
    Reviewer re
JOIN
    Rating r
ON
    re.rid = r.rid
JOIN
    Movie m
ON
    m.mid = r.mid
WHERE
    re.name = m.director;

--8. Return all reviewer names and movie names together in a single list, alphabetized.
SELECT
    name
FROM
    Reviewer
UNION
SELECT
    title
FROM
    Movie
ORDER BY
    name ASC;

--9. Find the titles of all movies not reviewed by “Chris Jackson”.
SELECT
    title
FROM
    Movie m
LEFT JOIN
    Rating r
ON
    m.mid = r.mid
LEFT JOIN
    Reviewer re
ON
    re.rid = r.rid
WHERE
    re.name != "Chris Jackson"
    OR r.rid IS NULL;

--10. For all pairs of reviewers such that both reviewers gave a rating to the same movie,
--return the names of both reviewers. Eliminate duplicates, don't pair reviewers with
--themselves, and include each pair only once. For each pair, return the names in the
--pair in alphabetical order.
SELECT
    DISTINCT re1.name AS name1,
    re2.name AS name2
FROM
    Reviewer re1
JOIN
    Rating r1
ON
    re1.rid = r1.rid
JOIN
    Rating r2
ON
    r1.mid = r2.mid
JOIN
    Reviewer re2
ON
    re2.rid = r2.rid
WHERE
    re1.name < re2.name
ORDER BY
    name1 ASC,
    name2 ASC;
