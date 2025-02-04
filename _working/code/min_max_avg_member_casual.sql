select
    min(trip_duration) as min,
    max(trip_duration) as max,
    avg(trip_duration) as avg,
    member_casual
from
(select
    (ended_at - started_at) as trip_duration,
    member_casual
from
    bike_rides) as durations
group by
    member_casual