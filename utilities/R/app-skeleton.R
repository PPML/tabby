# estimates ----
estimates <- list(
  IDs = list(
    controls = list(
      comparators = "estimatesComparator",
      populations = "estimatesPopulation",
      ages = "estimatesAges",
      outcomes = "estimatesOutcomes",
      interventions = "estimatesInterventions",
      analyses = "estimatesAnalyses",
      colorblind = "estimatesColorblind"
    ),
    downloads = list(
      png = "estimatesPNG",
      pdf = "estimatesPDF",
      pptx = "estimatesPPTX",
      csv = "estimatesCSV",
      xlsx = "esimtatesXLSX"
    ),
    panels = list(
      control = "estimatesControlPanel",
      visualization = "estimatesVisualizationPanel"
    ),
    brush = "estimatesPlotBrush",
    click = "esimtatesPlotClick",
    dblclick = "estimatesPlotDblclick",
    title = "estimatesTitle",
    subtitle = "estimatesSubtitle",
    plot = "estimatesPlot"
  ),
  comparators = list(
    heading = "Comparator",
    values = c(
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
  ),
  populations =  list(
    heading = "Population",
    values = c(
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
  ),
  ages = list(
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
  ),
  outcomes = list(
    heading = "Outcome",
    values = c(
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
  ),
  interventions = list(
    heading = "Intervention scenarios",
    values = c(
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
  ),
  analyses = list(
    heading = "Additional scenarios",
    values = c(
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
  ),
  downloads = list(
    heading = "Download",
    labels = c(
      "PNG",
      "PDF",
      "PPTX",
      "CSV",
      "XLSX"
    )
  )
)

# trends ----
trends <- list(
  IDs = list(
    controls = list(
      comparators = "trendsComparator",
      populations = "trendsPopulations",
      ages = "trendsAges",
      outcomes = "trendsOutcomes",
      interventions = "trendsInterventions",
      analyses = "trendsAnalyses",
      colorblind = "trendsColorblind"
    ),
    downloads = list(
      png = "trendsPNG",
      pdf = "trendsPDF",
      pptx = "trendsPPTX",
      csv = "trendsCSV",
      xlsx = "trendsXLSX"
    ),
    panels = list(
      control = "trendsControlPanel",
      visualization = "trendsVisualizationPanel"
    ),
    title = "trendsTitle",
    subtitle = "trendsSubtitle",
    plot = "trendsPlot"
  ),
  comparators = list(
    heading = "Comparator",
    values = c(
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
  ),
  populations = list(
    heading = "Population",
    values = c(
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
  ),
  ages = list(
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
  ),
  outcomes = list(
    heading = "Outcome",
    values = c(
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
  interventions = list(
    heading = "Intervention scenarios",
    values = c(
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
  ),
  analyses = list(
    heading = "Additional scenarios",
    values = c(
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
  ),
  downloads = list(
    heading = "Download",
    labels = c(
      "PNG",
      "PDF",
      "PPTX",
      "CSV",
      "XLSX"
    )
  )
)

# agegroups ----
agegroups <- list(
  IDs = list(
    controls = list(
      comparators = "agegroupComparator",
      populations = "agegroupPopulations",
      years = "agegroupYears",
      outcomes = "agegroupOutcomes",
      interventions = "agegroupInterventions",
      analyses = "agegroupAnalyses",
      colorblind = "agegroupsColorblind"
    ),
    downloads = list(
      png = "agegroupsPNG",
      pdf = "agegroupsPDF",
      pptx = "agegroupsPPTX",
      csv = "agegroupsCSV",
      xlsx = "agegroupsXLSX"
    ),
    panels = list(
      control = "agegroupsControlPanel",
      visualization = "agegroupsVisualizationPanel"
    ),
    title = "agegroupTitle",
    subtitle = "agegroupSubtitle",
    plot = "agegroupPlot"
  ),
  comparators = list(
    heading = "Comparator",
    values = c(
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
  ),
  populations = list(
    heading = "Populations",
    values = c(
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
  ),
  years = list(
    heading = "Year",
    min = 2016,
    max = 2099,
    step = 1
  ),
  outcomes = list(
    heading = "Outcomes",
    values = c(
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
  interventions = list(
    heading = "Intervention scenarios",
    values = c(
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
  ),
  analyses = list(
    heading = "Additional scenarios",
    values = c(
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
  ),
  downloads = list(
    heading = "Download",
    labels = c(
      "PNG",
      "PDF",
      "PPTX",
      "CSV",
      "XLSX"
    )
  )
)
