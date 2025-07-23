################################################################################
## Date: 2025/07/23
## Author: Monika Kelley
## Purpose: quick intro
################################################################################



# 1) math ----------------------------------------------------------------------
3 * 3
(2)^4
2^4




# 2) assign values -------------------------------------------------------------

## Great Basin bristlecone pine (named Methuselah)
## can assign numbers to words
oldest_tree_age <- 4853
oldest_tree_age


## this doesn't really work
"oldest tree age" <- 4853

## this will work
methuselah <- "oldest tree"
methuselah



# 3) vectors -------------------------------------------------------------------

## making list of things = vector
weather <- c("rain", "wind", "hail")
weather

temperature <- c(98, 100, 99)
temperature

base_temp <- c(50, 50, 50)

# can do math with your vectors
temperature - base_temp



# 4) setting your session ------------------------------------------------------

## set where you want to work/ grab data on yer computer
## tab baby is king

setwd("~/git/intro/scripts")



# 5) upload your data ----------------------------------------------------------

## make data upload data
data_quick <- read.csv("../data/quick.csv")

## view your data
data_quick$height.m.
head(data_quick)
unique(data_quick$species)

## do some quick cool things with your data
mean(data_quick$height.m.)
median(data_quick$height.m.)
min(data_quick$age)
max(data_quick$age)


# 6) figures -------------------------------------------------------------------

## 6.a) packages and libraries -------------------------------------------------


## for making figures folks most commonly use "ggplot2" (Grammar of Graphics)
## in order to actually use it we need to load the package and the library




### packages - collection of function, data, code, storage place
### typically only have to do this once per computer
install.packages("ggplot2")

### libraries - directory call on your computer for the packages
### have to do this for all new R files
library(ggplot2)


## quickly look at some data we can manipulate

### Create some fake data data
data <- data.frame(
  name = c("A","B","C","D","E") ,  
  value = c(5,10,5,18,45)) # manipulate these numbers

### Barplot
ggplot(data, aes(x = name, y = value)) + 
  geom_bar(stat = "identity") # identity = plot raw data (no stats)


## 6.b) our data ---------------------------------------------------------------

### reminder of what our data looks like
head(data_quick)
colnames(data_quick)

### the code to make plots!
ggplot(data_quick, aes( x = species, y = height.m.)) + 
         geom_bar(stat = "identity")


## can do other cool things 
### color
ggplot(data_quick, aes( x = age, y = height.m., fill = species)) + 
  geom_bar(stat = "identity") + 
  facet_wrap( ~ species)


## swap stuff around
ggplot(data_quick, aes( x = age, y = height.m., fill = species)) + 
  geom_bar(stat = "identity") + 
  facet_wrap( ~ species)


## different graph types
ggplot(data_quick, aes( x = age, y = height.m., color = species)) + 
  geom_line(size = 3)


ggplot(data_quick, aes( x = age, y = height.m., fill = species)) + 
  geom_point()


## modify the way it looks
ggplot(data_quick, aes( x = age, y = height.m., color = species, 
                        size = height.m.)) + 
  geom_point()




# 7) real world data -----------------------------------------------------------

## load data -------------------------------------------------------------------
data_meta <- read.csv("~/git/intro/data/vst_metadata.csv")
data <- read.csv("../data/vst_data.csv")


## examine/ clean data ---------------------------------------------------------

head(data_meta)
head(data)

### lots of info, and data split between sheets so lets combine the data.
### easy way to do that is with the "dplyr" package

## load library/ packages
install.packages("dplyr")
library(dplyr)


## merge data together 
data_meta$individualID
data$individualID

## merged, "left_join" = keep all of "left data", and only the relevant "right data"
data_merged <- left_join(data, data_meta, by = "individualID" )


## figures ---------------------------------------------------------------------

colnames(data_merged)
data_merged$taxonID # shows all listed "taxon"
unique(data_merged$taxonID) # shows only the unique values
length(unique(data_merged$taxonID)) # how many unique species?



## lets show how species influences how big the stems are
data_merged$stemDiameter
ggplot(data_merged, aes(x = taxonID, y = stemDiameter)) +
  geom_bar(stat = "identity")

## anything odd about that figure? 
min(data_merged$stemDiameter)
max(data_merged$stemDiameter)

min(data_merged$stemDiameter, na.rm = TRUE)
max(data_merged$stemDiameter, na.rm = TRUE)


## geomboxplot
ggplot(data_merged, aes(x = taxonID, y = stemDiameter)) +
  geom_boxplot()
  

## geomboxplot
data_merged$stemDiameter
ggplot(data_merged, aes(x = taxonID, y = stemDiameter, fill = taxonID)) +
  geom_boxplot()


## just want to look at certain data
data_merged %>% 
  filter (taxonID == "CAAM2") %>%
  select(stemDiameter)


data_merged %>% 
  filter (taxonID == "QUST") %>%
  select(stemDiameter)


## cleaning data after review --------------------------------------------------
## don't want to plot any thing that has "NA" for the stem diameter 

data_merged_clean_diameter <- data_merged %>%
  filter(!is.na(stemDiameter))

## lets see what our new data looks like 
unique(data_merged$stemDiameter)
unique(data_merged_clean_diameter$stemDiameter)

# can also just ask R if that column has any "NA" values
any(is.na(data_merged$stemDiameter))
any(is.na(data_merged_clean_diameter$stemDiameter))


## figures part 2 --------------------------------------------------------------

## plot
ggplot(data_merged_clean_diameter, aes(x = taxonID, 
                                       y = stemDiameter, 
                                       fill = taxonID)) +
  geom_boxplot()



## lets further divide the data
unique(data_merged_clean_diameter$growthForm)

ggplot(data_merged_clean_diameter, aes(x = taxonID, 
                                       y = stemDiameter, 
                                       fill = taxonID)) +
  geom_boxplot() +
  facet_wrap( ~ growthForm)




## focus on "tree" growth forms 
## can filter data directly in the ggplot code
ggplot(data_merged_clean_diameter %>%
         filter(growthForm %in% c("small tree", "single bole tree", "multi-bole tree")),
       aes(x = taxonID, y = stemDiameter, fill = taxonID)) +
  geom_boxplot() +
  facet_wrap(~ growthForm) +
  theme(
    
  )


## make it fancy
ggplot(data_merged_clean_diameter %>%
         filter(growthForm %in% c("small tree", "single bole tree", "multi-bole tree")),
       aes(x = taxonID, y = stemDiameter, fill = taxonID)) +
  geom_boxplot() +
  facet_wrap(~ growthForm) +
  theme_bw() +
  theme(
    axis.text = element_text(size = 14, angle = 90), # axis tick labels
    axis.title = element_text(size = 16), # axis titles
    strip.text = element_text(size = 16), # facet titles
    legend.text = element_text(size = 14), # legend labels
    legend.title = element_text(size = 14)  # legend title
  ) +
  labs(
    title = "Stem Diameter by Taxon",
    x = "Taxon",
    y = "Stem Diameter"
  )


data_merged_clean$height

## plot other data
ggplot(data_merged_clean_diameter %>%
         filter(growthForm %in% c("small tree", "single bole tree", "multi-bole tree")),
       aes(x = taxonID, y = height, fill = taxonID)) +
  geom_boxplot() +
  facet_wrap(~ growthForm) +
  theme_bw() +
  theme(
    axis.text = element_text(size = 14, angle = 90), # axis tick labels
    axis.title = element_text(size = 16), # axis titles
    strip.text = element_text(size = 16), # facet titles
    legend.text = element_text(size = 14), # legend labels
    legend.title = element_text(size = 14)  # legend title
  ) +
  labs(
    title = "Height by Taxon",
    x = "Taxon",
    y = "Height"
  )



## plot other data
ggplot(data_merged,
       aes(x = taxonID, y = height, fill = taxonID)) +
  geom_boxplot() +
  theme_bw() +
  theme(
    axis.text = element_text(size = 14, angle = 90), # axis tick labels
    axis.title = element_text(size = 16), # axis titles
    strip.text = element_text(size = 16), # facet titles
    legend.text = element_text(size = 14), # legend labels
    legend.title = element_text(size = 14)  # legend title
  ) +
  labs(
    title = "Height by Taxon",
    x = "Taxon",
    y = "Height"
  )
