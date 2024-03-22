# Vehicle and Accident Analysis

This repository contains SQL queries and analysis related to vehicle information and accident data. The analysis aims to answer various questions regarding accidents, vehicle characteristics, and related trends. I have used SQL Server Management Studio to build this project.

## Data Exploration

### Question 1: Accidents in Urban vs Rural Areas

This query counts the number of accidents that occurred in urban and rural areas. It groups the data by the 'Area' column in the 'accident' table and then calculates the count of accidents in each area.

```markdown


```sql
SELECT 
    Area, 
    COUNT(AccidentIndex) AS NumberofAccidents
FROM 
    dbo.accident
GROUP BY 
    Area 
ORDER BY 
    NumberofAccidents DESC;
```

### Question 2: Day with Highest Accidents

This query identifies the day of the week with the highest number of accidents. It counts the accidents for each day and then selects the day with the highest count using the `LIMIT` clause.

```sql
SELECT 
    Day, 
    COUNT(AccidentIndex) AS NumberofAccidents
FROM 
    dbo.accident
GROUP BY 
    Day
ORDER BY 
    NumberofAccidents DESC
LIMIT 1;
```

### Question 3: Average Age of Vehicles by Type

This query calculates the average age of vehicles involved in accidents based on their types. It calculates the average of the 'AgeVehicle' column after converting it to an integer using `CAST`.

```sql
SELECT 
    VehicleType, 
    AVG(CAST(AgeVehicle AS INT)) AS AvgAge
FROM 
    vehicle
GROUP BY 
    VehicleType
ORDER BY 
    AvgAge DESC;
```

### Question 4: Trends in Accidents based on Vehicle Age

This query identifies trends in accidents based on vehicle age, light conditions, weather conditions, road conditions, and speed limits. It joins the 'vehicle' and 'accident' tables to analyze the data.

```sql
SELECT 
    v.VehicleType, 
    a.LightConditions, 
    a.WeatherConditions, 
    a.RoadConditions, 
    AVG(CAST(a.SpeedLimit AS INT)) AS AvgSpeedLimit
FROM 
    vehicle AS v
JOIN 
    accident AS a
ON 
    v.AccidentIndex = a.AccidentIndex
GROUP BY 
    v.VehicleType, 
    a.LightConditions, 
    a.WeatherConditions, 
    a.RoadConditions
ORDER BY 
    v.VehicleType;
```

### Question 5: Weather Conditions and Severe Accidents

This query identifies specific weather conditions contributing to severe accidents. It filters out accidents with severity 'Slight' and then counts the occurrences for each weather condition.

```sql
SELECT 
    a.WeatherConditions, 
    COUNT(*) AS NumberofAccidents
FROM 
    vehicle AS v
JOIN 
    accident AS a
ON 
    v.AccidentIndex = a.AccidentIndex
WHERE 
    a.Severity <> 'Slight'
GROUP BY 
    a.WeatherConditions
ORDER BY 
    NumberofAccidents DESC;
```

### Question 6: Side Impacts in Accidents

This query analyzes whether accidents often involve impacts on the left-hand side of vehicles. It counts the occurrences of side impacts for each type of vehicle.

```sql
SELECT 
    LeftHand, 
    COUNT(*) AS NumberofAccidents
FROM 
    vehicle
GROUP BY 
    LeftHand;
```

### Question 7: Journey Purposes and Accident Severity

This query investigates relationships between journey purposes and the severity of accidents. It counts the occurrences of accident severities for each journey purpose.

```sql
SELECT 
    v.JourneyPurpose, 
    a.Severity, 
    COUNT(*) AS NumberofAccidents
FROM 
    vehicle AS v 
JOIN 
    accident AS a
ON 
    v.AccidentIndex = a.AccidentIndex
GROUP BY 
    v.JourneyPurpose, 
    a.Severity
ORDER BY 
    v.JourneyPurpose, 
    a.Severity;
```

### Question 8: Average Age of Vehicles in Accidents by Daylight and Impact Point

This query calculates the average age of vehicles involved in accidents considering daylight conditions and the point of impact. It filters the data based on daylight conditions and the impact point and then calculates the average age.

```sql
SELECT 
    a.Day, 
    a.LightConditions, 
    v.PointImpact,
    AVG(CAST(v.AgeVehicle AS INT)) AS AvgAge
FROM 
    vehicle AS v 
JOIN 
    accident AS a
ON 
    v.AccidentIndex = a.AccidentIndex
WHERE 
    a.LightConditions = 'Daylight' 
    AND v.PointImpact = 'Offside'
GROUP BY 
    a.Day, 
    a.LightConditions, 
    v.PointImpact;
```

## Summary

The analysis covers a range of questions related to accidents, vehicle characteristics, and accident severity. It provides insights into accidents' spatial distribution, temporal patterns, vehicle age effects, impact points, and journey purposes' influence on accident severity. These insights can be valuable for understanding accident trends and implementing targeted safety measures.
```

