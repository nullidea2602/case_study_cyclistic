select *
from bike_rides
where 
    -- Start coordinates out of range
    start_lat not between 41.4 and 42.6 or
    start_lng not between -88.2 and -87 or
    -- End coordinates out of range
    end_lat not between 41.4 and 42.6 or
    end_lng not between -88.2 and -87;
