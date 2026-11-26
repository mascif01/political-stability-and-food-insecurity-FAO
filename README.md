# political-stability-and-food-insecurity-FAO
Exploratory analysis in R of the relationship between political stability and prevalence of undernourishment (PoU) in African countries (FAOSTAT), with time trends for Somalia, Madagascar and Mali.

## Questions
- How are PoU and political stability distributed across countries?
- Are lower political stability and higher undernourishment associated?
- How did the two indicators evolve over time in the countries in the worst situation?

## Where to start
The full report is in [`political_stability_and_food_insecurity.pdf`](political_stability_and_food_insecurity.pdf).
It explains the methodology behind the PoU indicator, its limitations, the descriptive
analysis and the time series for Somalia, Mali and Madagascar. The R code is also
reported in the last chapter. 

## Analysis
1. **Descriptive statistics and histograms** of PoU and of the political stability index,
   with mean and median.
2. **Scatter plot** of political stability against PoU, labelled by country, with a
   linear trend line.
3. **Extreme cases**: the countries with the highest PoU and with the lowest political
   stability.
4. **Time trends** (2013 to 2022) of both indicators for Somalia, Madagascar and Mali.
   FAOSTAT reports PoU as 3-year averages, so each period is assigned to its central
   year (for example 2013-2015 becomes 2014).

## Variables
- `PoU`: prevalence of undernourishment (percent, 3-year average)
- `pol`: political stability and absence of violence/terrorism (index)

## Requirements
R with the packages `readr`, `readxl`, `tidyr`, `dplyr`, `ggplot2` and `ggrepel`.

## Data
Indicators from FAOSTAT (Food and Agriculture Organization of the United Nations),
reshaped before the analysis. 

## Notes
This is an exploratory analysis. The trend line summarises an association and does not
establish a causal relationship.

## Files
- `projectscript.R`: the full script
- `political_stability_and_food_insecurity.pdf`: the full report
