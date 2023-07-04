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