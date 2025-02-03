### **Prepare**
**Objective:** Gather, store, and verify the data before cleaning.
#### **Steps:**
1. **Download Data**
    - If using Excel/SQL/Tableau: Download the last 12 months of trip data.
    - If using R: Use **Divvy 2019 Q1** and **Divvy 2020 Q1** datasets.
2. **Store Data Properly**
    - Create folders and subfolders for:
        - **Raw data (CSV)**
        - **Processed data (Excel, Sheets, or cleaned CSV)**
3. **Understand Data Structure**
    - Identify table structures and key variables.
    - Verify if columns are named consistently across datasets.
4. **Check Data Credibility**
    - Assess the source and limitations (e.g., missing information, bias).
    - Ensure no personally identifiable information is included.
#### **Outputs from Prepare:**
- **Deliverable:** _Description of all data sources used_ (A document outlining the data sources and storage setup)
- **Files:** Downloaded raw CSV files stored in appropriate folders.
- **Takeaways:** Understanding of the data structure and its credibility.
---
### **Process**
**Objective:** Clean and transform the data for analysis.
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