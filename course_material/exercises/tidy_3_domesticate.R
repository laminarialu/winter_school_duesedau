# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

library(tidyverse)


# Data --------------------------------------------------------------------

# SST data
sst_NOAA <- read_csv("course_material/data/sst_NOAA.csv")


# Example -----------------------------------------------------------------

# Whatever we can imagine!
sst_NOAA %>%  
  group_by(site) %>%
  summarise(count = n(), 
            count_15 = sum(temp > 20)) %>% 
  mutate(prop_15 = count_15/count) %>% 
  arrange(prop_15)


# Exercise 1 --------------------------------------------------------------

# Filter two sites and summarise six different statistics


# Exercise 2 --------------------------------------------------------------

# Find the maximum temperature and SD per year per site
# Plot this as a bar plot with error bars
# Inset a map of each site over each bar plot


# Exercise 3 --------------------------------------------------------------

# From scratch, re-write the full analysis for exercise 1 'The new age'
# Inset maps for each at the end of each line on the Y axis


# BONUS -------------------------------------------------------------------

# Create a faceted heatmap showing the monthly climatologies per site

