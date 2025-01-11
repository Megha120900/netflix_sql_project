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

### 5. Find Content Added in the Last 5 Years
```sql
SELECT *,STR_TO_DATE(DATE_ADDED,'%M %D %Y') AS DATE_RELEASED, DATE_added
FROM NETFLIX
WHERE STR_TO_DATE(DATE_ADDED,'%M %D %Y')>=current_date-interval 5 YEAR;
```

### 6. Find All Movies/TV Shows by Director 'Mike Flanagan'
```sql
SELECT distinct title,director
FROM NETFLIX
where director like "%Mike Flanagan";
```

### 7. List All TV Shows with More Than 5 Seasons
```sql
Select *, cast(SUBSTRING_INDEX(duration," ",1) as UNSIGNED) as sessions from netflix
where type = "tv show" and cast(SUBSTRING_INDEX(duration," ",1) as UNSIGNED) > 5;
```

### 8.Find each year and the average numbers of content release in India on netflix. 
```sql
Select extract(Year from str_to_date(DATE_ADDED,'%M %D %Y')), 
count()/ (Select count() from netflix where country ="India")*100
from netflix
where country ="India"
GROUP BY 1
```

### 9. List All Movies that are Documentaries

```sql
SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries';
```


### 10. Find All Content Without a Director

```sql
SELECT * 
FROM netflix
WHERE director IS NULL;
```

### 11. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

### 12. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords
```sql

With count_label As(
Select title, description,
CASE WHEN description like "%kill%" or "%violence%" THEN "Bad"
ELSE "Good"
END AS Label
from netflix
)
Select count(*),label
from count_label
group by Label;
```

## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

