# Netflix Movies and TV Shows Data Analysis using SQL
![Netflix logo](https://github.com/Megha120900/netflix_sql_project/blob/main/BrandAssets_Logos_01-Wordmark.jpg)
## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.


## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

- ## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

```
## Business Questions and Analysis

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1;
```
**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows
```sql
Select type, rating, count(*) as count,
Rank() Over(partition by type order by count(*) desc) as ranking,
Rank() OVER(order by count(*) desc) as ranking_overall
from netflix
GROUP BY 1,2;
```

### 3. List All Movies Released in a Specific Year (e.g., 2020)
```sql
SELECT * 
FROM netflix
WHERE release_year = 2020;
```

### 4. Identify the Longest Movie
```sql
SELECT 
    *, cast(SUBSTRING_INDEX(duration," ",1) as UNSIGNED)
FROM netflix
WHERE type = 'Movie'
ORDER BY cast(SUBSTRING_INDEX(duration," ",1) as UNSIGNED) desc;
```
