


##### SETUP #####

# load libraries
library(tidyverse)

# load data
ghg_emissions <- read.csv("output/ghg_emissions.csv", header=TRUE, stringsAsFactors=FALSE)



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