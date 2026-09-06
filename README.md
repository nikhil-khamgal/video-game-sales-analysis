#  Video Game Sales Analysis — MySQL

##  Project Overview

This project analyzes historical video game sales data using **MySQL** to identify sales trends, top-performing games, successful gaming platforms, popular genres, publisher performance, regional preferences, and changes in platform leadership over time.

The project follows an end-to-end SQL workflow, starting from data inspection and cleaning and progressing to business-focused analysis and insights.

---

##  Business Objective

The main objective of this project is to analyze video game sales data and answer key business questions such as:

* Which games generated the highest global sales?
* Which gaming platforms performed best?
* Which genres generated the highest sales?
* Which publishers performed best?
* Which publishers had the highest average sales per game?
* How do genre preferences differ across regions?
* Which games performed best in different markets?
* How did global sales change over time?
* Which platforms dominated different years?
* Which genres performed best on different platforms?
* Is there an association between critic scores and game sales?
* How concentrated are global sales among the top-selling games?

---

##  Dataset

The dataset contains historical video game information including:

* Game Name
* Platform
* Year of Release
* Genre
* Publisher
* Regional Sales
* Global Sales
* Critic Score
* Critic Count
* User Score
* User Count
* Developer
* Rating

The dataset contains **16,448 records after cleaning**.

Sales values are measured in **millions of units**.

---

##  Tools & Technologies

* **MySQL**
* **MySQL Workbench**
* SQL
* CSV Dataset

---

##  Project Workflow

```text
Raw Dataset
     ↓
Data Inspection
     ↓
Data Type Validation
     ↓
Data Cleaning
     ↓
Missing Value Handling
     ↓
Data Validation
     ↓
Business Analysis
     ↓
Insights & Recommendations
```

---

##  Data Cleaning

The dataset was prepared for analysis using SQL-based data cleaning techniques.

### Key cleaning steps:

* Inspected the dataset structure using `DESCRIBE`.
* Checked the total number of records.
* Identified blank and missing values.
* Converted blank values to `NULL` where appropriate.
* Converted `Critic_Count` from text to `INT`.
* Converted `Critic_Score` from text to `DECIMAL(5,2)`.
* Converted `User_Count` from text to `INT`.
* Removed records where the game name was missing because the game identifier was unavailable.
* Performed post-cleaning validation using record counts and NULL checks.

---

##  SQL Concepts Used

This project demonstrates practical use of:

* `SELECT`
* `WHERE`
* `IS NULL`
* `TRIM()`
* `UPDATE`
* `DELETE`
* `ALTER TABLE`
* `MODIFY`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `LIMIT`
* `COUNT()`
* `SUM()`
* `AVG()`
* `ROUND()`
* `CASE WHEN`
* Subqueries
* Aggregate Functions
* Data Cleaning
* Data Type Conversion

---

#  Key Analysis & Insights

## 1. Overall Market Performance

The dataset contains **16,448 games** with total global sales of **8,818.92 million units**.

Regional sales:

| Region        | Sales (Million) |
| ------------- | --------------: |
| North America |        4,341.69 |
| Europe        |        2,399.68 |
| Japan         |        1,290.70 |
| Other Regions |          782.65 |
| Global        |        8,818.92 |

**Insight:** North America represents the largest regional market in the dataset, followed by Europe and Japan.

---

## 2. Top-Selling Games

**Wii Sports** was the highest-selling game with **82.53 million global sales**, followed by **Super Mario Bros.** with **40.24 million**.

**Insight:** Nintendo titles are strongly represented among the highest-selling games, demonstrating the commercial strength of major Nintendo franchises.

---

## 3. Platform Performance

**PS2** generated the highest total global sales at **1,233.46 million units**.

Other major platforms included:

* Xbox 360
* PS3
* Wii
* DS

**Insight:** PS2 had the largest overall sales volume in the dataset, showing strong commercial performance across its game portfolio.

---

## 4. Genre Performance

The highest-selling genres were:

1. **Action — 1,717.63M**
2. **Sports — 1,310.39M**
3. **Shooter — 1,041.83M**
4. **Role-Playing — 930.90M**

**Insight:** Action was the leading genre by global sales and also had the highest number of games in the dataset.

---

## 5. Publisher Performance

**Nintendo** generated the highest global sales at **1,786.72 million units**, followed by Electronic Arts and Activision.

**Insight:** Nintendo achieved strong overall sales despite having fewer games than some other major publishers.

---

## 6. Publisher Efficiency

When comparing publishers with at least 50 games, **Nintendo** had the highest average sales per game at **2.55 million units**.

**Insight:** Nintendo's strong average sales per title indicates high portfolio efficiency rather than relying only on a large number of releases.

---

## 7. Regional Genre Preferences

Regional analysis showed different genre preferences:

* **North America:** Action and Sports performed strongly.
* **Europe:** Action and Sports performed strongly.
* **Japan:** Role-Playing games showed particularly strong performance.

**Insight:** Video game preferences vary by region, suggesting that publishers can benefit from region-specific strategies.

---

## 8. Regional Top-Selling Games

### North America

**Wii Sports** was the highest-selling game with **41.36M units**.

### Europe

**Wii Sports** was the highest-selling game with **28.96M units**.

### Japan

**Pokémon Red/Pokémon Blue** was the highest-selling game with **10.22M units**.

**Insight:** North America and Europe showed strong performance for Wii Sports, while Japan showed a much stronger preference for Pokémon and Role-Playing titles.

---

## 9. Year-wise Sales Trend

Global sales increased significantly from the mid-1990s and reached the highest recorded level in the dataset in **2008**, with **671.79 million units**.

The number of game releases also peaked around this period.

**Insight:** The dataset shows significant growth in the video game market during the 2000s.

**Data Quality Note:** Later years contain considerably fewer records, so the apparent decline after 2010 should be interpreted cautiously because the dataset may have incomplete coverage for those years.

---

## 10. Platform Leadership Over Time

The analysis identified major shifts in platform leadership across different generations:

```text
Atari 2600
     ↓
NES
     ↓
Game Boy / SNES
     ↓
PlayStation
     ↓
PS2
     ↓
Wii
     ↓
Xbox 360 / PS3
     ↓
PS4
```

**Insight:** Video game market leadership changed significantly as new platform generations were introduced.

---

## 11. Platform Efficiency

**Game Boy** achieved the highest average sales per game at **2.62 million**, followed closely by NES at **2.56 million**.

However, **PS2** had the highest total sales.

**Insight:** Total sales and average sales per game measure different aspects of platform performance. A platform can have a large overall market while having lower average sales per title.

---

## 12. Platform vs Genre

Genre performance varied across platforms:

* **PlayStation platforms:** Action performed strongly.
* **Wii:** Sports performed particularly well.
* **Xbox platforms:** Shooter games performed strongly.
* **Nintendo handheld platforms:** Role-Playing and Platform genres showed strong performance.

**Insight:** Genre success can depend significantly on the platform ecosystem.

---

## 13. Critic Score vs Sales

Games were grouped into four critic-score categories:

| Category  | Average Sales/Game |
| --------- | -----------------: |
| Excellent |              2.85M |
| Good      |              1.01M |
| Average   |              0.43M |
| Low       |              0.27M |

**Insight:** Games with higher critic scores were associated with higher average global sales.

This analysis shows an **association**, not proof that critic scores directly cause higher sales.

---

## 14. Sales Concentration

The top 10 best-selling games generated:

* **Top 10 Sales:** 368.04M
* **Total Global Sales:** 8,818.92M
* **Top 10 Contribution:** 4.17%

**Insight:** The top 10 games accounted for only **4.17%** of total global sales, indicating that overall sales were distributed across a large number of titles rather than being dominated by a small group of blockbuster games.

---

#  Business Recommendations

Based on the analysis:

### 1. Focus on High-Performing Genres

Publishers can prioritize commercially strong genres such as **Action, Sports, Shooter, and Role-Playing**, while considering platform and regional preferences.

### 2. Use Region-Specific Strategies

Regional differences suggest that publishers should avoid using a single global strategy. For example, Role-Playing games may receive stronger attention in the Japanese market.

### 3. Consider Platform-Specific Genre Strategies

Genre performance differs across platforms. Publishers can evaluate the strengths of each platform before deciding which type of game to develop or prioritize.

### 4. Evaluate Portfolio Efficiency

Total sales alone do not provide the complete picture. Average sales per game can help publishers understand the efficiency of their game portfolios.

### 5. Consider Critical Reception

Higher critic scores were associated with higher average sales. Maintaining strong game quality may therefore be an important factor when targeting commercial success.

---

#  Conclusion

This project demonstrates how **MySQL can be used to transform raw sales data into actionable business insights**.

The analysis identified major trends across **games, platforms, genres, publishers, regions, and years**. It also demonstrated the importance of comparing both total performance and efficiency when evaluating platforms and publishers.

Overall, the project provided practical experience in **SQL data cleaning, exploratory analysis, aggregation, business-question solving, and insight generation**.

---

##  Project Files

```text
video-game-sales-analysis/
│
├── Video_Games_Sales_as_at_22_Dec_2016.csv
│
└── video_game_sales_analysis.sql
```

### SQL File

The `video_game_sales_analysis.sql` file contains the complete SQL workflow, including:

* Database setup
* Data inspection
* Data cleaning
* Data type conversion
* Missing value handling
* Business analysis queries

---

## 👨‍💻 Project Type

**Data Analytics | SQL Project**

**Primary Skill:** MySQL / SQL

**Focus Areas:** Data Cleaning, Exploratory Data Analysis, Business Analysis, Sales Analytics
