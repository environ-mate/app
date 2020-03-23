########## Data Preparation for Environ-Mate Web App ##########

##### Setup #####

# set working directory to /app/

# load libraries
library(tidyverse)



##################################################



##### Topics

# temperature
# emissions
# extreme weather



##################################################



##### Temperature #####

### european average temperatures over land areas relative to the pre-industrial period in degrees celcius
# download csv from https://www.eea.europa.eu/data-and-maps/daviz/european-average-air-temperature-anomalies-9#tab-chart_9
# rename file to european_land_temperature_deviations_annual_raw.csv
# move to ../app/data/raw_data/temperature/

# load, process and write data
read_csv("data/raw_data/temperature/european_land_temperature_deviations_annual_raw.csv",
         col_names = c("year", "temperature.deviation.degree.celcius", "type"),
         col_types = "i--n---c-",
         skip = 1) %>% 
  filter(type == "European annual") %>% 
  select(-type) %>% 
  write_csv("public/data/temperature/european_land_temperature_deviations_annual.csv")



##################################################



##### Emissions #####



##################################################



##### Extreme weather #####

### extreme weather occurences europe
# download csv from https://www.emdat.be/emdat_db/
# period: 1900 to most recent full year
# location: continent -> europe
# disasters classification: natural
# group results by: country name, disaster type and year
# rename file to extreme_weather_occurrences_europe_raw.csv
# move to ../app/data/raw_data/extreme_weather/

# load and process data (include climate related disasters only and exlude sparse pre-1960 data)
extreme_weather_occurrences_europe_since_1960 <- read_csv("data/raw_data/extreme_weather/extreme_weather_occurrences_europe_raw.csv",
                                                          col_names = c("country.name", "disaster.type", "year", "occurrence", "total.deaths", "total.damage.thousand.dollars"),
                                                          col_types = "-cciii----n",
                                                          skip = 2) %>% 
  head(-2) %>% 
  filter(year >= 1960) %>% 
  mutate(total.damage.million.dollars = total.damage.thousand.dollars / 1000) %>% 
  select(-total.damage.thousand.dollars) %>% 
  filter(disaster.type %in% c("Drought", "Extreme temperature", "Flood", "Landslide", "Storm", "Wildfire")) %>% 
  mutate_all(~replace(., is.na(.), 0))

# sum of total damages
sum(extreme_weather_occurrences_europe_since_1960$total.damage.million.dollars)
# 313,116 billion dollars

# sum of total deaths
sum(extreme_weather_occurrences_europe_since_1960$total.deaths)
# 162054

# calculate sum of disaster type occurrence per year
extreme_weather_occurrences_europe_since_1960 %>% 
  select(country.name, disaster.type, year, occurrence) %>% 
  spread(disaster.type, occurrence,
         fill = 0) %>% 
  rename(drought.occurrence = Drought,
         extreme.temperature.occurrence = `Extreme temperature`,
         flood.occurrence = Flood,
         landslide.occurrence = Landslide,
         storm.occurrence = Storm,
         wildfire.occurrence = Wildfire) %>% 
  group_by(year) %>% 
  summarise(drought.occurrence = sum(drought.occurrence),
            extreme.temperature.occurrence = sum(extreme.temperature.occurrence),
            flood.occurrence = sum(flood.occurrence),
            landslide.occurrence = sum(landslide.occurrence),
            storm.occurrence = sum(storm.occurrence),
            wildfire.occurrence = sum(wildfire.occurrence)) %>% 
  mutate_all(~replace(., is.na(.), 0)) %>% 
  arrange(year) %>% 
  write_csv("public/data/extreme_weather/extreme_weather_occurrences_europe_since_1960.csv")



##################################################