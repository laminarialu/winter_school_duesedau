# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

library(tidyverse)


# Data --------------------------------------------------------------------

# The mangled data
load("course_material/data/OISST_mangled.RData")

# The tidy data
sst_NOAA <- read_csv("course_material/data/sst_NOAA.csv")


# Example -----------------------------------------------------------------

# The first few rows of an untidy dataframe
head(OISST3)

# Pivot wide by date
  # NB: This is very untidy
OISST1_wide <- OISST1 %>% 
  pivot_wider(values_from = temp, names_from = t)


# Exercise 1 --------------------------------------------------------------

# Combine OISST4a and OISST4b into a new object


# Exercise 2 --------------------------------------------------------------

# Ensure that the date formatting is correct on your new object


# Exercise 3 --------------------------------------------------------------

# Split the date column on `sst_NOAA` and re-unite them


# BONUS -------------------------------------------------------------------

# Plot the temperatures of two time series against each other as a scatterplot
# Meaning temperature from time series 1 are the X axis, and time series 2 on the Y axis
# Hint: This requires pivoting the temperatures wide into columns

