library("dplyr")
library("ggplot2")
library("shiny")
library("plotly")
library("RColorBrewer")
library("maps")

# Pediatric flu death data
ped.flu.death.data <- read.csv("./data/PedFluDeath_MapData.csv")

# Get data to make choropleth map
map.data <- read.csv("./data/Flu_Map_Coverage.csv") %>%
  select("region" = STATENAME, "activity" = ACTIVITYESTIMATE)

# Take in word and return same word with capitalized first letter
capFirst <- function(word) {
  paste0(toupper(substring(word, 1, 1)), substring(word, 2))
}

locations <- map_data("state")
locations$region <- capFirst(locations$region)
locations <- full_join(locations, map.data)

# Get ILI and mortality data, and merge together
ili.data <- read.csv("./data/ILI_Washington.csv", stringsAsFactors = FALSE) %>%
  filter(YEAR != 2017) %>%
  filter(YEAR == 2013 | YEAR == 2014 | YEAR == 2015 | YEAR == 2016) %>%
  select(REGION, YEAR, WEEK, "ILI.Rate" = X.UNWEIGHTED.ILI)
colnames(ili.data)[1] <- "state"

death.data <- read.csv("./data/Flu_Death_Washington.csv", stringsAsFactors = FALSE) %>%
  select(state, "YEAR" = Year, "WEEK" = Week, "Mortality.Rate" = Percent.of.Deaths.Due.to.Pneumonia.and.Influenza)

full.data <- merge(death.data, ili.data)

# Get data according to age
age.data <- read.csv('./data/AgeViewBySeason.csv', stringsAsFactors = FALSE)