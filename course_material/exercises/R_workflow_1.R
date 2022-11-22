#R_workflow_1
#21.11.2022

#convert excel file in .csv file

# Plot and combine t-test and ANOVA stats using sst_NOAA

#load sst_NOAA_luisa into R

library(tidyverse)


sst_NOAA <- read_csv("course_material/data/sst_NOAA_luisa.csv")
#Call your object the file name so you know where it came from

print(sst_NOAA)
view(sst_NOAA)
#now we only have one coloum instead of the original three

# Note what the 'deliminator' is
# Excel saves .csv with ; as deliminator
# R wants ,

#use read_csv2 to load csv files deliminated with ;
#sst_NOAA <- read_csv2("course_material/data/sst_NOAA_luisa.csv")
#print(sst_NOAA)
#view(sst_NOAA)
#this does not work with a german system

#we need to use read_delim function
sst_NOAA <- read_delim("course_material/data/sst_NOAA_luisa.csv", delim = ,)
print(sst_NOAA)
view(sst_NOAA)

#use the following function for everything 
#sst_NOAA <- read_delim("course_material/data/sst_NOAA_luisa.csv", delim = "\t")
#print(sst_NOAA)
#view(sst_NOAA)


#examine data

head(sst_NOAA)
#shows the first 6 lines of the dataset

tail(sst_NOAA)
#shows the last 6 lines of the dataset

tail(sst_NOAA, 2)
#shows the two last lines of the dataset


# Example -----------------------------------------------------------------

glimpse(sst_NOAA)
#shows the same as the blue arrow next to the dataset in the environment
#$ means coloms in R

str(sst_NOAA)

summary(sst_NOAA)

#try some plots

ggplot(data = sst_NOAA,
       aes(x = t, y = temp)) +
  geom_point(aes(colour = as.factor(site))) +
  # Discrete viridis colour palette
  scale_colour_viridis_d(option = "D")+
  facet_wrap(~ site, ncol = 1)+
  theme_classic()



# ANOVA -------------------------------------------------------------------


# First create a list of comparisons to feed into our figure

str(sst_NOAA)
sst_NOAA$site <- as.factor(sst_NOAA$site)
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

