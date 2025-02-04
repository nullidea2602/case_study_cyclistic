WITH InvalidRides AS (
    SELECT ride_id
    FROM bike_rides
    WHERE started_at > ended_at
)
DELETE FROM bike_rides
WHERE ride_id IN (SELECT ride_id FROM InvalidRides);