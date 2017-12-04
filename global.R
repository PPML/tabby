
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
