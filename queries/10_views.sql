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

