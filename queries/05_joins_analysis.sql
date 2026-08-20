USE ride_sharing;


SELECT
    r.ride_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    r.ride_date,
    r.distance_km,
    r.fare,
    r.ride_status
FROM Rides r
JOIN Customers c
    ON r.customer_id = c.customer_id;


--Driver Performance

SELECT
    d.driver_id,
    CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
    d.city,
    COUNT(r.ride_id) AS total_rides,
    SUM(r.fare) AS total_earnings,
    ROUND(AVG(r.fare), 2) AS average_fare
FROM Drivers d
JOIN Rides r
    ON d.driver_id = r.driver_id
WHERE r.ride_status = 'Completed'
GROUP BY
    d.driver_id,
    d.first_name,
    d.last_name,
    d.city
ORDER BY total_earnings DESC;



--Ride ke saath Driver + Customer

SELECT
    r.ride_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
    r.ride_date,
    r.distance_km,
    r.fare
FROM Rides r
JOIN Customers c
    ON r.customer_id = c.customer_id
JOIN Drivers d
    ON r.driver_id = d.driver_id
WHERE r.ride_status = 'Completed';


--Pickup & Drop-off Locations

SELECT
    r.ride_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    pickup.area AS pickup_area,
    pickup.city AS pickup_city,
    dropoff.area AS dropoff_area,
    dropoff.city AS dropoff_city,
    r.distance_km,
    r.fare
FROM Rides r
JOIN Customers c
    ON r.customer_id = c.customer_id
JOIN Locations pickup
    ON r.pickup_location_id = pickup.location_id
JOIN Locations dropoff
    ON r.dropoff_location_id = dropoff.location_id;


--Complete Ride + Payment Information
SELECT
    r.ride_id,
    r.ride_date,
    r.fare,
    p.payment_method,
    p.payment_status,
    p.amount
FROM Rides r
JOIN Payments p
    ON r.ride_id = p.ride_id;



--Complete Ride + Rating

SELECT
    r.ride_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
    r.fare,
    rt.customer_rating,
    rt.driver_rating,
    rt.review
FROM Rides r
JOIN Customers c
    ON r.customer_id = c.customer_id
JOIN Drivers d
    ON r.driver_id = d.driver_id
JOIN Ratings rt
    ON r.ride_id = rt.ride_id;



--Har city mein kitni rides aur kitna revenue generate hua
SELECT
    l.city,
    COUNT(r.ride_id) AS total_rides,
    SUM(r.fare) AS total_revenue,
    ROUND(AVG(r.fare), 2) AS average_fare
FROM Rides r
JOIN Locations l
    ON r.pickup_location_id = l.location_id
WHERE r.ride_status = 'Completed'
GROUP BY l.city
ORDER BY total_revenue DESC;
