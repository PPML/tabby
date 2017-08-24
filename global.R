options(shiny.usecairo = TRUE)

library(shiny)
library(Cairo)

lapply(
  c("dplyr", "tidyr", "ggplot2", "ggrepel", "extrafont", "stringr", "officer",
    "purrr", "scales", "naturalsort"),
  library,
  logical.return = TRUE,
  character.only = TRUE
)

devtools::load_all("utilities")

#addResourcePath("eyeglass", "www")

.ESTIMATES <- data_estimates()
.TRENDS <- data_trends()
.AGEGROUPS <- data_agegroups()

.REGIONS <- data.frame(
  year = c(2000, 2025, 2050, 2075, 2100),
  right_bound = c(2000, 2025, 2050, 2075, 2100) + 12,
  left_bound = c(2000, 2025, 2050, 2075, 2100) - 12,
  top_bound = rep(Inf),
  bottom_bound = rep(-Inf)
)

settings <- list(
  font = if (interactive()) "Times" else "Helvetica-Narrow",
  color = list(
    standard = c(
      "base_case" = "#8A9DA3",
      "intervention_1" = "#C7351E",
      "intervention_2" = "#5BBCD6",
      "intervention_3" = "#7B6DA8",
      "intervention_4" = "#F9AD00",
      "intervention_5" = "#00A08A",
      "scenario_1" = "#ECCBAE",
      "scenario_2" = "#046C9A"
    ),
    colorblind = c(
      "base_case" = "#000000",
      "intervention_1" = "#D55E00",
      "intervention_2" = "#56B4E9",
      "intervention_3" = "#CC79A7",
      "intervention_4" = "#F0E442",
      "intervention_5" = "#009E73",
      "scenario_1" = "#E69F00",
      "scenario_2" = "#0072B2"
    )
  )
)
