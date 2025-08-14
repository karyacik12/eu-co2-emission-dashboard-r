library(dplyr)
library(ggplot2)
library(readr)

df <- read_csv("data/EU_emissions.csv") %>%
  filter(Region == "Europe", Year >= 2000) %>%
  group_by(Country, Year) %>%
  summarize(Emissions = sum(Emissions))

ggplot(df, aes(x = Year, y = Emissions, color = Country)) +
  geom_line(size = 1) +
  labs(title = "2000–2020 CO₂ Emission Trends in Europe", y = "Million Tons CO₂")
