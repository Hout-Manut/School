USE MovieRating;

INSERT INTO
    Movie (mid, title, YEAR, director)
VALUES
    (101, "Gone with the Wind", 1939, "Victor Fleming"),
    (102, "Star Wars", 1977, "George Lucas"),
    (103, "The sound of Music", 1965, "Robert Wise"),
    (104, "E.T.", 1982, "Steven Spielberg"),
    (105, "Titanic", 1997, "James Cameron"),
    (106, "Snow White", 1937, NULL),
    (107, "Avatar", 2009, "James Cameron"),
    (
        108,
        "Raiders of the Lost Ark",
        1981,
        "Steven Spielberg"
    );

INSERT INTO
    Reviewer (rid, name)
VALUES
    (201, "Sarah Martinez"),
    (202, "Daniel Lewis"),
    (203, "Brittany Harris"),
    (204, "Mike Anderson"),
    (205, "Chris Jackson"),
    (206, "Elizabeth Thomas"),
    (207, "James Cameron"),
    (208, "Ashley White");

INSERT INTO
    Rating (mid, rid, star, ratingDate)
VALUES
    (101, 201, 4, "2011-01-27"),
    (101, 204, 3, "2011-01-09"),
    (103, 203, 2, "2011-01-20"),
    (103, 205, 3, "2011-01-27"),
    (104, 205, 2, "2011-01-22"),
    (104, 208, 3, "2011-01-02"),
    (106, 202, 4, NULL),
    (106, 206, 5, "2011-01-19"),
    (107, 206, 3, "2011-01-15"),
    (107, 207, 5, "2011-01-20"),
    (108, 203, 2, "2011-01-30"),
    (108, 203, 4, "2011-01-12"),
    (108, 205, 4, NULL);