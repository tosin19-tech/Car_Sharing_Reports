SELECT * FROM carsharing;
SELECT * FROM temperature;
SELECT * FROM weather;
SELECT * FROM time;



-- (a) Please tell me which date and time we had the highest demand rate in 2017.--
SELECT Round(c.demand, 2) as highest_demand_rate, t.timestamp as Date, t.hour from time as t
join 
carsharing as c
using (timestamp)
where t.timestamp like '%2017'
Order by c.demand  desc
limit 1;



/* (b) Give me a table containing the name of the weekday, month, and season in which we had the highest and lowest average demand throughout 2017.
 Please include the calculated average demand values as well.*/
 
 -- Highest average demand--
 SELECT 'Highest' as category, Round(avg(demand), 2) as Avg_demand, t.weekday, t.monthname,t.season from carsharing as c
 join time as t
 using (timestamp)
 where t.Year = 2017
 Group by t.weekday, t.monthname, t.Year,t.season
 Order by Avg_demand desc
 limit 1;
 
 SELECT 'Lowest' as category, Round(avg(demand), 2) as Avg_demand, t.weekday, t.monthname,t.season from carsharing as c
 join time as t
 using (timestamp)
 where t.Year = 2017
 Group by t.weekday, t.monthname, t.Year,t.season
 Order by Avg_demand asc 
 limit 1;
 
 
 
 
/*(c) For the weekday(s) selected in (b), please give me a table showing the average demand we had at different hours of that weekday throughout 2017. 
Please sort the results in descending order based on the average demand.*/

-- For Sunday--
(SELECT 'Sunday' as Day,Round(avg(demand), 2) as Avg_demand, t.weekday, t.hour FROM carsharing as c
join 
time as t
using (timestamp)
WHERE t.Year = 2017 AND t.weekday = 'Sun' 
GROUP BY t.weekday, t.hour, Day 
Order by Avg_demand)

UNION ALL
(SELECT 'Monday' as Day, Round(avg(demand), 2) as Avg_demand, t.weekday, t.hour FROM carsharing as c
join 
time as t
using (timestamp)
WHERE t.Year = 2017 AND t.weekday = 'Mon' 
GROUP BY t.weekday, t.hour, Day 
Order by Avg_demand);

SELECT * FROM carsharing;


/* (d) Please tell me what the weather was like in 2017. Was it mostly cold, mild, or hot? which weather condition (shown in the weather column) was the most prevalent in 2017?
 What was the average, highest, and lowest wind speed and humidity for each month in 2017? Please organize this information in two tables for the wind speed and humidity.
 Please also give me a table showing the average demand for each cold, mild, and hot weather in 2017 sorted in descending order based on their average demand. */
 
 -- The most prevalent weather in 2017--
 SELECT  weather, count(*) as occurences from carsharing
 where timestamp LIKE '%2017'
 group by weather 
 order by occurences desc;
 
 -- Average, highest and lowest wind speed (2017)--
 SELECT avg(windspeed) as Avg_windspeed, max(windspeed) as Highest_windspeed, min(windspeed) as Lowest_windspeed, t.monthname from carsharing
 join 
 time as t
 Using (timestamp)
 group by t.monthname;
 
 -- Average, highest and lowest humidity (2017)--
 SELECT avg(monthname) as Avg_humidity, max(humidity) as Highest_humidity, min(humidity) as Lowest_humidity, t.monthname from carsharing
 join 
 time as t
 Using (timestamp)
 group by t.monthname;
 
  
-- Average demand for each cold, mild, and hot weather in 2017 --  
SELECT * FROM weather;
SELECT * FROM carsharing;
SELECT Round(avg(demand), 2) as Avg_demand, t.temp_category from carsharing as c
join 
temperature as t
where c.timestamp like '%2017'
group by t.temp_category;	

 

-- (e) Give me another table showing the information requested in (d) for the month we had the highest average demand in 2017 so that I can compare it with other months.--
SELECT Round(avg(demand), 2) as Avg_demand,tm.monthname, t.temp_category from carsharing as c
join 
time as tm 
using (timestamp)
join 
temperature as t
using (temp_code)
where c.timestamp like '%2017'
group by t.temp_category,tm.monthname
order by Avg_demand desc;	
