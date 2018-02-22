emptyDescriptionPanel <- function() {
  tags$div(
    class="about-tab tab-pane"
  )
}

emptyEstimatesPanel <- function() {
  tags$div(
    class="estimates-tab tab-pane"
  )
}

emptyTrendsPanel <- function() {
  tags$div(
    class="trends-tab tab-pane"
  )
}


emptyAgeGroupsPanel <- function() {
  tags$div(
    class="agegroups-tab tab-pane"
  )
}

descriptionPanel <- function() {
  tags$div(
    class="about-tab tab-pane active",

    h1("About Tabby"),

    tags$br(),

    p("Tabby is a web application providing predictions of future TB epidemiology in the United States under a range of different assumptions and policy scenarios. Users can select a health outcome and subpopulation of interest, then select one or multiple scenarios to compare. Results are displayed graphically, and following inputs from the user the graphs update automatically to reflect the new selections. Visualizations can be downloaded in various formats, and the estimates underlying the graphs can also be downloaded in tabular format."),

    p("The estimates shown by Tabby are based on a transmission-dynamic model of TB epidemiology in the US, incorporating TB transmission and natural history; TB drug resistance patterns; prior and future TB prevention and control; the impact of HIV on TB; heterogeneity in TB risks among US-born and foreign-born populations; and age-based differences in disease mechanisms and risk factor prevalence. Detailed methods (analytic methods, scenario and outcome definitions) and main results for this analysis are described in detail in \"Prospects for tuberculosis elimination in the United States: results of a transmission dynamic model\" [citation info to be added]."),

    p("The findings and conclusions described in this web application and linked journal article are those of the author(s) and do not necessarily represent the views of the US Centers for Disease Control and Prevention. This web tool was funded by the CDC, National Center for HIV, Viral Hepatitis, STD, and TB Prevention Epidemiologic and Economic Modeling Agreement (NEEMA, # 5U38PS004644-01)."),

    h3("Organization"),

    p("Tabby has three pages with interactive visualizations: ", tags$em("Estimates, Time Trends,"), " and ", tags$em("Age Groups."), "Each page can be accessed from the menu bar at the top of the page."),

    p("The ", tags$em("Estimates"), " page visualizes predicted TB outcomes at 5 major time points: 2016, 2025, 2050, 2075, and 2100. The ", tags$em("Time Trends"), " page depicts predicted TB outcomes for each individual year from 2016 to 2100. The ", tags$em("Age Groups"), " page visualizes predicted TB outcomes for a specified year subdivided into 11 age groups."),

    h4("Estimates and Time Trends pages"),

    p("User options are shown in a column on the left. The user specifies:"),

    p(tags$em("Comparator:"), " results can be shown as absolute values for each outcome in each year, or as a percentage of the base case scenario in the same year, or as a percentage of the base case scenario in 2016."),

    p(tags$em("Subgroup:"), " results can be shown for the total population, or for a subgroup described by nativity (US-born, foreign-born), and broad age groups (0-24 years, 25-64 years, 65+ years)."),

    p(tags$em("Outcome:"), " results can be shown for five different outcomes: 'Incident TB infections' representing the annual number of incident ", tags$em("M. tb (Mycobacterium tuberculosis)"), " infections per million due to transmission within the US (includes reinfection of individuals with prior infection, excludes immigrants entering the US with established LTBI); 'LTBI Prevalence' representing the percentage of individuals with latent TB infection in a given year; 'Active TB Incidence' representing the annual number of notified TB cases per million, including TB cases identified after death;  'MDR-TB in incident TB cases' representing the percentage of all incident TB cases with MDR-TB; and 'TB-Related Deaths' representing annual TB-attributable mortality per million."),

    p(tags$em("Scenarios:"), " results can be shown for up to seven  scenarios selected by the user, describing different assumptions about future TB prevention and control policy ('Intervention Scenarios'), or trends in major epidemiological determinants ('Additional Scenarios'). Descriptions for each scenario are provided below."),

    p(tags$em("Download:"), " clicking on a button initiates download of the visualization itself (.png, .pdf, .pptx) or the estimates underlying the visualization (.csv, .xlsx)."),

    h4("Age Groups page"),

    p("This page matches the format of the first two pages with the following exceptions:"),

    p(tags$em("Comparator:"), " results are only shown as absolute values for each outcome in each year."),

    p(tags$em("Subgroup:"), " results can be shown for the total population, or for US-born and foreign-born alone."),

    p(tags$em("Outcomes:"), " results can be shown for three major outcomes (LTBI prevalence, TB incidence, and TB-related deaths), either as a prevalence or incidence rate with each age group (first three selections), or in absolute numbers (last three selections)."),

    p("The following are descriptions of the intervention scenarios and outcomes available for visualization in Tabby. "),

    h3("Scenarios"),

    h4("Intervention Scenarios"),

    tags$ul(
      tags$li("'TLTBI for New Immigrants': Provision of LTBI testing and treatment for all new legal immigrants entering the US."),

      tags$li("'Improved TLTBI in the United States': Intensification of the current LTBI targeted testing and treatment policy for high-risk populations, doubling treatment uptake within each risk group compared to current levels, and increasing the fraction cured among individuals initiating LTBI treatment, via a 3-month Isoniazid-Rifapentine drug regimen."),

      tags$li("'Better Case Detection': Improved detection of active TB cases, such that the duration of untreated active disease (time from TB incidence to the initiation of treatment) is reduced by 50%."),

      tags$li("'Better TB Treatment': Improved treatment quality for active TB, such that treatment default, failure rates, and the fraction of individuals receiving an incorrect drug regimen are reduced by 50% from current levels."),

      tags$li("'All Improvements': The combination of all intervention scenarios described above.")
    ),

    h4("Additional Scenarios"),

    tags$ul(
      tags$li("'No Transmission Within the United States after 2016': From 2016 onwards, no individuals acquire ", em("M. tb"), " infection from transmission within the United States. In this scenario the only source of new LTBI cases is from existing infection in new migrants entering the country."),

      tags$li("'No LTBI Among Immigrants after 2016': From 2016 onwards, all individuals immigrating to the United States are free of ", em("M. tb"), " infection, while maintaining the same total volume of immigration.")

    ),

    h3("508 Accessibility of This Product"),

    p("Section 508 requires Federal agencies and grantees receiving Federal funds to ensure that individuals with disabilities who are members of the public or Federal employees have access to and use of electronic and information technology (EIT) that is comparable to that provided to individuals without disabilities, unless an undue burden would be imposed on the agency."),

    p("If you need assistance with this web application, please contact ", tags$a("ppml@hsph.harvard.edu", href='mailto:ppml@hsph.harvard.edu'))

  )
}
