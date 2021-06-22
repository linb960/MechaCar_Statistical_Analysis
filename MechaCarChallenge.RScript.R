# Deliverable 1

library(dplyr)

MechaCar_table <- read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F)
head(MechaCar_table)

lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD ,data=MechaCar_table) #generate multiple linear regression model

summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=MechaCar_table))

# Deliverable 2
SuspensionCoil_table <- read.csv(file='Suspension_Coil.csv',check.names=F,stringsAsFactors = F)
head(SuspensionCoil_table)

total_summary <- SuspensionCoil_table %>% summarize(Mean = mean(PSI), Median = median(PSI), Variance = var(PSI), SD = sd(PSI), .groups = 'keep')
total_summary

lot_summary <- SuspensionCoil_table %>% group_by(Manufacturing_Lot)  %>%  summarize(Mean = mean(PSI), Median = median(PSI), Variance = var(PSI), SD = sqrt(var(PSI)), .groups = 'keep')
lot_summary

