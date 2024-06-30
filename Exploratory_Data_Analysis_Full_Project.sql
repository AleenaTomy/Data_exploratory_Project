-- EXPLORATORY DATA ANALYSIS

SELECT * 
FROM layoffs_staging2;

# We are going to explore the data.
# Let's start simple, just look at the max of total_laid_off
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

# So let's find out the sum of total_laid_off
SELECT company, SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC;

#  let's look at our date ranges
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

# It looks like it starts in 2020 to 2023
# Let's look at which industry have the most layoffs

SELECT industry, SUM(total_laid_off) AS TLOFF_SUM 
FROM layoffs_staging2
GROUP BY industry
ORDER BY TLOFF_SUM DESC;
#7.40
# Now look at the country as well which countries 
SELECT country, SUM(total_laid_off) AS TLOFF_SUM 
FROM layoffs_staging2
GROUP BY country
ORDER BY TLOFF_SUM DESC;

#let's actually look at that date by year
SELECT YEAR(`date`), SUM(total_laid_off) AS TLOFF_SUM 
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY TLOFF_SUM DESC;

#look at it if you'd like.It's called stage 
#and this shows the stage of the company.
# the different series that they're in a b c d a, 
#I believe is like a series a funding that's like 
# a super super starting oh this is like a 
# seed phase. 
SELECT stage, SUM(total_laid_off) AS TLOFF_SUM 
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

# now let's try to do rolling total layoffs.
# let's do it based off the month.

SELECT SUBSTRING(`date`,6,2) AS months, SUM(total_laid_off) AS TLOFF_SUM
FROM layoffs_staging2
GROUP BY months;

# The issue with this is it's just going to show us month not the year
# But if we take the year too,

SELECT SUBSTRING(`date`,1,7) AS months, SUM(total_laid_off) AS TLOFF_SUM
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY months
ORDER BY months;

# now this is going to give us a much better
# now here's what we're going to do is we want 
# to take it from the very first month and we're
# grouping everything. Let's do a rolling sum this.

# with a CTE we'll do rolling 

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS months, SUM(total_laid_off) AS TLOFF_SUM
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY months
ORDER BY months
)
SELECT months,TLOFF_SUM
, SUM(TLOFF_SUM) OVER (ORDER BY months) AS rolling_total
FROM Rolling_Total; 

#and this shows a month by month progression 
#all the way down to the bottom

# Next, earlier we're looking at the company the sum of totally layoff
# look at these companies but I want to see how much they were laying off
# per year so instead of just looking at it as 
#a total we'll break it out by the year.

SELECT company, SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC;

SELECT company,
YEAR(`date`) AS `year`,
SUM(total_laid_off) AS TLOFF_SUM
FROM layoffs_staging2
GROUP BY company, `year`
ORDER BY `year` ASC ;

# Now what we want to do is we want to rank which years
# they laid off the most
# Let's use CTE

WITH company_year AS
(
SELECT company,
YEAR(`date`) AS `year`,
SUM(total_laid_off) AS TLOFF_SUM
FROM layoffs_staging2
GROUP BY company, `year`
),
company_year_rank AS
(SELECT *,
DENSE_RANK() OVER(PARTITION BY `year` ORDER BY TLOFF_SUM DESC) AS Ranking
FROM company_year
WHERE `year` IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE Ranking <=5;


#Now let check the data once more
SELECT * 
FROM layoffs_staging2;

SELECT DISTINCT industry 
FROM layoffs_staging2;

WITH industry_year AS
(
SELECT industry,
YEAR(`date`) AS `year`,
SUM(total_laid_off) AS TLOFF_SUM
FROM layoffs_staging2
GROUP BY industry, `year`
),
industry_year_rank AS
(SELECT *,
DENSE_RANK() OVER(PARTITION BY `year` ORDER BY TLOFF_SUM DESC) AS Ranking
FROM industry_year
WHERE `year` IS NOT NULL
)
SELECT *
FROM industry_year_rank
WHERE Ranking <=5;

