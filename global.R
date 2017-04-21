if (!interactive()) {
  if (dir.exists("~/.fonts/arsenal/")) {
    unlink("~/.fonts/arsenal", recursive = TRUE)
  } else {
    dir.create("~/.fonts")
  }

  system("cp -r eyeglass/inst/fonts/arsenal ~/.fonts")
  system("fc-cache -f ~/.fonts")
}

library(shiny)
library(Cairo)

options(shiny.usecairo = TRUE)

devtools::load_all("eyeglass")

# suppressMessages(extrafont::font_import("eyeglass/inst/fonts/arsenal/", prompt = FALSE))
# suppressMessages(extrafont::loadfonts())

addResourcePath("eyeglass", "www")

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

comparators <- list(
  heading = "Comparator",
  choices = c(
    "absolute_value",
    "pct_basecase_same_year",
    "pct_basecase_2016"
  ),
  labels = c(
    "absolute_value" = "Estimated values",
    "pct_basecase_same_year" = "Percentage of base case value in the same year",
    "pct_basecase_2016" = "Percentage of base case value in 2016"
  ),
  formatted = c(
    "absolute_value" = "",
    "pct_basecase_same_year" = "Percentage of base case value in the same year",
    "pct_basecase_2016" = "Percentage of base case value in 2016"
  ),
  selected = c(
    TRUE,
    FALSE,
    FALSE
  )
)

populations <- list(
  heading = "Population",
  choices = c(
    "all_populations",
    "usb_population",
    "fb_population"
  ),
  labels = c(
    "all_populations" = "Total", # US population",
    "usb_population" = "US-born", # population",
    "fb_population" = "Foreign-born" # US population"
  ),
  selected = c(
    TRUE,
    FALSE,
    FALSE
  ),
  formatted = c(
    "all_populations" = "total US population",
    "usb_population" = "US-born population",
    "fb_population" = "foreign-born US population"
  )
)

ages <- list(
  estimates = list(
    heading = "Age groups",
    values = c(
      "all_ages",
      "age_0_24",
      "age_25_64",
      "age_65p"
    ),
    labels = c(
      "all_ages" = "All",
      "age_0_24" = "0 to 24",
      "age_25_64" = "25 to 64",
      "age_65p" = "65+"
    ),
    formatted = c(
      "all_ages" = "all age groups",
      "age_0_24" = "0 to 24 years old",
      "age_25_64" = "25 to 64 years old",
      "age_65p" = "65+ years old"
    ),
    selected = c(
      TRUE,
      FALSE,
      FALSE,
      FALSE
    )
  ),
  trends = list(
    heading = "Age groups",
    values = c(
      "all_ages",
      "age_0_24",
      "age_25_64",
      "age_65p"
    ),
    labels = c(
      "all_ages" = "All ages",
      "age_0_24" = "0 to 24",
      "age_25_64" = "25 to 64",
      "age_65p" = "65+"
    ),
    formatted = c(
      "all_ages" = "all age groups",
      "age_0_24" = "0 to 24 years old",
      "age_25_64" = "25 to 64 years old",
      "age_65p" = "65+ years old"
    ),
    selected = c(
      TRUE,
      FALSE,
      FALSE,
      FALSE
    )
  )
)

years <- list(
  ages = list(
    heading = "Year",
    min = 2016,
    max = 2099,
    step = 1
  )
)

outcomes <- list(
  ages = list(
    heading = "Outcome",
    choices = c(
      "pct_ltbi",
      "tb_incidence_per_mil",
      "tb_mortality_per_mil",
      "ltbi_000s",
      "tb_incidence_000s",
      "tb_mortality_000s"
    ),
    labels = c(
      "pct_ltbi" = "LTBI prevalence (per million)",
      "tb_incidence_per_mil" = "TB incidence (per million)",
      "tb_mortality_per_mil" = "TB-related deaths (per million)",
      "ltbi_000s" = "New TB infections (in thousands)",
      "tb_incidence_000s" = "TB incidence (in thousands)",
      "tb_mortality_000s" = "TB-related deaths (in thousands)"
    ),
    formatted = list(
      "pct_ltbi" = "LTBI prevalence\n(percentage)",
      "tb_incidence_per_mil" = "TB incidence\n(per million)",
      "tb_mortality_per_mil" = "TB-related deaths\n(per million)",
      "ltbi_000s" = "New TB infections\n(in thousands)",
      "tb_incidence_000s" = "TB incidence\n(in thousands)",
      "tb_mortality_000s" = "TB-related deaths\n(in thousands)"
    ),
    selected = c(
      TRUE,
      FALSE,
      FALSE,
      FALSE,
      FALSE,
      FALSE
    )
  ),
  trends = list(
    heading = "Outcome",
    choices = c(
      "tb_infection_per_mil",
      "pct_ltbi",
      "tb_incidence_per_mil",
      "pct_mdrtb_in_incident_tb",
      "tb_deaths_per_mil"
    ),
    labels = c(
      "tb_infection_per_mil" = "New TB infections",
      "pct_ltbi" = "LTBI prevalence",
      "tb_incidence_per_mil" = "TB incidence",
      "pct_mdrtb_in_incident_tb" = "MDR-TB in new TB cases",
      "tb_deaths_per_mil" = "TB-related deaths"
    ),
    formatted = c(
      "tb_infection_per_mil" = "New TB Infections\n(per million)",
      "pct_ltbi" = "LTBI Prevalence\n(percentage)",
      "tb_incidence_per_mil" = "Incident M. TB Infection\n(per million)",
      "pct_mdrtb_in_incident_tb" = "MDR-TB in New TB Cases\n(percentage)",
      "tb_deaths_per_mil" = "TB-Related Deaths\n(per million)"
    ),
    selected = c(
      TRUE,
      FALSE,
      FALSE,
      FALSE,
      FALSE
    )
  ),
  estimates = list(
    heading = "Outcome",
    choices = c(
      "tb_infection_per_mil",
      "pct_ltbi",
      "tb_incidence_per_mil",
      "pct_mdrtb_in_incident_tb",
      "tb_deaths_per_mil"
    ),
    labels = c(
      "tb_infection_per_mil" = "New TB infections",
      "pct_ltbi" = "LTBI prevalence",
      "tb_incidence_per_mil" = "TB incidence",
      "pct_mdrtb_in_incident_tb" = "MDR-TB in new TB cases",
      "tb_deaths_per_mil" = "TB-related deaths"
    ),
    formatted = c(
      "tb_infection_per_mil" = "New TB Infections\n(per million)",
      "pct_ltbi" = "LTBI Prevalence\n(percentage)",
      "tb_incidence_per_mil" = "Incident M. TB Infection\n(per million)",
      "pct_mdrtb_in_incident_tb" = "MDR-TB in New TB Cases\n(percentage)",
      "tb_deaths_per_mil" = "TB-Related Deaths\n(per million)"
    ),
    selected = c(
      TRUE,
      FALSE,
      FALSE,
      FALSE,
      FALSE
    ),
    abbreviations = c(
      "tb_infection_per_mil" = "new-tb",
      "pct_ltbi" = "ltbi-prev",
      "tb_incidence_per_mil" = "tb-in",
      "pct_mdrtb_in_incident_tb" = "mdr-tb",
      "tb_deaths_per_mil" = "tb-mort"
    )
  )
)

interventions <- list(
  heading = "Intervention scenarios",
  choices = c(
    "intervention_1",
    "intervention_2",
    "intervention_3",
    "intervention_4",
    "intervention_5"
  ),
  labels = c(
    "intervention_1" = "TLTBI for new immigrants",
    "intervention_2" = "Improved TLTBI in the US",
    "intervention_3" = "Better case detection",
    "intervention_4" = "Better TB treatment",
    "intervention_5" = "All improvements"
  )
)

analyses <- list(
  heading = "Additional scenarios",
  choices = c(
    "scenario_1",
    "scenario_2"
  ),
  labels = c(
    "scenario_1" = "No transmission within the US after 2016",
    "scenario_2" = "No LTBI among immigrants after 2016"
  ),
  formatted = c(
    "scenario_1" = "No transmission within\nthe US after 2016",
    "scenario_2" = "No LTBI among\nimmigrants after 2016"
  )
)

settings <- list(
  color = list(
    standard = c(
      "base_case" = "#0E1111",
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
