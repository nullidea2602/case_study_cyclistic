#!/bin/bash

# Define variables
DB_NAME="case_study_cyclistic"
TABLE_NAME="bike_rides"
CSV_DIR="/home/nullidea/case_study_cyclistic/data"
IMPORT_DIR="/var/lib/postgresql/imports"

# Ensure the import directory exists
sudo mkdir -p "$IMPORT_DIR"

# Remove old CSV files
sudo rm -f "$IMPORT_DIR"/*.csv

# Copy new CSV files
sudo cp "$CSV_DIR"/*.csv "$IMPORT_DIR/"
sudo chown postgres:postgres "$IMPORT_DIR"/*.csv

# Run SQL commands
sudo -u postgres psql <<EOF
\c $DB_NAME

-- Drop table if it exists
DROP TABLE IF EXISTS $TABLE_NAME;

-- Recreate table
CREATE TABLE $TABLE_NAME (
    ride_id TEXT,
    rideable_type VARCHAR(16),
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    start_station_name TEXT,
    start_station_id TEXT,
    end_station_name TEXT,
    end_station_id TEXT,
    start_lat DOUBLE PRECISION,
    start_lng DOUBLE PRECISION,
    end_lat DOUBLE PRECISION,
    end_lng DOUBLE PRECISION,
    member_casual VARCHAR(6)
);
EOF

# Import CSV files
for file in "$IMPORT_DIR"/*.csv;
do
    sudo -u postgres psql -d "$DB_NAME" -c "\copy $TABLE_NAME FROM '$file' WITH CSV HEADER";
done

# Run SQL commands
sudo -u postgres psql <<EOF
\c $DB_NAME

WITH Duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ride_id
               ORDER BY started_at ASC  -- Keep the earliest ride if duplicates exist
           ) AS row_num
    FROM $TABLE_NAME
)
DELETE FROM $TABLE_NAME
WHERE ride_id IN (
    SELECT ride_id FROM Duplicates WHERE row_num > 1
);
ALTER TABLE $TABLE_NAME ADD PRIMARY KEY (ride_id);
EOF