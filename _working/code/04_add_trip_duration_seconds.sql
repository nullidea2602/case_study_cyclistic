ALTER TABLE bike_rides ADD COLUMN trip_duration_seconds BIGINT;
UPDATE bike_rides 
SET trip_duration_seconds = EXTRACT(EPOCH FROM (ended_at - started_at));