-- Data Cleaning

SELECT*
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. NULL values or Blank Values
-- 4. Remove Any Columns or Rows

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT*
FROM layoffs_staging;

INSERT layoffs_staging
SELECT*
FROM layoffs;

SELECT*,
ROW_NUMBER() OVER(
PARTITION BY Company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT*,
ROW_NUMBER() OVER(
PARTITION BY Company,location, industry, total_laid_off, percentage_laid_off, `date`, country,
funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT*
FROM duplicate_cte
WHERE row_num > 1;

SELECT*
FROM layoffs_staging
WHERE company= 'Casper';

WITH duplicate_cte AS
(
SELECT*,
ROW_NUMBER() OVER(
PARTITION BY Company,location, industry, total_laid_off, percentage_laid_off, `date`, country,
funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;

SELECT*
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT*,
ROW_NUMBER() OVER(
PARTITION BY Company,location, industry, total_laid_off, percentage_laid_off, `date`, country,
funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num >1;

SELECT*
FROM layoffs_staging2;

-- Standardiing data

SELECT company,TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company =TRIM(company);

SELECT  DISTINCT industry
FROM layoffs_staging2;


SET sql_safe_updates =0;
UPDATE layoffs_staging2
SET industry ='crypto'
WHERE industry LIKE'`crypto%';

UPDATE layoffs_staging2
SET industry ='crypto'
WHERE industry LIKE'`crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE industry LIKE 'crypto%';

UPDATE layoffs_staging2
SET industry ='crypto'
WHERE industry LIKE 'crypto%';

SELECT DISTINCT country,TRIM( TRAILING '.' FROM  country)
FROM layoffs_staging2
ORDER BY 1;

SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';
SELECT*
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';


SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company= t2.company
	AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry= '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company= t2.company
    SET t1.industry= t2.industry
    WHERE t1.industry IS NULL 
    AND t2.industry IS NOT NULL;
    
    SELECT*
    FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT*
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;



















 
 