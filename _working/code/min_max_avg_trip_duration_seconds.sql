select
    avg(trip_duration_seconds / 60) as avg_trip_duration_m,
    min(trip_duration_seconds / 60) as min_trip_duration_m,
    max(trip_duration_seconds / 60) as max_trip_duration_m
from
    bike_rides