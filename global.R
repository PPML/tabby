
library(shiny)
options(shiny.usecairo = TRUE)

library(Cairo)
library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)
library(ggrepel)
library(viridis)
library(stringr)
library(officer)
library(scales)
library(naturalsort)
library(yaml)

devtools::load_all("utilities")

ESTIMATES_DATA <- utilities::data_estimates()
TRENDS_DATA <- utilities::data_trends()
AGEGROUPS_DATA <- utilities::data_agegroups()

plots <- utilities::config_plots()
# bit of a hacky work around
for (i in c("colors", "shapes", "linetypes", "labels")) {
  plots[[i]] <- unlist(plots[[i]])
}

estimates <- utilities::config_estimates()
trends <- utilities::config_trends()
agegroups <- utilities::config_agegroups()
