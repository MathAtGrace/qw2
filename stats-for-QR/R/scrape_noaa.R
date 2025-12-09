library(tidyverse)
library(xml2)
library(janitor)
library(rvest)

#Change the last year to be the last complete year
last_year = 2024
saveRDS(last_year, 'data/last_year.rds')

year <- 1991:last_year
basin <- c('atl', 'epac', 'cpac')
meta_data <- expand_grid(year, basin) |>
  mutate(url = str_glue(
    "https://www.nhc.noaa.gov/data/tcr/index.php?season={year}&basin={basin}"))
meta_list <- meta_data |>
  pmap(~ list(...))

#read the html for each page
pages <- lapply(meta_data$url, read_html)
#Zip the meta data with the pages
pages_w_meta <- mapply(list, meta_list, pages, SIMPLIFY = FALSE)

#Grab the first table and format it using this function and then lapply
get_first_table <- function(page_w_meta){
  meta <- page_w_meta[[1]]
  page <- page_w_meta[[2]]
  table_data <- page |>
    html_element("table") |>
    html_table()  |>
    as.data.frame() |>
    janitor::clean_names() |>
    mutate(max_winds_kt = as.numeric(gsub("[^0-9.]", "", max_winds_kt)),
           min_pressure_mb = as.numeric(gsub("[^0-9.]", "", min_pressure_mb)),
           storm_number = as.integer(gsub("[^0-9.]", "", storm_number)),
           u_s_damagee_million = as.numeric(gsub("[^0-9.]", "", u_s_damagee_million)),
           year = meta[['year']],
           basin = factor(case_when(
             meta[['basin']] == "atl" ~ "Atlantic",
             meta[['basin']] == "epac" ~ "Eastern Pacific",
             meta[['basin']] == "cpac" ~ "Central Pacific"
           ), levels = c("Atlantic", "Eastern Pacific", "Central Pacific")),
           source = meta[['url']])
  return(table_data)
}
all <- tables <- lapply(pages_w_meta, get_first_table) |>
  bind_rows()

all |>
  saveRDS("data/noaa_hurricanes.rds")

all |>
  write.csv("data/noaa_hurricanes.csv")






#################################################
