-- "How many taxi trips were totally made on September 18th 2019?" 
SELECT COUNT(1)
FROM public.green_taxi_data as g
WHERE 
DATE(g.lpep_pickup_datetime) = DATE('2019-09-18')
and 
DATE(g.lpep_dropoff_datetime) = DATE('2019-09-18');

-- Which was the pick up day with the largest trip distance.

SELECT  maxe.total_distance, maxe.date
from
(SELECT max(g.trip_distance) as "total_distance", DATE(g.lpep_pickup_datetime) as date
FROM public.green_taxi_data as g
GROUP BY 
DATE(g.lpep_pickup_datetime)) as maxe
ORDER BY   maxe.total_distance DESC LIMIT 1

--Which were the 3 pick up Boroughs that had a sum of total_amount superior to 50000?
  	SELECT t_a. "Borough", t_a.total_tip_amount
	FROM
	  (SELECT 
        z."Borough" as "Borough",
        SUM(total_amount) AS total_tip_amount
    FROM 
        public.green_taxi_data as g
    INNER JOIN 
        public.zone_names as z ON z."LocationID" = g."PULocationID"
    INNER JOIN 
        public.zone_names as za ON za."LocationID" = g."DOLocationID"
    WHERE  
       DATE(g.lpep_pickup_datetime) = DATE('2019-09-18')
    GROUP BY  
        z."Borough") as t_a
		where t_a.total_tip_amount>=50000
		ORDER BY   t_a.total_tip_amount DESC 

--For the passengers picked up in September 2019 in the zone name Astoria which was the drop off zone that had the largest tip? We want the name of the zone, not the id.

		
	WITH ZoneSums AS (
	SELECT 
        za."Zone" as "Drop Off Zone",
        MAX(g.tip_amount) AS total_tip_amount
    FROM 
        public.green_taxi_data as g
    INNER JOIN 
        public.zone_names as z ON z."LocationID" = g."PULocationID"
    INNER JOIN 
        public.zone_names as za ON za."LocationID" = g."DOLocationID"
    WHERE  
        z."Zone" = 'Astoria' and  za."Zone"<> 'Astoria'
    GROUP BY  
        za."Zone")
SELECT 
    zs."Drop Off Zone",
    zs.total_tip_amount
FROM 
    ZoneSums zs
WHERE 
    zs.total_tip_amount = (SELECT MAX(total_tip_amount) FROM ZoneSums);