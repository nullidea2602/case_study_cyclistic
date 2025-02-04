ALTER TABLE bike_rides ADD COLUMN trip_day_of_week INT;

UPDATE bike_rides 
SET trip_day_of_week = EXTRACT(DOW FROM started_at) + 1;