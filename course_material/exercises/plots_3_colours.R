# Roundtrip FACE-IT 2022-11-21
# plots_3_colours_R
# Luisa Düsedau
# 21.11.2022


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(RColorBrewer)
library(palmerpenguins)


# Data --------------------------------------------------------------------

# Load the dataset into the local environment
penguins <- penguins


# Example -----------------------------------------------------------------

# Discrete viridis colour palette
# viridis is the best colour palette to use because everyone could be able to see it

ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = as.factor(year))) +
  scale_colour_viridis_d(option = "A")

ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = as.factor(year))) +
  scale_colour_viridis_d(option = "B")

ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = as.factor(year))) +
  scale_colour_viridis_d(option = "C")

ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = as.factor(year))) +
  scale_colour_viridis_d(option = "D") #most used in publications

# Compare species
ggplot(data = penguins, aes(x = species, y = bill_length_mm)) +
  geom_boxplot(aes(fill = species), show.legend = F) +
  stat_compare_means(method = "anova")
#show.legend = F stands for show legend FALSE, we have a legend for species already on the x axis and don't need an additional one 

# Exercise 1 --------------------------------------------------------------

# Create your own continuous and discrete colour palettes

#1. continuous colour palette
#http://tristen.ca/hcl-picker/#/hlc/6/0.95/48B4B6/345363

#2B3B4C,#24525F,#1D6A6A,#2B826C,#4E9967,#7CAD5C
#2B3B4B,#25525E,#1F6A6A,#2C826C,#4F9967,#7CAD5D

colour_plot_1 <- ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = bill_depth_mm)) +
  scale_colour_gradientn(colours = c("#2B3B4B", "#25525E", "#1F6A6A", "#2C826C", "#4F9967", "#7CAD5D"))

#2. discrete colour palette
#http://medialab.github.io/iwanthue/

#99a154
#ca5937
#70ba86
#98665d
#a9cc40

colour_plot_2 <- ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = as.factor(sex))) +
  # How to use custom palette
  scale_colour_manual(values = c("#ca5937", "#a9cc40"),
                      # How to change the legend text
                      labels = c("female", "male", "other")) + 
  # How to change the legend title
  labs(colour = "Sex") 

# Create and combine two figures, each using a different palette

# List the names of the plot objects to combine 
grid_colours <- ggarrange(colour_plot_1, colour_plot_2,
                    # Set number of rows and columns
                    ncol = 2, nrow = 1,
                    # Label each figure
                    labels = c("a)", "b)"),
                    # Set legend position
                    legend = "bottom")
grid_colours

# Exercise 2 --------------------------------------------------------------

# Create two versions of the same figure and combine
# Use a viridis colour palette against a default palette in a way that 
# allows features in the data to be more pronounced

print(penguins)

#For discrete values####
#FACTORS!!!#
#1. Bodymass vs finnlenght over species

#default
colour_plot_3 <- ggplot(data = penguins,
       aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(colour = as.factor(species))) 


#viridis colour palette
colour_plot_4 <- ggplot(data = penguins,
       aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(colour = as.factor(species))) +
  scale_colour_viridis_d(option = "D")
#scale_colour_viridis_d -> d for discrete!

#2. Bill length vs. bill depth over island

#default
colour_plot_5 <- ggplot(data = penguins,
                        aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = as.factor(island))) 

colour_plot_5

#viridis colour palette
colour_plot_6 <- ggplot(data = penguins,
                        aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = as.factor(island))) +
  scale_colour_viridis_d(option = "D")
#scale_colour_viridis_d -> d for discrete!

colour_plot_6

#Combine  plots

grid_colours_2 <- ggarrange(colour_plot_3, colour_plot_4, colour_plot_5, colour_plot_6,
                          # Set number of rows and columns
                          ncol = 2, nrow = 2,
                          # Label each figure
                          labels = c("A", "B", "C", "D"),
                          # Set legend position
                          legend = "bottom")
grid_colours_2

#For continious values####
#1. Bodymass vs finnlenght over bill_length_mm

#default
colour_plot_7 <- ggplot(data = penguins,
                        aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(colour = bill_length_mm)) 

colour_plot_7

#viridis colour palette

colour_plot_8 <- ggplot(data = penguins,
                        aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(colour = bill_length_mm)) +
  scale_colour_viridis_c(option = "D")
#scale_colour_viridis_c -> c for continiuos!

colour_plot_8


#2. Bodymass vs sex over flipper length

#default
colour_plot_9 <- ggplot(data = penguins,
                        aes(x = sex, y = body_mass_g)) +
  geom_point(aes(colour = flipper_length_mm)) 

colour_plot_9

#viridis colour palette

colour_plot_10 <- ggplot(data = penguins,
                        aes(x = sex, y = body_mass_g)) +
  geom_point(aes(colour = flipper_length_mm)) +
  scale_colour_viridis_c(option = "D")
#scale_colour_viridis_c -> c for continiuos!

colour_plot_10


#Combine  plots

grid_colours_3 <- ggarrange(colour_plot_7, colour_plot_8, colour_plot_9, colour_plot_10,
                            # Set number of rows and columns
                            ncol = 1, nrow = 4,
                            # Label each figure
                            labels = c("A)", "B)", "C)", "D)"),
                            # Set legend position
                            legend = "bottom")
grid_colours_3

# Exercise 3 --------------------------------------------------------------

# Plot and combine t-test and ANOVA stats 
# See this site for more info on plotting stats:
# http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/76-add-p-values-and-significance-levels-to-ggplots/

#getwd()

#read.csv(file = 'course_material/data/sst_NOAA.csv')

# Do t-test and ANOVA with compare_means
# t-test
compare_means(body_mass_g ~ sex, data = penguins, method = "t.test")


# ANOVA
compare_means(body_mass_g ~ species, data = penguins, method = "anova")

#Plot statistics, default
ggplot(data = penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot(aes(fill = species), show.legend = F) +
  stat_compare_means(method = "anova")

#Plot better
ggplot(data = penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot(aes(fill = species), show.legend = F) +
  stat_compare_means(method = "anova", 
                     aes(label = paste0("p ", ..p.format..)), 
                     label.x = 2) +
  theme_bw()

stat_compare_means()

# Multiple means
# First create a list of comparisons to feed into our figure
penguins_levels <- levels(penguins$species)
my_comparisons <- list(c(penguins_levels[1], penguins_levels[2]), 
                       c(penguins_levels[2], penguins_levels[3]),
                       c(penguins_levels[1], penguins_levels[3]))


# All together_Robert -----------------------------------------------------

# First create a list of comparisons to feed into our figure
penguins_levels <- levels(penguins$species)
my_comparisons <- list(c(penguins_levels[1], penguins_levels[2]), 
                       c(penguins_levels[2], penguins_levels[3]),
                       c(penguins_levels[1], penguins_levels[3]))

# Then we stack it all together
ggplot(data = penguins, aes(x = species, y = bill_length_mm)) +
  geom_boxplot(aes(fill  = species), colour = "grey40", show.legend = F) +
  stat_compare_means(method = "anova", colour = "grey50",
                     label.x = 1.8, label.y = 32) +
  # Add pairwise comparisons p-value
  stat_compare_means(comparisons = my_comparisons,
                     label.y = c(62, 64, 66)) +
  # Perform t-tests between each group and the overall mean
  stat_compare_means(label = "p.signif", 
                     method = "t.test",
                     ref.group = ".all.") + 
  # Add horizontal line at base mean
  geom_hline(yintercept = mean(penguins$bill_length_mm, na.rm = T), 
             linetype = 2) + 
  labs(y = "Bill length (mm)", x = NULL) +
  theme_bw()


# All_together_Luisa ------------------------------------------------------



# First create a list of comparisons to feed into our figure

penguins$year <- as.factor(penguins$year)
penguins_levels_year <- levels(penguins$year)
print(penguins_levels_year)

my_comparisons_years <- list(c(penguins_levels_year[1], penguins_levels_year[2]), 
                       c(penguins_levels_year[2], penguins_levels_year[3]),
                       c(penguins_levels_year[1], penguins_levels_year[3]))

# ANOVA
compare_means(body_mass_g ~ year, data = penguins, method = "anova")

# Then we stack it all together
ggplot(data = penguins, aes(x = year, y = body_mass_g)) +
  geom_boxplot(aes(fill  = year), colour = "grey40", show.legend = F) +
  stat_compare_means(method = "anova", colour = "grey50",
                     label.x = 1.8, label.y = 32) + #position of the label (ANOVA output) on the x axis
  # Add pairwise comparisons p-value
  stat_compare_means(comparisons = my_comparisons_years,
                     label.y = c(62, 64, 66)) +
  # Perform t-tests between each group and the overall mean
  stat_compare_means(label = "p.signif", 
                     method = "t.test",
                     ref.group = ".all.") + 
  # Add horizontal line at base mean
  geom_hline(yintercept = mean(penguins$body_mass_g, na.rm = T), 
             linetype = 2) + 
  labs(y = "Body mass (g)", x = NULL) +
  theme_bw()

#not significant


# All_togehter_islands ----------------------------------------------------

# First create a list of comparisons to feed into our figure

penguins$island <- as.factor(penguins$island)
penguins_levels_island <- levels(penguins$island)
print(penguins_levels_island)

my_comparisons_island <- list(c(penguins_levels_island[1], penguins_levels_island[2]), 
                             c(penguins_levels_island[2], penguins_levels_island[3]),
                             c(penguins_levels_island[1], penguins_levels_island[3]))

# ANOVA
compare_means(body_mass_g ~ island, data = penguins, method = "anova")

# Then we stack it all together
ggplot(data = penguins, aes(x = island, y = body_mass_g)) +
  geom_boxplot(aes(fill  = island), colour = "grey40", show.legend = F) +
  stat_compare_means(method = "anova", colour = "grey50",
                     label.x = 1.8, label.y = 32) + #position of the label (ANOVA output) on the x axis
  # Add pairwise comparisons p-value
  stat_compare_means(comparisons = my_comparisons_island,
                     label.y = c(7300, 7600, 7900)) +
  # Perform t-tests between each group and the overall mean
  stat_compare_means(label = "p.signif", 
                     method = "t.test",
                     ref.group = ".all.") + 
  # Add horizontal line at base mean
  geom_hline(yintercept = mean(penguins$body_mass_g, na.rm = T), 
             linetype = 2) + 
  labs(y = "Body mass (g)", x = NULL) +
  theme_bw()

# BONUS -------------------------------------------------------------------

# Create a correlogram

