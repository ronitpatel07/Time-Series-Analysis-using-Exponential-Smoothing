library(forecast)
library(dplyr)
library(quantmod)
library(bindrcpp)

#importing and checking data
TV_df<-read.csv("TV_by_network_daypart.csv")
head(TV_df)
str(TV_df)

#spliting data into train and test data
TV_train<-filter(TV_df, date<=201612)
tail(TV_train)
TV_test<-filter(TV_df, date>201612)
head(TV_test)
TV_train$date<-as.character(TV_train$date)

#Combining 55 time series and converting train and test data into time stamp
TV_train<-split(TV_train, list(TV_train$daypart,TV_train$network), drop=T)

TV_test<-split(TV_test, list(TV_test$daypart,TV_test$network), drop=T)

test<-lapply(TV_test, function(x) x[c(4)])
test
test<-lapply(test, function(x) ts(x, frequency=12, start=c(2017,1)))
test

TV_train
TV_train<-lapply(TV_train, function(x) x[c(4)])
TV_train
train_ts<-lapply(TV_train, function(x) ts(x, frequency=12, start=c(2014,1)))
train_ts

#stl decomposition, acf, pacf plot of training data
decom<-lapply(train_ts, function(x) decompose(x))
lapply(decom, function(x) plot(x, col="red"))
lapply(train_ts, function(x) acf(x, ylim=c(-0.2,2)))
lapply(train_ts, function(x) pacf(x, ylim=c(-0.2,2)))

#Running holtwinter exponential smoothing model with defined parameters
model<-lapply(train_ts, function(x) HoltWinters(x, alpha = 0.2, beta = 0.1, gamma = 0.2))
model

#Predicting the test data
pred<-lapply(model, function(x) predict(x, n.ahead=12))
pred

#Converting time series data back to numeric to find MSE
prediction<-lapply(pred, function(x) as.numeric(x[,1]))
prediction
test_act<-lapply(test, function(x) as.numeric(x[,1]))
test_act

#Mean-Square Errror for prediction made from pre-defined model
mae<-mapply(function(x,y) mean(abs(x-y)), x=prediction, y=test)
mae

#Running holtwinter model with undefined parameter and making predictions
mod<-lapply(train_ts, function(x) HoltWinters(x))
mod
pred_acc<-lapply(mod, function(x) predict(x, n.ahead=12))
pred_acc
prediction_acc<-lapply(pred_acc, function(x) as.numeric(x[,1]))
prediction_acc

#Calculating MSE for predictions made from undefined model
mae_acc<-mapply(function(x,y) mean(abs(x-y)), x=prediction_acc, y=test_act)
mae_acc


plt<-lapply(test, function(a) ts.plot(a,ylim=c(0,1000), xlim=c(2017, 2018)))
plt1<-lapply(pred, function(x) lines(x, col="green"))
plt2<-lapply(pred_acc, function(x) lines(x, col="blue"))

