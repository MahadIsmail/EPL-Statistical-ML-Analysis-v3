# EPL-Statistical-ML-Analysis-v3
Predicting English Premier League standings using financial metrics through multiple linear regression and Random Forest models.

# Financial Metrics as Predictors of Premier League Success
**Author:** Mahad Ismail • **Language:** R (tidyverse, ggplot2, randomForest)

## Abstract
Research project investigating how financial metrics relate to Premier League performance across 2022/23–2024/25. I apply classical statistical modeling and machine learning to predict league outcomes from (i) Total Market Value, (ii) Annual Wage Bill, and (iii) Net Transfer Spend.

## Methods
- **EDA**: correlation/scatter analyses by season.
- **Multiple Linear Regression**: significance tests (p-values), interpretability; **VIF** for multicollinearity.
- **Random Forest Regression**: non-linear relationships + variable importance.
- **RMSE / absolute residuals**: predictive accuracy; top-6 probability estimates.

## Results (summary)
- **Market value** is the strongest, statistically significant predictor across seasons.
- **Wage bill** helps in Random Forest (collinearity with market value hurts OLS).
- **Net spend** shows weak/unstable correlation.
- Both models estimate **top-6 probabilities** well; exact rank order is harder due to randomness.

## How to Reproduce
```r
source("R/00_setup.R")
source("R/01_market_value_vs_position.R")
source("R/02_wages_vs_position.R")
source("R/03_net_spend_vs_position.R")
source("R/10_linear_model.R")
source("R/20_random_forest.R")
source("R/30_compare_models.R")
