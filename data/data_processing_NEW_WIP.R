########## Data Preparation for Environ-Mate Web App ##########

##### Setup #####

# set working directory to /app/data/

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
# move to ../app/data/raw_data/temperature/

# load, process and write temperature data
read_csv("raw_data/temperature/european-average-air-temperature-anomalies-9.csv",
         col_names = c("year", "temperature.deviation.degree.celcius", "type"),
         col_types = "i--n---c-",
         skip = 1) %>% 
  filter(type == "European annual") %>% 
  select(-type) %>% 
  write_csv("processed_data/temperature/european_land_temperature_deviations_annual.csv")



##################################################



##### Emissions #####



##################################################



##### Extreme weather #####



##################################################