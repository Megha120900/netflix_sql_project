
1.
SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1;


2.
Select type, rating, count(*) as count,
Rank() Over(partition by type order by count(*) desc) as ranking,
Rank() OVER(order by count(*) desc) as ranking_overall
from netflix
GROUP BY 1,2;


3
SELECT * 
FROM netflix
WHERE release_year = 2020;

5.
SELECT 
    *, cast(SUBSTRING_INDEX(duration," ",1) as UNSIGNED)
FROM netflix
WHERE type = 'Movie'
ORDER BY cast(SUBSTRING_INDEX(duration," ",1) as UNSIGNED) desc;


6.
SELECT *,STR_TO_DATE(DATE_ADDED,'%M %D %Y') AS DATE_RELEASED, DATE_added
FROM NETFLIX
WHERE STR_TO_DATE(DATE_ADDED,'%M %D %Y')>=current_date-interval 5 YEAR;


7.
SELECT distinct title,director
FROM NETFLIX
where director like "%Mike Flanagan";

8.
Select *, cast(SUBSTRING_INDEX(duration," ",1) as UNSIGNED) as sessions from netflix
where type = "tv show" and cast(SUBSTRING_INDEX(duration," ",1) as UNSIGNED) > 5;


10.
Select extract(Year from str_to_date(DATE_ADDED,'%M %D %Y')), 
count()/ (Select count() from netflix where country ="India")*100
from netflix
where country ="India"
GROUP BY 1


11.
SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries';


12.
SELECT * 
FROM netflix
WHERE director IS NULL;

13.
SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;


15.
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