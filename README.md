# Project3_Data-Analytic-with-R
## **Cyclistic Bike-Share Case Study : How Does a Bike-Share Navigate Speedy Success?**
_This document is created as part of the capstone project of the Google Data Analytics Professional Certificate._


## Overview
Cyclistic: A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day. 

The marketing director of Cyclistic, a bike-share company in Chicago, believes the company’s future success depends on maximizing the number of annual memberships. Therefore, this analysis is to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, we will design a new marketing strategy to convert casual riders into annual members. 

## About the Company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.

**Cyclistic pricing plans:** <br>
single-ride passes _(Casual riders)_ <br>
full-day passes _(Casual riders)_ <br>
annual memberships. _(Cyclistic membership)_ <br> 

## **PHASE 1: Ask** 
**Problem statements:**
 1. The differences between casual riders and annual members using the Cyclistic bikes?
 2. Why would casual riders buy Cyclistic annual memberships?
 3. How to influence casual riders to become annual members?

**Business Task**
  - To identify how do annual members and casual riders use Cyclistic bikes differently.
  - The analysis will later be use to develop a marketing strategy to convert casual riders into annual members



**Stakeholders:**

- Primary stakeholders: The director of marketing and Cyclistic executive team
- Secondary stakeholders: Cyclistic marketing analytics team

## **PHASE 2: Data Preparation**

Cyclistic’s historical trip data. This data consist of 12 dataset from each month in 2022:
  - [Link](https://divvy-tripdata.s3.amazonaws.com/index.html)  - analyzed period 01/22’ ~ 12/22’ <br>
_(Note: The datasets have a different name because Cyclistic is a fictional company. The data has been made available by Motivate International Inc. under this [license](https://ride.divvybikes.com/data-license-agreement).)_

  - The dataset consists of 12 CSV files (each for a month) with 13 columns and more than 4 million rows.

ROCCC approach is used to determine the credibility of the data

-   **R**eliable – It is complete and accurate and it represents all bike rides taken in the city of Chicago for the selected duration of our analysis.
-   **O**riginal - The data is made available by Motivate International Inc. which operates the city of Chicago’s Divvy bicycle sharing service which is powered by Lyft.
-   **C**omprehensive - the data includes all information about ride details including starting time, ending time, station name, station ID, type of membership and many more.
-   **C**urrent – It is up-to-date as it includes data until end of Dec 2022
-   **C**ited - The data is cited and is available under Data License Agreement.

## **PHASE 3: Process**

Before we start analyzing, it is necessary to make sure data is clean, free of error and in the right format.
### **Tasks:**

 **1. Tools:** R Programming is used for its ability to handle huge datasets efficiently. Microsoft Excel is used for further analysis and visualization. 

 - Install and Load packages in R
 
 install.packages("tidyverse")
 install.packages("lubridate")
 library(tidyverse)
 library(lubridate)

 **2. Organize**: 

 - Import Data to R
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

- Check data structure for each dataset
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

*From the checking: Columns "started_at" and "ended_at" in Jan_22 data in character format.*

- Change started_at, ended_at columns in Jan_22 from character to date format
Jan_22$started_at <- as.POSIXct(Jan_22$started_at, format = "%m/%d/%Y %H:%M")
Jan_22$ended_at <- as.POSIXct(Jan_22$ended_at, format = "%m/%d/%Y %H:%M")

- Check again Jan_22 dataset
glimpse(Jan_22)

- Combines all the dataset
trips_2022 <- rbind(Jan_22, Feb_22, Mar_22, Apr_22, May_22, Jun, Jul_22, Aug_22, Sep_22, Oct_22, Nov_22, Dec_22)

- Checking the new dataset characteristics
head(trips_2022) #see the first 6 rows of the data frame
nrow(trips_2022) #how many rows are in the data frame
colnames(trips_2022) #list of column names
dim(trips_2022) #dimensions of the data frame
summary(trips_2022) #statistical summary of data, mainly for numerics
str(trips_2022) #see list of columns and data types
glimpse(trips_2022) # displays the column name,data type,data values,additional information
tail(trips_2022) #see the last 6 rows of the data frame

- Write combined data frame as csv
write.csv(trips_2022, "trips2022_all_raw.csv")

**3. Preparing for analysis**

- Remove unnecessary columns
trips_2022 <- select(trips_2022, -c("start_lat","start_lng","end_lat","end_lng"))

- Check that all ride ids are unique
n_distinct(trips_2022$ride_id) == nrow(trips_2022)

- Adding columns for date, month, year, day of the week into the data frame.
trips_2022$date <- as.Date(trips_2022$started_at) 
trips_2022$month <- format(as.Date(trips_2022$date), "%m")
trips_2022$day <- format(as.Date(trips_2022$date), "%d")
trips_2022$year <- format(as.Date(trips_2022$date), "%Y")
trips_2022$day_of_week <- format(as.Date(trips_2022$date), "%A")

- Add column called “ride_length" and calculated the length of each ride
trips_2022$ride_length_sec <- as.numeric(trips_2022$ended_at - trips_2022$started_at)

- Check the names of all the new columns
colnames(trips_2022) 

**4. Check and clean data for errors**

- Removed rows which had negative ride_length
	>cleantrips_22 <- trips_2022 %>%
  	   >filter(ride_length_sec > 0)
 
- Removed any rides that were shorter than 1 minute and longer than 24 hours
	>cleantrips_22 <- cleantrips_22 %>% <br>
  	   >filter(ride_length_sec > 60, ride_length_sec < 60*60*24)

- Check again the "ride_length_sec" column
	>summary(cleantrips_22$ride_length_sec)

- Remove rows with NA values 
	cleantrips_22 <- na.omit(cleantrips_22)

- Remove duplicate rows
	cleantrips_22 <- distinct(cleantrips_22)

- Check new dimension of cleaned dataset
dim(cleantrips_22)

- Write clean data frame as csv
	write.csv(cleantrips_22, "trips2022_cleaned.csv")

**As summary: Raw data have 5667717 rows and 13 columns ; New clean dataset have 4291190 rows and 15 columns

## PHASE 4: Analyzing Data
Performed data aggregation using R Programming.
- Click [here](https://github.com/skramazan/GDA_Capstone_Project_Cyclistic_Bike-share/blob/main/02.%20Analysis/analysis_script.R) to view the R script and the summary of complete analysis process.

Further analysis were carried out to perform calculations, identify trends and relationships using PivotTable and Charts on Microsoft Excel.

 - Click [here](https://github.com/skramazan/GDA_Capstone_Project_Cyclistic_Bike-share/tree/main/02.%20Analysis) to view individual Excel files used for analysis

## PHASE 5: Share
Microsoft PowerPoint is used for data visualization and presenting key insights.
- Click [here](https://github.com/skramazan/GDA_Capstone_Project_Cyclistic_Bike-share/tree/main/03.%20Presentation) to download the presentation.

## PHASE 6: Act
After analizing, we reached to the following conclusion:
- Casual riders take less number of rides but for longer durations.
- Casual Riders are most active on weekends, and the months of June and July.
- Casual riders mostly use bikes for recreational purposes.

Here are my top 3 recommendations based on above key findings:
1. Design riding packages by keeping recreational activities, weekend contests, and summer events in mind and offer special discounts and coupons on such events to encourage casual riders get annual membership.

2. Design seasonal packages, It allows flexibility and encourages casual riders to get membership for specific periods if they are not willing to pay for annual subscription.

3. Effective and efficient promotions by targeting casual riders at the busiest times and stations:
	- Days: Weekends
	- Months: February, June, and July
	- Stations: Streeter Dr & Grand Ave, Lake Shore Dr & Monroe St, Millennium Park


***Thanks for reading and Happy Analyzing!*** :smiley: :bar_chart:

 


