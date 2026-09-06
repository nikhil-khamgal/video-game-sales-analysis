create database   video_game;

select * from video_games;

SELECT COUNT(*) AS total_rows FROM video_games;

SELECT * FROM video_games LIMIT 10;

 #check data types & change 
 
DESCRIBE video_games; 

UPDATE video_games
SET Critic_Count = NULL
WHERE TRIM(Critic_Count) = '';

SET SQL_SAFE_UPDATES = 0;

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

ALTER TABLE video_games
MODIFY User_Count INT; 

#check null values 

SELECT *
FROM video_games
WHERE TRIM(Name) = '';

DELETE FROM video_games
WHERE TRIM(Name) = '';

SELECT
    SUM(TRIM(User_Score) = '') AS User_Score_Blank,
    SUM(TRIM(Developer) = '') AS Developer_Blank,
    SUM(TRIM(Rating) = '') AS Rating_Blank
FROM video_games;

SET SQL_SAFE_UPDATES = 0;

UPDATE video_games
SET User_Score = NULL
WHERE TRIM(User_Score) = '';

UPDATE video_games
SET Developer = NULL
WHERE TRIM(Developer) = '';

UPDATE video_games
SET Rating = NULL
WHERE TRIM(Rating) = '';

SELECT
    SUM(User_Score IS NULL) AS User_Score_Null,
    SUM(Developer IS NULL) AS Developer_Null,
    SUM(Rating IS NULL) AS Rating_Null
FROM video_games;

# Analyais

SELECT
    COUNT(*) AS Total_Games,
    ROUND(SUM(NA_Sales), 2) AS Total_NA_Sales,
    ROUND(SUM(EU_Sales), 2) AS Total_EU_Sales,
    ROUND(SUM(JP_Sales), 2) AS Total_JP_Sales,
    ROUND(SUM(Other_Sales), 2) AS Total_Other_Sales,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games;

#Which games generated the highest global sales?
SELECT
    Name,
    Platform,
    Year_of_Release,
    Genre,
    Global_Sales
FROM video_games
ORDER BY Global_Sales DESC
LIMIT 10;
#Which gaming platforms generated the highest total global sales?
SELECT
    Platform,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
GROUP BY Platform
ORDER BY Total_Global_Sales DESC
LIMIT 10;

#Which genres generate the highest global sales?
SELECT
    Genre,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
WHERE Genre IS NOT NULL
GROUP BY Genre
ORDER BY Total_Global_Sales DESC;

#Which publishers have generated the highest global sales?

SELECT
    Publisher,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
WHERE Publisher IS NOT NULL
GROUP BY Publisher
ORDER BY Total_Global_Sales DESC
LIMIT 10;

#Which publishers generate the highest average sales per game?
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

#Which games perform best in each region?

SELECT
    Name,
    Platform,
    Genre,
    NA_Sales
FROM video_games
WHERE Name IS NOT NULL
ORDER BY NA_Sales DESC
LIMIT 10;

SELECT
    Name,
    Platform,
    Genre,
    EU_Sales
FROM video_games
WHERE Name IS NOT NULL
ORDER BY EU_Sales DESC
LIMIT 10;

SELECT
    Name,
    Platform,
    Genre,
    JP_Sales
FROM video_games
WHERE Name IS NOT NULL
ORDER BY JP_Sales DESC
LIMIT 10;

#Year-wise Global Sales Trend
SELECT
    Year_of_Release,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
WHERE Year_of_Release IS NOT NULL
GROUP BY Year_of_Release
ORDER BY Year_of_Release;

#Which Platforms Were Most Successful in Each Year?

SELECT
    Year_of_Release,
    Platform,
    ROUND(SUM(Global_Sales), 2) AS Global_Sales
FROM video_games
WHERE Year_of_Release IS NOT NULL
GROUP BY Year_of_Release, Platform
ORDER BY Year_of_Release, Global_Sales DESC;


SELECT
    Platform,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales,
    ROUND(AVG(Global_Sales), 2) AS Avg_Sales_Per_Game
FROM video_games
GROUP BY Platform
HAVING COUNT(*) >= 50
ORDER BY Avg_Sales_Per_Game DESC;

#Which Genres Perform Best on Each Platform?

SELECT
    Platform,
    Genre,
    COUNT(*) AS Total_Games,
    ROUND(SUM(Global_Sales), 2) AS Total_Global_Sales
FROM video_games
WHERE Genre IS NOT NULL
GROUP BY Platform, Genre
ORDER BY Platform, Total_Global_Sales DESC;

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

SELECT
    Year_of_Release,
    Name,
    Platform,
    Genre,
    Global_Sales
FROM video_games
WHERE Year_of_Release IS NOT NULL
ORDER BY Year_of_Release, Global_Sales DESC;

SELECT
    ROUND(SUM(Global_Sales), 2) AS Top_10_Sales,
    (
        SELECT ROUND(SUM(Global_Sales), 2)
        FROM video_games
    ) AS Total_Global_Sales,
    ROUND(
        SUM(Global_Sales) /
        (SELECT SUM(Global_Sales) FROM video_games) * 100,
        2
    ) AS Top_10_Sales_Percentage
FROM (
    SELECT Global_Sales
    FROM video_games
    ORDER BY Global_Sales DESC
    LIMIT 10
) AS top_games;