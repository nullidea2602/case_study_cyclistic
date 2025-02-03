SELECT *
FROM bike_rides
WHERE ride_id IN (
    SELECT ride_id
    FROM bike_rides
    GROUP BY ride_id
    HAVING COUNT(*) > 1
)
ORDER BY ride_id;
