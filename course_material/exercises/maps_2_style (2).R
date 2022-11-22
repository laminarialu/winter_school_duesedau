# /R_workshop/winter_school_duesedau/maps_2_style.R
# Luisa Düsedau
# 2022-11-22

# Libraries ---------------------------------------------------------------

library(tidyverse) # Contains most of what we need

library(marmap) # For downloading bathymetry data

# Data --------------------------------------------------------------------

load("course_material/data/bathy_WA_df.RData")


# # Download bathy data
# bathy_WA <-  getNOAA.bathy(lon1 = 111, lon2 = 117, 
#                            # NB: smaller value first, i.e. more negative
#                            lat1 = -36, lat2 = -19, 
#                            # In degree minutes
#                            resolution = 4)
# 
# # Convert to data.frame for use with ggplot2
# bathy_WA_df <- fortify.bathy(bathy_WA) %>% 
#   # Remove altimetry data
#   filter(z <= 0) 
# 
# # Save
# save(bathy_WA_df, file = "course_material/data/bathy_WA_df.RData")

# Example -----------------------------------------------------------------

# The basic map
ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_equal(xlim = c(-90, -70), ylim = c(20, 40))




# From the slides ---------------------------------------------------------





ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group), colour = "black", fill = "grey60") +
  # Add 200 m contour
  geom_contour(data = bathy_WA_df, 
               aes(x = x, y = y, z = z),
               breaks = c(-200), 
               linewidth = c(0.3), colour = "grey") +
  coord_cartesian(xlim = c(111, 117), 
                  ylim = c(-36, -19), expand = FALSE)

# Exercise 1 --------------------------------------------------------------

# Choose a coastal region somewhere within 30°N/S of the equator
# Download bathymetry data and plot them


# Exercise 2 --------------------------------------------------------------

# Chose a different region and get bathymetry
# Plot and combine the two figures


# Exercise 3 --------------------------------------------------------------

# Change the themes and minutia of the previous two plots and combine them


# BONUS -------------------------------------------------------------------

# Overlay data layers on a Google map image

