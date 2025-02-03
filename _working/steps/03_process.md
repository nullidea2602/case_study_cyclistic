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
	- I'm using Excel, Go, PostgreSQL, and PowerBI
	- Alternate: Sheets, BigQuery, Tableau
	- Alternate: R
- Have you ensured your data’s integrity? 
	- noted duplicate primary keys during sql import
	- removed duplicates via sql script
	- further review of data after importing from SQL to PowerBI using sorts/filters to understand data, where there were blanks, etc.
- What steps have you taken to ensure that your data is clean?
	- Review Station IDs and Names to see if they are consistent
- How can you verify that your data is clean and ready to analyze?
- Have you documented your cleaning process so you can review and share those results?
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