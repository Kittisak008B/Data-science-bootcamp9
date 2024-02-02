## homework data-transform

library(nycflights13)
## nycflights13 This package contains information about all flights that departed from NYC (e.g. EWR, JFK and LGA) 
## to destinations in the United States, Puerto Rico, and the American Virgin Islands) in 2013: 336,776 flights in total. 
## To help understand what causes delays, it also includes a number of other useful datasets.

library(tidyverse) 

## Ask questions about this datasets
data("flights")
data("airlines")
data("airports")
data("planes")
data("weather")

## Q1. most flight carrier in Sep 2013
flights %>%
  filter(month == 9, year == 2013) %>%
  count(carrier) %>%
  arrange(desc(n)) %>%
  head(5) %>%
  left_join(airlines)

## Q2. find avg departure delay and avg arrival delay for each airlines
flights %>% 
  filter(arr_delay > 0 & arr_delay != "NA" & dep_delay > 0 & dep_delay != "NA") %>%
  group_by(carrier) %>% 
  summarise(avg_arr_delay = mean(arr_delay, na.rm = TRUE),
            avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  arrange(desc(avg_arr_delay)) %>%
  left_join(airlines,by= "carrier")

## clean data

#Number of departures getting cancelled or NA
print(sum(is.na(flights$dep_time)))
print(sum(is.na(flights$dep_delay)))

#remove all NA values from flights dataset.
flights_clean <- flights %>% 
  filter(!is.na(arr_delay), !is.na(dep_delay))

print(sum(is.na(flights_clean$dep_time)))
print(sum(is.na(flights_clean$dep_delay)))
print(sum(is.na(flights_clean$arr_delay)))

## Q3. avg departure delays and avg arrival delay by month with flights per month
flights_per_m <- flights_clean %>% 
  group_by(month) %>%
  count(month) 
colnames(flights_per_m)[2] ="flights per month"

flights_clean %>% 
  filter(arr_delay>0 & dep_delay>0) %>% 
  group_by(month) %>% 
  summarise(avg_arr_delay = mean(arr_delay),
            avg_dep_delay = mean(dep_delay)) %>% 
  left_join(flights_per_m,by= "month")

## Q4. avg departure delays and avg arrival delay by weekdays
flights_clean %>% 
  mutate(weekdays = weekdays(time_hour)) %>%
  filter(arr_delay>0 & dep_delay>0) %>% 
  group_by(weekdays) %>%
  summarise(avg_arr_delay = mean(arr_delay),
            avg_dep_delay = mean(dep_delay)) %>% 
  arrange(desc(avg_arr_delay))

## Q5. avg departure delays by different destination
avg_delays_dest <- flights_clean %>% 
  filter(arr_delay>0 & dep_delay>0) %>%
  group_by(dest) %>% 
  summarise(avg_distance = mean(distance, na.rm = TRUE),avg_dep_delay = mean(dep_delay)) %>% 
  arrange(desc(avg_distance)) 

avg_delays_dest %>% 
  head(10)

##Q6. The route with the most frequent flights with avg departure delays and avg_distance 
route01 <- flights_clean %>% 
  group_by(origin,dest) %>%
  summarise(count=n()) %>% 
  arrange(desc(count)) %>% 
  left_join(avg_delays_dest, by= "dest") 
  
route01 %>% 
  head(10)

##Q7. Number of flights and Average flight distance for each airlines
n_of_flights <- flights_clean %>% 
  count(carrier) %>%
  arrange(desc(n))

flights_clean %>%
  group_by(carrier) %>%
  summarise( avg_distance = mean(distance)) %>%
  arrange(desc(avg_distance)) %>% 
  left_join(n_of_flights, by= "carrier") %>% 
  left_join(airlines, by= "carrier")  

##Q8. average speed for each airlines
#speed in the unit of miles per hour  
flights_clean %>%
  mutate(speed = distance /(air_time / 60) ) %>%
  group_by(carrier) %>%
  summarise(avg_speed = mean(speed)) %>%
  arrange(desc(avg_speed)) %>%
  left_join(airlines, by= "carrier")

##Q9. average speed for different route
flights_clean %>%
  mutate(speed = distance /(air_time / 60) ) %>%
  group_by(origin,dest) %>%
  summarise(avg_speed = mean(speed)) %>%
  arrange(desc(avg_speed)) %>% 
  head(10)

##Q10. find the oldest passenger aircraft models that were still use in 2013

flights_clean %>%
  select(tailnum) %>% 
  left_join(planes, by = "tailnum") %>% 
  arrange(year) %>% 
  distinct(tailnum) %>% 
  pull()

flights_clean %>% 
  filter(tailnum %in% c('N381AA')) %>% 
  select(tailnum,flight,time_hour) 

planes %>% 
  filter(tailnum %in% c('N381AA'))
## The oldest passenger aircraft models that were still use in 2013 is N381AA
## This aircraft has an operational lifespan of 57 years (2013-1956).

##Q11. aggregate function related to weather conditions
weather %>% 
  select(origin) %>%
  distinct(origin) %>% 
  pull()

airports %>% 
  filter(faa %in% c("JFK", "EWR","LGA")) %>% 
  left_join(weather, by = c("faa" = "origin")) %>%
  group_by(faa) %>% 
  summarise(avg_temp=mean(temp, na.rm = T),avg_humid=mean(humid, na.rm = T),
            avg_wind_speed=mean(wind_speed, na.rm = T),
            avg_pressure=mean(pressure, na.rm = T))













