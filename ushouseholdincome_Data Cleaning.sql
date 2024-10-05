-- US Household Income Data Cleaning

SELECT * FROM ushouseholdincome;
SELECT * FROM ushouseholdincome_statistics;

-- Fixing the column name from the ushouseholdincome_statistics table

ALTER TABLE ushouseholdincome_statistics RENAME COLUMN `ï»¿id` TO `ID`;

-- First  of all, Finding duplicates

SELECT id, 
COUNT(id)
FROM ushouseholdincome
GROUP BY Id
HAVING COUNT(id) > 1
;

SELECT *
FROM (
SELECT row_id,
Id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
FROM ushouseholdincome) as ROw_table
WHERE row_num > 1
;

-- Deleting duplicates from the table
DELETE FROM ushouseholdincome
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
		Id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
		FROM ushouseholdincome) as ROw_table
	WHERE row_num > 1)
;

-- FInding problems in state column
SELECT *
FROM ushouseholdincome
;
-- Was found a state spelled in the wrong way
UPDATE ushouseholdincome
SET state_name = 'Georgia'
WHERE state_name = 'georia'
;

UPDATE ushouseholdincome
SET state_name = 'Alabama'
WHERE state_name = 'alabama'
;

-- Replacing blank value in Place column to a value that correspond to it according to city and county
SELECT state_name, place
FROM ushouseholdincome
WHERE place = ''
;

UPDATE ushouseholdincome
SET Place = 'Autaugaville'
WHERE county = 'Autauga County'
AND city = 'Vinemont'
;

-- Looking for errors of writing on the type column
SELECT Type, COUNT(row_id)
FROM ushouseholdincome
GROUP BY Type
ORDER BY type
;
-- Found Borough and Boroughs are the same. I will fix Boroughs to Borough
SELECT *
FROM ushouseholdincome
WHERE TYPE = 'Boroughs'
;

UPDATE ushouseholdincome
SET Type = 'Borough'
WHERE TYPE = 'Boroughs'
;
