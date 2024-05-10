USE MovieRating;


--1. Find the titles of all movies directed by “Steven Spielberg”.
SELECT
    title,
    director
FROM
    Movie
WHERE
    director="Steven Spielberg";
-- +-------------------------+------------------+
-- | title                   | director         |
-- +-------------------------+------------------+
-- | E.T.                    | Steven Spielberg |
-- | Raiders of the Lost Ark | Steven Spielberg |
-- +-------------------------+------------------+

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
-- +------+--------+
-- | year | titles |
-- +------+--------+
-- | 1939 |      1 |
-- | 2009 |      1 |
-- | 1937 |      2 |
-- | 1981 |      2 |
-- +------+--------+

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
-- +-----------+
-- | title     |
-- +-----------+
-- | Star Wars |
-- | Titanic   |
-- +-----------+

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
-- +---------------+
-- | name          |
-- +---------------+
-- | Daniel Lewis  |
-- | Chris Jackson |
-- +---------------+

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
-- +------------------+-------------------------+-------+-------------+
-- | Reviewer_Name    | Movie_Title             | Stars | Rating_Date |
-- +------------------+-------------------------+-------+-------------+
-- | Ashley White     | E.T.                    |     3 | 2011-01-02  |
-- | Brittany Harris  | Raiders of the Lost Ark |     4 | 2011-01-12  |
-- | Brittany Harris  | Raiders of the Lost Ark |     2 | 2011-01-30  |
-- | Brittany Harris  | The sound of Music      |     2 | 2011-01-20  |
-- | Chris Jackson    | E.T.                    |     2 | 2011-01-22  |
-- | Chris Jackson    | Raiders of the Lost Ark |     4 | NULL        |
-- | Chris Jackson    | The sound of Music      |     3 | 2011-01-27  |
-- | Daniel Lewis     | Snow White              |     4 | NULL        |
-- | Elizabeth Thomas | Avatar                  |     3 | 2011-01-15  |
-- | Elizabeth Thomas | Snow White              |     5 | 2011-01-19  |
-- | James Cameron    | Avatar                  |     5 | 2011-01-20  |
-- | Mike Anderson    | Gone with the Wind      |     3 | 2011-01-09  |
-- | Sarah Martinez   | Gone with the Wind      |     4 | 2011-01-27  |
-- +------------------+-------------------------+-------+-------------+

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
-- +----------------+------+
-- | name           | star |
-- +----------------+------+
-- | Sarah Martinez |    4 |
-- | Mike Anderson  |    3 |
-- +----------------+------+

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
-- +---------------+--------+------+
-- | name          | title  | star |
-- +---------------+--------+------+
-- | James Cameron | Avatar |    5 |
-- +---------------+--------+------+

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
-- +-------------------------+
-- | Ashley White            |
-- | Avatar                  |
-- | Brittany Harris         |
-- | Chris Jackson           |
-- | Daniel Lewis            |
-- | E.T.                    |
-- | Elizabeth Thomas        |
-- | Gone with the Wind      |
-- | James Cameron           |
-- | Mike Anderson           |
-- | Raiders of the Lost Ark |
-- | Sarah Martinez          |
-- | Snow White              |
-- | Star Wars               |
-- | The sound of Music      |
-- | Titanic                 |
-- +-------------------------+

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
-- +-------------------------+
-- | title                   |
-- +-------------------------+
-- | Gone with the Wind      |
-- | Gone with the Wind      |
-- | Star Wars               |
-- | The sound of Music      |
-- | E.T.                    |
-- | Titanic                 |
-- | Snow White              |
-- | Snow White              |
-- | Avatar                  |
-- | Avatar                  |
-- | Raiders of the Lost Ark |
-- | Raiders of the Lost Ark |
-- +-------------------------+

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
-- +------------------+------------------+
-- | name1            | name2            |
-- +------------------+------------------+
-- | Ashley White     | Chris Jackson    |
-- | Brittany Harris  | Chris Jackson    |
-- | Daniel Lewis     | Elizabeth Thomas |
-- | Elizabeth Thomas | James Cameron    |
-- | Mike Anderson    | Sarah Martinez   |
-- +------------------+------------------+
