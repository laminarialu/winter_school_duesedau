# /R_workshop/winter_school_duesedau/maps_1_basics_R
# Luisa Düsedau
# 2022-11-22


# Libraries ---------------------------------------------------------------

# Which libraries should be loaded?

library(tidyverse) # Contains most of what we need

library(ggpubr) # For combining figures

library(ggsn) # Contains code to make scale bars


# Data --------------------------------------------------------------------

# Call the global data to the environment
map_data_world <- map_data("world")

print(map_data_world)



# Some plots --------------------------------------------------------------

earth_1 <- ggplot() +
  # The global shape file
  borders(fill = "grey70", colour = "black") +
  # Equal sizing for lon/lat 
  coord_equal()

earth_1

green_1 <- ggplot() +
  borders(fill = "grey70", colour = "black") +
  # Force lon/lat extent
  coord_equal(xlim = c(-75, -10), ylim = c(58, 85)) 

green_1


# organise the dataset and see which regions are there --------------------

map_data('world') %>% 
  select(region) %>% 
  distinct() %>% 
  arrange(region)

# Example -----------------------------------------------------------------

# extract a region e.g. Germany
# The basic map
map_data_world %>% 
  filter(region == "Germany") %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_polygon(aes(group = group))

#ggsn::   to search for specific function within a package

# Exercise 1 --------------------------------------------------------------

# Create maps of four regions and combine
# Use a mix of cropping and direct access 

# direct access####

Yemen <- map_data_world %>% 
  filter(region == "Yemen") %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_polygon(aes(group = group))

Yemen

Sweden <- map_data_world %>% 
  filter(region == "Sweden") %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_polygon(aes(group = group))

Sweden

# cropping = ausschneiden####

#whole map

whole_world <- ggplot() +
  # The global shape file
  borders(fill = "grey70", colour = "black") +
  # Equal sizing for lon/lat 
  coord_equal()

whole_world

#Australia

australia <- ggplot() +
  borders(fill = "red", colour = "yellow") +
  # Force lon/lat extent
  coord_equal(xlim = c(110, 155), ylim = c(-45, -5)) 

australia

#GB

GB <- ggplot() +
  borders(fill = "green", colour = "blue") +
  # Force lon/lat extent
  coord_equal(xlim = c(-10, 2.5), ylim = c(48, 62))

GB

# Combine####

grid_1 <- ggarrange(Yemen, Sweden, GB, australia,
                    # Set number of rows and columns
                    ncol = 2, nrow = 2,
                    # Label each figure
                    labels = c("a)", "b)", "c)", "d)"),
                    # Set legend position
                    legend = "bottom")
grid_1


###############Start from here in the next excercise#######################


# Exercise 2 --------------------------------------------------------------

# Create a map that benefits from a scale bar and add a North arrow
# Hint: use annotate("segment", ...) to accomplish this

green_2 <- ggplot(data = map_data_green, aes(x = long, y = lat)) +
  # What is this doing?
  geom_polygon(aes(group = group), 
               # Note these are outside of aes() 
               fill = "chartreuse4", colour = "black")
green_2

# Exercise 3 --------------------------------------------------------------

# Create a meaningful inset map


# BONUS -------------------------------------------------------------------

# Plot maps using Google Maps

