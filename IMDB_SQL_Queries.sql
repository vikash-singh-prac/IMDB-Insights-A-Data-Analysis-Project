-- 1. Trend Analysis:
-- 1a
select startYear, avg(runtimeMinutes) 
from imdb_src_movie.dim_title_basics
group by startYear
having startYear=2027
order by startYear;

-- 1b
select tb.startYear, avg(fr.averageRating)
from imdb_src_movie.dim_title_basics tb
join imdb_src_movie.fact_rating fr
on tb.tconst=fr.tconst
group by startYear
order by startYear;

-- 1c
select startYear, count(distinct tconst)
from imdb_src_movie.dim_title_basics
group by startYear
order by startYear;

-- Genre Analysis
-- 2a
SELECT
    dg.genres,
    AVG(fr.averageRating) AS averageGenreRating
FROM
    dim_genre dg
JOIN dim_title_genre dtg ON dg.Genre_SK = dtg.Genre_SK
JOIN dim_title_basics dtb ON dtg.Title_Basics_SK = dtb.Title_Basics_SK
JOIN fact_rating fr ON dtb.tconst = fr.tconst
WHERE
    dtb.startYear BETWEEN YEAR(NOW()) - 10 AND YEAR(NOW()) - 1
GROUP BY
    dg.genres
ORDER BY
    averageGenreRating DESC;

-- 2b
SELECT
    dg.genres,
    SUM(fm.Gross) AS totalGenreGross
FROM
    dim_genre dg
JOIN dim_title_genre dtg ON dg.Genre_SK = dtg.Genre_SK
JOIN dim_title_basics dtb ON dtg.Title_Basics_SK = dtb.Title_Basics_SK
JOIN fact_movies_number fm ON dtb.Title_Basics_SK = fm.Title_Basics_SK
GROUP BY
    dg.genres
ORDER BY
    totalGenreGross DESC
LIMIT 5;

-- 3. Performance Metrics:
-- 3a
select fr.averageRating, avg(tb.runtimeMinutes)
from imdb_src_movie.dim_title_basics tb
join imdb_src_movie.fact_rating fr
on tb.tconst = fr.tconst
group by fr.averageRating
order by fr.averageRating;


-- 3b
select runtimeMinutes, sum(Gross)
from imdb_src_movie.dim_title_basics tb
join imdb_src_movie.fact_movies_number fn
on tb.Title_Basics_SK = fn.Title_Basics_SK
group by runtimeMinutes
order by runtimeMinutes;

-- 3c
select averageRating, avg(numVotes)
from imdb_src_movie.fact_rating
group by averageRating
order by averageRating;

-- 4. Director Success Matirx

-- 4a
use imdb_src_movie;
SELECT
    dp.primaryName AS DirectorName,
    COUNT(fr.tconst) AS NumberOfFilmsAbove7
FROM
    dim_person dp
JOIN dim_title_director dtd ON dp.Person_SK = dtd.Person_SK
JOIN dim_title_basics dtb ON dtd.Title_Basics_SK = dtb.Title_Basics_SK
JOIN fact_rating fr ON dtb.tconst = fr.tconst
WHERE
    fr.averageRating > 7
GROUP BY
    dp.primaryName
ORDER BY
    NumberOfFilmsAbove7 DESC;
    
SELECT
    dp.primaryName AS DirectorName,
    COUNT(DISTINCT fr.tconst) AS FilmsAbove7Count
FROM
    dim_person dp
JOIN dim_title_director dtd ON dp.Person_SK = dtd.Person_SK
JOIN dim_title_basics dtb ON dtd.Title_Basics_SK = dtb.Title_Basics_SK
JOIN fact_rating fr ON dtb.tconst = fr.tconst
WHERE
    fr.averageRating > 7
GROUP BY
    dp.primaryName
ORDER BY
    COUNT(DISTINCT fr.tconst) DESC;



-- 5. Actor/Actress
-- 6. Seasonal Analysis

-- 6a
SELECT
    dd.Season,
    SUM(fm.Gross) AS TotalSeasonGross
FROM
    fact_movies_number fm
JOIN dim_date dd ON fm.Date_SK = dd.Date_SK
GROUP BY
    dd.Season
ORDER BY
    TotalSeasonGross DESC;

-- 6b
WITH RankedMovies AS (
    SELECT
        fm.title,
        fm.Gross,
        dd.Season,
        ROW_NUMBER() OVER (PARTITION BY dd.Season ORDER BY fm.Gross DESC) AS RowNum
    FROM
        fact_movies_number fm
    JOIN dim_date dd ON fm.Date_SK = dd.Date_SK
    WHERE
        dd.Season IN ('Spring', 'Summer', 'Fall')
)
SELECT
    title,
    Gross,
    Season
FROM
    RankedMovies
WHERE
    RowNum <= 3;
    
select m.title, sum(m.Gross)
from fact_movies_number m
join dim_date d on m.Date_SK = d.Date_SK
where d.Season='Spring'
group by m.title
order by sum(m.Gross) desc

-- 7. Release Region
SELECT
    dtb.tconst AS MovieID,
    dtb.primaryTitle AS MovieTitle,
    COUNT(DISTINCT dtreg.Region_SK) AS ReleaseCount
FROM
    dim_title_basics dtb
JOIN dim_title_region dtreg ON dtb.Title_Basics_SK = dtreg.Title_Basics_SK
GROUP BY
    dtb.tconst, dtb.primaryTitle
ORDER BY
    ReleaseCount DESC;


-- Matrix
-- No of directors
SELECT
    dtb.primaryTitle AS MovieTitle,
    COUNT(DISTINCT dtd.Person_SK) AS NumberOfDirectors
FROM
    dim_title_basics dtb
JOIN dim_title_director dtd ON dtb.Title_Basics_SK = dtd.Title_Basics_SK
JOIN (
    SELECT Title_Basics_SK
    FROM fact_movies_number
    ORDER BY Total_Gross DESC
) top_movies ON dtb.Title_Basics_SK = top_movies.Title_Basics_SK
GROUP BY
    dtb.primaryTitle
    order by COUNT(DISTINCT dtd.Person_SK) desc;


-- No of actor/actress
SELECT
    dtb.primaryTitle AS MovieTitle,
    COUNT(DISTINCT dtd.Person_SK) AS NumberOfActors
FROM
    dim_title_basics dtb
JOIN dim_title_actor dtd ON dtb.Title_Basics_SK = dtd.Title_Basics_SK
JOIN (
    SELECT Title_Basics_SK
    FROM fact_movies_number
    ORDER BY Total_Gross DESC
) top_movies ON dtb.Title_Basics_SK = top_movies.Title_Basics_SK
GROUP BY
    dtb.primaryTitle
    order by COUNT(DISTINCT dtd.Person_SK) desc;

-- No of writers
SELECT
    dtb.primaryTitle AS MovieTitle,
    COUNT(DISTINCT dtd.Person_SK) AS NumberOfDirectors
FROM
    dim_title_basics dtb
JOIN dim_title_writer dtd ON dtb.Title_Basics_SK = dtd.Title_Basics_SK
JOIN (
    SELECT Title_Basics_SK
    FROM fact_movies_number
    ORDER BY Total_Gross DESC
) top_movies ON dtb.Title_Basics_SK = top_movies.Title_Basics_SK
GROUP BY
    dtb.primaryTitle
    order by COUNT(DISTINCT dtd.Person_SK) desc;

-- Total worldwide gross earnings
select title, sum(Gross)
from fact_movies_number
group by title 
order by sum(Gross) desc

-- Average Ratings

SELECT
    dtb.primaryTitle AS MovieTitle,
    AVG(fr.averageRating) AS AverageRating
FROM
    dim_title_basics dtb
JOIN fact_movies_number fm ON dtb.Title_Basics_SK = fm.Title_Basics_SK
JOIN fact_rating fr ON dtb.tconst = fr.tconst
WHERE
    dtb.Title_Basics_SK IN (
        SELECT Title_Basics_SK
        FROM fact_movies_number
        ORDER BY Total_Gross DESC
    )
GROUP BY
    dtb.primaryTitle;
 
-- No. of Regions it was realeased
SELECT
    dtb.primaryTitle AS MovieTitle,
    COUNT(DISTINCT dtreg.Region_SK) AS NumberOfRegions
FROM
    dim_title_basics dtb
JOIN dim_title_region dtreg ON dtb.Title_Basics_SK = dtreg.Title_Basics_SK
WHERE
    dtb.Title_Basics_SK IN (
        SELECT Title_Basics_SK
        FROM fact_movies_number
        ORDER BY Total_Gross DESC
    )
GROUP BY
    dtb.primaryTitle
order by  COUNT(DISTINCT dtreg.Region_SK) desc;

-- No of Genres
SELECT
    dtb.primaryTitle AS MovieTitle,
    COUNT(DISTINCT dtgen.Genre_SK) AS NumberOfGenres
FROM
    dim_title_basics dtb
JOIN dim_title_genre dtgen ON dtb.Title_Basics_SK = dtgen.Title_Basics_SK
WHERE
    dtb.Title_Basics_SK IN (
        SELECT Title_Basics_SK
        FROM fact_movies_number
        ORDER BY Total_Gross DESC
    )
GROUP BY
    dtb.primaryTitle
order by  COUNT(DISTINCT dtgen.Genre_SK) desc;