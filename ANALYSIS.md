# From Balance Sheets to League Tables: Unveiling the Financial Forces Behind Premier League Success
**Author:** Mahad Ismail

## Project Objective
The objective of this project is to analyze how money and business play a role in affecting sports teams' results. This analysis focuses on soccer — specifically the English Premier League (EPL). The Premier League is not only the most popular division of professional soccer but also one of the biggest drivers of money in transfer values, revenue, and other financial flows.

There is constant debate about how money influences the current state of the league. This study examines **net spend**, **wage bills**, and **overall squad value** as financial metrics to understand their relationship with team success.

The main statistical approach is **Multiple Linear Regression** to determine if these financial metrics significantly predict a team's placement in the league table at season’s end. The model also estimates the probabilities for key milestones — such as qualifying for European competitions (top 6 finish) — based on each predictor.

Additionally, a **Random Forest** model is run and compared with the linear regression approach to evaluate which method yields better predictive performance.

Before building combined models, each predictor is examined individually to determine correlation with league position. Then, the predictors are combined into a single model to run multiple linear regression and assess overall explanatory power.

## Data & Variables
- **Target variable:** Final league position (`1` = champion, higher numbers = lower rank).
- **Predictors:**
  - **Net spend**: Transfer expenditure minus income.
  - **Wage bill**: Annual player salary expenditure.
  - **Squad market value**: Estimated total value of all players.

Data covers multiple seasons of the EPL, with values collected from reputable sports finance and statistics sources.

## Methodology
1. **Exploratory Data Analysis (EDA)** — scatterplots, correlation analysis, and basic descriptive statistics for each predictor.
2. **Multiple Linear Regression (OLS)** — fitting models for each predictor individually and in combination, measuring significance via p-values, and checking for multicollinearity.
3. **Random Forest Regression** — modeling non-linear relationships and interactions between predictors, measuring feature importance.
4. **Probability Estimates** — calculating probabilities for specific outcomes (e.g., finishing in the top 6) based on model residuals and predictions.

## Key Findings
- **Squad Market Value** consistently shows the strongest correlation with final league position.
- **Wage Bill** is also a significant factor but overlaps with market value in its explanatory power.
- **Net Spend** has a weaker and less stable relationship with league position, likely due to short-term fluctuations and context-dependent effects.
- The Random Forest model performs comparably to the regression model, with some improvement in capturing non-linear patterns, but market value remains the dominant predictor in both approaches.

## Interpretation
Financial capacity plays a major role in on-field performance in the EPL. Higher-value squads and larger wage bills tend to finish higher in the league standings. However, spending heavily in one transfer window (net spend) is not a guaranteed formula for success, as other factors — such as player fit, tactics, and injuries — come into play.

## Limitations
- Limited number of teams (20 per season) and seasons analyzed reduces statistical power.
- Financial figures are estimates and may vary depending on the source.
- Models do not account for in-season dynamics such as injuries, managerial changes, or fixture difficulty.

## Conclusion
This research supports the notion that financial strength correlates with competitive success in the Premier League, particularly via long-term squad value and wage commitments. While transfer spending can impact results, it is not as reliable a predictor of final league position without considering other contextual variables.
