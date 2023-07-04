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
 2. How to influence casual riders to become annual members?

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
Click [PHASE 3 - Processing Data.R](https://github.com/iqbal159/Project3_Data-Analytic-with-R/blob/53de26bad755876937c10ef79f7e0ddc24f9904c/PHASE%203%20-%20Processing%20Data.R) for R coding of this section.

Below are the summary of the processes: 

 **1. Tools:** R Programming is used for its ability to handle huge datasets efficiently. 

 - Install and Load packages in R

 **2. Organize**: 

 - Import Data from csv dataset to R
 - Check data structure for each dataset

*From the checking: Columns "started_at" and "ended_at" in Jan_22 data is in character format.*

- Change "started_at", "ended_at" columns in Jan_22 from character to date format
- Check again Jan_22 dataset to make sure the format is correct
- Combines all the datasets to become one dataset
- Checking the new dataset characteristics and columns
- Write combined data frame as new raw csv files

**3. Preparing for analysis**

- Remove unnecessary columns for analysis
- Check that all ride ids are unique to make sure no repetitive data
- Adding columns for date, month, year, day of the week into the data frame.
- Add column called “ride_length" and calculated the length of each ride
- Check the names of all the new columns to make sure we have all the columns necessary for analysis

**4. Check and clean data for errors**

- Removed rows which had negative ride_length, which should be impossible
- Removed any rides that were shorter than 1 minute and longer than 24 hours
- Check again the "ride_length_sec" column to confirm our data within the timeframe
- Remove rows with NA values 
- Remove any duplicate rows
- Check new dimension of cleaned dataset
- Write clean data frame as new csv

**As summary: Raw data have 5667717 rows and 13 columns and our new clean dataset now have 4291190 rows and 15 columns

## PHASE 4: Analyzing Data
Performed data aggregation using R Programming. <br>
Click [PHASE 4 - Analyzing Data.R](https://github.com/iqbal159/Project3_Data-Analytic-with-R/blob/53de26bad755876937c10ef79f7e0ddc24f9904c/PHASE%204%20-%20Analyzing%20Data.R) for R coding of this section.

Below are the summary and analyze items of the processes: 

#1. Average ride length for casual and member riders
Avg_ride_length <- cleantrips_22 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>% 
  summarize(number_of_rides = n(), average_duration = mean((ride_length_sec)/60)) %>% 
  arrange(member_casual, weekday) %>% 
  ggplot(aes(x=weekday, y=average_duration, fill=member_casual)) +
  geom_col(position = "dodge") +
  labs(
    title = "Average Ride Duration",
    subtitle = "Members vs Casual Riders",
    x = "User type", 
    y = "Average ride duration (minutes)",
    fill = "User type") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

Avg_ride_length

#2. Daily Number of Rides
daily_trips <- cleantrips_22 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarize(number_of_rides = n()
            ,average_duration = mean(ride_length_sec)) %>% 
  arrange(member_casual, weekday)  %>%
  ggplot(aes(x=weekday, y=number_of_rides, fill=member_casual))+
  geom_col(position="dodge") +
  labs(
    title = "Number of Daily Rides",
    subtitle = "Members vs Casual Riders",
    x = "User type", 
    y = "Number of rides",
    fill = "User type") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

daily_trips

#3. Type of Rides
cleantrips_22 %>% 
  group_by(member_casual, rideable_type) %>%
  summarize(num_rides = n()) %>% 
  mutate(percent_rides = 100* num_rides/sum(num_rides))

bike_type <- cleantrips_22 %>% 
  group_by(rideable_type, member_casual) %>% 
  filter(rideable_type == "classic_bike" | rideable_type == "electric_bike" | rideable_type == "docked_bike") %>% 
  summarize(number_of_rides = n()
            ,average_duration = mean(ride_length_sec)) %>% 
  arrange(member_casual) %>% 
  ggplot(aes(x=member_casual, y=number_of_rides, fill=rideable_type)) +
  geom_col(position = "dodge") +
  labs(
    title = "Number of Rides with Type of Bikes",
    subtitle = "Members vs Casual Riders",
    x = "Membership type", 
    y = "Number of rides",
    fill = "Bike type", 
    labels = c("classic_bike", "electric_bike", "docked_bike")) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

bike_type

#4. Monthly Number of Rides
ggplot(data = cleantrips_22) +
  geom_bar(mapping = aes(x = month, fill = member_casual), position = "dodge") +
  labs(title="Monthly Ridership Trends", subtitle="Members vs Casual Riders", fill = "Rider Type") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) 

#5. Most used station by both user types
top_stations <- cleantrips_22 %>%
  count(start_station_name, member_casual, name = "number_of_rides") %>%
  arrange(desc(number_of_rides)) %>%
  head(5) %>%
  ggplot(aes(x = number_of_rides, y = start_station_name, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Top 5 Most Used Stations", x = "Number of Rides", y = "Stations", fill = "Member Type")

top_stations

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

 


