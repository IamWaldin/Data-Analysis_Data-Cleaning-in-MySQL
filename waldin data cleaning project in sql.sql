SHOW DATABASES

select *
from layoffs;


-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove Unecassary Columns


create table layoffs_staging
like layoffs;

select *
from layoffs_staging

insert layoffs_staging
select *
from layoffs


SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) AS row_num
from layoffs_staging;


WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location,
industry, total_laid_off, percentage_laid_off, date, stage
, country, funds_raised_millions) AS row_num
from layoffs_staging
)
SELECT *
FROM duplicate_cte
where row_num > 1;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) AS row_num
from layoffs_staging
)

DELETE
FROM duplicate_cte
where row_num >1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` bigint DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location,
industry, total_laid_off, percentage_laid_off, date, stage
, country, funds_raised_millions) AS row_num
from layoffs_staging

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- 2 STANDARDIZING DATA, FINDING ISSUES INT OUR DATA AND FIXING IT.
-- REMOVE WHITESPACES BEFORE AND AFTER TEXT IF EXISTS


select company, trim(company)
from layoffs_staging2;


update layoffs_staging2
set company = trim(company);

-- REMOVE DUPLICATES OR REDUNDENCY IN THE "INDUSTRY" COLUMN (SAME INDUSRTY WITH TWO DIFFERENT NAMES)

SELECT distinct industry
FROM layoffs_staging2


UPDATE layoffs_staging2
SET industry = 'Crypto'
where industry LIKE 'Crypto%';

-- BRIEF CHECK THROUGH THE "location" COLUMN AND EVERYTHING LOOKS GOOD.

SELECT DISTINCT location
from layoffs_staging2
order by 1

-- SYNCRONYZE SPELLING OF "country" NAMES TO AVOID REDUNDENCY OR DUPLICATES

SELECT DISTINCT country
from layoffs_staging2
order by 1;


SELECT DISTINCT country
from layoffs_staging2
where country like 'United States%'
order by 1;

SELECT DISTINCT country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;


update layoffs_staging2
set country = trim(TRAILING '.' from country)
where country LIKE 'United States%';


SELECT *
from layoffs_staging2

-- CHANGE fORMAT OF 'date' COLUMN

SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y')


SELECT `date`
from layoffs_staging2;

Alter table layoffs_staging2
modify column `date` DATE; 



-- WORKING WITH NULL AND BLANK VALUES

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS null
AND percentage_laid_off is null;


SELECT *
FROM layoffs_staging2
WHERE industry is null
or industry = ''

SELECT *
FROM layoffs_staging2
where company = 'Airbnb';


select *
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    where (t1.industry is null or t1.industry = '')
    and t2.industry is not null

update layoffs_staging2 t1 
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;


update layoffs_staging2
set industry = null
where industry = '';

select *
from layoffs_staging2

delete
from layoffs_staging2
where total_laid_off IS NULL
and percentage_laid_off IS NULL;

alter table layoffs_staging2
drop column row_num


-- THERE ARE PLENTY OF REMAINING NULL VALUES IN THE TABLE BUT WE CANNOT POPULATE THEM BASED ON THE DATA THAT WE HAVE
-- MEANING WE CANNOT RUN AGGREGATE QUERIES TO POPULATE THESE NULL CELLS, NIETHER CAN WE POPULATE THEM BASED ON PREDICTIONS
-- FOUND USING OTHER RELATED COLUMNS,SO OUR BEST OPTION IS TO LEAVE THE REMAINING NULL VALUES AS IS.

-- THANK YOU AND PLEASE SEE THE NEXT DATA EXPLORATORY PROJECT BASED ON OUR NEWLY CLEANED DATASHEET








