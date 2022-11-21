# Roundtrip FACE-IT 2022-11-21
# plot_2_facets_R
# Luisa Düsedau
# 21.11.2022


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(palmerpenguins)


# Data --------------------------------------------------------------------

# Load the dataset into the local environment
penguins <- penguins


# Example -----------------------------------------------------------------

# Basic faceted plot
lm_1 <- ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm, colour = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~species)
lm_1

# Basic combined plot
ggarrange(lm_1, lm_1)


# Exercise 1 --------------------------------------------------------------

# Create a new plot type and facet by gender

nlm_2 <- ggplot(data = penguins,
               aes(x = body_mass_g, y = flipper_length_mm, colour = sex)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~sex)
nlm_2

# Exercise 2 --------------------------------------------------------------

# Create a new plot type and facet by two categories

plot_3 <- ggplot(data = penguins,
       aes(x = bill_length_mm, y = bill_depth_mm, colour = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  # Takes two or more column names (e.g. species+sex~island)
  facet_grid(species~year)
#the coloum namend in colour should also be used as one argument in the facet_grid argument

plot_3


#Create a forth plot

histogram_1 <- ggplot(data = penguins, 
                      # NB: There is no y-axis value for histograms
                      aes(x = flipper_length_mm)) + 
  geom_histogram(aes(fill = species), position = "stack") +
  # NB: We use 'fill' here rather than 'colour'
  labs(x = "Body mass (g)", fill = "Species")
histogram_1

# Exercise 3 --------------------------------------------------------------

# Combine all of the plots you've created so far
# Save them as a high-res file larger than 2 MB



# BONUS -------------------------------------------------------------------

# Use a different package to combine plots

