DELETE FROM bike_rides
WHERE 
    start_lat NOT BETWEEN 41.4 AND 42.6 
    OR start_lng NOT BETWEEN -88.2 AND -87
    OR end_lat NOT BETWEEN 41.4 AND 42.6
    OR end_lng NOT BETWEEN -88.2 AND -87;