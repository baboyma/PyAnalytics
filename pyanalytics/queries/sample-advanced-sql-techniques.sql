-- Active: 1740851630833@@127.0.0.1@5432@training@public

-- REF.: https://medium.com/@esrasoylu/advanced-sql-techniques-7016163019eb

-- ADVANCED SQL TECHNIQUES

-- 1. Database Partitioning

/**
    - List partitioning
    - Range partitioning
    - Hash partitioning
    - Composite partitioning
**/

-- Create Table for Kaggle Video Games dataset ---

DROP TABLE IF EXISTS videogames;

CREATE TABLE videogames (
    game_id SERIAL,
    game_rank INT,
    game_name TEXT,
    platform TEXT,
    year_of_release INT,
    genre TEXT,
    publisher TEXT,
    na_sales NUMERIC(10, 2),
    eu_sales NUMERIC(10, 2),
    jp_sales NUMERIC(10, 2),
    other_sales NUMERIC(10, 2),
    global_sales NUMERIC(10, 2)
)
PARTITION BY LIST (platform);

-- Create Partitions

CREATE TABLE videogames_ps2 PARTITION OF videogames
    FOR VALUES IN ('PS2');

CREATE TABLE videogames_ps3 PARTITION OF videogames
    FOR VALUES IN ('PS3');

CREATE TABLE videogames_ps4 PARTITION OF videogames
    FOR VALUES IN ('PS4');

-- Can create a default partition for other platforms.
CREATE TABLE videogames_other PARTITION OF videogames
    DEFAULT;

-- Copy data from CSV file to tables --

/** COPY function did not work on VSCode - Use PGAdmin4 **/

/**
COPY videogames (game_name, platform, year_of_release, genre, publisher, na_sales, eu_sales, jp_sales, other_sales, global_sales)
FROM '~/Documents/Projects/Python/PyAnalytics/data/videogames.csv'
DELIMITER ','
CSV HEADER
NULL AS 'N/A';
**/

-- Check data

SELECT COUNT(*) FROM videogames;

SELECT COUNT(*) FROM videogames_ps2;

-- CASE #2: RANGE Partition

CREATE TABLE videogames_rg (
    game_id SERIAL,
    game_rank INT,
    game_name TEXT,
    platform TEXT,
    year_of_release INT,
    genre TEXT,
    publisher TEXT,
    na_sales NUMERIC(10, 2),
    eu_sales NUMERIC(10, 2),
    jp_sales NUMERIC(10, 2),
    other_sales NUMERIC(10, 2),
    global_sales NUMERIC(10, 2)
) PARTITION BY RANGE (year_of_release);

CREATE TABLE videogames_1980s PARTITION OF videogames_rg
    FOR VALUES FROM (1980) TO (2000);

CREATE TABLE videogames_2000s PARTITION OF videogames_rg
    FOR VALUES FROM (2000) TO (2010);

CREATE TABLE videogames_2010s PARTITION OF videogames_rg
    FOR VALUES FROM (2010) TO (2020);

CREATE TABLE videogames_2020s PARTITION OF videogames_rg
    FOR VALUES FROM (2020) TO (2025);

CREATE TABLE videogames_default PARTITION OF videogames_rg
    DEFAULT;

-- Check range partition data

select count(*) from videogames_rg;

select count(*) from videogames_2000s;

-- CASE #3: HASH Partition

DROP TABLE IF EXISTS videogames_ha;

CREATE TABLE videogames_ha (
    game_id SERIAL,
    game_rank INT,
    game_name TEXT,
    platform TEXT,
    year_of_release INT,
    genre TEXT,
    publisher TEXT,
    na_sales NUMERIC(10, 2),
    eu_sales NUMERIC(10, 2),
    jp_sales NUMERIC(10, 2),
    other_sales NUMERIC(10, 2),
    global_sales NUMERIC(10, 2),
    PRIMARY KEY (game_id, year_of_release)
) PARTITION BY HASH (year_of_release);

-- Hash 1. partition
CREATE TABLE videogames_h1 PARTITION OF videogames_ha
    FOR VALUES WITH (MODULUS 4, REMAINDER 0);

-- Hash 2. partition
CREATE TABLE videogames_h2 PARTITION OF videogames_ha
    FOR VALUES WITH (MODULUS 4, REMAINDER 1);

-- Hash 3. partition
CREATE TABLE videogames_h3 PARTITION OF videogames_ha
    FOR VALUES WITH (MODULUS 4, REMAINDER 2);

-- Hash 4. partition
CREATE TABLE videogames_h4 PARTITION OF videogames_ha
    FOR VALUES WITH (MODULUS 4, REMAINDER 3);

-- Check hash partition records

select count(*) from videogames_ha;

select count(*) from videogames_h1;

-- CASE #4: Compuse Partition

CREATE TABLE videogames_co (
    game_id SERIAL,
    game_rank INT,
    game_name TEXT,
    platform TEXT,
    year_of_release INT,
    genre TEXT,
    publisher TEXT,
    na_sales NUMERIC(10, 2),
    eu_sales NUMERIC(10, 2),
    jp_sales NUMERIC(10, 2),
    other_sales NUMERIC(10, 2),
    global_sales NUMERIC(10, 2)
) PARTITION BY RANGE (year_of_release);

-- Partition for the years 1980-2000
CREATE TABLE video_games_1980s PARTITION OF video_games
    FOR VALUES FROM (1980) TO (2000) PARTITION BY LIST (platform);

-- Partition for the years 2000-2010
CREATE TABLE video_games_2000s PARTITION OF video_games
    FOR VALUES FROM (2000) TO (2010) PARTITION BY LIST (platform);

--List division by platform for the years 1980-2000
CREATE TABLE video_games_1980s_wii_ps2 PARTITION OF video_games_1980s
    FOR VALUES IN ('Wii', 'PS2');

--List division by platform for the years 2000-2010
CREATE TABLE video_games_2000s_ps3_xbox_pc PARTITION OF video_games_2000s
    FOR VALUES IN ('PS3', 'XBOX', 'PC');

-- 2) Windowing Functions
-- 2.1.)Using Partition By with SQL Sorting Functions

/**
Let’s consider the frequently used sorting functions with Partition By.

Row Number:
When sorting in a data set, the sorting continues regardless of whether they have equal values.

Rank:
When sorting a data set, if there are values ​​of equal value, the data remains the same number as the ranking number.
When a different value arrives, it is increased by the skipped value.

Dense Rank:
When sorting a data set, if there are values ​​of equal value, the data remains the same number as the ranking number.
When a different value arrives, the next number is passed in order.
**/

-- Ranking of games based on sales amount

SELECT DISTINCT platform FROM videogames ORDER BY platform;

SELECT
    game_name,
    platform,
    year_of_release,
    global_sales,
    RANK() OVER (PARTITION BY platform ORDER BY global_sales DESC) AS sales_rank
FROM
    videogames;


-- 2.2.) Value Functions
/**
LAG: This function, used with time data, is a function that accesses a previous row from another column and allows you to create a new column with this accessed information.
Syntax: LAG (column1_name) OVER (ORDER BY column2_name) AS newcolumn_name

Lead: It is a function that allows you to create a new column by taking the value from the next row. For example, if we want to create a column about next month’s sales in the list of monthly sales, the Lead function can be used.
Syntax: LAG (column1_name) OVER (ORDER BY column2_name) AS newcolumn_name
**/

SELECT
    game_name,
    platform,
    year_of_release,
    global_sales,
    LAG(global_sales, 1) OVER (ORDER BY year_of_release) AS previous_sales,
    LEAD(global_sales, 1) OVER (ORDER BY year_of_release) AS next_sales
FROM
    videogames;

/**
First Value: If we want to get the first value from an ordered list, we can use the first_value function. For example, this function can be used when we want to find the first year of game sales.
Last Value:When we want to get the last value from a sorted column, we can use the last_value function. For example, we can use this function when we want to find the last year of game sales.
**/

SELECT
    game_name,
    platform,
    year_of_release,
    global_sales,
    FIRST_VALUE(year_of_release) OVER (PARTITION BY platform ORDER BY year_of_release) AS first_sales,
    LAST_VALUE(year_of_release) OVER (PARTITION BY platform ORDER BY year_of_release RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sales
FROM
    videogames;

-- 3)Case Statements
/**
In SQL, the `CASE` statement is used to create conditional expressions to check, return values, or generate new columns through logical validation. In each `CASE` expression, the condition is specified using `WHEN`, and `END` is used to terminate the conditions.

Syntax:

CASE case_value
WHEN condition THEN result1
WHEN condition THEN result2
If not the result
END CASE;
**/

SELECT
    game_name,
    platform,
    na_sales,
    CASE
        WHEN na_sales > 5 THEN 'High'
        WHEN na_sales BETWEEN 2 AND 5 THEN 'Medium'
        ELSE 'Low'
    END AS sales_level
FROM videogames;

-- Total Sales by platform and by year

SELECT
    platform,
    SUM(CASE WHEN year_of_release = 2005 THEN na_sales ELSE 0 END) AS sales_2005,
    SUM(CASE WHEN year_of_release = 2006 THEN na_sales ELSE 0 END) AS sales_2006,
    SUM(CASE WHEN year_of_release = 2007 THEN na_sales ELSE 0 END) AS sales_2007
FROM
    videogames
GROUP BY
    platform;