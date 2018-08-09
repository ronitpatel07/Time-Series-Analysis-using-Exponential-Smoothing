# Time-Series-Analysis-using-Exponential-Smoothing

# Task
For this task you will use real TV viewership data. The data set (available for download at https://drive.google.com/open?id=1fBgIMacfAYiNcTCsXdhYMNe96-fLQGTg) has the following information:

Date: Year and Month the measurement corresponds to. The data set contains measurements from January 2014 to December 2017. 
Network: The TV channel the measurement corresponds to. We will simply use five categorical identifiers.
Daypart: A “daypart” is a grouping of days and hours that are of relevance in the TV industry. For example, Mondays through Fridays from 8:00 pm to 11:00 pm is a daypart. In the data set, there are 11 dayparts. 
Number of viewers: The actual value of the measurement. 

In this task, you are expected to analyze via STL decomposition and ACF as well as PACF plots, the time series contained in the data set available for download here. A time series in this data set is the set of measurements from January 2014 to December 2017 for each combination of network-daypart. In total, therefore, there are 55 time series in this data set. 

In all your analyses, use the period between January 2014 to December 2016 as the “training” set, and the year 2017 as the “test” data set. Use exponential smoothing (via the HoltWinters function in R) to fit your model and then produce forecasts (using the function “forecast” from the forecast package) for the 55 time series and compare those forecasts with the actuals by creating plots and calculating the mean absolute error (MAE).

# Solution
I imported the csv file containing data into R and then checked structure of data. Then, I split data into Training and Testing dataset based on the year as indicated in problem. Data contains factorized variable network and daypart with factors 5 and 11 respectively. So, I split data as per the function and eventually, formed a list containing Dataframe of 55 different combination of time series which it contains. Next, I performed STL decomposition using decomposition function to plot time-series, seasonality and trend chart of all 55 time-series. I performed each operation on all 55 time-series by using lapply function. I plotted auto-correlation and Partial auto correlation using ACF and PACF functions respectively. After that, I created exponential smoothing model with initial parameter values of alpha, beta and gamma equal to 0.2, 0.1, 0.2. Then, I predicted the values of test data using this model and calculated mean absolute value for all 55 time-series. I created another model without initializing any values to parameter and let, R decide the optimum value of those parameter which R did differently for each of 55 time-series. Then, I predicted the values of test data using newly created model and calculated mean absolute value. I figured out from the output, that the performance of model with optimum value of parameter decided by in-built function of R was better in most of the time series. After doing this, I tried to plot the predicted values with test data to compare.
