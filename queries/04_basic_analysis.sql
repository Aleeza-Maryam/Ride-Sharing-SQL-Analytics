USE ride_sharing;

--Total number of customers
SELECT COUNT(*) FROM CUSTOMERS;

--Total drivers
SELECT COUNT(*) AS total_drivers
FROM Drivers;

--Total rides
SELECT COUNT(*) AS total_rides
FROM Rides;

--Completed vs cancelled rides

SELECT ride_status,
COUNT(*) AS Total_rides
FROM ride
GROUP BY ride_status;