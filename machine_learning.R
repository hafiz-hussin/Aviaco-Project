# libraries ---------------------------------------------------------------
library(tidyr)
library(lubridate)
library(dplyr)
library(lubridate)
library(stringr)
library(rebus)
library(prophet)
library(data.table)
library(cowplot)
library(tidyquant)
library(prophet)
library(funModeling)
library(forecast)

# data --------------------------------------------------------------------
df <- read.csv("db/crew_data.csv")

class(df)
df_status(df)
colnames(df)

library(readxl)
dataset <- read_excel("db/crew_data.xlsx",col_types = c("date", "numeric", "numeric", "numeric"))
View(dataset)
head(dataset)

# time-series-plots -------------------------------------------------------
dataset %>%
  ggplot(aes(Date_time, Total_crew)) +
  geom_line(color = palette_light()[[1]], alpha = 0.5) +
  geom_point(color = palette_light()[[1]]) +
  theme_tq() +
  xlab("Time: Day Hour Minute")


# prophet algorithm -------------------------------------------------------
# Change column names
data_temp <- dataset %>% select(Date_time, Total_crew)
names(data_temp) = c("ds", "y")
data_temp %>% count()

# The BoxCox.lambda() function will choose a value of lambda
lam = BoxCox.lambda(data_temp$y, method = "loglik")
df$y = BoxCox(df$value, lam)
df.m <- melt(df, measure.vars=c("value", "y"))



m <- prophet(data_temp)
future <- make_future_dataframe(m, periods = 7)
forecast <- predict(m, future)
plot(m, forecast)
prophet_plot_components(m, forecast)



inverse_forecast <- forecast
inverse_forecast <- column_to_rownames(inverse_forecast, var = "ds")
inverse_forecast$yhat_untransformed = InvBoxCox(forecast$yhat, lam)

plot(inverse_forecast)

# Split the dataset into training and testing
train <- data_temp %>% 
  filter(ds < as.Date("2019-07-08"))

# testing set
test <- data_temp %>% 
  filter(ds >= as.Date("2019-07-08"))

# Model building ----------------------------------------------------------
model <- prophet(train)
train_predict <- make_future_dataframe(model, periods = 1257)
train_forecast <- predict(model, train_predict)

plot(model, train_forecast)
prophet_plot_components(model, train_forecast)

# Visualize the test data
p <- ggplot()
p <- p + geom_point(data = train, aes(x = ds, y = y), size = 0.5)
p <- p + geom_line(data = train_forecast, aes(x = as.Date(ds), y = yhat), color = "#0072B2")
p <- p + geom_ribbon(data = train_forecast, aes(x = as.Date(ds), ymin = yhat_lower, ymax = yhat_upper), fill = "#0072B2", alpha = 0.3)
p <- p + geom_point(data = test, aes(x = ds, y = y), size = 0.5, color = 'red')
p + theme(legend.position = "bottom") +
  ggtitle("Training Set and Testing Set", subtitle = "Training Horizon: 2005 - 2014  Testing Horizon: 2015 - 2018")

# Model performance
# Function that returns Mean Absolute Error
df.cv <- cross_validation(model, horizon = 365, units = "days")
head(df.cv)
tail(df.cv)

df.p = performance_metrics(df.cv)
head(df.p)
plot_cross_validation_metric(df.cv, metric = 'rmse') + theme(legend.position = "bottom") +
  ggtitle("RMSE", subtitle = "Cross validation result in traning data")
plot_cross_validation_metric(df.cv, metric = 'mae') +
  ggtitle("MAE", subtitle = "Cross validation result in traning data")

# test performance
predicted_value <- train_forecast %>%
  filter(ds >= as.Date("2015-01-01") & ds <= as.Date("2018-06-11")) %>% 
  select(ds, yhat) 
predicted_value$ds <- as.Date(predicted_value$ds)
actual_value <- test

test_error_tbl <- dplyr::left_join(predicted_value, actual_value, by="ds")
test_error_tbl[is.na(test_error_tbl)] <- 0

mean_square_error <- mean((test_error_tbl$y - test_error_tbl$yhat)^2)
sqrt(mean_square_error)
mean_absolute_error <- mean((abs(test_error_tbl$y - test_error_tbl$yhat)))
mean_absolute_error

