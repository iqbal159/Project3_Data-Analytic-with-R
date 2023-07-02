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

	# Install and Load packages in R
 install.packages("tidyverse")
 install.packages("lubridate")
 library(tidyverse)
 library(lubridate)

**2. Organize**: 

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

 #Combines all the dataset
 trips_2022 <- rbind(Jan_22, Feb_22, Mar_22, Apr_22, May_22, Jun, Jul_22, Aug_22, Sep_22, Oct_22, Nov_22, Dec_22)

**3. Sampling**: Due to limitation in computational power and efficiency purposes, I had to take a random sample without replacement out of 4,073,561 observations. Sample size is calculated as follow:
 - Population size: 4,073,561
 - Confidence level: 99.99%
 - Margin of Error: 0.2
 - Sample size: 767,554

       >df <-read_csv("combined_datasets.csv",col_types=cols(start_station_id=col_character(),end_station_id = col_character()))
       >sample_df <- sample_n(df, 767554, replace=F)
       >write_csv(sample_df, "sample_dataset.csv")


**4. Preparing for analysis**

- Added column called “ride_length and calculated the length of each ride
- Added new columns to calculate the following for each ride.
	- Date
	- Year
	- Month
	- Day
	- Day of the week
 - These columns provide additional opportunities to aggregate the data.

		>df$date <- as.Date(df$started_at) df$year <- format(as.Date(df$date), "%Y") 
		>df$month <- format(as.Date(df$date), "%m") 
		>df$day <- format(as.Date(df$date), "%d")
		>df <- df %>% 
		>  mutate(ride_length = ended_at - started_at) %>%   
		>  mutate(day_of_week = weekdays(as.Date(df$started_at)))

**5. Check data for errors**: A quick sorting and filtering shows that in 1931 rows, there is a negative difference between two time periods (started_at and ended_at) which logically isn’t possible.
	Removed the rows where trip duration is negative.

	>df <- df %>%   
		filter(ride_length > 0)

**6. Clean column names and checked for duplicate records in rows.**

    >df <- df %>%    
	    clean_names() %>%    
	    unique()
    # Export cleaned df to a new csv 
    write_csv(df,"2020-2021_divvy-tripdata_cleaned.csv")


