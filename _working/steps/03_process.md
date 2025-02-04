### **3. PROCESS Phase**

✔ **Documentation of Any Data Cleaning or Manipulation**

- **Check for errors** in the dataset (missing values, duplicates, incorrect formats)
- **Transform data for analysis**:
    - Add `ride_length` column (Calculate ride duration)
    - Add `day_of_week` column (Extract weekday from date)
- **Save a cleaned version of the dataset**

---

### Guiding questions
- What tools are you choosing and why?
	- I'm using Excel, PowerShell, PostgreSQL, and PowerBI
	- Alternate: Sheets, BigQuery, Tableau
	- Alternate: PostgreSQL, Python, RStudio
- Have you ensured your data’s integrity? 
	- noted duplicate primary keys during sql import
	- removed duplicates via sql script
	- further review of data after importing from SQL to PowerBI using sorts/filters to understand data, where there were blanks, etc.
- What steps have you taken to ensure that your data is clean?
	- Review Station IDs and Names to see if they are consistent
	- Further validation using Power BI to check for missing values and inconsistencies.
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

- How can you verify that your data is clean and ready to analyze?
	- I can verify my data is clean and ready to analyze by running a SQL script to detect duplicates.
- Have you documented your cleaning process so you can review and share those results?
	- Yes.
### Key tasks
- Check the data for errors.
- Choose your tools.
- Transform the data so you can work with it effectively.
- Document the cleaning process.
### Deliverable
- Documentation of any cleaning or manipulation of data

Follow these steps:
1. Download the previous 12 months of trip data. Note: If you are planning on using Posit’s RStudio, use the Divvy 2019 Q1 and Divvy 2020 Q1 datasets. Choosing other data might lead to errors because the data exceeds the memory available in the free plan.
2. Unzip the files.
3. Create a folder on your desktop or Drive to house the files. Use appropriate file-naming conventions.
4. Create subfolders for the .csv file and the .xls or Sheets file so that you have a copy of the original data. Move the downloaded files to the appropriate subfolder.
5. Follow these instructions for either Excel (1) or Google Sheets (2):
	1. Launch Excel, open each file, and choose to Save As an Excel Workbook file. Put it in the subfolder you created for .xls files.
	2. Open each .csv file in Google Sheets and save it to the appropriate subfolder.
6. Open your spreadsheet and create a column called ride_length. Calculate the length of each ride by subtracting the column started_at from the column ended_at (for example, =D2-C2) and format as HH:MM:SS using Format > Cells > Time > 37:30:55.
7. Create a column called day_of_week, and calculate the day of the week that each ride started using the WEEKDAY command (for example, =WEEKDAY(C2,1)) in each file. Format as General or as a number with no decimals, noting that 1 = Sunday and 7 = Saturday.
8. Proceed to the analyze step.


Follow these steps:
1. Download the previous 12 months of trip data. Note: If you are planning on using Posit’s RStudio, use the Divvy 2019 Q1 and Divvy 2020 Q1 datasets. Choosing other data might lead to errors because the data exceeds the memory available in the free plan.
2. Unzip the files.
3. Create a folder on your desktop or Drive to house the files. Use appropriate file-naming conventions.
4. Create subfolders for the .csv file and the .xls or Sheets file so that you have a copy of the original data. Move the downloaded files to the appropriate subfolder.
5. Follow these instructions for either Excel (1) or Google Sheets (2):
	1. Launch Excel, open each file, and choose to Save As an Excel Workbook file. Put it in the subfolder you created for .xls files.
	2. Open each .csv file in Google Sheets and save it to the appropriate subfolder.
6. Open your spreadsheet and create a column called ride_length. Calculate the length of each ride by subtracting the column started_at from the column ended_at (for example, =D2-C2) and format as HH:MM:SS using Format > Cells > Time > 37:30:55.
7. Create a column called day_of_week, and calculate the day of the week that each ride started using the WEEKDAY command (for example, =WEEKDAY(C2,1)) in each file. Format as General or as a number with no decimals, noting that 1 = Sunday and 7 = Saturday.
8. Proceed to the analyze step.

#### **Steps:**
1. **Check for Errors and Clean Data**
    - Handle missing or inconsistent values.
    - Remove duplicates.
    - Standardize column names if needed.
2. **Transform Data**
    - Add new columns:
        - `ride_length` = `ended_at - started_at`
        - `day_of_week` = Extracted from `started_at`
    - Convert `ride_length` into a usable time format.
3. **Choose Tools for Processing**
    - Excel/Google Sheets: Use formulas to clean and transform data.
    - SQL: Use queries to remove inconsistencies and generate summary tables.
    - R: Use scripts to clean and merge datasets.
4. **Document Cleaning Process**
    - Keep track of each transformation step to ensure reproducibility.
#### **Outputs from Process:**
- **Deliverable:** _Documentation of any cleaning or manipulation of data_ (A document outlining how errors were fixed, transformations performed, and steps taken for verification)
- **Files:**
    - Cleaned dataset (CSV, Excel, or database table).
    - Logs or notes detailing the data cleaning process.
- **Takeaways:** Data is structured and ready for analysis.


| Issue                                                        | Columns Affected                                                               | Action         | Justification                                                                                                                   |
| ------------------------------------------------------------ | ------------------------------------------------------------------------------ | -------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **Duplicate Ride IDs (422 rows)**                            | `ride_id`                                                                      | ❌ Drop         | Each ride should be unique. Duplicates are likely system errors.                                                                |
| **Trip End Before Trip Start (277 rows)**                    | `started_at`, `ended_at`                                                       | ❌ Drop         | Negative trip durations are invalid data.                                                                                       |
| **Missing Only End Station Info (7,152 rows)**               | `end_station_name`, `end_station_id`, `end_lat`, `end_lng`                     | ✅ Keep         | These trips still have valid start station data and can be analyzed for trip duration, start station trends, and user behavior. |
| **Missing  Station Name or ID But Have Lat/Lng (1,652,079)** | `start_station_name`, `start_station_id`, `end_station_name`, `end_station_id` | ✅ Keep         | Since these have valid latitude/longitude, we can still analyze spatial trends.                                                 |
| **Mismatched Station IDs/Names**                             | `start_station_name`, `start_station_id`, `end_station_name`, `end_station_id` | 🔄 Standardize | These can be corrected rather than dropped.                                                                                     |
