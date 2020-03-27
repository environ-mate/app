########## Data Preparation for Environ-Mate Web App ##########

##### Setup #####

# set working directory to /app/

# path to raw data
path <- "data/raw_data/"

# load libraries
library(tidyverse)



##################################################



##### Topics

# annual average temperature deviations europe
# greenhouse gas emissions europe
# extreme weather occurrences



##################################################



##### Temperature #####

### european average temperatures over land areas relative to the pre-industrial period in degrees celcius 1880 to 2018 (HadCRUT4)
# download csv from https://www.eea.europa.eu/data-and-maps/daviz/european-average-air-temperature-anomalies-9#tab-chart_9
# rename file to european_land_temperature_deviations_annual_raw.csv
# move to ../app/data/raw_data/temperature/

# load data, select model and filter measurement type
column_names <- c("year",
                  "temperature.deviation.degree.celcius",
                  "type")

read_csv(paste0(path, "temperature/european_land_temperature_deviations_annual_raw.csv"),
         col_names = column_names,
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

# load data, filter countries, sectors and years and transform ghg emissions per sector
column_names <- c("country.name",
                  "ghg.emissions.giga.tonnes",
                  "pollutant.name",
                  "sector.name",
                  "year")

ghg_emissions_total_and_per_sector_europe <- read_csv(paste0(path, "ghg_emissions/ghg_emissions_total_and_per_sector_europe_raw.csv"),
                                                      col_names = column_names,
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
    sector.name == "1 - Energy" ~ "ghg.emissions.energy.mio.tonnes",
    sector.name == "1.A.3 - Transport" ~ "ghg.emissions.transport.mio.tonnes",
    sector.name == "2 - Industrial Processes and Product Use" ~ "ghg.emissions.industry.mio.tonnes",
    sector.name == "3 - Agriculture" ~ "ghg.emissions.agriculture.mio.tonnes",
    sector.name == "5 - Waste management" ~ "ghg.emissions.waste.mio.tonnes",
    sector.name == "Total (without LULUCF, without indirect CO2)" ~ "ghg.emissions.total.mio.tonnes")) %>% 
  mutate(ghg.emissions.mio.tonnes = round(ghg.emissions.giga.tonnes / 1000, 1)) %>% 
  select(country.name,
         year,
         sector.name,
         ghg.emissions.mio.tonnes) %>% 
  spread(sector.name, ghg.emissions.mio.tonnes) %>% 
  mutate(ghg.emissions.energy.mio.tonnes = ghg.emissions.energy.mio.tonnes - ghg.emissions.transport.mio.tonnes)



##################################################



### ghg emissions per capita europe 1990 to 2017
# download zipped tsv from https://ec.europa.eu/eurostat/web/products-datasets/-/sdg_13_10
# extract and rename file to ghg_emissions_per_capita_europe_raw.tsv
# move to ../app/data/raw_data/ghg_emissions/

# load data, filter indicator and countries and transform ghg emissions per capita
ghg_emissions_per_capita_europe <- read_tsv(paste0(path, "ghg_emissions/ghg_emissions_per_capita_europe_raw.tsv")) %>% 
  separate(`indic_env,geo\\time`, c("indicator", "country.code"), sep = ",") %>% 
  filter(indicator == "GHG_T_HAB" & 
         country.code != "EU27_2020") %>% 
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
    country.code == "LU" ~ "Luxembourg",
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
    country.code == "TR" ~ "Turkey")) %>% 
  gather("year", "ghg.emissions.per.capita.tonnes", 3:30) %>% 
  select(country.name,
         year,
         ghg.emissions.per.capita.tonnes) %>% 
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

# load data, select years, categories, scenario and gas and transform ghg emissions projections
column_names <- c("country.code",
                  "year",
                  "category",
                  "scenario",
                  "gas",
                  "ghg.emissions.kilo.tonnes.co2e")

ghg_emissions_projections_total_and_per_sector_europe <- read_csv(paste0(path, "ghg_emissions/ghg_emissions_projections_total_and_per_sector_europe_raw.csv"),
                                                                  col_names = column_names,
                                                                  col_types = "ci-c-cc--n",
                                                                  skip = 1) %>% 
  filter(year %in% c(2018, 2019, 2020, 2030, 2040) & 
         category %in% c("Total w.out LULUCF", "1.", "1.A.3.", "2.", "3.", "5.") & 
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
    country.code == "LU" ~ "Luxembourg",
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
    country.code == "TR" ~ "Turkey")) %>% 
  mutate(category = case_when(
    category == "1." ~ "ghg.emissions.energy.mio.tonnes",
    category == "1.A.3." ~ "ghg.emissions.transport.mio.tonnes",
    category == "2." ~ "ghg.emissions.industry.mio.tonnes",
    category == "3." ~ "ghg.emissions.agriculture.mio.tonnes",
    category == "5." ~ "ghg.emissions.waste.mio.tonnes",
    category == "Total w.out LULUCF" ~ "ghg.emissions.total.mio.tonnes")) %>% 
  mutate(ghg.emissions.mio.tonnes = round(ghg.emissions.kilo.tonnes.co2e / 1000, 1)) %>% 
  select(country.name,
         year,
         category,
         ghg.emissions.mio.tonnes) %>% 
  spread(category, ghg.emissions.mio.tonnes) %>% 
  mutate(ghg.emissions.energy.mio.tonnes = ghg.emissions.energy.mio.tonnes - ghg.emissions.transport.mio.tonnes)



### population europe 1975 to 2019 to compute ghg emissions projections per capita for 2018 and 2019
# download zipped tsv from https://ec.europa.eu/eurostat/web/products-datasets/-/namq_10_pe
# extract and rename file to population_europe_raw.tsv
# move to ../app/data/raw_data/population/

# load data, select indicators and countries and compute mean population for 2018 and 2019 per country
population_europe <- read_tsv(paste0(path, "population/population_europe_raw.tsv")) %>% 
  separate(`unit,s_adj,na_item,geo\\time`, c("unit", "s_adj", "na_item", "geo"), sep = ",") %>% 
  filter(unit == "THS_PER" & 
         s_adj == "NSA" & 
         na_item == "POP_NC" & 
         !(geo %in% c("EA", "EA12", "EA19", "EU15", "EU27_2020", "RS"))) %>% 
  select(geo,
         `2019Q4`,
         `2019Q3`,
         `2019Q2`,
         `2019Q1`,
         `2018Q4`,
         `2018Q3`,
         `2018Q2`,
         `2018Q1`) %>% 
  mutate(country.name = case_when(
    geo == "AT" ~ "Austria",
    geo == "BE" ~ "Belgium",
    geo == "BG" ~ "Bulgaria",
    geo == "CH" ~ "Switzerland",
    geo == "CY" ~ "Cyprus",
    geo == "CZ" ~ "Czech Republic",
    geo == "DE" ~ "Germany",
    geo == "DK" ~ "Denmark",
    geo == "EE" ~ "Estonia",
    geo == "ES" ~ "Spain",
    geo == "EU" | geo == "EU28" ~ "EU28",
    geo == "FI" ~ "Finland",
    geo == "FR" ~ "France",
    geo == "GB" | geo == "UK" ~ "UK",
    geo == "GR" | geo == "EL" ~ "Greece",
    geo == "HR" ~ "Croatia",
    geo == "HU" ~ "Hungary",
    geo == "IE" ~ "Ireland",
    geo == "IS" ~ "Iceland",
    geo == "IT" ~ "Italy",
    geo == "LI" ~ "Liechtenstein",
    geo == "LT" ~ "Lithuania",
    geo == "LU" ~ "Luxembourg",
    geo == "LV" ~ "Latvia",
    geo == "MT" ~ "Malta",
    geo == "NL" ~ "Netherlands",
    geo == "NO" ~ "Norway",
    geo == "PL" ~ "Poland",
    geo == "PT" ~ "Portugal",
    geo == "RO" ~ "Romania",
    geo == "SE" ~ "Sweden",
    geo == "SI" ~ "Slovenia",
    geo == "SK" ~ "Slovakia",
    geo == "TR" ~ "Turkey")) %>% 
  gather("year.quarter", "population.thousands", 2:9) %>% 
  mutate(population.mio = round(as.numeric(str_replace_all(population.thousands, "[^0-9.-]", "")) / 1000, 1)) %>% 
  separate(year.quarter, c("year", "quarter"), sep = "Q") %>% 
  mutate(year = as.integer(year)) %>% 
  group_by(country.name,
           year) %>% 
  summarise(population.mio = round(mean(population.mio, na.rm = TRUE), 1))

# # population Luxembourg 1995 to 2017
# population_luxembourg <- read_tsv(paste0(path, "population/population_europe_raw.tsv")) %>% 
#   separate(`unit,s_adj,na_item,geo\\time`, c("unit", "s_adj", "na_item", "geo"), sep = ",") %>% 
#   filter(unit == "THS_PER" & 
#            s_adj == "NSA" & 
#            na_item == "POP_NC" & 
#            geo == "LU") %>% 
#   gather("year.quarter", "population.thousands", 5:184) %>% 
#   separate(year.quarter, c("year", "quarter"), sep = "Q") %>% 
#   mutate(country.name = "Luxembourg") %>%
#   mutate(year = as.integer(year)) %>% 
#   filter(year >= 1990 & 
#            year <= 2017) %>% 
#   mutate(population.thousands = case_when(
#     year == 1990 ~ "382",
#     year == 1991 ~ "386",
#     year == 1992 ~ "391",
#     year == 1993 ~ "397",
#     year == 1994 ~ "402",
#     TRUE ~ population.thousands)) %>% 
#   group_by(country.name,
#            year) %>% 
#   summarise(population.mio = round(mean(as.numeric(population.thousands) / 1000), 1))



### population projections europe 2018 to 2100 to compute ghg emissions projections per capita for 2020, 2030 and 2040
# download zipped tsv from https://ec.europa.eu/eurostat/web/products-datasets/-/tps00002
# extract and rename file to population_projections_europe_raw.tsv
# move to ../app/data/raw_data/population/

population_projections_europe <- read_tsv(paste0(path, "population/population_projections_europe_raw.tsv")) %>% 
  separate(`projection,unit,sex,age,geo\\time`, c("projection", "unit", "sex", "age", "geo"), sep = ",") %>% 
  filter(sex == "T" & 
         !(geo %in% c("EA19", "EU27_2020"))) %>% 
  mutate(country.name = case_when(
    geo == "AT" ~ "Austria",
    geo == "BE" ~ "Belgium",
    geo == "BG" ~ "Bulgaria",
    geo == "CH" ~ "Switzerland",
    geo == "CY" ~ "Cyprus",
    geo == "CZ" ~ "Czech Republic",
    geo == "DE" ~ "Germany",
    geo == "DK" ~ "Denmark",
    geo == "EE" ~ "Estonia",
    geo == "ES" ~ "Spain",
    geo == "EU" | geo == "EU28" ~ "EU28",
    geo == "FI" ~ "Finland",
    geo == "FR" ~ "France",
    geo == "GB" | geo == "UK" ~ "UK",
    geo == "GR" | geo == "EL" ~ "Greece",
    geo == "HR" ~ "Croatia",
    geo == "HU" ~ "Hungary",
    geo == "IE" ~ "Ireland",
    geo == "IS" ~ "Iceland",
    geo == "IT" ~ "Italy",
    geo == "LI" ~ "Liechtenstein",
    geo == "LT" ~ "Lithuania",
    geo == "LU" ~ "Luxembourg",
    geo == "LV" ~ "Latvia",
    geo == "MT" ~ "Malta",
    geo == "NL" ~ "Netherlands",
    geo == "NO" ~ "Norway",
    geo == "PL" ~ "Poland",
    geo == "PT" ~ "Portugal",
    geo == "RO" ~ "Romania",
    geo == "SE" ~ "Sweden",
    geo == "SI" ~ "Slovenia",
    geo == "SK" ~ "Slovakia",
    geo == "TR" ~ "Turkey")) %>% 
  select(country.name,
         `2020`,
         `2030`,
         `2040`) %>% 
  gather("year", "population", 2:4) %>% 
  mutate(year = as.integer(year)) %>% 
  mutate(population.mio = round(population / 1000000, 1)) %>% 
  select(-population)



### put everything together

# # Luxembourg
# luxembourg <- ghg_emissions_total_and_per_sector_europe %>% 
#   filter(country.name == "Luxembourg") %>% 
#   left_join(population_luxembourg, by = c("country.name", "year")) %>% 
#   mutate(ghg.emissions.per.capita.tonnes = round(ghg.emissions.total.mio.tonnes / population.mio, 1)) %>% 
#   select(-population.mio)
  
# projections
ghg_emissions_projections <- population_europe %>% 
  bind_rows(population_projections_europe) %>% 
  right_join(ghg_emissions_projections_total_and_per_sector_europe, by = c("country.name", "year")) %>% 
  mutate(ghg.emissions.per.capita.tonnes = round(ghg.emissions.total.mio.tonnes / population.mio, 1)) %>% 
  select(-population.mio)

# everything
ghg_emissions <- ghg_emissions_total_and_per_sector_europe %>% 
  # filter(country.name != "Luxembourg") %>% 
  # bind_rows(luxembourg) %>% 
  left_join(ghg_emissions_per_capita_europe, by = c("country.name", "year")) %>% 
  bind_rows(ghg_emissions_projections)



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