USE ride_sharing;

SHOW INDEX FROM Rides;

SHOW INDEX FROM Customers;
SHOW INDEX FROM Drivers;
SHOW INDEX FROM Payments;

CREATE INDEX idx_rides_customer
ON Rides(customer_id);

CREATE INDEX idx_rides_driver
ON Rides(driver_id);

CREATE INDEX idx_rides_pickup
ON Rides(pickup_location_id);

CREATE INDEX idx_rides_dropoff
ON Rides(dropoff_location_id);

CREATE INDEX idx_rides_status
ON Rides(ride_status);

CREATE INDEX idx_rides_date
ON Rides(ride_date);

WHERE ride_status = 'Completed'

CREATE INDEX idx_rides_status_date
ON Rides(ride_status, ride_date);


--explain for optimization

EXPLAIN
SELECT *
FROM Rides
WHERE ride_status = 'Completed';

EXPLAIN
SELECT
    r.ride_id,
    c.first_name,
    c.last_name,
    r.fare
FROM Rides r
JOIN Customers c
    ON r.customer_id = c.customer_id
WHERE r.ride_status = 'Completed';



--data filtering

EXPLAIN
SELECT
    ride_date,
    COUNT(*) AS total_rides
FROM Rides
WHERE ride_date >= '2025-01-01'
  AND ride_date < '2025-02-01'
GROUP BY ride_date;

SHOW INDEX FROM Rides;