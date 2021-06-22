# MechaCar Statistical Analysis

## Overview
A company AutosRUs' is testing a new prototype __MechaCar__.  This prototype is having some production troubles blocking manufacturing.  This analysis will review production data to gain insight to help the production team.

## Setup and Tools
The manufacturing team provided two files to help with the analytics __MechaCar_mpg.csv__ and __Suspension_Coil.csv__.  Using the R programming language and the __dplyr__ library the following will be done: <br>
- A multiple Linear regression will be done to identify which variables predict the mpg of the prototype.
- Summary statistics on the pounds per square inch (PSI) will be collected.
- t-tests will be run to determine if the manufacturing lots are statistically different from the mean population.
- A statistical study to compare vehicle performance of the MechaCar against other vehicles will be designed.

## Linear Regression to Predict MPG
A linear regression is run and all 6 variables(columns) from the Mecha_Car.csv file are passed into the lm() function. <br>

The __multiple linear regression__ equation is y = m1x1 + m2x2 + … + mnxn + b, for all independent x variables and their m coefficients.
```
> lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD ,data=MechaCar_table) #generate multiple linear regression model

Coefficients:
     (Intercept)    vehicle_length    vehicle_weight     spoiler_angle  ground_clearance               AWD  
      -1.040e+02         6.267e+00         1.245e-03         6.877e-02         3.546e+00        -3.411e+00  

```
The summary formula then is:<br>
```
> summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=MechaCar_table))

Call:
lm(formula = mpg ~ vehicle_length + vehicle_weight + spoiler_angle + 
    ground_clearance + AWD, data = MechaCar_table)

Residuals:
     Min       1Q   Median       3Q      Max 
-19.4701  -4.4994  -0.0692   5.4433  18.5849 

Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
(Intercept)      -1.040e+02  1.585e+01  -6.559 5.08e-08 ***
vehicle_length    6.267e+00  6.553e-01   9.563 2.60e-12 ***
vehicle_weight    1.245e-03  6.890e-04   1.807   0.0776 .  
spoiler_angle     6.877e-02  6.653e-02   1.034   0.3069    
ground_clearance  3.546e+00  5.412e-01   6.551 5.21e-08 ***
AWD              -3.411e+00  2.535e+00  -1.346   0.1852    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 8.774 on 44 degrees of freedom
Multiple R-squared:  0.7149,	Adjusted R-squared:  0.6825 
F-statistic: 22.07 on 5 and 44 DF,  p-value: 5.35e-11
```
Our results are mpg = 2.60e-12 vehicle_length + 0.0776 vehicle_weight + 0.3069 spoiler_angle + 5.21e-08 ground_clearance + 0.1852 AWD + 5.08e-08 <br>

According to the results, vehicle length and ground clearance (as well as intercept) are statistically likely to provide __non-random__ amounts of variance to the linear model. In other words the vehicle length and ground clearance have a significant impact on miles per gallon. 

Where as the vehicle weight, spoiler angle and AWD provide random amounts of variance to the mpg values.

In addition, the p-value of our linear regression analysis is 5.35e-11, which is much smaller than our assumed significance level of 0.05%. Therefore, we can state that there is sufficient evidence to reject our null hypothesis, which means that the __slope of our linear model is not zero__.

From our linear regression model, the r-squared value is 0.71490, which means that roughly 70% of the variablilty of our dependent variable (mpg predictions) is explained using this linear model. This means that this linear model predicts mpg of the MechaCar prototypes effectively.

## Summary statistics on Suspension Coils
Using the Suspension_Coil.csv a total summary of the PSI on the suspension coils was calculated for all of the vehicles manufactured:
```
total_summary <- SuspensionCoil_table %>% summarize(Mean = mean(PSI), Median = median(PSI), Variance = var(PSI), SD = sd(PSI), .groups = 'keep')
> total_summary
Mean        Median   Variance       SD
1 1498.78   1500     62.29356       7.892627
```
A summary by Lot number was also calculated:
```
> lot_summary <- SuspensionCoil_table %>% group_by(Manufacturing_Lot)  %>%  summarize(Mean = mean(PSI), Median = median(PSI), Variance = var(PSI), SD = sqrt(var(PSI)), .groups = 'keep')

# Groups:   Manufacturing_Lot [3]
  Manufacturing_Lot  Mean  Median   Variance     SD

1 Lot1              1500   1500     0.980      0.990
2 Lot2              1500.  1500     7.47       2.73 
3 Lot3              1496.  1498.    170.       13.0  
```
The design specifications for the MechaCar suspension coils dictate that the variance of the suspension coils must not exceed 100 pounds per square inch. <br>
#### Findings
Clearly the overall summary shows that with a variance of __62.29356__ the coils __are__ within specifications.<br>
But __Lot 3__ shows that the variance is over 100 at __170__.  This lot __is not__ within design specifications.

## T-Tests on Suspension Coils
The t.test is used against the SuspensionCoil_table to determine if the PSI across all manufacturing lots is statisticall different from the population mean of 1,500 pounds per square inch.  <br>

Assuming our significance level was the common 0.05 percent for all the tests below, our p-value is above our significance level in all tests except for __Lot 3__. Therefore for the test on all of the Lots and Lot 1 and Lot 2, we do not have sufficient evidence to reject the null hypothesis.

On the first test below where we use all of the data we find that the mean of x is 1498.78 and the p-value is 0.06028.<br>
```
> t.test(SuspensionCoil_table$PSI,mu=1500)

	One Sample t-test

data:  SuspensionCoil_table$PSI
t = -1.8931, df = 149, p-value = 0.06028
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1497.507 1500.053
sample estimates:
mean of x 
  1498.78 
```
Lot 1 shows that the mean is 1500 and the p-value is 1.  And Lot 2 has a mean of 1500.2 and a p-value of 0.6072. <br>
```
> t.test(subset(SuspensionCoil_table, Manufacturing_Lot=="Lot1")$PSI,mu=1500)

	One Sample t-test

data:  subset(SuspensionCoil_table, Manufacturing_Lot == "Lot1")$PSI
t = 0, df = 49, p-value = 1
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1499.719 1500.281
sample estimates:
mean of x 
     1500 

> t.test(subset(SuspensionCoil_table, Manufacturing_Lot=="Lot2")$PSI,mu=1500)

	One Sample t-test

data:  subset(SuspensionCoil_table, Manufacturing_Lot == "Lot2")$PSI
t = 0.51745, df = 49, p-value = 0.6072
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1499.423 1500.977
sample estimates:
mean of x 
   1500.2 
```
Lot 3 shows that we have a mean of 1496.14 and a p-value less then .05 at 0.04168.  This means that we have significant evidence in this t.test to reject the null hypothesis.
```
> t.test(subset(SuspensionCoil_table, Manufacturing_Lot=="Lot3")$PSI,mu=1500)

	One Sample t-test

data:  subset(SuspensionCoil_table, Manufacturing_Lot == "Lot3")$PSI
t = -2.0916, df = 49, p-value = 0.04168
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1492.431 1499.849
sample estimates:
mean of x 
  1496.14 
```







