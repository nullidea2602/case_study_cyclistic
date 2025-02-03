# Introduction

Cyclistic is a Chicago based bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Lily Moreno, Director of Marketing, believes the company’s future success depends on maximizing the number of annual memberships.

# Business Task


**The business task is to understand how casual riders differ from annual members in their usage of Cyclistic bikes by analyzing the Cyclistic historical bike trip data to identify trends.**

From these insights, the marketing analytics team will make recommendations on how Cyclistic can use digital media to influence casual riders to become members.

The recommendations will be submitted to the Executive team for approval. Upon approval, your team will use these insights to design a new marketing strategy to convert casual riders into annual members.

## Constraints

Data-privacy issues prohibit us from using riders’ personally identifiable information. This means that we won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

## Data License Agreement
[DivvyBikes Data License Agreement](https://divvybikes.com/data-license-agreement)

# Data Sources

For this analysis, we are utilizing Cyclistic's historical trip data, sourced from the Divvy bike-sharing system operated by Lyft Bikes and Scooters, LLC in partnership with the City of Chicago. The data covers all recorded trips within the specified timeframe and is publicly available for research and analysis.

#### Primary Data Sources
- Amazon S3 Bucket: [Index of bucket "divvy-tripdata"](https://divvy-tripdata.s3.amazonaws.com/index.html)
- Divvy Official Website: [Divvy Data](https://divvybikes.com/system-data)
- Live GBFS Feed (for reference only): [Divvy GBFS JSON](https://gbfs.divvybikes.com/gbfs/2.3/gbfs.json)
- Timeframe: 2024 (January - December), structured as monthly CSV files (`202401-divvy-tripdata.zip` through `202412-divvy-tripdata.zip`)
#### Data Organization
- The dataset consists of one CSV file per month, each containing trip details.
- Key columns in the dataset:

```
ride_id //Unique identifier (alphanumeric)  
rideable_type //Type of vehicle (classic_bike | electric_bike | electric_scooter)  
started_at, ended_at //Timestamps for ride start and end (can cross into a new month)  
start_station_name, end_station_name //Text fields, may contain blanks  
start_station_id, end_station_id //Text/numeric values, may contain blanks  
start_lat, start_lng, end_lat, end_lng //Numeric values, may contain blanks  
member_casual //User type (casual or member)
```

#### Data Storage & SQL Schema
- The dataset is structured in a SQL table as follows:

```
CREATE TABLE bike_rides (  
    ride_id TEXT PRIMARY KEY,  
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
```

## Data Quality and Integrity

To assess data credibility, we applied the ROCCC framework:
- Reliable/Original: The data is officially provided by Lyft Bikes and Scooters, LLC under an agreement with the City of Chicago.
- Comprehensive: The dataset includes all recorded rides within the specified timeframe.
- Current: The dataset is updated up to the last available month (2024-12).
- Cited: The source of the data is properly referenced.
	- Citation: Divvy. (n.d.). Divvy Bicycle Sharing System Data. Retrieved from [Divvy System Data](https://divvybikes.com/system-data).

## Legal and Ethical Considerations
- Data License Agreement: Governed by the [Divvy Data License Agreement](https://divvybikes.com/data-license-agreement)
	- Allows reproduction, analysis, and modification of data for lawful purposes.
	- Prohibits resale or redistribution of raw data as a standalone dataset.
- Privacy & Security: No personally identifiable information (PII) is included in the dataset.
	- Pass purchases are not linked to credit card information or user identities.
- Accessibility: The dataset is freely available to the public via official sources.

## Data Integrity Verification

To ensure accuracy and reliability, the following steps were performed:
- Initial review of raw CSV files
- Validation of data types and structure
- Import into SQL database, noting duplicate `ride_id` values
- Removal of 422 duplicate records using SQL script:

```
WITH Duplicates AS (  
    SELECT *,  
           ROW_NUMBER() OVER (  
               PARTITION BY ride_id  
               ORDER BY started_at ASC  
           ) AS row_num  
    FROM bike_rides  
)  
DELETE FROM bike_rides  
WHERE ride_id IN (  
    SELECT ride_id FROM Duplicates WHERE row_num > 1  
);
```

- Further validation using Power BI to check for missing values and inconsistencies.

## Relevance to the Analysis

This dataset is crucial for analyzing ridership trends based on user type. By segmenting trips into casual vs. member, we can investigate differences in:

- Ride duration
- Time of day and day of the week usage patterns
- Seasonal trends
- Station-to-station trip patterns

## Challenges and Limitations

- Duplicate `ride_id` entries: Found 422 duplicate entries, resolved via SQL cleanup.
- Missing data: Some station names and GPS coordinates contain blanks.
- Cross-month rides: Some trips start in one month and end in the next, requiring careful time-based analysis.

# Data Cleaning Process

# Analysis Summary & Findings

# Visualizations & Key Insights

# Recommendations
