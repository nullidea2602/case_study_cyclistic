select
    *
from
    bike_rides
where
    (ended_at - started_at) < INTERVAL '0 second'