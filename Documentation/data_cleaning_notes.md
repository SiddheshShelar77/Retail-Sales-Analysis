# Data Cleaning Notes

## Dataset

Sample Superstore retail sales dataset.

## Data Cleaning Activities

### 1. Empty Rows

- Identified and removed completely empty rows from the dataset.
- Checked the dataset after removal.

### 2. Missing Values

- Identified 11 missing values in the Postal Code column.
- Preserved these values as NULL rather than assuming postal codes.
- Other columns were reviewed for missing values.

### 3. Duplicate Records

- Reviewed repeated Order IDs.
- Retained repeated Order IDs because a single order can contain multiple product line items.
- Did not treat repeated Order IDs as duplicate records.

### 4. Date Formatting

- Identified Order Date and Ship Date values stored as text.
- Converted dates into proper date values in Excel for analysis.
- Used the DMY date format for the original date strings.

### 5. Data Import Preparation

- Saved the cleaned dataset as CSV.
- Imported the data into MySQL using an explicitly defined table structure.
- Used NULLIF to convert blank Postal Code values into SQL NULL values.

## Outcome

The dataset was prepared for SQL analysis and Excel dashboard development.
