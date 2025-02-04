# GDP Forecasting Methods

## Overview
This repository contains an analysis of GDP forecasting using different time series models. The performance of each model is evaluated based on various error metrics, including Mean Squared Error (MSE), Root Mean Squared Error (RMSE), Mean Absolute Error (MAE), and Mean Absolute Percentage Error (MAPE).

## Data
- The dataset used contains quarterly GDP data.
- Time Series data spans from **1959 Q1 to 1988 Q4**.
- The data is split into **training (1959-1978)** and **testing (1979-1988)** periods.

## Forecasting Models Implemented
1. **ARIMA (Autoregressive Integrated Moving Average)**
2. **ETS (Exponential Smoothing)**
3. **TBATS (Trigonometric Box-Cox ARMA Trend Seasonal)**
4. **NNAR (Neural Network Autoregression)**
5. **STL Decomposition + Forecast**
6. **Prophet (Facebook Prophet)**

## Performance Metrics Comparison
| Algorithm | MSE | RMSE | MAE | MAPE |
|-----------|------------|------------|------------|------------|
| **ARIMA** | 32159.36 | 179.33 | 163.15 | 4.27% |
| **ETS** | 8471.18 | 92.04 | 73.24 | 2.04% |
| **TBATS** | 1450292.92 | 1204.28 | 917.50 | 21.13% |
| **NNAR** | 456581.23 | 675.71 | 505.07 | 11.78% |
| **STL + Forecast** | 5824.18 | 76.32 | 56.75 | 1.53% |
| **Prophet** | 10099391.63 | 3177.95 | 3103.55 | 82.14% |

## Key Findings
- **STL Decomposition + Forecast** performs best, achieving the lowest error metrics (MSE: 5,824, MAPE: 1.53%).
- **ETS (Exponential Smoothing)** is the second-best model with a relatively low MAPE of 2.04%.
- **ARIMA** performs moderately well but is less accurate compared to STL and ETS.
- **TBATS, NNAR, and Prophet** exhibit significantly higher errors, making them less suitable for this dataset.
- **Prophet** has the highest MAPE (82.14%), making it the least accurate model in this study.

## Code Implementation
### Data Preparation:
```r
library(readxl)
gdp <- read_excel("gdp.xlsx")
gdptime = ts(gdp$GDP, start = c(1959, 1), frequency = 4)
training_data = window(gdptime, start = c(1959, 1), end = c(1978, 4))
testing_data = window(gdptime, start = c(1979, 1), end = c(1988, 4))
```
### Model Implementation:
#### ARIMA
```r
gdpmodel = auto.arima(training_data, ic="aic", trace = TRUE)
forecasted_arima = forecast(gdpmodel, level = c(95), h = length(testing_data))
accuracy(forecasted_arima, testing_data)
```
#### STL Decomposition + Forecast
```r
gdp_stl = stl(training_data, s.window = "periodic")
forecasted_stl = forecast(gdp_stl, level = c(95), h = length(testing_data))
accuracy(forecasted_stl, testing_data)
```
### Other models (ETS, TBATS, NNAR, Prophet) follow a similar pattern.

## Conclusion
Among all the forecasting models tested, **STL Decomposition + Forecast** provided the most accurate predictions based on error metrics. However, tuning different versions of STL and other models could yield better results.

## How to Run the Code
1. Install R and required libraries: `forecast`, `tseries`, `prophet`, `readxl`.
2. Load the dataset (`gdp.xlsx`).
3. Run the provided scripts for each model.
4. Compare accuracy metrics and visualize results.

## Contact
For any inquiries, feel free to reach out to the authors.

