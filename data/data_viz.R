


##### SETUP #####

# load libraries
library(tidyverse)

# load data
ghg_emissions <- read.csv("output/ghg_emissions.csv", header=TRUE, stringsAsFactors=FALSE)
extreme_weather <- read.csv("output/extreme_weather.csv", header=TRUE, stringsAsFactors=FALSE)



##### VIZ #####

# total ghg emissions
viz <- ggplot(filter(ghg_emissions, country.name %in% c("EU28", "Germany")),
              aes(x=year,
                  y=total.ghg.emissions.mio.tonnes,
                  color=country.name)) +
  geom_line(size=1.25) +
  geom_point(size=2.5) +
  geom_vline(xintercept=2020) +
  geom_text(aes(2030,2020,label = "FORECAST", vjust = -1), color="black") +
  labs(title="EU28 and Germany Greenhouse Gas Emissions", y="Greenhouse gas emissions\nin million tonnes CO2 equivalent", x="Year", color="Country")

viz

ggsave("viz/EU28_Germany_total_ghg_emissions_draft.png", width=16, height=9, dpi=100)



# ghg emissions indexed
viz <- ggplot(filter(ghg_emissions, country.name %in% c("EU28", "Germany")),
              aes(x=year,
                  y=ghg.emissions.indexed,
                  color=country.name)) +
  geom_line(size=1.25) +
  geom_point(size=2.5) +
  geom_vline(xintercept=2020) +
  geom_text(aes(2030,70,label = "FORECAST", vjust = -1), color="black") +
  geom_hline(yintercept=80) +
  geom_text(aes(2030,80,label = "EU 2020 80% Goal", vjust = -1), color="black") +
  labs(title="EU28 and Germany Greenhouse Gas Emissions", y="Greenhouse gas emissions indexed (base year 1990)", x="Year", color="Country")

viz

ggsave("viz/EU28_Germany_ghg_emissions_indexed_draft.png", width=16, height=9, dpi=100)



# viz ghg emissions per capita
viz <- ggplot(filter(ghg_emissions, country.name %in% c("EU28", "Germany")),
              aes(x=year,
                  y=ghg.emissions.per.capita.tonnes,
                  color=country.name)) +
  geom_line(size=1.25) +
  geom_point(size=2.5) +
  geom_vline(xintercept=2020) +
  geom_text(aes(2030,12,label = "FORECAST", vjust = -1), color="black") +
  labs(title="EU28 and Germany Greenhouse Gas Emissions", y="Greenhouse gas emissions\n per capita in tonnes CO2 equivalent", x="Year", color="Country")

viz

ggsave("viz/EU28_Germany_ghg_emissions_per_capita_draft.png", width=16, height=9, dpi=100)



# sectors Germany
sectors <- ghg_emissions %>% 
  filter(country.name=="Germany", year==2018) %>% 
  select(agriculture.ghg.emissions.national.share,
         energy.ghg.emissions.national.share,
         industry.ghg.emissions.national.share,
         transport.ghg.emissions.national.share,
         waste.ghg.emissions.national.share,
         other.ghg.emissions.national.share) %>% 
  gather("sector", "share") %>% 
  mutate(share=share*100) %>% 
  arrange(desc(sector)) %>% 
  mutate(lab.ypos=cumsum(share)-0.5*share)

mycols <- c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF", "purple", "green")

viz <- ggplot(sectors, aes(x = 2, y = share, fill = sector)) +
  geom_bar(stat = "identity", color = "white") +
  coord_polar(theta = "y", start = 0)+
  geom_text(aes(y = lab.ypos, label = share), color = "white")+
  scale_fill_manual(values = mycols) +
  theme_void()+
  xlim(0.5, 2.5)+
  labs(title="Germany 2018 Greenhouse Gas Emissions per Sector")

viz

ggsave("viz/Germany_2018_ghg_emissions_per_sector_draft.png", width=16, height=9, dpi=100)




# sectors EU28
sectors <- ghg_emissions %>% 
  filter(country.name=="EU28", year==2018) %>% 
  select(agriculture.ghg.emissions.national.share,
         energy.ghg.emissions.national.share,
         industry.ghg.emissions.national.share,
         transport.ghg.emissions.national.share,
         waste.ghg.emissions.national.share,
         other.ghg.emissions.national.share) %>% 
  gather("sector", "share") %>% 
  mutate(share=share*100) %>% 
  arrange(desc(sector)) %>% 
  mutate(lab.ypos=cumsum(share)-0.5*share)

mycols <- c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF", "purple", "green")

viz <- ggplot(sectors, aes(x = 2, y = share, fill = sector)) +
  geom_bar(stat = "identity", color = "white") +
  coord_polar(theta = "y", start = 0)+
  geom_text(aes(y = lab.ypos, label = share), color = "white")+
  scale_fill_manual(values = mycols) +
  theme_void()+
  xlim(0.5, 2.5)+
  labs(title="EU28 2018 Greenhouse Gas Emissions per Sector")

viz

ggsave("viz/EU28_2018_ghg_emissions_per_sector_draft.png", width=16, height=9, dpi=100)





# extreme weather
extreme_weather_aggregated <- extreme_weather %>% 
  filter(year!=2019) %>% 
  replace_na(list(drought.occurrence=0, flood.occurrence=0, storm.occurrence=0, wildfire.occurrence=0,
                  drought.total.deaths=0, flood.total.deaths=0, storm.total.deaths=0, wildfire.total.deaths=0,
                  drought.total.damage.mio.dollars=0, flood.total.damage.mio.dollars=0, storm.total.damage.mio.dollars=0, wildfire.total.damage.mio.dollars=0)) %>% 
  group_by(year) %>% 
  summarize(drought.occurrence=sum(drought.occurrence),
            flood.occurrence=sum(flood.occurrence),
            storm.occurrence=sum(storm.occurrence),
            wildfire.occurrence=sum(wildfire.occurrence),
            drought.total.deaths=sum(drought.total.deaths),
            flood.total.deaths=sum(flood.total.deaths),
            storm.total.deaths=sum(storm.total.deaths),
            wildfire.total.deaths=sum(wildfire.total.deaths),
            drought.total.damage.mio.dollars=sum(drought.total.damage.mio.dollars),
            flood.total.damage.mio.dollars=sum(flood.total.damage.mio.dollars),
            storm.total.damage.mio.dollars=sum(storm.total.damage.mio.dollars),
            wildfire.total.damage.mio.dollars=sum(wildfire.total.damage.mio.dollars)) %>% 
  mutate(occurrence.total=drought.occurrence+flood.occurrence+storm.occurrence+wildfire.occurrence,
         deaths.total=drought.total.deaths+flood.total.deaths+storm.total.deaths+wildfire.total.deaths,
         damage.mio.dollars.total=drought.total.damage.mio.dollars+flood.total.damage.mio.dollars+storm.total.damage.mio.dollars+wildfire.total.damage.mio.dollars)

# occurrence
viz <- ggplot(extreme_weather_aggregated,
              aes(x=year,
                  y=occurrence.total)) +
  geom_line(size=1.25) +
  geom_point(size=2.5) +
  geom_smooth(method = "lm") +
  labs(title="Occurrence of Extreme Weather Events in Europe", y="Occurrence", x="Year")

viz

ggsave("viz/occurrence_extreme_weather_events_Europe_draft.png", width=16, height=9, dpi=100)

# deaths
viz <- ggplot(extreme_weather_aggregated,
              aes(x=year,
                  y=deaths.total)) +
  geom_line(size=1.25) +
  geom_point(size=2.5) +
  geom_smooth(method = "lm") +
  labs(title="Total Deaths caused by Extreme Weather Events in Europe", y="Total deaths", x="Year")

viz

ggsave("viz/deaths_extreme_weather_events_Europe_draft.png", width=16, height=9, dpi=100)

# damage
viz <- ggplot(extreme_weather_aggregated,
              aes(x=year,
                  y=damage.mio.dollars.total)) +
  geom_line(size=1.25) +
  geom_point(size=2.5) +
  geom_smooth(method = "lm") +
  labs(title="Total Damage caused by Extreme Weather Events in Europe", y="Total damage in million US dollars", x="Year")

viz

ggsave("viz/damage_extreme_weather_events_Europe_draft.png", width=16, height=9, dpi=100)

# occurrence by event
viz <- ggplot(extreme_weather_aggregated,
              aes(x=year)) +
  geom_line(aes(y=drought.occurrence, color="drought.occurrence"), size=1.25) +
  geom_point(aes(y=drought.occurrence, color="drought.occurrence"), size=2.5) +
  geom_line(aes(y=flood.occurrence, color="flood.occurrence"), size=1.25) +
  geom_point(aes(y=flood.occurrence, color="flood.occurrence"), size=2.5) +
  geom_line(aes(y=storm.occurrence, color="storm.occurrence"), size=1.25) +
  geom_point(aes(y=storm.occurrence, color="storm.occurrence"), size=2.5) +
  geom_line(aes(y=wildfire.occurrence, color="wildfire.occurrence"), size=1.25) +
  geom_point(aes(y=wildfire.occurrence, color="wildfire.occurrence"), size=2.5) +
  labs(title="Occurrence of Droughts, Floods, Storms and Wildfires in Europe", y="Number of extreme weather events", x="Year")

viz

ggsave("viz/droughts_floods_storms_wildfires_Europe_draft.png", width=16, height=9, dpi=100)



