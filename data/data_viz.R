


##### SETUP #####

# set working directory
setwd("C:/Users/alex.merdian-tarko/Desktop/EU Datathon 2019/data/")

# load libraries
library(tidyverse)

# load data
ghg_emissions <- read.csv("output/ghg_emissions.csv", header=TRUE, stringsAsFactors=FALSE)

# viz
viz <- ggplot(filter(ghg_emissions, country.name %in% c("EU28", "Germany")),
              aes(x=year,
                  y=total.ghg.emissions.mio.tonnes,
                  color=country.name)) +
  geom_line(size=1.25) +
  geom_point(size=2.5) +
  geom_vline(xintercept=2020) +
  geom_text(aes(2030,2020,label = "FORECAST", vjust = -1), color="black") +
  labs(title="EU28 and Germany Greenhouse Gas Emissions", y="Greenhouse gas emissions\nin million tonnes CO2 equivalent", x="Year", color="Country")

ggsave("EU28_Germany_ghg_emissions_draft.png", width=16, height=9, dpi=100)
