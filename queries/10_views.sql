USE ride_sharing;

--Driver Performance View

CREATE OR REPLACE VIEW vw_driver_performance AS
SELECT
    d.driver_id,
    CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
    d.city,
    COUNT(r.ride_id) AS completed_rides,
    ROUND(SUM(r.fare), 2) AS total_revenue,
    ROUND(AVG(r.fare), 2) AS average_fare
FROM Drivers d
JOIN Rides r
    ON d.driver_id = r.driver_id
WHERE r.ride_status = 'Completed'
GROUP BY
    d.driver_id,
    d.first_name,
    d.last_name,
    d.city;

SELECT *
FROM vw_driver_performance;


--City Performance View

CREATE OR REPLACE VIEW vw_city_performance AS
SELECT
    l.city,
    COUNT(r.ride_id) AS total_rides,
    ROUND(SUM(r.fare), 2) AS total_revenue,
    ROUND(AVG(r.fare), 2) AS average_fare,
    ROUND(
        SUM(r.fare) / NULLIF(SUM(r.distance_km), 0),
        2
    ) AS revenue_per_km
FROM Rides r
JOIN Locations l
    ON r.pickup_location_id = l.location_id
WHERE r.ride_status = 'Completed'
GROUP BY l.city;


SELECT *
FROM vw_city_performance
ORDER BY total_revenue DESC;

--Customer Performance View

CREATE OR REPLACE VIEW vw_customer_performance AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    COUNT(r.ride_id) AS total_rides,
    ROUND(SUM(r.fare), 2) AS total_spent,
    ROUND(AVG(r.fare), 2) AS average_fare
FROM Customers c
JOIN Rides r
    ON c.customer_id = r.customer_id
WHERE r.ride_status = 'Completed'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city;


--Customer Performance View

CREATE OR REPLACE VIEW vw_customer_performance AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    COUNT(r.ride_id) AS total_rides,
    ROUND(SUM(r.fare), 2) AS total_spent,
    ROUND(AVG(r.fare), 2) AS average_fare
FROM Customers c
JOIN Rides r
    ON c.customer_id = r.customer_id
WHERE r.ride_status = 'Completed'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city;


SELECT *
FROM vw_customer_performance
ORDER BY total_spent DESC;


--Monthly Revenue View

CREATE OR REPLACE VIEW vw_monthly_revenue AS
SELECT
    DATE_FORMAT(ride_date, '%Y-%m') AS month,
    COUNT(*) AS completed_rides,
    ROUND(SUM(fare), 2) AS total_revenue,
    ROUND(AVG(fare), 2) AS average_fare
FROM Rides
WHERE ride_status = 'Completed'
GROUP BY DATE_FORMAT(ride_date, '%Y-%m');

SELECT *
FROM vw_monthly_revenue
ORDER BY month;


--Payment Analysis View

CREATE OR REPLACE VIEW vw_payment_analysis AS
SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(AVG(amount), 2) AS average_transaction
FROM Payments
WHERE payment_status = 'Paid'
GROUP BY payment_method;


SELECT *
FROM vw_payment_analysis
ORDER BY total_amount DESC;



--Ride Details View

CREATE OR REPLACE VIEW vw_ride_details AS
SELECT
    r.ride_id,
    r.ride_date,

    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city AS customer_city,

    CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
    d.city AS driver_city,

    pickup.area AS pickup_area,
    pickup.city AS pickup_city,

    dropoff.area AS dropoff_area,
    dropoff.city AS dropoff_city,

    r.distance_km,
    r.fare,
    r.ride_status

FROM Rides r

JOIN Customers c
    ON r.customer_id = c.customer_id

JOIN Drivers d
    ON r.driver_id = d.driver_id

JOIN Locations pickup
    ON r.pickup_location_id = pickup.location_id

JOIN Locations dropoff
    ON r.dropoff_location_id = dropoff.location_id;


SELECT *
FROM vw_ride_details
LIMIT 20;


--Cancellation Analysis View

CREATE OR REPLACE VIEW vw_cancellation_analysis AS
SELECT
    l.city,
    COUNT(r.ride_id) AS total_rides,

    SUM(
        CASE
            WHEN r.ride_status = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_rides,

    ROUND(
        SUM(
            CASE
                WHEN r.ride_status = 'Cancelled' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(r.ride_id),
        2
    ) AS cancellation_rate

FROM Rides r

JOIN Locations l
    ON r.pickup_location_id = l.location_id

GROUP BY l.city;


SELECT *
FROM vw_cancellation_analysis
ORDER BY cancellation_rate DESC;

--SHOW VIEWS
SHOW FULL TABLES
WHERE Table_type = 'VIEW';