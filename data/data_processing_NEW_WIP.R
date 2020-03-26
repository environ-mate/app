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

### european average temperatures over land areas relative to the pre-industrial period in degrees celcius 1880 to 2018
# download csv from https://www.eea.europa.eu/data-and-maps/daviz/european-average-air-temperature-anomalies-9#tab-chart_9
# rename file to european_land_temperature_deviations_annual_raw.csv
# move to ../app/data/raw_data/temperature/

# load, process and write data
col_names <- c("year",
               "temperature.deviation.degree.celcius",
               "type")

read_csv("data/raw_data/temperature/european_land_temperature_deviations_annual_raw.csv",
         col_names = col_names,
         col_types = "i--n---c-",
         skip = 1) %>% 
  filter(type == "European annual") %>% 
  select(-type) %>% 
  write_csv("public/data/temperature/european_land_temperature_deviations_annual.csv")



##################################################



##### Greenhouse Gas Emissions #####



### ghg emissions total and per sector europe 1985 to 2017
# download zipped csv from https://www.eea.europa.eu/data-and-maps/data/national-emissions-reported-to-the-unfccc-and-to-the-eu-greenhouse-gas-monitoring-mechanism-15
# extract and rename file to ghg_emissions_total_and_per_sector_europe_raw.csv
# move to ../app/data/raw_data/ghg_emissions/

col_names <- c("country.name",
               "ghg.emissions.giga.tonnes",
               "pollutant.name",
               "sector.name",
               "year")

ghg_emissions_total_and_per_sector_europe_raw <- read_csv("data/raw_data/ghg_emissions/ghg_emissions_total_and_per_sector_europe_raw.csv",
                                                      col_names = col_names,
                                                      col_types = "--c-n---c-c-c",
                                                      skip = 1) %>% 
  filter(!(country.name %in% c("EU (KP)")) & 
         pollutant.name == "All greenhouse gases - (CO2 equivalent)" & 
         sector.name %in% c("1 - Energy", "1.A.3 - Transport", "2 - Industrial Processes and Product Use", "3 - Agriculture", "5 - Waste management", "Total (without LULUCF, without indirect CO2)") & 
         !(year %in% c("1985-1987", "1985", "1986", "1987", "1988", "1989"))) %>% 
  mutate(country.name = case_when(
    country.name == "EU28 (Convention)" ~ "EU28",
    country.name == "United Kingdom (Convention)" ~ "UK",
    country.name == "Czechia" ~ "Czech Republic",
    TRUE ~ country.name)) %>% 
  mutate(year = as.integer(year)) %>% 
  mutate(sector.name = case_when(
    sector.name == "1 - Energy" ~ "energy",
    sector.name == "1.A.3 - Transport" ~ "transport",
    sector.name == "2 - Industrial Processes and Product Use" ~ "industry",
    sector.name == "3 - Agriculture" ~ "agriculture",
    sector.name == "5 - Waste management" ~ "waste",
    sector.name == "Total (without LULUCF, without indirect CO2)" ~ "total")) %>% 
  mutate(ghg.emissions.mio.tonnes = round(ghg.emissions.giga.tonnes / 1000, 1)) %>% 
  select(country.name,
         year,
         sector.name,
         ghg.emissions.mio.tonnes) %>% 
  arrange(country.name,
          year,
          sector.name) %>% 
  spread(sector.name, ghg.emissions.mio.tonnes) %>% 
  mutate(energy = energy - transport)



##################################################



### ghg emissions per capita europe 1990 to 2017
# download zipped tsv from https://ec.europa.eu/eurostat/web/products-datasets/-/sdg_13_10
# extract and rename file to ghg_emissions_per_capita_europe_raw.tsv
# move to ../app/data/raw_data/ghg_emissions/

# load and process data
ghg_emissions_per_capita_europe_raw <- read_tsv("data/raw_data/ghg_emissions/ghg_emissions_per_capita_europe_raw.tsv") %>% 
  separate(`indic_env,geo\\time`, c("indicator", "country.code"), sep = ",") %>% 
  filter(indicator == "GHG_T_HAB") %>% 
  mutate(country.name = case_when(
    country.code == "AT" ~ "Austria",
    country.code == "BE" ~ "Belgium",
    country.code == "BG" ~ "Bulgaria",
    country.code == "CH" ~ "Switzerland",
    country.code == "CY" ~ "Cyprus",
    country.code == "CZ" ~ "Czech Republic",
    country.code == "DE" ~ "Germany",
    country.code == "DK" ~ "Denmark",
    country.code == "EE" ~ "Estonia",
    country.code == "ES" ~ "Spain",
    country.code == "EU" | country.code == "EU28" ~ "EU28",
    country.code == "FI" ~ "Finland",
    country.code == "FR" ~ "France",
    country.code == "GB" | country.code == "UK" ~ "UK",
    country.code == "GR" | country.code == "EL" ~ "Greece",
    country.code == "HR" ~ "Croatia",
    country.code == "HU" ~ "Hungary",
    country.code == "IE" ~ "Ireland",
    country.code == "IS" ~ "Iceland",
    country.code == "IT" ~ "Italy",
    country.code == "LI" ~ "Liechtenstein",
    country.code == "LT" ~ "Lithuania",
    country.code == "LU" ~ "Luxembourgh",
    country.code == "LV" ~ "Latvia",
    country.code == "MT" ~ "Malta",
    country.code == "NL" ~ "Netherlands",
    country.code == "NO" ~ "Norway",
    country.code == "PL" ~ "Poland",
    country.code == "PT" ~ "Portugal",
    country.code == "RO" ~ "Romania",
    country.code == "SE" ~ "Sweden",
    country.code == "SI" ~ "Slovenia",
    country.code == "SK" ~ "Slovakia",
    country.code == "TR" ~ "Turkey",
    TRUE ~ NA_character_)) %>% 
  filter(country.code != "EU27_2020")

# # extract and process ghg emissions total indexed
# ghg_emissions_total_indexed <- ghg_emissions_total_and_per_capita_europe_raw %>% 
#   filter(indicator == "GHG_I90") %>% 
#   gather("year", "ghg.emissions.total.indexed", 3:30) %>% 
#   select(country.name,
#          year,
#          ghg.emissions.total.indexed) %>% 
#   arrange(country.name,
#           year) %>% 
#   mutate(year = as.integer(year)) %>% 
#   mutate(ghg.emissions.total.indexed = as.numeric(ghg.emissions.total.indexed))

# extract and process ghg emissions per capita
ghg_emissions_per_capita <- ghg_emissions_per_capita_europe_raw %>% 
  filter(indicator == "GHG_T_HAB") %>% 
  gather("year", "ghg.emissions.per.capita.tonnes", 3:30) %>% 
  select(country.name,
         year,
         ghg.emissions.per.capita.tonnes) %>% 
  arrange(country.name,
          year) %>% 
  mutate(year = as.integer(year)) %>% 
  mutate(ghg.emissions.per.capita.tonnes = str_replace(ghg.emissions.per.capita.tonnes, "b", "")) %>% 
  mutate(ghg.emissions.per.capita.tonnes = str_replace(ghg.emissions.per.capita.tonnes, "e", "")) %>% 
  mutate(ghg.emissions.per.capita.tonnes = str_replace(ghg.emissions.per.capita.tonnes, "p", "")) %>% 
  mutate(ghg.emissions.per.capita.tonnes = as.numeric(ghg.emissions.per.capita.tonnes))



##################################################



### ghg emissions projections total and per sector europe 2014 to 2040
# download latest and checked projections as zipped csv from https://www.eea.europa.eu/data-and-maps/data/greenhouse-gas-emission-projections-for-6
# extract and rename file to ghg_emissions_projections_total_and_per_sector_europe_raw.csv
# move to ../app/data/raw_data/ghg_emissions/

# load and process data (select most recent full year, categories and scenario)
col_names <- c("country.code",
               "year",
               "category",
               "category.name",
               "scenario",
               "gas",
               "ghg.emissions.kilo.tonnes.co2e")

ghg_emissions_projections_total_and_per_sector_europe_raw <- read_csv("data/raw_data/ghg_emissions/ghg_emissions_projections_total_and_per_sector_europe_raw.csv",
                                                                      col_names = col_names,
                                                                      col_types = "ci-cccc--n",
                                                                      skip = 1) %>% 
  filter(year == 2019 & 
         category.name == "Total w.out LULUCF" & 
         scenario == "WEM" & 
         gas == "Total GHGs (ktCO2e)") %>% 
  mutate(country.name = case_when(
    country.code == "AT" ~ "Austria",
    country.code == "BE" ~ "Belgium",
    country.code == "BG" ~ "Bulgaria",
    country.code == "CH" ~ "Switzerland",
    country.code == "CY" ~ "Cyprus",
    country.code == "CZ" ~ "Czech Republic",
    country.code == "DE" ~ "Germany",
    country.code == "DK" ~ "Denmark",
    country.code == "EE" ~ "Estonia",
    country.code == "ES" ~ "Spain",
    country.code == "EU" | country.code == "EU28" ~ "EU28",
    country.code == "FI" ~ "Finland",
    country.code == "FR" ~ "France",
    country.code == "GB" | country.code == "UK" ~ "UK",
    country.code == "GR" | country.code == "EL" ~ "Greece",
    country.code == "HR" ~ "Croatia",
    country.code == "HU" ~ "Hungary",
    country.code == "IE" ~ "Ireland",
    country.code == "IS" ~ "Iceland",
    country.code == "IT" ~ "Italy",
    country.code == "LI" ~ "Liechtenstein",
    country.code == "LT" ~ "Lithuania",
    country.code == "LU" ~ "Luxembourgh",
    country.code == "LV" ~ "Latvia",
    country.code == "MT" ~ "Malta",
    country.code == "NL" ~ "Netherlands",
    country.code == "NO" ~ "Norway",
    country.code == "PL" ~ "Poland",
    country.code == "PT" ~ "Portugal",
    country.code == "RO" ~ "Romania",
    country.code == "SE" ~ "Sweden",
    country.code == "SI" ~ "Slovenia",
    country.code == "SK" ~ "Slovakia",
    country.code == "TR" ~ "Turkey",
    TRUE ~ NA_character_)) %>% 
  mutate(ghg.emissions.kilo.tonnes.co2e = round(ghg.emissions.kilo.tonnes.co2e / 1000, 1)) %>% 
  select(country.name,
         year,
         category,
         category.name,
         ghg.emissions.kilo.tonnes.co2e)

### todo
# select correct sectors (agriculture, energy, industry, total, transport, waste and other)
# compute per capita emissions in tonnes
# compute ghg emissions in mio tonnes per sector for each country
# compute national share ghg emissions per sector for each country
# compute Eu28 share ghg emissions per sector for each country
# compute rank based on total emissions in mio tonnes



##################################################



#
# Plot confidence intervals for future projections
#
#
library(ggplot2)
data <- read.csv("public/data/future-greenhouse-gas-emission-scenarios.csv", header=T)
#data[,-c(1,2)] <- apply(data[,-c(1,2)], 2, function(x) ifelse(x<0, 0, x))


# MEDIAN of last entry for label positioning
# no climate policies: 4.1-4.8?C - 128.9
# current policies: 3.1-3.7?C    - 62.75
# pledges: (2.6-3.2?C)           - 41.67
# pathway: 2?C                   - 2.97
# pathway: 1.5?C                 - -5.46


# plot
alpha = 0.6
image <- ggplot(data=data)+  
  geom_line(aes(x = Year, y = Historic..billion.tonnes.CO..equivalent.), color = "black")+
  geom_ribbon(aes(x = Year, ymin= No.climate.policies..low...billion.tonnes.CO..equivalent., ymax =  No.climate.policies..high...billion.tonnes.CO..equivalent.), fill= "#fb6a4a", alpha = alpha)+  
  geom_ribbon(aes(x = Year, ymin= Current.policies..low...billion.tonnes.CO..equivalent., ymax =  Current.policies..high...billion.tonnes.CO..equivalent.), fill= "#9e9ac8", alpha = alpha)+ 
  geom_ribbon(aes(x = Year, ymin= Pledges..low...billion.tonnes.CO..equivalent., ymax =  Pledges..high...billion.tonnes.CO..equivalent.), fill= "#fed976", alpha = alpha)+ 
  geom_ribbon(aes(x = Year, ymin= X2C.pathways..low...billion.tonnes.CO..equivalent., ymax =  X2C.pathways..high...billion.tonnes.CO..equivalent.), fill= "#74c476", alpha = alpha)+ 
  geom_ribbon(aes(x = Year, ymin= X1.5C.pathways..low...billion.tonnes.CO..equivalent., ymax =  X1.5C.pathways..high...billion.tonnes.CO..equivalent.), fill= "#67a9cf", alpha = alpha)+ 
  ylim(-10,200) + xlim(1990,2100)+
  theme_bw()+ 
  theme(axis.text=element_text(size=14))+
  #theme (panel.border = element_blank()) + geom_hline(yintercept=0) + geom_vline(xintercept=1990) + 
  labs(y="Gt CO2", x="t")+
  scale_y_continuous(sec.axis=dup_axis(name=" ", breaks=c(-5.46, 2.97,41.67,62.75,128.9), labels=c("1.5?C","2?C","2.6-3.2?C","3.1-3.7?C","4.1-4.8?C")))

#save the plot as png
ggsave(file="public/assets/emission_projection_2100.png", plot=image, width=12, height=6)  



##################################################



##### Extreme weather #####

### extreme weather occurences europe
# sign up at and download csv from https://www.emdat.be/emdat_db/
# period: 1900 to most recent full year
# location: continent -> europe
# disasters classification: natural
# group results by: country name, disaster type and year
# rename file to extreme_weather_occurrences_europe_raw.csv
# move to ../app/data/raw_data/extreme_weather/

# load and process data (include climate related disasters only and exlude sparse pre-1960 data)
col_names <- c("country.name",
               "disaster.type",
               "year",
               "occurrence",
               "total.deaths",
               "total.damage.thousand.dollars")

extreme_weather_occurrences_europe_since_1960 <- read_csv("data/raw_data/extreme_weather/extreme_weather_occurrences_europe_raw.csv",
                                                          col_names = col_names,
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