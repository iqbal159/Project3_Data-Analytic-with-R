#Setting working directory
setwd("C:/Users/jjf8yb/OneDrive - Aptiv/Desktop/New folder/BigData-PostClass/Coursera/CaseStudy/Data_Case_Study-1")

#Install and load library

install.packages("tidyverse") # data processing and analysis
install.packages("lubridate") # wrangle dates and times
install.packages("dplyr") # data manipulation and transformation
install.packages("ggplot2") # data visualization

library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)

#Import Data to R

Jan_22 <- read_csv("202201-divvy-tripdata.csv")
Feb_22 <- read_csv("202202-divvy-tripdata.csv")
Mar_22 <- read_csv("202203-divvy-tripdata.csv")
Apr_22 <- read_csv("202204-divvy-tripdata.csv")
May_22 <- read_csv("202205-divvy-tripdata.csv")
Jun_22 <- read_csv("202206-divvy-tripdata.csv")
Jul_22 <- read_csv("202207-divvy-tripdata.csv")
Aug_22 <- read_csv("202208-divvy-tripdata.csv")
Sep_22 <- read_csv("202209-divvy-tripdata.csv")
Oct_22 <- read_csv("202210-divvy-tripdata.csv")
Nov_22 <- read_csv("202211-divvy-tripdata.csv")
Dec_22 <- read_csv("202212-divvy-tripdata.csv")

#Check data structure for each dataset
glimpse(Jan_22)
glimpse(Feb_22)
glimpse(Mar_22)
glimpse(Apr_22)
glimpse(May_22)
glimpse(Jun_22)
glimpse(Jul_22)
glimpse(Aug_22)
glimpse(Sep_22)
glimpse(Oct_22)
glimpse(Nov_22)
glimpse(Dec_22)

##From the checking:Columns started_at and ended_at in Jan_22 data in character format.

# Change started_at, ended_at columns in Jan_22 from character to date format
Jan_22$started_at <- as.POSIXct(Jan_22$started_at, format = "%m/%d/%Y %H:%M")
Jan_22$ended_at <- as.POSIXct(Jan_22$ended_at, format = "%m/%d/%Y %H:%M")

#Check again Jan_22 dataset
glimpse(Jan_22)

#Combines all the dataset
trips_2022 <- rbind(Jan_22, Feb_22, Mar_22, Apr_22, May_22, Jun_22,
                    Jul_22, Aug_22, Sep_22, Oct_22, Nov_22, Dec_22)

#Write combined data frame as csv
write.csv(trips_2022, "trips2022_all_raw.csv")

#Checking the new dataset characteristics
head(trips_2022) #see the first 6 rows of the data frame
nrow(trips_2022) #how many rows are in the data frame
colnames(trips_2022) #list of column names
dim(trips_2022) #dimensions of the data frame
summary(trips_2022) #statistical summary of data, mainly for numerics
str(trips_2022) #see list of columns and data types
glimpse(trips_2022) # displays the column name,data type,data values,additional information
tail(trips_2022) #see the last 6 rows of the data frame

#Remove unnecessary columns
trips_2022 <- select(trips_2022, -c("start_lat","start_lng","end_lat","end_lng"))

#Check that all ride ids are unique
n_distinct(trips_2022$ride_id) == nrow(trips_2022)

#Adding columns for date, month, year, day of the week into the data frame.
trips_2022$date <- as.Date(trips_2022$started_at) 
trips_2022$month <- format(as.Date(trips_2022$date), "%m")
trips_2022$day <- format(as.Date(trips_2022$date), "%d")
trips_2022$year <- format(as.Date(trips_2022$date), "%Y")
trips_2022$day_of_week <- format(as.Date(trips_2022$date), "%A")

#Create column ride_length for duration
trips_2022$ride_length_sec <- as.numeric(trips_2022$ended_at - trips_2022$started_at)

#Check the names of all the new columns
colnames(trips_2022) 

#Removed rows which had negative ride_length
cleantrips_22 <- trips_2022 %>%
  filter(ride_length_sec > 0)

#Removed any rides that were shorter than 1 minute and longer than 24 hours
cleantrips_22 <- cleantrips_22 %>%
  filter(ride_length_sec > 60, ride_length_sec < 60*60*24)

#Check again the "ride_length_sec" dataset
summary(cleantrips_22$ride_length_sec)

#Remove rows with NA values 
cleantrips_22 <- na.omit(cleantrips_22)

#remove duplicate rows
cleantrips_22 <- distinct(cleantrips_22) 

dim(cleantrips_22)

#Write clean data frame as csv
write.csv(cleantrips_22, "trips2022_cleaned.csv")