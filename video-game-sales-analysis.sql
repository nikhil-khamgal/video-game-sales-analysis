/* ============================================================
   PROJECT: Video Game Sales Analysis
   DATABASE: video_game
   TABLE: video_games
   TOOL: MySQL Workbench
   ============================================================ */


/* ============================================================
   1. DATABASE SETUP
   ============================================================ */

CREATE DATABASE IF NOT EXISTS video_game;

USE video_game;




SELECT * FROM video_games;


SELECT COUNT(*) AS Total_Rows FROM video_games;


SELECT * FROM video_games LIMIT 10;

-- Check table structure and data types
DESCRIBE video_games;


/* ============================================================
   3. DATA CLEANING & TRANSFORMATION
   ============================================================ */

-- Allow UPDATE and DELETE operations
SET SQL_SAFE_UPDATES = 0;



UPDATE video_games
SET Critic_Count = NULL
WHERE TRIM(Critic_Count) = '';

ALTER TABLE video_games
MODIFY Critic_Count INT;




UPDATE video_games
SET Critic_Score = NULL
WHERE TRIM(Critic_Score) = '';

ALTER TABLE video_games
MODIFY Critic_Score DECIMAL(5,2);


UPDATE video_games
SET User_Count = NULL
WHERE TRIM(User_Count) = '';

ALTER TABLE video_games
MODIFY User_Count INT;




SELECT *
FROM video_games
WHERE TRIM(Name) = '';


-- Remove records where Game Name is missing
-- Name is a critical identifier for game-level analysis

DELETE FROM video_games
WHERE TRIM(Name) = '';


-- ------------------------------------------------------------
-- 3.5 Check missing values in text columns
-- ------------------------------------------------------------

SELECT
    SUM(TRIM(User_Score) = '') AS User_Score_Blank,
    SUM(TRIM(Developer) = '') AS Developer_Blank,
    SUM(TRIM(Rating) = '') AS Rating_Blank
FROM video_games;


-- ------------------------------------------------------------
-- 3.6 Convert blank text values to NULL
-- ------------------------------------------------------------

UPDATE video_games
SET User_Score = NULL
WHERE TRIM(User_Score) = '';

UPDATE video_games
SET Developer = NULL
WHERE TRIM(Developer) = '';

UPDATE video_games
SET Rating = NULL
WHERE TRIM(Rating) = '';


-- Restore safe update mode
SET SQL_SAFE_UPDATES = 1;


/* ============================================================
   4. POST-CLEANING VALIDATION
   ============================================================ */

-- Check final row count
SELECT COUNT(*) AS Final_Total_Rows
FROM video_games;

-- Check remaining NULL values
SELECT
    SUM(User_Score IS NULL) AS User_Score_Null,
    SUM(Developer IS NULL) AS Developer_Null,
    SUM(Rating IS NULL) AS Rating_Null
FROM video_games;

-- Check final table structure
DESCRIBE video_games;


/* ============================================================
   5. BUSINESS ANALYSIS
   ============================================================ */


/* ------------------------------------------------------------
   Analysis 1: Overall Market Performance
   ------------------------------------------------------------ */

SELECT
    COUNT(*) AS Total_Games,
    ROUND(SUM(NA_Sales), 2) AS Total_NA_Sales,
    ROUND(SUM(EU_Sales), 2) AS Total_EU_Sales,
    ROUND(SUM(JP_Sales), 2) AS Total_JP_Sales,
    ROUND(SUM(Other_Sales), 2) AS Total_Other_Sales,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games;


/* ------------------------------------------------------------
   Analysis 2: Top 10 Best-Selling Games
   Business Question:
   Which games generated the highest global sales?
   ------------------------------------------------------------ */

SELECT
    Name,
    Platform,
    Year_of_Release,
    Genre,
    Global_Sales
FROM video_games
ORDER BY Global_Sales DESC
LIMIT 10;


/* ------------------------------------------------------------
   Analysis 3: Platform Performance
   Business Question:
   Which gaming platforms generated the highest total sales?
   ------------------------------------------------------------ */

SELECT
    Platform,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
GROUP BY Platform
ORDER BY Total_Global_Sales DESC
LIMIT 10;


/* ------------------------------------------------------------
   Analysis 4: Genre Performance
   Business Question:
   Which genres generate the highest global sales?
   ------------------------------------------------------------ */

SELECT
    Genre,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
WHERE Genre IS NOT NULL
GROUP BY Genre
ORDER BY Total_Global_Sales DESC;


/* ------------------------------------------------------------
   Analysis 5: Publisher Performance
   Business Question:
   Which publishers generated the highest global sales?
   ------------------------------------------------------------ */

SELECT
    Publisher,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
WHERE Publisher IS NOT NULL
GROUP BY Publisher
ORDER BY Total_Global_Sales DESC
LIMIT 10;


/* ------------------------------------------------------------
   Analysis 6: Publisher Efficiency
   Business Question:
   Which publishers generate the highest average sales per game?
   
   Minimum 50 games used to avoid misleading results from
   publishers with very small portfolios.
   ------------------------------------------------------------ */

SELECT
    Publisher,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales,
    ROUND(AVG(Global_Sales), 2) AS Avg_Sales_Per_Game
FROM video_games
WHERE Publisher IS NOT NULL
GROUP BY Publisher
HAVING COUNT(*) >= 50
ORDER BY Avg_Sales_Per_Game DESC
LIMIT 10;


/* ------------------------------------------------------------
   Analysis 7: Genre Performance by Region
   ------------------------------------------------------------ */

SELECT
    Genre,
    ROUND(SUM(NA_Sales), 2) AS NA_Sales,
    ROUND(SUM(EU_Sales), 2) AS EU_Sales,
    ROUND(SUM(JP_Sales), 2) AS JP_Sales,
    ROUND(SUM(Other_Sales), 2) AS Other_Sales,
    ROUND(SUM(Global_Sales), 2) AS Global_Sales
FROM video_games
WHERE Genre IS NOT NULL
GROUP BY Genre
ORDER BY Global_Sales DESC;


/* ------------------------------------------------------------
   Analysis 8A: Top Games in North America
   ------------------------------------------------------------ */

SELECT
    Name,
    Platform,
    Genre,
    NA_Sales
FROM video_games
WHERE Name IS NOT NULL
ORDER BY NA_Sales DESC
LIMIT 10;


/* ------------------------------------------------------------
   Analysis 8B: Top Games in Europe
   ------------------------------------------------------------ */

SELECT
    Name,
    Platform,
    Genre,
    EU_Sales
FROM video_games
WHERE Name IS NOT NULL
ORDER BY EU_Sales DESC
LIMIT 10;


/* ------------------------------------------------------------
   Analysis 8C: Top Games in Japan
   ------------------------------------------------------------ */

SELECT
    Name,
    Platform,
    Genre,
    JP_Sales
FROM video_games
WHERE Name IS NOT NULL
ORDER BY JP_Sales DESC
LIMIT 10;


/* ------------------------------------------------------------
   Analysis 9: Year-wise Global Sales Trend
   Business Question:
   How did global game sales change over time?
   ------------------------------------------------------------ */

SELECT
    Year_of_Release,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
WHERE Year_of_Release IS NOT NULL
GROUP BY Year_of_Release
ORDER BY Year_of_Release;


/* ------------------------------------------------------------
   Analysis 10: Platform Performance by Year
   Business Question:
   Which platforms were most successful in each year?
   ------------------------------------------------------------ */

SELECT
    Year_of_Release,
    Platform,
    ROUND(SUM(Global_Sales), 2) AS Global_Sales
FROM video_games
WHERE Year_of_Release IS NOT NULL
GROUP BY Year_of_Release, Platform
ORDER BY Year_of_Release, Global_Sales DESC;


/* ------------------------------------------------------------
   Analysis 11: Platform Efficiency
   Business Question:
   Which platforms have the highest average sales per game?
   
   Minimum 50 games used for a more reliable comparison.
   ------------------------------------------------------------ */

SELECT
    Platform,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales,
    ROUND(AVG(Global_Sales), 2) AS Avg_Sales_Per_Game
FROM video_games
GROUP BY Platform
HAVING COUNT(*) >= 50
ORDER BY Avg_Sales_Per_Game DESC;


/* ------------------------------------------------------------
   Analysis 12: Platform vs Genre Performance
   Business Question:
   Which genres perform best on each platform?
   ------------------------------------------------------------ */

SELECT
    Platform,
    Genre,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
WHERE Genre IS NOT NULL
GROUP BY Platform, Genre
ORDER BY Platform, Total_Global_Sales DESC;


/* ------------------------------------------------------------
   Analysis 13: Critic Rating vs Sales
   Business Question:
   Do games with higher critic scores achieve higher sales?
   ------------------------------------------------------------ */

SELECT
    CASE
        WHEN Critic_Score >= 90 THEN 'Excellent'
        WHEN Critic_Score >= 75 THEN 'Good'
        WHEN Critic_Score >= 60 THEN 'Average'
        ELSE 'Low'
    END AS Rating_Category,
    COUNT(*) AS Total_Games,
    ROUND(AVG(Critic_Score), 2) AS Avg_Critic_Score,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales,
    ROUND(AVG(Global_Sales), 2) AS Avg_Sales_Per_Game
FROM video_games
WHERE Critic_Score IS NOT NULL
GROUP BY Rating_Category
ORDER BY Avg_Sales_Per_Game DESC;


/* ------------------------------------------------------------
   Analysis 14: Year-wise Top-Performing Games
   Used to examine game performance across release years.
   ------------------------------------------------------------ */

SELECT
    Year_of_Release,
    Name,
    Platform,
    Genre,
    Global_Sales
FROM video_games
WHERE Year_of_Release IS NOT NULL
ORDER BY Year_of_Release, Global_Sales DESC;


/* ------------------------------------------------------------
   Analysis 15: Sales Concentration
   Business Question:
   What percentage of total global sales comes from the
   top 10 best-selling games?
   ------------------------------------------------------------ */

SELECT
    ROUND(SUM(Global_Sales), 2) AS Top_10_Sales,

    (
        SELECT ROUND(SUM(Global_Sales), 2)
        FROM video_games
    ) AS Total_Global_Sales,

    ROUND(
        SUM(Global_Sales) /
        (SELECT SUM(Global_Sales)
         FROM video_games) * 100,
        2
    ) AS Top_10_Sales_Percentage

FROM (
    SELECT Global_Sales
    FROM video_games
    ORDER BY Global_Sales DESC
    LIMIT 10
) AS top_games;


/* ============================================================
   END OF PROJECT
   ============================================================ */
