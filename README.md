# Data_exploratory_Project
This project involves performing exploratory data analysis (EDA) on the cleaned table to uncover insights about layoffs. The analysis starts with an initial inspection of the data to understand its structure and content. 

**Maximum Values Analysis**:
We begin by identifying the maximum values of `total_laid_off` and `percentage_laid_off` to pinpoint the highest layoffs and layoff percentages. This helps in understanding the upper limits of the dataset.

**Detailed Inspection Based on Layoff Percentage**:
Next, we filter records where the `percentage_laid_off` is 100% and order them by `funds_raised_millions`. This step identifies companies that laid off their entire workforce and ranks them by their funding, providing insights into how even well-funded companies are impacted.

**Total Layoffs by Company**:
We then calculate the sum of `total_laid_off` grouped by each company, ordering the results by the total layoffs in descending order. This identifies the companies with the highest layoffs, providing a clearer picture of which companies are most affected.

**Date Range Analysis**:
By identifying the minimum and maximum dates in the dataset, we establish the time frame of the data, which spans from 2020 to 2023. This helps in contextualizing the layoffs over the given period.

**Industry and Country Analysis**:
We aggregate the total layoffs by industry and country, ordering the results to highlight which industries and countries have experienced the most significant layoffs. This provides a sectoral and geographical perspective on the impact of layoffs.

**Yearly Layoffs**:
We examine the total layoffs by year, grouping and summing them to see trends over time. This step helps in identifying particular years with higher layoff activities.

**Company Stage Analysis**:
Analyzing layoffs by the funding stage of companies helps understand how layoffs vary across different stages of company development, from early seed phases to more advanced funding stages.

**Monthly Rolling Total of Layoffs**:
We calculate the monthly rolling total of layoffs using a common table expression (CTE). This step involves grouping data by year and month, then computing a cumulative sum to observe the progression of layoffs over time.

**Annual Company Layoffs**:
We break down layoffs per company by year to see the year-on-year variations and rank the years by layoffs using a dense rank within a CTE. This helps in understanding temporal layoff patterns within companies.

**Industry Yearly Ranking**:
Similar to the company analysis, we aggregate and rank layoffs by industry for each year. This step involves using a CTE to group and sum layoffs by industry and year, followed by ranking them to highlight the most affected industries annually.

**Final Data Check**:
We conclude with a final check of the dataset and distinct industries to ensure the completeness and correctness of the data before finalizing the analysis.

Overall, this project uses a structured approach to explore various dimensions of layoffs, providing comprehensive insights into the scale, timing, and distribution of layoffs across companies, industries, and countries.
