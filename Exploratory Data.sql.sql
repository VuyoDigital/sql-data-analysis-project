-- Exploratory Data Analysis

SELECT*
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC;
 
 SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

 SELECT stage , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT*
FROM layoffs_staging2;

SELECT stage , AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off)
FROM Layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC;


WITH Rolling_Total AS
(SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off) AS total_off
FROM Layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC
)
SELECT `Month`, total_off
 ,SUM(total_off) OVER (ORDER BY `Month`) AS rolling_Total
FROM Rolling_Total;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT company, YEAR (`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY company, `date`
ORDER BY 3 DESC;

WITH Company_Year(Comapny, years, total_laid_off) AS
(SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT*, 
DENSE_RANK() OVER (PARTITION BY YEARS ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year 
WHERE years IS NOT NULL
)
SELECT*
FROM Company_Year_Rank
WHERE Ranking <5;








