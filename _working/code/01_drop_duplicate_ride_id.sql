WITH Duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ride_id
               ORDER BY started_at ASC  -- Keep the earliest ride if duplicates exist
           ) AS row_num
    FROM bike_rides
)
DELETE FROM bike_rides
WHERE ride_id IN (
    SELECT ride_id FROM Duplicates WHERE row_num > 1
);
ALTER TABLE bike_rides ADD PRIMARY KEY (ride_id);