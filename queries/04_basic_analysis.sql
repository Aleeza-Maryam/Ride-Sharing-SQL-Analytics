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
FROM rides
GROUP BY ride_status;


--Total revenue

SELECT SUM(fare) AS Revenue
FROM rides
WHERE ride_status='Completed';

SELECT
    AVG(fare) AS average_fare
FROM Rides
WHERE ride_status = 'Completed';

SELECT
    AVG(distance_km) AS average_distance
FROM Rides
WHERE ride_status = 'Completed';


--Which customer took which ride?

SELECT
    r.ride_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    r.ride_date,
    r.distance_km,
    r.fare
FROM Rides r
JOIN Customers c
    ON r.customer_id = c.customer_id;

    