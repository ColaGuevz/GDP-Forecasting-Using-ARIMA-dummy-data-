library(readxl)
gdp <- read_excel("D:\\Files\\Files\\Academics\\BSCS-4th Year(1st Sem)\\QUANTITATIVE METHODS (INCL.MODELING AND SIMULATIONS)\\ARIMA\\Lab Exercise 4.3\\gdp.xlsx")
View(gdp)
class(gdp)
gdptime = ts(gdp$GDP, start = c(1959, 1), frequency = 4)
class(gdptime)
library(forecast)
library(tseries)
training_data = window(gdptime, start = c(1959, 1), end = c(1978, 4))
testing_data = window(gdptime, start = c(1979, 1), end = c(1988, 4))

# ARIMA
gdpmodel=auto.arima(training_data,ic="aic",trace = TRUE)
summary(gdpmodel)
mygdpforecast=forecast(gdpmodel,level = c(95), h = length(testing_data))
plot(mygdpforecast)
lines(testing_data, col = "red")
accuracy(mygdpforecast, testing_data)

# ETS (Exponential Smoothing)
gdp_ets_model <- ets(training_data)
summary(gdp_ets_model)
mygdpforecast_ets <- forecast(gdp_ets_model, level = c(95), h = length(testing_data))
plot(mygdpforecast_ets)
lines(testing_data, col = "red")
accuracy(mygdpforecast_ets, testing_data)

# TBATS 
gdp_tbats_model <- tbats(training_data)
summary(gdp_tbats_model)
mygdpforecast_tbats <- forecast(gdp_tbats_model, level = c(95), h = length(testing_data))
plot(mygdpforecast_tbats)
lines(testing_data, col = "red")
accuracy(mygdpforecast_tbats, testing_data)

# NNAR (Neural Network Autoregression) Model
set.seed(420)
gdp_nnar_model <- nnetar(training_data)
summary(gdp_nnar_model)
mygdpforecast_nnar <- forecast(gdp_nnar_model, level = c(95), h = length(testing_data))
plot(mygdpforecast_nnar)
lines(testing_data, col = "red")
accuracy(mygdpforecast_nnar, testing_data)

# STL Decomposition + Forecast
gdp_stl <- stl(training_data, s.window = "periodic")
mygdpforecast_stl <- forecast(gdp_stl, level = c(95), h = length(testing_data))
plot(mygdpforecast_stl)
lines(testing_data, col = "red")
accuracy(mygdpforecast_stl, testing_data)

# Prophet
library(prophet)
train_df <- data.frame(ds = seq(as.Date("1959-01-01"), as.Date("1978-10-01"), by = "quarter"),
                       y = as.numeric(training_data))
gdp_prophet_model <- prophet(train_df)
future <- make_future_dataframe(gdp_prophet_model, periods = length(testing_data), freq = "quarter")
mygdpforecast_prophet <- predict(gdp_prophet_model, future)
plot(gdp_prophet_model, mygdpforecast_prophet)
lines(as.numeric(testing_data), col = "red")
forecasted <- mygdpforecast_prophet$yhat[1:length(testing_data)]
accuracy(forecasted, as.numeric(testing_data))