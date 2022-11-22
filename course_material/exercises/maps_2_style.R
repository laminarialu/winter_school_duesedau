# /R_workshop/winter_school_duesedau/maps_2_style.R
# Luisa Düsedau
# 2022-11-22



# Libraries ---------------------------------------------------------------

library(tidyverse) # Contains most of what we need

library(marmap) # For downloading bathymetry data

#Base Map

ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_equal()

#Fix the time line issue by creating a new data frame
map_global_fix <- map_data('world') %>% 
  rename(lon = long) %>% 
  # Why +2000?
  mutate(group = ifelse(lon > 180, group+2000, group),
         lon = ifelse(lon > 180, lon-360, lon))

map_global_fix

ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group), colour = "black", fill = "grey60") +
  # The default coordinate system, with specific limits
  coord_cartesian(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE)

# Bathymetry data --------------------------------------------------------------------

# Call the global data to the environment

# Download bathy data
bathy_WA <-  getNOAA.bathy(lon1 = 111, lon2 = 117, 
                           # NB: smaller value first, i.e. more negative
                           lat1 = -36, lat2 = -19, 
                           # In degree minutes
                           resolution = 4)

# Convert to data.frame for use with ggplot2
bathy_WA_df <- fortify.bathy(bathy_WA) %>% 
  # Remove altimetry data
  filter(z <= 0) 

# Save
save(bathy_WA_df, file = "course_material/data/bathy_WA_df.RData")


# Example -----------------------------------------------------------------

# The basic map
ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_equal(xlim = c(-90, -70), ylim = c(20, 40))


# Exercise 1 --------------------------------------------------------------

# Choose a coastal region somewhere within 30°N/S of the equator



# Download bathymetry data and another data layer

# Plot them


# Exercise 2 --------------------------------------------------------------

# Chose a different region

# Download two different data layers

# Plot and combine the data


# Exercise 3 --------------------------------------------------------------

# Change the themes and minutia of the previous two plots and combine them


# BONUS -------------------------------------------------------------------

# Overlay data layers on a Google map image

