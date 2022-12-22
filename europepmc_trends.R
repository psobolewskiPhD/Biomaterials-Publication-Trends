library(europepmc)
library(firatheme)
library(tidyverse)

# search for biomaterial, biomaterials, or biocompatibility in Abstracts, Titles, and Keywords
# the query: https://europepmc.org/search?query=%28ABSTRACT%3A%22biomaterial%22%20OR%20ABSTRACT%3A%22biomaterials%22%20OR%20ABSTRACT%3A%22biocompatibility%22%20OR%20TITLE%3A%22biomaterial%22%20OR%20TITLE%3A%22biomaterials%22%20OR%20TITLE%3A%22biocompatibility%22%20OR%20KW%3A%22biomaterial%22%20OR%20KW%3A%22biomaterials%22%20OR%20KW%3A%22biocompatibility%22%29
query_text <- '(ABSTRACT:"biomaterial" OR ABSTRACT:"biomaterials" OR ABSTRACT:"biocompatibility" OR TITLE:"biomaterial" OR TITLE:"biomaterials" OR TITLE:"biocompatibility" OR KW:"biomaterial" OR KW:"biomaterials" OR KW:"biocompatibility")'

# execute the query
trend_data <- europepmc::epmc_hits_trend(query = query_text,
                                        period = 2012:2022)
# plot a line plot
trend_data %>% 
    ggplot(aes(year, query_hits / all_hits)) + 
    geom_point() + 
    geom_smooth(se = FALSE) +
    scale_y_continuous(limits = c(0, 0.007), expand = c(0,0), breaks= scales::breaks_pretty()) +
    scale_x_continuous(breaks= scales::breaks_pretty()) + 
    labs(x = "Year", y = "Proportion of all EuropePMC documents") +
    theme_fira() -> EuropePMC_trends

# save the figure as a png
cowplot::save_plot("EuropePMC_trends.png", EuropePMC_trends, base_width = 6)
