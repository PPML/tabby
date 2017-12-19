
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

ESTIMATES_DATA <- data_estimates()
TRENDS_DATA <- data_trends()
AGEGROUPS_DATA <- data_agegroups()

plots <- config_plots()
# bit of a hacky work around
for (i in c("colors", "shapes", "linetypes", "labels")) {
  plots[[i]] <- unlist(plots[[i]])
}

estimates <- config_estimates()
trends <- config_trends()
agegroups <- config_agegroups()
