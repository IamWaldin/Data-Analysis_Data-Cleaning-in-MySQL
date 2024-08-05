In this Data Cleaning Project I will use MYSQL Workbench
This DataSet is Dirty and I just Love to work through Dirty Data and Fix all the Issues to get it into a more Usable Format, and a more Readable Format
so that when I start Exploring the Data or Using it in Visualizations the Data will be Usefull and Understandable.

PASSIONATE ABOUT DATA
This project involves cleaning a dataset containing information about layoffs from companies around the world. The cleaning process includes removing duplicates, standardizing data, handling null or blank values, and removing unnecessary columns. After cleaning the data, an exploratory data analysis (EDA) is performed to gain insights into the dataset.

Data Cleaning Steps

Step 1: Remove Duplicates
We identify and remove duplicate records based on multiple columns (company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) by using a row_number() window function.

Step 2: Standardize Data
Standardizing data involves converting date formats to a consistent format and ensuring all text fields are in the same case (e.g., all lowercase or all uppercase).

Step 3: Handle NULL or Blank Values
Handling NULL or blank values involves filling them with appropriate default values or removing records where necessary.

Step 4: Remove Unnecessary Columns
Remove columns that are not relevant to the analysis and do not affect other processes. Care should be taken to ensure these columns are not used elsewhere in the project.

