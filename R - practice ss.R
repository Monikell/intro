3*3
A<-5
B<-10
A+B
weather <- c("rain", "wind", "hail")
weather

temperature <- c(98, 100, 99)
temperature 

base_temp <- c(50, 50, 50)
temperature - base_temp

#setting your session
setwd("~/git/intro/scripts")

data_quick <- read.csv("../data/quick.csv")
data_quick$height.m.
head(data_quick)
unique(data_quick$species)

# anaylize data
mean(data_quick$height.m.)
median(data_quick$height.m.)
min(data_quick$age)
max(data_quick$age)

#figures 

#packages and libraries 

#ggplot2

install.packages("ggplot2")
library(ggplot2)

data <- data.frame(
  name = c("A", "B", "C", "D", "E"),
  value = c(5, 10, 100, 18, 45))
#making a bar plot 
ggplot(data, aes(x = name, y = value)) +
  geom_bar(stat = "identity")

#that was fake data gonna use real data

ggplot(data_quick, aes( x=species, y= height.m.))+
  geom_bar(stat= "identity")

ggplot(data_quick, aes( x=species, y= height.m., fill = species))+
  geom_bar(stat= "identity")
facet_wrap(~species)
 # seperating bar by species 
# seperating bar by color 
# seperating bar by line size

ggplot(data_quick, aes( x=age, y= height.m., color = species))+
geom_line(size = 3)

#realworld data VSTDATA

data_meta<-
read.csv("~/git/intro/data/vst_metadata.csv")
data <- read.csv("../data/vst_data.csv")

#examine and clean data

install.packages("dplyr")
library(dplyr)


data_merged <- left_join(data, data_meta, by = "individualID")


unique(data_merged$taxonID)
length(unique(data_merged$taxonID))
# count species above
# below we are creating a bar graph 

ggplot(data_merged, aes(x = taxonID, y = stemDiameter)) + 
  geom_bar(stat = "identity")

# with real world data you will get NA values
min(data_merged$stemDiameter, na.rm = TRUE)
max(data_merged$stemDiameter, na.rm = TRUE)

# geom blox plot 

ggplot(data_merged, aes(x = taxonID, y = stemDiameter))+
  geom_boxplot()
#color 

ggplot(data_merged, aes(x = taxonID, y = stemDiameter, fill = taxonID)) +
  geom_boxplot()

#FILTERING?? 

data_merged %>%
  filter (taxonID == "CAAM2") %>%
  select(stemDiameter)

data_merged %>%
  filter (taxonID == "QUST") %>%
  select(stemDiameter)

#clean data after review 

data_merged_clean_diameter <- data_merged %>%
  filter(!is.na(stemDiameter))
 # printing clean data 
ggplot(data_merged_clean_diameter, aes(x = taxonID,
                                       y = stemDiameter,
                                       fill = taxonID)) + geom_boxplot()
        
ggplot(data_merged_clean_diameter, aes(x = taxonID,
                                       y = stemDiameter,
                                       fill = taxonID)) + geom_boxplot() + 
facet_wrap(~growthForm)

#can directly filter the ggplot code 
ggplot(data_merged_clean_diameter %>%
         filter(growthForm %in% c("small tree", "single bole tree", "multiple-bole")),
       aes(x = taxonID, y = stemDiameter, fill = taxonID)) +
  geom_boxplot() +
  facet_wrap(~ growthForm) + 
  theme (
    
    
  )
  








