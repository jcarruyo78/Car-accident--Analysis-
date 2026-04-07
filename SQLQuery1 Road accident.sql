    
select *
from road_accident
-- CURRENT YEAR CASUALTIES
  SELECT SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR(accident_date)= '2022' 

--CURRENT YEAR ACCIDENTS 
SELECT COUNT(*) AS Accidents_2022
FROM road_accident
WHERE accident_date >= '2022-01-01'
  AND accident_date < '2023-01-01';

-- Fatal casualties in 2022 
SELECT SUM(number_of_casualties) AS Fatal_Casualties_2022
FROM road_accident
WHERE accident_severity = 'Fatal'
  AND accident_date >= '2022-01-01'
  AND accident_date < '2023-01-01';

-- Seriouus casulaties in 2022
SELECT SUM(number_of_casualties) AS Serious_Casualties_2022
FROM road_accident
WHERE accident_severity = 'Serious'
AND accident_date >= '2022-01-01'
  AND accident_date < '2023-01-01';

  --SLIGHT CASUALTIES
  SELECT SUM(number_of_casualties) AS CY_Sight_casualties
FROM road_accident
WHERE  accident_severity= 'SLIGHT'


---- Slight percentage in 2022
SELECT 
    SUM(CASE WHEN number_of_casualties= 3 THEN 1 ELSE 0 END) * 100.0 
    / COUNT(*) AS slight_percentage
FROM road_accident
where accident_severity = 'slight'

-- Casualties by vehicle type .....
SELECT 
    vehicle_type,
    SUM(number_of_casualties) AS total_casualties
FROM road_accident
GROUP BY vehicle_type
ORDER BY total_casualties DESC;

----By Groups 
    SELECT 
        CASE 
            WHEN vehicle_type LIKE '%Agricultural%' THEN 'Agricultural'
            WHEN vehicle_type LIKE '%Motorcycle%' 
              OR vehicle_type LIKE '%Bike%' 
              OR vehicle_type LIKE '%Scooter%' THEN 'Bike'
            WHEN vehicle_type LIKE '%Bus%' OR vehicle_type LIKE '%Coach%' THEN 'Bus'
            WHEN vehicle_type LIKE '%Car%' OR vehicle_type LIKE '%Taxi%' THEN 'Car'
            WHEN vehicle_type LIKE '%Van%' THEN 'Van'
            ELSE 'Other'
        END AS vehicle_group,
    
        SUM(number_of_casualties) AS total_casualties

    FROM road_accident
    GROUP BY 
        CASE 
            WHEN vehicle_type LIKE '%Agricultural%' THEN 'Agricultural'
            WHEN vehicle_type LIKE '%Motorcycle%' 
              OR vehicle_type LIKE '%Bike%' 
              OR vehicle_type LIKE '%Scooter%' THEN 'Bike'
            WHEN vehicle_type LIKE '%Bus%' OR vehicle_type LIKE '%Coach%' THEN 'Bus'
            WHEN vehicle_type LIKE '%Car%' OR vehicle_type LIKE '%Taxi%' THEN 'Car'
            WHEN vehicle_type LIKE '%Van%' THEN 'Van'
            ELSE 'Other'
        END

    ORDER BY total_casualties DESC;


---

SELECT 
    MONTH(accident_date) AS MonthNumber,
    DATENAME(MONTH, accident_date) AS MonthName,
    SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = YEAR(2022)
GROUP BY 
    MONTH(accident_date),
    DATENAME(MONTH, accident_date)
ORDER BY 
    MonthNumber;

    ---

    SELECT 
    MONTH(accident_date) AS MonthNumber,
    DATENAME(MONTH, accident_date) AS MonthName,
    SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = 2022  -- change to your data year
GROUP BY 
    MONTH(accident_date),
    DATENAME(MONTH, accident_date)
ORDER BY 
    MonthNumber;

    ---- Casualties by road type
     
  SELECT 
    road_type,
    SUM(number_of_casualties) AS total_casualties
FROM road_accident
GROUP BY road_type
ORDER BY total_casualties DESC;

or if need to filter by year 2022

SELECT 
    road_type,
    SUM(number_of_casualties) AS total_casualties
FROM road_accident
WHERE accident_date = '2022'
GROUP BY road_type
ORDER BY total_casualties DESC;

--- Casualties by urban or rural areaSELECT 
SELECT 
    urban_or_rural_area,
    SUM(number_of_casualties) AS total_casualties
FROM road_accident
GROUP BY urban_or_rural_area
ORDER BY total_casualties DESC;

with Percentage 
SELECT 
    urban_or_rural_area,
    SUM(number_of_casualties) AS total_casualties,
    ROUND(
        100.0 * SUM(number_of_casualties) / SUM(SUM(number_of_casualties)) OVER (), 
        2
    ) AS percentage_share
FROM road_accident
GROUP BY urban_or_rural_area
ORDER BY total_casualties DESC;

--TOP 10 LOCAL PLACES WITH MOST CASUALTIES
SELECT TOP 10
    local_authority,
    SUM(number_of_casualties) AS total_casualties
FROM road_accident
GROUP BY local_authority
ORDER BY total_casualties DESC;

