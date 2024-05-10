USE MovieRating;

SELECT
    title,
    director
FROM
    Movie
WHERE
    director="Steven Spielberg";

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

SELECT
    title
FROM
    Movie m
JOIN 