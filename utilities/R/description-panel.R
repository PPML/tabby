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

    p("Tabby is an application developed to visualize simulated outcomes of various
      intervention scenarios in a model of tuberculosis in the United States.
      Tabby allows these interventions to be contrasted in their outcomes,
      showing how different intervention strategies yield improved outcomes
      in different ways."),

    p("The model divides its population into compartments by age groups and nativity.
      Outcomes include incidence and prevalence rates broken down into rates
      describing active, latent, and, multi-drug-resistant tuberculosis."),

    p(
      "Tabby has three pages: Estimates, Time Trends, and Age Groups. The estimates
      page visualizes outcomes in 2016, 2025, 2050, 2075, and 2100 by a
      choice of comparator which adjusts the plot such that estimates of intervention
      outcomes are shown directly, as a percentages of the estimated values in the
      base-case, or as percentages of the base case intervention in 2016.
      The time trends page depicts the same intervention outcomes as displayed on the
      Estimates tab, but in a continuous plot depicting values for every year after
      2016 in the 21st century. The age groups page visualizes outcomes for 11 age
      groups in a specific year chosen by the user."),

    p(
      "The following are descriptions of several of the options available for
      visualization in Tabby."
    ),

    h3("Descriptions of Outcomes"),
    tags$ul(

      tags$li(
        "New TB infections - TB cases identified each year (includes TB cases identified
        after death)"
      ),
      tags$li(
        "LTBI Prevalence - Incident M. TB infections each year due to transmission within
      the US (includes reinfection of individuals with prior infection, excludes
      immigrants entering the US with established LTBI)"
      ),
      tags$li(
        "MDR-TB in New TB Cases - Incident M. TB infections each year due to transmission
        within the US (includes reinfection of individuals with prior infection,
                       excludes immigrants entering the US with established LTBI)"
      ),
      tags$li(
        "Incidence - Incident M. TB infections each year due to transmission within the
        US (includes reinfection of individuals with prior infection, excludes
        immigrants entering the US with established LTBI)"
      ),
      tags$li(
        "TB-Related Deaths - Number of deaths attributable to TB each year"
      )
    ),

    h3("Intervention Scenarios"),

    tags$ul(

      tags$li(
        "TLTBI for New Immigrants - Provision of LTBI testing and treatment for all new
        legal immigrants entering the US"
        ),

      tags$li(
        "Improved TLTBI in the United States - Intensification of the current LTBI
        targeted testing and treatment policy for high-risk populations, doubling
        treatment uptake within each risk group compared to current levels, and
        increasing the fraction cured among individuals initiating LTBI treatment, via a
        3-month Isoniazid-Rifapentine drug regimen"
      ),

      tags$li(
        "Better Case Detection - Improved detection of active TB cases, such that the
        duration of untreated active disease (time from TB incidence to the initiation
        of treatment) is reduced by 50%"
      ),

      tags$li(
        "Better TB Treatment - Improved treatment quality for active TB, such that
        treatment default, failure rates, and the fraction of individuals receiving an
        incorrect drug regimen are reduced by 50% from current levels"
      ),

      tags$li(
        "All Improvements - The combination of all intervention scenarios described above"
      )
    ),

    h3("Additional Scenarios"),

    tags$ul(

      tags$li(
        "No Transmission Within the United States after 2016 - From 2016 onwards, no
        individuals acquire M. TB infection from transmission within the United States.
        In this scenario the only source of new LTBI cases is from existing infection in
        new immigrants."
      ),

      tags$li(
        "No LTBI Among Immigrants after 2016 - From 2016 onwards, all individuals
        immigrating to the United States are free of M. TB infection, while maintaining
        the same total volume of immigration."
      )
    )
  )
}
