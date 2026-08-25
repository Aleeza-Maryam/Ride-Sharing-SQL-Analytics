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