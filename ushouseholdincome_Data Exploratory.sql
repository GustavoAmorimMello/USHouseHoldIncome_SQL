-- US Household Income Exploratory Data Analysis

SELECT * FROM ushouseholdincome;
SELECT * FROM ushouseholdincome_statistics;

-- Exploring the Land Area and Water Area
-- We can see Texas has the largest Land Area
SELECT state_name, SUM(Aland), SUM(Awater) 
FROM ushouseholdincome
GROUP BY State_name
ORDER BY 2 DESC
;
-- We can see Texas has the largest Water Area
SELECT state_name, SUM(Aland), SUM(Awater) 
FROM ushouseholdincome
GROUP BY State_name
ORDER BY 3 DESC
;

-- Top 10 largest states by land
SELECT state_name, SUM(Aland), SUM(Awater) 
FROM ushouseholdincome
GROUP BY State_name
ORDER BY 2 DESC
LIMIT 10
;
-- Top 10 largest states by Water
SELECT state_name, SUM(Aland), SUM(Awater) 
FROM ushouseholdincome
GROUP BY State_name
ORDER BY 3 DESC
LIMIT 10
;

-- INNER JOIN was chosen because RIGHT JOIN showed some data that was NULL
SELECT u.state_name, County, Type, `Primary`, Mean, Median
FROM ushouseholdincome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;
-- Was done a filter based on Mean data based on top 5 Asc order
SELECT u.state_name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM ushouseholdincome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.state_name
ORDER BY 2
LIMIT 5
;
-- Looking for householdincome per Type > Municipality shows with bigger Mean data
-- Urban and Community shows the lowest Mean data average. What could not be sustainable for a house
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM ushouseholdincome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY type
ORDER BY 3 DESC
;
-- Doing a filter by Mean data we can see County, Urban and community areas may be 
-- the most poorest areas
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM ushouseholdincome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY type
ORDER BY 4 DESC
;
-- Filtering states that have community areas
-- The average salaries and the median salaries are lower in Puerto Rico
SELECT * 
FROM ushouseholdincome
WHERE Type = 'Community'
;
-- Filtering out some of the outliers. Considering only the higher volume using types
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM ushouseholdincome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY type
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
;
-- Looking and ordering salaries average per city and ordering in descending order to see richest cities
SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM ushouseholdincome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
 GROUP BY  u.State_Name, City 
 ORDER BY ROUND(AVG(Mean),1) DESC
 ;   