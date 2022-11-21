# Roundtrip FACE-IT 2022-11-21
# Luisa Düsedau
# 21.11.2022

#Create headlines in your script
#Crtl + shift + R

# first excersice ---------------------------------------------------------

#create sub-headings in your script
# 4#s in front and in the back
####subheading####


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(palmerpenguins)


# Data --------------------------------------------------------------------

# Load the dataset into the local environment
penguins <- penguins


# Example -----------------------------------------------------------------

# The basic plot
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = species))


# Exercise 1 --------------------------------------------------------------

# Create a basic plot with different x and y axes

view(penguins)
print(penguins)

ggplot(data = penguins,
       aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(colour = sex))

ggplot(data = penguins,
       aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = year))


# Exercise 2 --------------------------------------------------------------

# Change the aes() arguments

ggplot(data = penguins,
       aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = island, shape = species, size = year))

ggplot(data = penguins,
       aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = year, shape = sex, size = island))

str(penguins)
penguins$year <- as.factor(penguins$year) 
str(penguins)

ggplot(data = penguins,
       aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = sex, shape = year, size = island))

# Exercise 3 --------------------------------------------------------------

# Change the labels

ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm, colour = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  # Change label text
  labs(x = "Body mass (g)", y = "Bill length (mm)", colour = "Species") +
  # Change legend position
  theme(legend.position = "bottom")

ggplot(data = penguins,
       aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = year, shape = sex)) +
  # Change label text
  labs(x = "Bill lenght (mm)", y = "Bill depth (mm)", colour = "Year", shape = "Sex") +
  # Change legend position
  theme(legend.position = "top")


# BONUS -------------------------------------------------------------------

# Create a ridgeplot

# library
library(ggridges)
library(ggplot2)


# basic example

print(penguins)


ggplot(data = penguins, aes(x = bill_length_mm, y = year, fill = year)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")
#y needs to be the same as fill!

ggplot(data = penguins, aes(x = body_mass_g, y = sex, fill = sex)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")

ggplot(data = penguins, aes(x = bill_length_mm, y = sex, fill = sex)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")

ggplot(data = penguins, aes(x = body_mass_g, y = sex, fill = sex)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")


#Color relative to numeric value

# library
library(ggridges)
library(ggplot2)
library(viridis)
library(hrbrthemes)

# Plot
ggplot(data = penguins, aes(x = `body_mass_g`, y = `species`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_viridis(name = "Body mass (g)", option = "C") +
  labs(title = 'Time series') +
  theme_ipsum() 
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8)
  )
  
  
