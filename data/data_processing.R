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

# load data, select model and filter measurement type
column_names <- c("year", "temperature.deviation.degree.celcius", "type")

read_csv("https://www.eea.europa.eu/data-and-maps/daviz/european-average-air-temperature-anomalies-9/download.csv",
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
column_names <- c("country.name", "ghg.emissions.giga.tonnes", "pollutant.name", "sector.name", "year")

ghg_emissions_total_and_per_sector_europe <- read_csv(paste0(path, "ghg_emissions/ghg_emissions_total_and_per_sector_europe_raw.csv"),
                                                      col_names = column_names,
                                                      col_types = "--c-n---c-c-c",
                                                      skip = 1) %>% 
  filter(!(country.name %in% c("EU (KP)")) & 
         pollutant.name == "All greenhouse gases - (CO2 equivalent)" & 
         sector.name %in% c("1 - Energy",
                            "1.A.3 - Transport",
                            "2 - Industrial Processes and Product Use",
                            "3 - Agriculture",
                            "5 - Waste management",
                            "Total (without LULUCF, without indirect CO2)") & 
         !(year %in% c("1985-1987", "1985", "1986", "1987", "1988", "1989"))) %>% 
  mutate(country.name = case_when(
    country.name == "EU28 (Convention)" ~ "EU28",
    country.name == "United Kingdom (Convention)" ~ "UK",
    country.name == "Czechia" ~ "Czech Republic",
    TRUE ~ country.name)) %>% 
  mutate(year = as.integer(year)) %>% 
  mutate(sector.name = case_when(
    sector.name == "1 - Energy" ~ "energy.ghg.emissions.mio.tonnes",
    sector.name == "1.A.3 - Transport" ~ "transport.ghg.emissions.mio.tonnes",
    sector.name == "2 - Industrial Processes and Product Use" ~ "industry.ghg.emissions.mio.tonnes",
    sector.name == "3 - Agriculture" ~ "agriculture.ghg.emissions.mio.tonnes",
    sector.name == "5 - Waste management" ~ "waste.ghg.emissions.mio.tonnes",
    sector.name == "Total (without LULUCF, without indirect CO2)" ~ "total.ghg.emissions.mio.tonnes")) %>% 
  mutate(ghg.emissions.mio.tonnes = round(ghg.emissions.giga.tonnes / 1000, 1)) %>% 
  select(country.name, year, sector.name, ghg.emissions.mio.tonnes) %>% 
  spread(sector.name, ghg.emissions.mio.tonnes) %>% 
  mutate(energy.ghg.emissions.mio.tonnes = energy.ghg.emissions.mio.tonnes - transport.ghg.emissions.mio.tonnes)



##################################################



### ghg emissions per capita europe 1990 to 2017

# load data, filter indicator and countries and transform ghg emissions per capita
ghg_emissions_per_capita_europe <- read_tsv("https://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?file=data/sdg_13_10.tsv.gz") %>% 
  separate(`indic_env,geo\\time`, c("indicator", "country.code"), sep = ",") %>% 
  filter(indicator == "GHG_T_HAB" & country.code != "EU27_2020") %>% 
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
    country.code == "GB" | country.code == "UK" ~ "United Kingdom",
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
  select(country.name, year, ghg.emissions.per.capita.tonnes) %>% 
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
column_names <- c("country.code", "year", "category", "scenario", "gas", "ghg.emissions.kilo.tonnes.co2e")

ghg_emissions_projections_total_and_per_sector_europe <- read_csv(paste0(path, "ghg_emissions/ghg_emissions_projections_total_and_per_sector_europe_raw.csv"),
                                                                  col_names = column_names,
                                                                  col_types = "ci-c-cc--n",
                                                                  skip = 1) %>% 
  filter(year %in% c(2018, 2019, 2020, 2025, 2030, 2035, 2040) & 
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
    country.code == "GB" | country.code == "UK" ~ "United Kingdom",
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
    category == "1." ~ "energy.ghg.emissions.mio.tonnes",
    category == "1.A.3." ~ "transport.ghg.emissions.mio.tonnes",
    category == "2." ~ "industry.ghg.emissions.mio.tonnes",
    category == "3." ~ "agriculture.ghg.emissions.mio.tonnes",
    category == "5." ~ "waste.ghg.emissions.mio.tonnes",
    category == "Total w.out LULUCF" ~ "total.ghg.emissions.mio.tonnes")) %>% 
  mutate(ghg.emissions.mio.tonnes = round(ghg.emissions.kilo.tonnes.co2e / 1000, 1)) %>% 
  select(country.name, year, category, ghg.emissions.mio.tonnes) %>% 
  spread(category, ghg.emissions.mio.tonnes) %>% 
  mutate(energy.ghg.emissions.mio.tonnes = energy.ghg.emissions.mio.tonnes - transport.ghg.emissions.mio.tonnes)



### population europe 1975 to 2019 to compute ghg emissions projections per capita for 2018 and 2019

# load data, select indicators and countries and compute mean population for 2018 and 2019 per country
population_europe <- read_tsv("https://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?file=data/namq_10_pe.tsv.gz") %>% 
  separate(`unit,s_adj,na_item,geo\\time`, c("unit", "s_adj", "na_item", "geo"), sep = ",") %>% 
  filter(unit == "THS_PER" & s_adj == "NSA" & na_item == "POP_NC" & !(geo %in% c("EA", "EA12", "EA19", "EU15", "EU27_2020", "RS"))) %>% 
  select(geo, `2019Q4`, `2019Q3`, `2019Q2`, `2019Q1`, `2018Q4`, `2018Q3`, `2018Q2`, `2018Q1`) %>% 
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
    geo == "GB" | geo == "UK" ~ "United Kingdom",
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
  group_by(country.name, year) %>% 
  summarise(population.mio = round(mean(population.mio, na.rm = TRUE), 1))



### population projections europe 2018 to 2100 to compute ghg emissions projections per capita for 2020, 2030 and 2040

# load data, select indicators and countries and compute mean population for 2025 and 2035 per country
population_projections_europe <- read_tsv("https://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?file=data/tps00002.tsv.gz") %>% 
  separate(`projection,unit,sex,age,geo\\time`, c("projection", "unit", "sex", "age", "geo"), sep = ",") %>% 
  filter(sex == "T" & !(geo %in% c("EA19", "EU27_2020"))) %>% 
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
    geo == "GB" | geo == "UK" ~ "United Kingdom",
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
  mutate(`2025` = (`2020` + `2030`) / 2) %>% 
  mutate(`2035` = (`2030` + `2040`) / 2) %>% 
  select(country.name, `2020`, `2025`, `2030`, `2035`, `2040`) %>% 
  gather("year", "population", 2:6) %>% 
  mutate(year = as.integer(year)) %>% 
  mutate(population.mio = round(population / 1000000, 1)) %>% 
  select(-population)



### put everything together

# population
population <- population_europe %>% 
  bind_rows(population_projections_europe)

# ghg emissions projections
ghg_emissions_projections <- ghg_emissions_projections_total_and_per_sector_europe %>% 
  left_join(population, by = c("country.name", "year")) %>% 
  mutate(ghg.emissions.per.capita.tonnes = round(total.ghg.emissions.mio.tonnes / population.mio, 1)) %>% 
  select(-population.mio)

# everything
ghg_emissions <- ghg_emissions_total_and_per_sector_europe %>% 
  left_join(ghg_emissions_per_capita_europe, by = c("country.name", "year")) %>% 
  bind_rows(ghg_emissions_projections)

# eu28
ghg_emissions_eu28 <- ghg_emissions %>% 
  filter(country.name == "EU28") %>% 
  select(-country.name) %>% 
  rename_all(function(x) paste0("EU28.", x))

# ghg emissions with national and EU28 shares
ghg_emissions_with_shares <- ghg_emissions %>% 
  left_join(ghg_emissions_eu28, by = c("year" = "EU28.year")) %>% 
  mutate(agriculture.ghg.emissions.national.share = round(agriculture.ghg.emissions.mio.tonnes / total.ghg.emissions.mio.tonnes, 4) * 100,
         energy.ghg.emissions.national.share = round(energy.ghg.emissions.mio.tonnes / total.ghg.emissions.mio.tonnes, 4) * 100,
         industry.ghg.emissions.national.share = round(industry.ghg.emissions.mio.tonnes / total.ghg.emissions.mio.tonnes, 4) * 100,
         transport.ghg.emissions.national.share = round(transport.ghg.emissions.mio.tonnes / total.ghg.emissions.mio.tonnes, 4) * 100,
         waste.ghg.emissions.national.share = round(waste.ghg.emissions.mio.tonnes / total.ghg.emissions.mio.tonnes, 2) * 100,
         agriculture.ghg.emissions.EU28.share = round(agriculture.ghg.emissions.mio.tonnes / EU28.agriculture.ghg.emissions.mio.tonnes, 4) * 100,
         energy.ghg.emissions.EU28.share = round(energy.ghg.emissions.mio.tonnes /EU28.energy.ghg.emissions.mio.tonnes, 4) * 100,
         industry.ghg.emissions.EU28.share = round(industry.ghg.emissions.mio.tonnes / EU28.industry.ghg.emissions.mio.tonnes, 4) * 100,
         total.ghg.emissions.EU28.share = round(total.ghg.emissions.mio.tonnes / EU28.total.ghg.emissions.mio.tonnes, 4) * 100,
         transport.ghg.emissions.EU28.share = round(transport.ghg.emissions.mio.tonnes / EU28.transport.ghg.emissions.mio.tonnes, 4) * 100,
         waste.ghg.emissions.EU28.share = round(waste.ghg.emissions.mio.tonnes / EU28.waste.ghg.emissions.mio.tonnes, 4) * 100) %>% 
  select(-EU28.agriculture.ghg.emissions.mio.tonnes,
         -EU28.energy.ghg.emissions.mio.tonnes,
         -EU28.industry.ghg.emissions.mio.tonnes,
         -EU28.total.ghg.emissions.mio.tonnes,
         -EU28.transport.ghg.emissions.mio.tonnes,
         -EU28.waste.ghg.emissions.mio.tonnes,
         -EU28.ghg.emissions.per.capita.tonnes) %>% 
  mutate(country.code = case_when(
    country.name == "Austria" ~ "AT",
    country.name == "Belgium" ~ "BE",
    country.name == "Bulgaria" ~ "BG",
    country.name == "Switzerland" ~ "CH",
    country.name == "Cyprus" ~ "CY",
    country.name == "Czech Republic" ~ "CZ",
    country.name == "Germany" ~ "DE",
    country.name == "Denmark" ~ "DK",
    country.name == "Estonia" ~ "EE",
    country.name == "Spain" ~ "ES",
    country.name == "EU28" ~ "EU28",
    country.name == "Finland" ~ "FI",
    country.name == "France" ~ "FR",
    country.name == "United Kingdom" ~ "UK",
    country.name == "Greece" ~ "GR",
    country.name == "Croatia" ~ "HR",
    country.name == "Hungary" ~ "HU",
    country.name == "Ireland" ~ "IE",
    country.name == "Iceland" ~ "IS",
    country.name == "Italy" ~ "IT",
    country.name == "Liechtenstein" ~ "LI",
    country.name == "Lithuania" ~ "LT",
    country.name == "Luxembourg" ~ "LU",
    country.name == "Latvia" ~ "LV",
    country.name == "Malta" ~ "MT",
    country.name == "Netherlands" ~ "NL",
    country.name == "Norway" ~ "NO",
    country.name == "Poland" ~ "PL",
    country.name == "Portugal" ~ "PT",
    country.name == "Romania" ~ "RO",
    country.name == "Sweden" ~ "SE",
    country.name == "Slovenia" ~ "SI",
    country.name == "Slovakia" ~ "SK",
    country.name == "Turkey" ~ "TR")) %>% 
  select(country.code, 1:20) %>% 
  arrange(country.name, year) %>% 
  write_csv("public/data/ghg_emissions/ghg_emissions.csv")

# ghg emissions most recent full year
ghg_emissions_with_shares %>% 
  filter(year == 2019) %>% 
  select(country.code, country.name, total.ghg.emissions.mio.tonnes, ghg.emissions.per.capita.tonnes, total.ghg.emissions.EU28.share) %>% 
  mutate(total.ghg.emissions.mio.tonnes.rank = row_number(-total.ghg.emissions.mio.tonnes) - 1) %>% 
  arrange(total.ghg.emissions.mio.tonnes.rank) %>% 
  write_csv("public/data/ghg_emissions/ghg_emissions_most_recent_full_year.csv")



# ### plot confidence intervals for ghg emissions projections
# # https://ourworldindata.org/grapher/future-greenhouse-gas-emission-scenarios?time=1990..2100
# data <- read.csv("public/data/future-greenhouse-gas-emission-scenarios.csv", header=T)
# #data[,-c(1,2)] <- apply(data[,-c(1,2)], 2, function(x) ifelse(x<0, 0, x))
# 
# # MEDIAN of last entry for label positioning
# # no climate policies: 4.1-4.8?C - 128.9
# # current policies: 3.1-3.7?C    - 62.75
# # pledges: (2.6-3.2?C)           - 41.67
# # pathway: 2?C                   - 2.97
# # pathway: 1.5?C                 - -5.46
# 
# # plot
# alpha = 0.6
# image <- ggplot(data=data)+  
#   geom_line(aes(x = Year, y = Historic..billion.tonnes.CO..equivalent.), color = "black")+
#   geom_ribbon(aes(x = Year, ymin= No.climate.policies..low...billion.tonnes.CO..equivalent., ymax =  No.climate.policies..high...billion.tonnes.CO..equivalent.), fill= "#fb6a4a", alpha = alpha)+  
#   geom_ribbon(aes(x = Year, ymin= Current.policies..low...billion.tonnes.CO..equivalent., ymax =  Current.policies..high...billion.tonnes.CO..equivalent.), fill= "#9e9ac8", alpha = alpha)+ 
#   geom_ribbon(aes(x = Year, ymin= Pledges..low...billion.tonnes.CO..equivalent., ymax =  Pledges..high...billion.tonnes.CO..equivalent.), fill= "#fed976", alpha = alpha)+ 
#   geom_ribbon(aes(x = Year, ymin= X2C.pathways..low...billion.tonnes.CO..equivalent., ymax =  X2C.pathways..high...billion.tonnes.CO..equivalent.), fill= "#74c476", alpha = alpha)+ 
#   geom_ribbon(aes(x = Year, ymin= X1.5C.pathways..low...billion.tonnes.CO..equivalent., ymax =  X1.5C.pathways..high...billion.tonnes.CO..equivalent.), fill= "#67a9cf", alpha = alpha)+ 
#   ylim(-10,200) + xlim(1990,2100)+
#   theme_bw()+ 
#   theme(axis.text=element_text(size=14))+
#   #theme (panel.border = element_blank()) + geom_hline(yintercept=0) + geom_vline(xintercept=1990) + 
#   labs(y="Gt CO2", x="t")+
#   scale_y_continuous(sec.axis=dup_axis(name=" ", breaks=c(-5.46, 2.97,41.67,62.75,128.9), labels=c("1.5?C","2?C","2.6-3.2?C","3.1-3.7?C","4.1-4.8?C")))
# 
# #save the plot as png
# ggsave(file="public/assets/emission_projection_2100.png", plot=image, width=12, height=6)  



### ghg emissions USA and China 2019

# USA
ghg_emissions_usa_2019_mio_tonnes <- (6611 + 6599) / 2 # https://climateactiontracker.org/countries/usa/
population_usa_2019_mio <- 329.1 # https://population.un.org/wpp/DataQuery/
ghg_emissions_usa_2019_per_capita_tonnes <- round(ghg_emissions_usa_2019_mio_tonnes / population_usa_2019_mio, 1)

# China
ghg_emissions_china_2019_mio_tonnes <- (13405 + 13553) / 2 # https://climateactiontracker.org/countries/china/
population_china_2019_mio <- 1433.8 # https://population.un.org/wpp/DataQuery/
ghg_emissions_china_2019_per_capita_tonnes <- round(ghg_emissions_china_2019_mio_tonnes / population_china_2019_mio, 1)

# World
ghg_emissions_world_2019_mio_tonnes <- 37423.1 # https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions
population_world_2019 <- 7713.5 # https://population.un.org/wpp/DataQuery/
ghg_emissions_world_2019_per_capita <- round(ghg_emissions_world_2019_mio_tonnes / population_world_2019, 1)



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
column_names <- c("country.name", "disaster.type", "year", "occurrence", "total.deaths", "total.damage.thousand.dollars")

extreme_weather_occurrences_europe_since_1960 <- read_csv("data/raw_data/extreme_weather/extreme_weather_occurrences_europe_raw.csv",
                                                          col_names = column_names,
                                                          col_types = "-cciii----n",
                                                          skip = 2) %>% 
  head(-2) %>% 
  filter(year >= 1960) %>% 
  mutate(total.damage.mio.dollars = total.damage.thousand.dollars / 1000) %>% 
  select(-total.damage.thousand.dollars) %>% 
  filter(disaster.type %in% c("Drought", "Extreme temperature", "Flood", "Landslide", "Storm", "Wildfire")) %>% 
  mutate_all(~replace(., is.na(.), 0))

# sum of total damages
sum(extreme_weather_occurrences_europe_since_1960$total.damage.mio.dollars)
# 313,116 billion dollars

# sum of total deaths
sum(extreme_weather_occurrences_europe_since_1960$total.deaths)
# 162054

# calculate sum of disaster type occurrence per year
extreme_weather_occurrences_europe_since_1960 %>% 
  select(country.name, disaster.type, year, occurrence) %>% 
  spread(disaster.type, occurrence, fill = 0) %>% 
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
