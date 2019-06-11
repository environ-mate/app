########## Data Preparation for EU Datathon 2019 ##########



##### SETUP #####

# load libraries
library(tidyverse)

### NOTES
# replace NA with 0 for extreme weather data?

# set this variable to exclude and include the proper years from the projection and ghg measures
# NOTE: note affecting the population calculations yet (TODO?)
# NOTE: ghg emission for each country AND per capita must be up to date to the same year!
MOST_RECENT_YEAR_FOR_GHG_DATA = 2016


##### POPULATION #####

### population for 2017 and 2018
# source: https://ec.europa.eu/eurostat/web/products-datasets/-/namq_10_pe

# load raw data
population_raw <- read.csv("input/population_raw.tsv", header=TRUE, sep="\t", stringsAsFactors=FALSE)

# process raw data
population <- population_raw %>% 
  separate(unit.s_adj.na_item.geo.time, c("unit", "s_adj", "na_item", "geo", "time"), sep=",") %>% 
  filter(unit=="THS_PER" & s_adj=="NSA" & na_item=="POP_NC" & !(geo %in% c("EA", "EA12", "EA19", "EU15", "EU27_2019", "RS"))) %>% 
  select(geo, X2018Q4, X2018Q3, X2018Q2, X2018Q1, X2017Q4, X2017Q3, X2017Q2, X2017Q1) %>% 
  rename(country.code=geo)

# replace values and cast data types
population <- data.frame(population[1], lapply(population[2:9], function(x) gsub(":", NA, x)))
population <- data.frame(population[1], lapply(population[2:9], function(x) as.numeric(gsub("p", "", x))*1000))
population$country.code <- gsub("EL", "GR", population$country.code)

# calculate mean population for 2017 and 2018
population <- population %>% 
  mutate("2017"=round((X2017Q4+X2017Q3+X2017Q2+X2017Q1)/4),
         "2018"=ifelse(country.code=="CH", round((X2018Q3+X2018Q2+X2018Q1)/3), round((X2018Q4+X2018Q3+X2018Q2+X2018Q1)/4))) %>% 
  gather("year", "population", 10:11) %>% 
  select(country.code, year, population)



### population projections for 2015 to 2080
# source: https://ec.europa.eu/eurostat/web/products-datasets/-/tps00002

# load raw data
population_projections_raw <- read.csv("input/population_projections_raw.tsv", header=TRUE, sep="\t", stringsAsFactors=FALSE)

# process raw data
population_projections <- population_projections_raw %>% 
  separate(unit.age.sex.projection.geo.time, c("unit", "age", "sex", "projection", "geo", "time"), sep=",") %>% 
  filter(sex=="T") %>% 
  select(geo, X2020, X2030, X2040) %>% 
  rename(country.code=geo)
  
# calculate population projections for missing years
population_projections <- population_projections %>% 
  mutate("2025"=round((X2020+X2030)/2),
         "2035"=round((X2030+X2040)/2)) %>% 
  gather("year", "population", 2:6)

# change country name and year where necessary
population_projections$country.code <- gsub("EL", "GR", population_projections$country.code)
population_projections$year <- gsub("X", "", population_projections$year)

# combine population and population projections
population <- rbind(population, population_projections) %>% 
  arrange(country.code, year)

# cast year to integer data type
population$year <- as.integer(population$year)





##### TEMPERATURE #####

### European average temperatures over land areas relative to the pre-industrial period in degrees celcius
# source: https://www.eea.europa.eu/data-and-maps/daviz/european-average-air-temperature-anomalies-8#tab-chart_8

# load raw data
temperature_deviations_raw <- read.csv("input/temperature_deviations_raw.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# process raw data
european_land_temperature_deviations_annual <- temperature_deviations_raw %>% 
  filter(Type.text=="European annual") %>% 
  select(Year.year, HadCRUT4.number) %>% 
  rename(year=Year.year, temperature.deviation.degree.celcius=HadCRUT4.number)

# write csv
write.csv(european_land_temperature_deviations_annual, "output/european_land_temperature_deviations_annual.csv", row.names=FALSE)





##### EMISSIONS #####

### greenhouse gas (ghg) emissions per sector in giga tonnes CO2 equivalent (gtco2e), 1985-2016, European countries incl. EU28
# source: https://www.eea.europa.eu/data-and-maps/data/national-emissions-reported-to-the-unfccc-and-to-the-eu-greenhouse-gas-monitoring-mechanism-15

# load raw data
ghg_emissions_per_sector_raw <- read.csv("input/ghg_emissions_per_sector_raw.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# filter ghg emissions, sectors and years
ghg_emissions_per_sector <- ghg_emissions_per_sector_raw %>% 
  filter(Pollutant_name=="All greenhouse gases - (CO2 equivalent)" & # including CO2, CH4, N2O, HFCs, PFCs, unspecified mix of HFCs and PFCs, SF6 and NF3 (in giga tonnes CO2 equivalent) # unit???
           (Sector_name=="Total (without LULUCF, without indirect CO2)" | 
              Sector_name=="1.A.1 - Energy Industries" | Sector_name=="1.A.3 - Transport" | 
              Sector_name=="2 - Industrial Processes and Product Use" | 
              Sector_name=="3 - Agriculture" | Sector_name=="5 - Waste management" | Sector_name=="1.A.4.b - Residential" | Sector_name=="1.A.4.a - Commercial/Institutional") &
           !(Year %in% c("1985-1987", "1985", "1986", "1987", "1988", "1989")) & Country!="EU (KP)") %>% 
  select(Country, Country_code, emissions, Sector_name, Year) %>% 
  rename(country.name=Country, country.code=Country_code, ghg.emissions.mio.tonnes=emissions, sector=Sector_name, year=Year)

# replace country names, country codes and sector names where necessary
ghg_emissions_per_sector$country.name[ghg_emissions_per_sector$country.name=="EU28 (Convention)"] <- "EU28"
ghg_emissions_per_sector$country.code[ghg_emissions_per_sector$country.code=="EUA"] <- "EU28"
ghg_emissions_per_sector$country.name[ghg_emissions_per_sector$country.name=="United Kingdom (Convention)"] <- "United Kingdom"
ghg_emissions_per_sector$sector[ghg_emissions_per_sector$sector=="Total (without LULUCF, without indirect CO2)"] <- "total.ghg.emissions.mio.tonnes"
ghg_emissions_per_sector$sector[ghg_emissions_per_sector$sector=="1.A.1 - Energy Industries"] <- "energy.ghg.emissions.mio.tonnes"
ghg_emissions_per_sector$sector[ghg_emissions_per_sector$sector=="1.A.3 - Transport"] <- "transport.ghg.emissions.mio.tonnes"
ghg_emissions_per_sector$sector[ghg_emissions_per_sector$sector=="2 - Industrial Processes and Product Use"] <- "industry.ghg.emissions.mio.tonnes"
ghg_emissions_per_sector$sector[ghg_emissions_per_sector$sector=="3 - Agriculture"] <- "agriculture.ghg.emissions.mio.tonnes"
ghg_emissions_per_sector$sector[ghg_emissions_per_sector$sector=="5 - Waste management"] <- "waste.ghg.emissions.mio.tonnes"

# spread sectors to separate columns
ghg_emissions_per_sector <- ghg_emissions_per_sector %>% 
  spread(sector, ghg.emissions.mio.tonnes)
  
  
# rename and sum colums for commercial and residential emissions
ghg_emissions_per_sector$residential.ghg.emissions.mio.tonnes <- apply(ghg_emissions_per_sector[,c("1.A.4.b - Residential", "1.A.4.a - Commercial/Institutional")],1, sum)
ghg_emissions_per_sector <- ghg_emissions_per_sector[, -which(names(ghg_emissions_per_sector) %in% c("1.A.4.b - Residential", "1.A.4.a - Commercial/Institutional"))]


# cast year to integer data type
ghg_emissions_per_sector$year <- as.integer(as.character(ghg_emissions_per_sector$year))


# calculate EU28 total sum and cumsum ghg emissions in gtco2e
EU28_total_ghg_emissions <- ghg_emissions_per_sector %>% 
  filter(country.name=="EU28") %>% 
  group_by(year) %>% 
  summarize(sum.total.ghg.emissions.mio.tonnes=round(sum(total.ghg.emissions.mio.tonnes/1000), 1)) %>% 
  mutate(cumsum.total.ghg.emissions.mio.tonnes=round(cumsum(sum.total.ghg.emissions.mio.tonnes), 1))

# write csv
write.csv(EU28_total_ghg_emissions, "output/EU28_total_ghg_emissions.csv", row.names=FALSE)



### ghg emissions indexed (base year 1990), ghg emissions per capita (tonnes), 1990-2016, European countries incl. EU28
# source: https://ec.europa.eu/eurostat/web/products-datasets/-/sdg_13_10

#  The indicator measures all man-made emissions of the so called 'Kyoto basket' of greenhouse gases, including carbon dioxide (CO2), methane (CH4), nitrous oxide (N2O), and the so-called F-gases (hydrofluorocarbons, perfluorocarbons, nitrogen triflouride (NF3) and sulphur hexafluoride (SF6)). Using each gas' individual global warming potential (GWP), they are being integrated into a single indicator expressed in units of CO2 equivalents. Emissions data are submitted annually by the EU Member States as part of the reporting under the United Nations Framework Convention on Climate Change (UNFCCC). 

# load raw data
ghg_emissions_indexed_and_per_capita_raw <- read.csv(paste0("input/ghg_emissions_indexed_and_per_capita_raw.tsv"), header=TRUE, sep="\t", stringsAsFactors=FALSE)

# split first column
ghg_emissions_indexed_and_per_capita <- ghg_emissions_indexed_and_per_capita_raw %>% 
  separate(indic_env.geo.time, c("indicator", "country.code"), sep=",")

# replace country codes where necessary
ghg_emissions_indexed_and_per_capita$country.code[ghg_emissions_indexed_and_per_capita$country.code=="EL"] <- "GR"

# get ghg emissions indexed
ghg_emissions_indexed <- ghg_emissions_indexed_and_per_capita %>% 
  filter(indicator=="GHG_I90") %>% 
  gather("year", "ghg.emissions.indexed", 3:29) %>% 
  select(-indicator)

# replace some characters and cast data types
ghg_emissions_indexed$year <- gsub("X", "", ghg_emissions_indexed$year)
ghg_emissions_indexed$year <- as.integer(ghg_emissions_indexed$year)
ghg_emissions_indexed$ghg.emissions.indexed <- as.numeric(ghg_emissions_indexed$ghg.emissions.indexed)

# get ghg emissions per capita
ghg_emissions_per_capita <- ghg_emissions_indexed_and_per_capita %>% 
  filter(indicator=="GHG_T_HAB") %>% 
  gather("year", "ghg.emissions.per.capita", 3:29) %>% 
  select(-indicator) %>% 
  rename(ghg.emissions.per.capita.tonnes=ghg.emissions.per.capita)

# replace some characters and cast data types
ghg_emissions_per_capita$ghg.emissions.per.capita.tonnes <- gsub("b", "", ghg_emissions_per_capita$ghg.emissions.per.capita.tonnes)
ghg_emissions_per_capita$ghg.emissions.per.capita.tonnes <- gsub("e", "", ghg_emissions_per_capita$ghg.emissions.per.capita.tonnes)
ghg_emissions_per_capita$ghg.emissions.per.capita.tonnes <- gsub("p", "", ghg_emissions_per_capita$ghg.emissions.per.capita.tonnes)
ghg_emissions_per_capita$ghg.emissions.per.capita.tonnes <- as.numeric(ghg_emissions_per_capita$ghg.emissions.per.capita.tonnes)
ghg_emissions_per_capita$year <- gsub("X", "", ghg_emissions_per_capita$year)
ghg_emissions_per_capita$year <- as.integer(ghg_emissions_per_capita$year)



### ghg emissions projections (no projections for Switzerland, Iceland, Liechtenstein and Turkey)
# source: https://www.eea.europa.eu/data-and-maps/data/greenhouse-gas-emission-projections-for-4

# load raw data
ghg_emissions_projections_raw <- read.csv("input/ghg_emissions_projections_raw.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# cast Final.Gap.filled to numeric
ghg_emissions_projections_raw$Final.Gap.filled <- as.numeric(ghg_emissions_projections_raw$Final.Gap.filled) # NA for Malta 2036-2040 waste

# filter scenario, ghg emissions and sectors
ghg_emissions_projections <- ghg_emissions_projections_raw %>% 
  filter(Scenario=="WEM" & # projections taking into account the (current) existing domestic policies
           (Category_name=="Agriculture" | 
              Category_name=="Energy industries" | 
              Category_name=="Industrial processes" | 
              Category_name=="Transport" | 
              Category_name=="Total w.out LULUCF"| 
              Category_name=="Waste") & 
           Gas=="Total GHGs (ktCO2e)") %>% # unit???
  select(MS, Year, Category_name, Final.Gap.filled) %>% 
  spread(Category_name, Final.Gap.filled) %>% 
  rename(country.code=MS, year=Year, agriculture.ghg.emissions.mio.tonnes=Agriculture, energy.ghg.emissions.mio.tonnes=`Energy industries`, industry.ghg.emissions.mio.tonnes=`Industrial processes`, transport.ghg.emissions.mio.tonnes=Transport, total.ghg.emissions.mio.tonnes=`Total w.out LULUCF`, waste.ghg.emissions.mio.tonnes=Waste)

# replace country codes where necessary
ghg_emissions_projections$country.code[ghg_emissions_projections$country.code=="GB"] <- "UK"
ghg_emissions_projections$country.code[ghg_emissions_projections$country.code=="EU"] <- "EU28"

# get 1990 ghg emissions
ghg_emissions_1990 <- ghg_emissions_per_sector %>% 
  filter(year==1990) %>% 
  select(country.code, total.ghg.emissions.mio.tonnes) %>% 
  rename(total.ghg.emissions.mio.tonnes.1990=total.ghg.emissions.mio.tonnes)

# get country names and codes for mapping
country_names_and_codes <- ghg_emissions_per_sector %>% 
  select(country.name, country.code) %>%
  unique()

# filter only required years and calculate ghg emissions indexed and ghg emissions per capita for current and future years
ghg_emissions_projections_filtered <- ghg_emissions_projections %>% 
  filter(year %in% c(MOST_RECENT_YEAR_FOR_GHG_DATA+1, MOST_RECENT_YEAR_FOR_GHG_DATA+2, 2020, 2025, 2030, 2035)) %>% 
  left_join(ghg_emissions_1990, by="country.code") %>% 
  mutate(ghg.emissions.indexed=round((total.ghg.emissions.mio.tonnes/total.ghg.emissions.mio.tonnes.1990)*100, 1)) %>% 
  inner_join(population, by=c("country.code", "year")) %>% 
  mutate(ghg.emissions.per.capita.tonnes=round(((total.ghg.emissions.mio.tonnes/1000)/(population/1000000)), 1)) %>% 
  select(-population, -total.ghg.emissions.mio.tonnes.1990) %>% 
  left_join(country_names_and_codes, by="country.code") %>% 
  arrange(country.code, year)



### put everything together

# combine all ghg emissions dataframes and add 'Other' category to sectors for the sum of emissions per sector to be equal to total ghg emissions
ghg_emissions <- ghg_emissions_per_sector %>% 
  inner_join(ghg_emissions_indexed, by=c("country.code", "year")) %>% 
  inner_join(ghg_emissions_per_capita, by=c("country.code", "year")) %>% 
  rbind(ghg_emissions_projections_filtered) %>% 
  mutate(other.ghg.emissions.mio.tonnes=total.ghg.emissions.mio.tonnes-agriculture.ghg.emissions.mio.tonnes
         -energy.ghg.emissions.mio.tonnes
         -industry.ghg.emissions.mio.tonnes
         -transport.ghg.emissions.mio.tonnes
         -waste.ghg.emissions.mio.tonnes
         -residential.ghg.emissions.mio.tonnes
         ) %>% 
  arrange(country.name, year)

  
  
  
  
  
# extract EU28 ghg emissions
EU28_ghg_emissions <- ghg_emissions %>%
  filter(country.name=="EU28") %>% 
  select(-country.name, -country.code, -ghg.emissions.indexed, -ghg.emissions.per.capita.tonnes) %>% 
  rename_all(function(x) paste0("EU28.", x)) %>% 
  rename(year=EU28.year)

# calculate national and EU28 ghg emission shares
ghg_emissions_with_shares <- ghg_emissions %>% 
  left_join(EU28_ghg_emissions, by="year") %>% 
  mutate(agriculture.ghg.emissions.national.share=round(agriculture.ghg.emissions.mio.tonnes/total.ghg.emissions.mio.tonnes, 4),
         energy.ghg.emissions.national.share=round(energy.ghg.emissions.mio.tonnes/total.ghg.emissions.mio.tonnes, 4),
         industry.ghg.emissions.national.share=round(industry.ghg.emissions.mio.tonnes/total.ghg.emissions.mio.tonnes, 4),
         transport.ghg.emissions.national.share=round(transport.ghg.emissions.mio.tonnes/total.ghg.emissions.mio.tonnes, 4),
         waste.ghg.emissions.national.share=round(waste.ghg.emissions.mio.tonnes/total.ghg.emissions.mio.tonnes, 4),
         other.ghg.emissions.national.share=round(other.ghg.emissions.mio.tonnes/total.ghg.emissions.mio.tonnes, 4),
         agriculture.ghg.emissions.EU28.share=round(agriculture.ghg.emissions.mio.tonnes/EU28.agriculture.ghg.emissions.mio.tonnes, 4),
         energy.ghg.emissions.EU28.share=round(energy.ghg.emissions.mio.tonnes/EU28.energy.ghg.emissions.mio.tonnes, 4),
         industry.ghg.emissions.EU28.share=round(industry.ghg.emissions.mio.tonnes/EU28.industry.ghg.emissions.mio.tonnes, 4),
         total.ghg.emissions.EU28.share=round(total.ghg.emissions.mio.tonnes/EU28.total.ghg.emissions.mio.tonnes, 4),
         transport.ghg.emissions.EU28.share=round(transport.ghg.emissions.mio.tonnes/EU28.transport.ghg.emissions.mio.tonnes, 4),
         waste.ghg.emissions.EU28.share=round(waste.ghg.emissions.mio.tonnes/EU28.waste.ghg.emissions.mio.tonnes, 4),
         other.ghg.emissions.EU28.share=round(other.ghg.emissions.mio.tonnes/EU28.waste.ghg.emissions.mio.tonnes, 4)) %>% 
  select(-EU28.agriculture.ghg.emissions.mio.tonnes,
         -EU28.energy.ghg.emissions.mio.tonnes,
         -EU28.industry.ghg.emissions.mio.tonnes,
         -EU28.total.ghg.emissions.mio.tonnes,
         -EU28.transport.ghg.emissions.mio.tonnes,
         -EU28.waste.ghg.emissions.mio.tonnes,
         -EU28.other.ghg.emissions.mio.tonnes)

# round ghg emissions
ghg_emissions_with_shares <- ghg_emissions_with_shares %>%
  mutate_at(vars(agriculture.ghg.emissions.mio.tonnes,
                 energy.ghg.emissions.mio.tonnes,
                 industry.ghg.emissions.mio.tonnes,
                 total.ghg.emissions.mio.tonnes,
                 transport.ghg.emissions.mio.tonnes,
                 waste.ghg.emissions.mio.tonnes,
                 other.ghg.emissions.mio.tonnes), funs(round(./1000, 1)))

# change order of columns
ghg_emissions_with_shares <- ghg_emissions_with_shares[, c(1:3,10,11,4:9,12:25)]

# write csv
write.csv(ghg_emissions_with_shares, "output/ghg_emissions.csv", row.names=FALSE)





##### EXTREME WEATHER #####

### extreme weather and natural disasters
# EM-DAT: The Emergency Events Database - Université catholique de Louvain (UCL) - CRED, www.emdat.be, Brussels, Belgium. Classification: https://emdat.be/classification

# load raw data
extreme_weather_raw <- read.csv("input/extreme_weather_raw.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# rename columns
names(extreme_weather_raw)[names(extreme_weather_raw) == "X.country_name"] <- "country.name"
names(extreme_weather_raw)[names(extreme_weather_raw) == "Total.deaths"] <- "total.deaths"
names(extreme_weather_raw)[names(extreme_weather_raw) == "Injured"] <- "injured"
names(extreme_weather_raw)[names(extreme_weather_raw) == "Affected"] <- "affected"
names(extreme_weather_raw)[names(extreme_weather_raw) == "Homeless"] <- "homeless"
names(extreme_weather_raw)[names(extreme_weather_raw) == "Total.affected"] <- "total.affected"
names(extreme_weather_raw)[names(extreme_weather_raw) == "Total.damage....000.US.."] <- "total.damage"

# convert total damage to millions
extreme_weather_raw$total.damage.mio.dollars <- round(extreme_weather_raw$total.damage/1000)

# drop columns that are not needed
extreme_weather_raw$iso <- NULL
extreme_weather_raw$injured <- NULL
extreme_weather_raw$affected <- NULL
extreme_weather_raw$homeless <- NULL
extreme_weather_raw$total.damage <- NULL

# relevant disasters
relevant_disasters <- c("Drought", "Extreme temperature", "Flood", "Storm", "Wildfire")

# countries that don't exist anymore
not_existant_countries <- c("Czechoslovakia", "Serbia Montenegro", "Soviet Union", "Yugoslavia")

# rename some countries
extreme_weather_raw$country.name[extreme_weather_raw$country.name=="Czech Republic (the)"] <- "Czech Republic"
extreme_weather_raw$country.name[extreme_weather_raw$country.name=="United Kingdom of Great Britain and Northern Ireland (the)"] <- "United Kingdom"
extreme_weather_raw$country.name[extreme_weather_raw$country.name=="Netherlands (the)"] <- "Netherlands"

# filter relevant disasters
extreme_weather <- extreme_weather_raw %>% 
  filter(disaster.type %in% relevant_disasters & !(country.name %in% not_existant_countries)) %>% 
  arrange(country.name, year)

# occurrence
occurrence <- extreme_weather %>% 
  select(country.name, disaster.type, year, occurrence) %>% 
  spread(disaster.type, occurrence) %>% 
  rename(drought.occurrence=Drought, storm.occurrence=Storm, flood.occurrence=Flood, wildfire.occurrence=Wildfire)

# total deaths
total_deaths <- extreme_weather %>% 
  select(country.name, disaster.type, year, total.deaths) %>% 
  spread(disaster.type, total.deaths) %>% 
  rename(drought.total.deaths=Drought, storm.total.deaths=Storm, flood.total.deaths=Flood, wildfire.total.deaths=Wildfire)

# total affected
total_affected <- extreme_weather %>% 
  select(country.name, disaster.type, year, total.affected) %>% 
  spread(disaster.type, total.affected) %>% 
  rename(drought.total.affected=Drought, storm.total.affected=Storm, flood.total.affected=Flood, wildfire.total.affected=Wildfire)

# total damage
total_damage <- extreme_weather %>% 
  select(country.name, disaster.type, year, total.damage.mio.dollars) %>% 
  spread(disaster.type, total.damage.mio.dollars) %>% 
  rename(drought.total.damage.mio.dollars=Drought, storm.total.damage.mio.dollars=Storm, flood.total.damage.mio.dollars=Flood, wildfire.total.damage.mio.dollars=Wildfire)

# merge transformed indicators
extreme_weather_processed <- merge(occurrence, total_deaths, by=c("country.name", "year"))
extreme_weather_processed <- merge(extreme_weather_processed, total_affected, by=c("country.name", "year"))
extreme_weather_processed <- merge(extreme_weather_processed, total_damage, by=c("country.name", "year"))

# aggregate events in same years in Germany, Germany Fed Rep and Germany Dem Rep
germany <- extreme_weather_processed %>% 
  filter(country.name %in% c("Germany", "Germany Dem Rep", "Germany Fed Rep")) %>% 
  group_by(year) %>% 
  summarize(drought.occurrence=sum(drought.occurrence), 
            drought.total.deaths=sum(drought.total.deaths),
            drought.total.affected=sum(drought.total.affected),
            drought.total.damage.mio.dollars=sum(drought.total.damage.mio.dollars),
            flood.occurrence=sum(flood.occurrence), 
            flood.total.deaths=sum(flood.total.deaths),
            flood.total.affected=sum(flood.total.affected),
            flood.total.damage.mio.dollars=sum(flood.total.damage.mio.dollars),
            storm.occurrence=sum(storm.occurrence), 
            storm.total.deaths=sum(storm.total.deaths),
            storm.total.affected=sum(storm.total.affected),
            storm.total.damage.mio.dollars=sum(storm.total.damage.mio.dollars),
            wildfire.occurrence=sum(wildfire.occurrence), 
            wildfire.total.deaths=sum(wildfire.total.deaths),
            wildfire.total.affected=sum(wildfire.total.affected),
            wildfire.total.damage.mio.dollars=sum(wildfire.total.damage.mio.dollars)) %>% 
  mutate(country.name="Germany")

# replace Germany, BRD and DDR events with aggregated ones
extreme_weather_processed <- extreme_weather_processed %>% 
  filter(!(country.name %in% c("Germany", "Germany Dem Rep", "Germany Fed Rep"))) %>%
  rbind(germany) %>% 
  arrange(country.name, year)

# write csv
write.csv(extreme_weather_processed, "output/extreme_weather.csv", row.names=FALSE)



##
# Process data for sum of occurences.
##

data <- extreme_weather_processed
data <- data[,-1]
data <- data[,c(1:5)]
data[is.na(data)] <- 0
data_tmp <- data %>% group_by(year) %>% summarise_all(sum)
write.csv(data_tmp, file="output/extreme_weather_occurences.csv", row.names=F)




#
# Plot confidence intervals for future projections
#
#
library(ggplot2)
data <- read.csv("public/data/future-greenhouse-gas-emission-scenarios.csv", header=T)
#data[,-c(1,2)] <- apply(data[,-c(1,2)], 2, function(x) ifelse(x<0, 0, x))


# MEDIAN of last entry for label positioning
# no climate policies: 4.1-4.8°C - 128.9
# current policies: 3.1-3.7°C    - 62.75
# pledges: (2.6-3.2°C)           - 41.67
# pathway: 2°C                   - 2.97
# pathway: 1.5°C                 - -5.46


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
  scale_y_continuous(sec.axis=dup_axis(name=" ", breaks=c(-5.46, 2.97,41.67,62.75,128.9), labels=c("1.5°C","2°C","2.6-3.2°C","3.1-3.7°C","4.1-4.8°C")))
  
#save the plot as png
ggsave(file="public/assets/emission_projection_2100.png", plot=image, width=12, height=6)  
  

  
##
## Calculate rank of GHG emissions per country and countries capita
##
library(tidyverse)
data <- read.csv("ghg_emissions.csv", header=T)
tmp <- data %>% filter(data$year == 2017) %>% select(country.name, country.code, year, total.ghg.emissions.mio.tonnes, ghg.emissions.per.capita.tonnes)

which(tmp$country.code %in% c(EU28)
  
  
"country.name","country.code","total.ghg.emissions.mio.tonnes","ghg.emissions.per.capita.tonnes","total_eu28_ghg_tonnes_share","total_eu28_ghg_tonnes_rank"











