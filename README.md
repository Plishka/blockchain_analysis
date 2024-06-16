# Cryptocurrency On-Chain Analysis

## Project Overview

This project involves analyzing blockchain data to uncover investment opportunities and provide critical insights for data-driven decision-making. By meticulously tracking transactions, scrutinizing wallet addresses, and analyzing token distribution, the project aims to reveal key patterns and potential red flags.

## Objectives

1. **Uncover Investment Opportunities**: Identify promising investment avenues through detailed blockchain analytics.
2. **Analyze Token Distribution**: Evaluate the fairness and transparency of token distribution.
3. **Detect Artificial Trading Volume**: Identify any manipulation in trading volumes to gauge genuine market interest.
4. **Assess Fund Return**: Measure the return on investment to understand financial risks and potential gains.

## Methodology

### Data Scraping

Data was scraped from two primary sources:
- **Unisat Blockchain Explorer**: For all blockchain transactions.
- **OKEX Ordinals Market**: For trade data.

### Data Cleaning

The data was meticulously cleaned to ensure accuracy and consistency:
- Removed inconsistencies and outliers.
- Handled missing values.
- Filtered out unneeded columns and failed transactions.

### Data Analysis

The analysis focused on several key metrics:
- **Mint Distribution**: To understand the initial distribution of tokens.
- **Trading Volume**: To detect any artificial inflation of trading activities.
- **Investment Return**: To measure the recovery of initial funds and future price manipulation risks.

## Key Insights

1. **Mint Distribution Discrepancy**: A significant portion of the token supply was minted by a single entity using multiple wallets, suggesting an unfair distribution.
2. **Artificial Trading Volume**: Instances of artificial trading volume were detected, indicating potential price manipulation.
3. **Limited Fund Return**: Only half of the initial investment funds were recovered, highlighting the high possibility of future token price manipulation.

## Tools and Technologies

- **BigQuery**: Used for querying and processing blockchain data.
- **Tableau**: Utilized for building interactive dashboards and visualizations.
- **Instant Data Scraper**: Employed for scraping data from web sources.

## Advanced Techniques and Approaches Used

- **Data Scraping**: Extracted blockchain and trade data from multiple sources.
- **Data Cleaning**: Handled inconsistencies, outliers, and missing values to ensure data integrity.
- **Data Aggregation**: Combined data from various sources into a cohesive dataset for analysis.
- **Anomaly Detection**: Identified suspicious wallet activities and artificial trading volumes.
- **Mint Price Analysis**: Conducted additional research to accurately determine token mint prices.
- **Visualization Techniques**: Created interactive and insightful visualizations using advanced Tableau features.

## Dashboard Preview

[![Revenue Metrics Dashboard](https://raw.githubusercontent.com/Plishka/revenue_metrics/4217e1dca21b6016b629472839aad0a245b070d7/Revenue%20Metrics.png)](https://public.tableau.com/app/profile/oleksandr.plishka/viz/RevenueMetrics_17055101609680/Dashboard1){:target="_blank"}

## Conclusion

This project demonstrates the power of blockchain analytics in uncovering investment opportunities and potential risks. The insights gained from analyzing transaction patterns, wallet activities, and token distributions can significantly inform stakeholders' investment strategies.

For detailed SQL queries and further technical documentation, please refer to the [SQL File](link-to-your-sql-file.sql) in the repository.
