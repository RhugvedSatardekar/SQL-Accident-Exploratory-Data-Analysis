select * from dbo.vehicle

select * from dbo.accident

-- ---------------------------------------- Exploratory Data Analysis -------------------------------------------------

-- --Question 1: How many accidents have occurred in urban areas versus rural areas?


select Area,
count(AccidentIndex) as NumberofAccidents
from dbo.accident
group by Area 
order by NumberofAccidents;

-- Question 2: Which day of the week has the highest number of accidents?

select Day, NumberofAccidents from
	(select Day,
	count(AccidentIndex) as NumberofAccidents,
	rank() over (order by count(AccidentIndex) desc) as R
	from dbo.accident
	group by Day) as AccidentTbl
where AccidentTbl.R = 1;

-- Question 3: What is the average age of vehicles involved in accidents based on their type?

select VehicleType,avg(cast(AgeVehicle as int)) as AvgAge
from vehicle
group by VehicleType
order by AvgAge desc

-- Question 4: Can we identify any trends in accidents based on the age of vehicles involved?

select v.VehicleType,a.LightConditions,a.WeatherConditions,a.RoadConditions, avg(cast(a.SpeedLimit as int)) from vehicle as v
join accident as a
on v.AccidentIndex = a.AccidentIndex
group by v.VehicleType, a.LightConditions,a.WeatherConditions,a.RoadConditions
order by v.VehicleType

-- v.AgeVehicle,v.Propulsion,a.LightConditions,a.WeatherConditions,a.RoadConditions,a.SpeedLimit,a.Area

-- Question 5: Are there any specific weather conditions that contribute to severe accidents?

select a.WeatherConditions, a.LightConditions
from 
	vehicle as v
	join 
	accident as a
on v.AccidentIndex = a.AccidentIndex
where a.Severity <> 'Slight' 
-- and a.WeatherConditions <> 'Unknown' and a.WeatherConditions <> 'Other'
group by a.WeatherConditions, a.LightConditions
order by a.WeatherConditions;

-- Question 6: Do accidents often involve impacts on the left-hand side of vehicles?

select LeftHand,count(LeftHand) as SideImpact
	from vehicle
	group by LeftHand

-- Ans: No

-- Question 7: Are there any relationships between journey purposes and the severity of accidents?

select v.JourneyPurpose,a.Severity,count(a.Severity) as SeaverityCount,
rank() over (partition by v.JourneyPurpose order by count(a.Severity) desc) as SeverityRanking
from 
	vehicle as v 
	join
	accident as a
	on v.AccidentIndex = a.AccidentIndex
group by v.JourneyPurpose,a.Severity
order by v.JourneyPurpose

-- Question 8: Calculate the average age of vehicles involved in accidents , considering Day light and point of impact:

select a.Day, avg(cast(v.AgeVehicle as int)) as AvgAge
from 
	vehicle as v 
	join
	accident as a
	on v.AccidentIndex = a.AccidentIndex
where a.LightConditions = 'Daylight' and v.PointImpact = 'Offside'
group by a.Day,a.LightConditions,v.PointImpact;