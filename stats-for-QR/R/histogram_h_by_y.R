library(tidyverse)

last_year <- readRDS('data/last_year.rds')
h_by_year <- readRDS('data/noaa_hurricanes.rds') |>
  filter(typea %in% c('HU', 'MH')) |>
  group_by(year, basin, .drop = FALSE) |>
  count()

h_by_year |>
  ggplot(aes(x = n)) + 
  geom_histogram(binwidth = 1) +
  facet_grid(basin ~ .) +
  labs(title =str_glue('Hurricanes Recorded by NOAA from 1991 to {last_year}'),
       x = 'Number of hurricanes in each year') + 
  scale_y_continuous(breaks = function(x) unique(floor(pretty(x))))

