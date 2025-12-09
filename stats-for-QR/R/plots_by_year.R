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

ggsave('plots/histogram_by_year.png')

h_by_year |>
  ggplot(aes(x = n, y = fct_rev(basin))) +
  geom_boxplot() +
  labs(title =str_glue('Hurricanes Recorded by NOAA from 1991 to {last_year}'),
       x = 'Number of hurricanes in each year',
       y = '')
ggsave('plots/boxplot_by_year.png')

h_by_year |>
  ggplot(aes(x = as_date(str_glue("{year}-06-01")), y = n, color = basin)) +
  geom_point() +
  geom_smooth(span = 1.2) +
  labs(title =str_glue('Hurricanes Recorded by NOAA from 1991 to {last_year}'),
       x = 'Year',
       y = 'Number of hurricanes') +
  coord_cartesian(ylim = c(0, NA)) # Set lower limit of y-axis to 0
ggsave('plots/scatterplot_by_year.png')

all <- readRDS('data/noaa_hurricanes.rds')

