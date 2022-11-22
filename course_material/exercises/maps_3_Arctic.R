# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(ggOceanMaps)
library(ggOceanMapsData)

# Data --------------------------------------------------------------------

# Fixed base map
map_global_fix <- map_data('world') %>% 
  rename(lon = long) %>% 
  mutate(group = ifelse(lon > 180, group+2000, group),
         lon = ifelse(lon > 180, lon-360, lon))

# Load sea surface temperatures for 2000-01-01
load("course_material/data/OISST_2022.RData")


# Redo the slides ---------------------------------------------------------

#try out different coord_ functions####

#coord_cartesian
ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Numeric sizing for lon/lat 
  coord_cartesian()

#coord_equal
ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Equal sizing for lon/lat 
  coord_equal()

#coord_fixed
ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Ratio (Y divided by X) sizing for lon/lat 
  coord_fixed(ratio = 2)

ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Ratio (Y divided by X) sizing for lon/lat 
  coord_fixed(ratio = 3)

#coord_quickmap
ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Behind the scenes this adapts the "mercator" projection
  coord_quickmap()

#map projections####

#coord_sf()
ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  coord_sf() # sf = simple feature

#coord_polar()
ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  scale_y_reverse() +
  # A very different projection
  coord_polar()

#coord_map
ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Look up the help file for moer info
  coord_map(projection = "ortho", orientation = c(90, 0, 0))

# Filter map data and plot it in one code chunk
map_global_fix %>% 
  filter(lon > 9, lon < 28, lat > 76, lat < 81) %>% 
  ggplot(aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Filtering the OISST_2022 data directly in geom_tile()
  geom_tile(data = filter(OISST_2022,
                          lon > 9, lon < 28, lat > 76, lat < 81), 
            aes(fill = temp)) +
  coord_map(projection = "ortho", orientation = c(90, 0, 0))

# Filter map data and plot it in one code chunk
map_global_fix %>% 
  filter(lon > 9, lon < 28, lat > 76, lat < 81) %>% 
  ggplot(aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Filtering the OISST_2022 data directly in geom_tile()
  geom_tile(data = filter(OISST_2022,
                          lon > 9, lon < 28, lat > 76, lat < 81), 
            aes(fill = temp)) +
  coord_cartesian(expand = F)

head(map_global_fix)
head(OISST_2022)

# ggOceanMap --------------------------------------------------------------

basemap(limits = 60)

basemap(limits = c(100, 160, -20, 30), bathymetry = TRUE)

basemap(limits = 60, glaciers = TRUE, bathymetry = TRUE)

basemap(limits = c(-160, -80, 60, 85), rotate = TRUE)

# Example -----------------------------------------------------------------

# The basic map
ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_polar()


# Exercise 1 --------------------------------------------------------------

# Directly access the shape of a region near a pole and plot with polar projection

#Porsangerfjord

map_global_fix %>% 
  filter(lon > 20, lon < 30, lat > 65, lat < 75) %>% 
  ggplot(aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Filtering the OISST_2022 data directly in geom_tile()
  geom_tile(data = filter(OISST_2022,
                          lon > 20, lon < 30, lat > 65, lat < 75), 
            aes(fill = temp)) +
  coord_map(projection = "ortho", orientation = c(90, 0, 0))

basemap(limits = 65)

basemap(limits = c(20, 30, 65, 75), bathymetry = TRUE)

basemap(limits = c(22, 28, 68, 74), bathymetry = TRUE)

basemap(limits = 65, glaciers = TRUE, bathymetry = TRUE)

basemap(limits = c(23, 28, 69, 72), rotate = TRUE)

#Svalbard

map_global_fix %>% 
  filter(lon > 5, lon < 30, lat > 75, lat < 82) %>% 
  ggplot(aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Filtering the OISST_2022 data directly in geom_tile()
  geom_tile(data = filter(OISST_2022,
                          lon > 5, lon < 30, lat > 75, lat < 82), 
            aes(fill = temp)) +
  coord_map(projection = "ortho", orientation = c(90, 0, 0))

basemap(limits = 75)

basemap(limits = c(-2, 27, 75, 82), bathymetry = TRUE)

basemap(limits = 75, glaciers = TRUE, bathymetry = TRUE)

basemap(limits = c(7, 27, 76, 81), rotate = TRUE)

#Kongsfjorden

basemap(limits = c(11, 13, 78, 80))

# Exercise 2 --------------------------------------------------------------

# Add a data layer to a polar projection plot


# Exercise 3 --------------------------------------------------------------

# Use ggoceanmaps to create a similar plot

basemap(limits = c(8, 28, 76, 81), rotate = TRUE)

basemap(limits = c(8, 29, 76, 81), bathymetry = TRUE, bathy.style = "contour_blues", rotate = TRUE) 

basemap(limits = c(8, 29, 76, 81), bathymetry = TRUE, rotate = TRUE) +
  scale_fill_viridis_d("Water depth (m)") 


basemap(limits = c(8, 28, 76, 81), rotate = TRUE) +
  annotation_scale(location = "bl") + 
  annotation_north_arrow(location = "tr", which_north = "true") 

basemap(limits = c(8, 29, 76, 81), bathymetry = TRUE, rotate = TRUE) +
  scale_fill_viridis_d("Water depth (m)") +
  annotation_scale(location = "bl") + 
  annotation_north_arrow(location = "tr", which_north = "true")

#make a dot in your figure
#look up the coordinates with google maps

one_dot <- data.frame(lat = 78.992634, long = 11.984046)

basemap(limits = c(8, 28, 76, 81), rotate = TRUE) +
  geom_spatial_point(data = one_dot, aes(x = long, y = lat), color = "red") +
  annotation_scale(location = "bl") + 
  annotation_north_arrow(location = "tr", which_north = "true") 

#make a rectangle in your figure


basemap(limits = c(8, 28, 76, 81), rotate = TRUE) +
geom_spatial_rect(aes (xmin = 11, xmax = 13, ymin = 78.85, ymax = 79.1), fill = NA, color = "red")  +
geom_spatial_point(data = one_dot, aes(x = long, y = lat), color = "red") +
  annotation_scale(location = "bl") + 
  annotation_north_arrow(location = "tr", which_north = "true") 

map_1 <- basemap(limits = c(8, 28, 76, 81), rotate = TRUE) +
  geom_spatial_rect(aes (xmin = 11, xmax = 13, ymin = 78.85, ymax = 79.1), fill = NA, color = "red")  +
  geom_spatial_point(data = one_dot, aes(x = long, y = lat), color = "red") +
  annotation_scale(location = "bl") + 
  annotation_north_arrow(location = "tr", which_north = "true") 

map_2 <- basemap(limits = c(11.3, 12.5, 78.8, 79.1))

#you need the package cow plot for the function ggdraw

library("cowplot")

ggdraw() +
  draw_plot(map_1) +
  draw_plot(map_2, x = 0.05, y = 0.65, width = 0.3, height = 0.3)

#get a more detailed projection map for Svalbard

#devtools::install_github("MikkoVihtakari/PlotSvalbard", upgrade = "never")

basemap("Svalbard", bathymetry = TRUE, glaciers = TRUE, legends = FALSE)

basemap(limits = c(10.9, 12.65, 78.83, 79.12), 
        bathymetry = TRUE, shapefiles = "Svalbard",
        legends = FALSE, glaciers = TRUE)

basemap(limits = c(8, 28, 76, 81), 
        bathymetry = TRUE, shapefiles = "Svalbard",
        legends = FALSE, glaciers = TRUE) +
  geom_spatial_rect(aes (xmin = 11, xmax = 13, ymin = 78.85, ymax = 79.1), fill = NA, color = "red")  +
  geom_spatial_point(data = one_dot, aes(x = long, y = lat), color = "red") +
  annotation_scale(location = "br") + 
  annotation_north_arrow(location = "tl", which_north = "true")


map_3 <- basemap(limits = c(8, 28, 76, 81), 
                 bathymetry = TRUE, shapefiles = "Svalbard",
                 legends = FALSE, glaciers = TRUE) +
  geom_spatial_rect(aes (xmin = 11, xmax = 13, ymin = 78.85, ymax = 79.1), fill = NA, color = "red")  +
  geom_spatial_point(data = one_dot, aes(x = long, y = lat), color = "red") +
  annotation_scale(location = "br") + 
  annotation_north_arrow(location = "tl", which_north = "true")

basemap(limits = c(11.3, 12.5, 78.8, 79.1), bathymetry = TRUE, shapefiles = "Svalbard",
        legends = FALSE, glaciers = TRUE) +
  geom_spatial_point(data = one_dot, aes(x = long, y = lat), color = "red", size = 4)

map_4 <- basemap(limits = c(11.3, 12.5, 78.8, 79.1), bathymetry = TRUE, shapefiles = "Svalbard",
                 legends = FALSE, glaciers = TRUE) +
  geom_spatial_point(data = one_dot, aes(x = long, y = lat), color = "red", size = 4)



ggdraw() +
  draw_plot(map_3) +
  draw_plot(map_4, x = 0.05, y = 0.65, width = 0.3, height = 0.3)

# BONUS -------------------------------------------------------------------

# Create a workflow for creating a polar plot for any region

