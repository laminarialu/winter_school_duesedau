#*R*oundtript_2022-11-19#
#*
library(tidyverse)

a <-  2
b <- -9
d <- 4

rm(d)

d <- 4

d < -4

apples <- c(1.2, 4.2, 7.5)

apples

mean(apples)

sd(apples)

round(sd(apples))

round(sd(apples), 2) #rounds to 2 numbers after the decimal

ls()

#work with sst_NOAA data####
#excel exercise#
#monthly climatology in excel#
#best to use pivot tables#
#now try in R#

library(tidyverse)
library(lubridate)

sst_NOAA <- read_csv("C:/Users/ldueseda/Desktop/sst_NOAA.csv")

#does the same as a pivot table
sst_monthly <- sst_NOAA %>% 
  mutate(month = month(t, label = T)) %>% 
  group_by(site, month) %>% 
  summarise(temp = round(mean(temp, na.rm = T), 3))

ggplot(data = sst_monthly, aes(x = month, y = temp)) +
  geom_point(aes(colour = site)) +
  geom_line(aes(colour = site, group = site)) +
  labs(x = NULL, y = "Temperature (°C)")

ggplot(data = sst_monthly, aes(x = month, y = temp)) +
  geom_point(aes(colour = site)) +
  geom_line(aes(colour = site, group = site)) +
  labs(x = "", y = "Temperature (°C)") +
  facet_wrap(~site, ncol = 1) # Create panels
