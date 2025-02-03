### **2. PREPARE Phase**

✔ **Description of All Data Sources Used**

- Download the correct dataset:
    - **If using Excel/SQL:** Previous 12 months of trip data
    - **If using R:** Divvy 2019 Q1 & Divvy 2020 Q1 datasets
- Ensure the data is stored in an **organized folder structure**
- Confirm dataset credibility and privacy compliance

---

Use Cyclistic’s historical trip data to analyze and identify trends. 
### Guiding questions
- Where is your data located?
	- [Index of bucket "divvy-tripdata"](https://divvy-tripdata.s3.amazonaws.com/index.html)
	- [Divvy Data](https://divvybikes.com/system-data)
	- Just for fun: [gbfs.divvybikes.com/gbfs/2.3/gbfs.json](https://gbfs.divvybikes.com/gbfs/2.3/gbfs.json)
	- 202401-divvy-tripdata.zip through 202412-divvy-tripdata.zip
- How is the data organized?
	- one CSV file per month
	- Columns
		- `ride_id: alphanumeric`
		- `rideable_type: classic_bike | electric_bike | electric_scooter`
		- `started_at, ended_at: datetime`
			- `ended_at` can roll over into next month, `month(started_at) != month(ended_at)`
		- `start_station_name, end_ _station_name: text, blanks`
		- `start_station_id, end_station_id: text, numbers, blanks`
		- `start_lat, start_lng, end_lat, end_lng: numberic, blanks`
		- `member_casual: casual | member`
	- SQL
```sql
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
- Are there issues with bias or credibility in this data? Does your data ROCCC?
	- Reliable/Original
		- Lyft Bikes and Scooters, LLC (“Bikeshare”) operates the City of Chicago’s (“City”) Divvy bicycle sharing service. Bikeshare and the City are committed to supporting bicycling as an alternative transportation option. As part of that commitment, the City permits Bikeshare to make certain Divvy system data owned by the City (“Data”) available to the public..."
	- Comprehensive
		- Covers all rides during time frame
	- Current
		- Up to last month (2024-12)
	- Cited
		- Divvy. (n.d.). _Divvy Bicycle Sharing System Data_. Retrieved from https://divvybikes.com/system-data.
- How are you addressing licensing, privacy, security, and accessibility?
	- [Data License Agreement | Divvy Bikes](https://divvybikes.com/data-license-agreement)
		- "Bikeshare hereby grants to you a non-exclusive, royalty-free, limited, perpetual license to access, reproduce, analyze, copy, modify, distribute in your product or service and use the Data for any lawful purpose (“License”)."
		- "The License does not authorize you to do, and you will not do or assist others in doing, any of the following" ... "Host, stream, publish, distribute, sublicense, or sell the Data as a stand-alone dataset; provided, however, you may include the Data as source material, as applicable, in analyses, reports, or studies published or distributed for non-commercial purposes;"
	- Data-privacy issues prohibit us from using riders’ personally identifiable information. This means that we won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.
	- Data is publicly available.
	- Data is accessible at: [Index of bucket "divvy-tripdata"](https://divvy-tripdata.s3.amazonaws.com/index.html) or [Divvy Data](https://divvybikes.com/system-data)
- How did you verify the data’s integrity?
	- Initial review of raw csv data
	- Noted data types
	- Defined SQL structure
- How does it help you answer your question?
	- Because the trip data is denoted by casual and member, I can use this data to uncover differences in trip time, day of week, season, route (to and from what stations), etc.
- Are there any problems with the data?
	- 422 duplicate `ride_id`, see duplicates.csv
```sql
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
```
### Key tasks
- Download data and store it appropriately.
- Identify how it’s organized.
- Sort and filter the data.
- Determine the credibility of the data.
### Deliverable
- A description of all data sources used