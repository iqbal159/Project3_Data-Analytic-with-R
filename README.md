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

Below are the summary of the analyze items of the processes: 

1. Average Ride Length for Casual and Member Riders
- To compare daily average usage of bikes for Casual and Member Riders

![1  Average Ride Duration](https://github.com/iqbal159/Project3_Data-Analytic-with-R/assets/130142247/db76910c-cd40-4350-a04d-145c0c7720c8)

2. Daily Number of Rides for Casual and Member Riders
- To compare total number of rides taken by Casual and Member Riders

![2  Number of Daily Rides](https://github.com/iqbal159/Project3_Data-Analytic-with-R/assets/130142247/85afe6ee-7838-4592-a715-bc6fe4c385a7)

3. Type of Rides
- To differentiate type of bikes used by Casual and Member Riders
  
![3  Number of Rides with Type of Bikes](https://github.com/iqbal159/Project3_Data-Analytic-with-R/assets/130142247/dab93d64-39c6-454e-9bc9-b3c1fbbace1a)

4. Monthly Number of Rides
- To compare daily average usage of bikes for Casual and Member Riders

 ![4  Monthly Number of Rides](https://github.com/iqbal159/Project3_Data-Analytic-with-R/assets/130142247/b209fff9-ca97-4cd6-8bf6-e2e3986f58e7)

5. Most used station by both user types
- Top 5 most used stations by all the users

![5  Top 5 Most Used Stations](https://github.com/iqbal159/Project3_Data-Analytic-with-R/assets/130142247/e3c26819-33dc-4aff-b04e-4f48ef21d385)

## PHASE 5: Share
Microsoft PowerPoint is used for data visualization and presenting key insights.
- Click [here](https://github.com/iqbal159/Project3_Data-Analytic-with-R/blob/230118305ee92581cf1bc19f1abd2eae48fc5e3a/Cyclistic%20Bike%20Share%20Case_Study.pptx) to download the presentation.

## PHASE 6: Act
Based on 5 analyze points in the [Analyze Phase](https://github.com/iqbal159/Project3_Data-Analytic-with-R/blob/d90bf7a4cc6e255c4e0ed48236c21a8c86be19ed/PHASE%204%20-%20Analyzing%20Data.R) above, we reached to the following conclusion:
- Casual riders use bikes for longer period of times on daily basis compare to Members.
- Member Riders are mostly used bike on weekday, probably to commute for work, whereas Casual riders mostly use bikes on weekends, probably for recreational purposes.
- Classic bikes are the most use as type of rides, followed by electric bikes. But, only Casual members use docked bike.
- Based on monthly analysis, middle of the year is the most number of rides, and the trend becomes lower towards early and end of the year
- Based on our 5 most start station used, 4 of them are used by Casual riders.

Here are my top 3 recommendations based on above key findings:

Insight 1) 
- If riders are charged on duration basis, offer special membership discount coupons for more longer rides duration as casual riders spent more time on the bikes. This can encourage them to sign for membership

Insight 2) 
- Design a package for recreational activities on the weekend, targeting for the casual riders. 

Insight 3) 
- Classic bikes is popular than electric bikes for both users. But only casual riders are using docked bike.  Focusing suitable campaigns on docked bike might convert some casual riders to members

Insight 4) 
- Mid year especially May to Oct shows significance number of rides for casual riders. Channeling correct advertisement during this timeline can attract more casual riders to become members

Insight 5) 
- 4 of the most used as start stations are use by casual riders. Increase proper advertisement at this stations to attract more casual riders join as members

Thank you!
