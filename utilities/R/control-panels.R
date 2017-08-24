estimatesControlPanel  <- function() {
  controlPanel(
    class = "estimates-tab",
    active = TRUE,
    comparators = radioButtons2(
      id = estimates$IDs$controls$comparators,
      heading = estimates$comparators$heading,
      labels = estimates$comparators$labels,
      values = estimates$comparators$values,
      selected = estimates$comparators$selected
    ),
    populations = radioButtons2(
      id = estimates$IDs$controls$populations,
      heading = estimates$populations$heading,
      labels = estimates$populations$labels,
      values = estimates$populations$values,
      selected = estimates$populations$selected
    ),
    ages = radioButtons2(
      id = estimates$IDs$controls$ages,
      heading = estimates$ages$heading,
      labels = estimates$ages$labels,
      values = estimates$ages$values,
      selected = estimates$ages$selected
    ),
    outcomes = radioButtons2(
      id = estimates$IDs$controls$outcomes,
      heading = estimates$outcomes$heading,
      labels = estimates$outcomes$labels,
      values = estimates$outcomes$values,
      selected = estimates$outcomes$selected
    ),
    interventions = checkboxGroup2(
      id = estimates$IDs$controls$interventions,
      heading = estimates$interventions$heading,
      labels = estimates$interventions$labels,
      values = estimates$interventions$values
    ),
    analyses = checkboxGroup2(
      id = estimates$IDs$controls$analyses,
      heading = estimates$analyses$heading,
      labels = estimates$analyses$labels,
      values = estimates$analyses$values
    ),
    colorblind = checkboxGroup2(
      id = estimates$IDs$controls$colorblind,
      heading = "Options",
      labels = "Enable colorblind mode",
      values = TRUE
    ),
    downloads = downloadButtonBar(
      ids = estimates$IDs$downloads,
      heading = estimates$downloads$heading,
      labels = estimates$downloads$labels
    )
  )
}

trendsControlPanel <- function() {
  controlPanel(
    class = "trends-tab",
    comparators = radioButtons2(
      id = trends$IDs$controls$comparators,
      heading = trends$comparators$heading,
      labels = trends$comparators$labels,
      values = trends$comparators$values,
      selected = trends$comparators$selected
    ),
    populations = radioButtons2(
      id = trends$IDs$controls$populations,
      heading = trends$populations$heading,
      labels = trends$populations$labels,
      values = trends$populations$values,
      selected = trends$populations$selected
    ),
    ages = radioButtons2(
      id = trends$IDs$controls$ages,
      heading = trends$ages$heading,
      labels = trends$ages$labels,
      values = trends$ages$values,
      selected = trends$ages$selected
    ),
    outcomes = radioButtons2(
      id = trends$IDs$controls$outcomes,
      heading = trends$outcomes$heading,
      labels = trends$outcomes$labels,
      values = trends$outcomes$values,
      selected = trends$outcomes$selected
    ),
    interventions = checkboxGroup2(
      id = trends$IDs$controls$interventions,
      heading = trends$interventions$heading,
      labels = trends$interventions$labels,
      values = trends$interventions$values
    ),
    analyses = checkboxGroup2(
      id = trends$IDs$controls$analyses,
      heading = trends$analyses$heading,
      labels = trends$analyses$labels,
      values = trends$analyses$values
    ),
    colorblind = checkboxGroup2(
      id = trends$IDs$controls$colorblind,
      heading = "Options",
      labels = "Enable colorblind mode",
      values = TRUE
    ),
    downloads = downloadButtonBar(
      ids = trends$IDs$downloads,
      heading = trends$downloads$heading,
      labels = trends$downloads$labels
    )
  )
}

agegroupsControlPanel <- function() {
  controlPanel(
    class = "agegroups-tab",
    populations = radioButtons2(
      id = agegroups$IDs$controls$populations,
      heading = agegroups$populations$heading,
      labels = agegroups$populations$labels,
      values = agegroups$populations$values,
      selected = agegroups$populations$selected
    ),
    years = {
      si <- selectInput(
        inputId = agegroups$IDs$controls$years,
        label = agegroups$years$heading,
        choices = seq(from = agegroups$years$min, to = agegroups$years$max),
        selectize = FALSE
      )
      si$children[[2]]$children[[1]]$attribs$size <- 5
      si
    },
    outcomes = radioButtons2(
      id = agegroups$IDs$controls$outcomes,
      heading = agegroups$outcomes$heading,
      labels = agegroups$outcomes$labels,
      values = agegroups$outcomes$values,
      selected = agegroups$outcomes$selected
    ),
    interventions = checkboxGroup2(
      id = agegroups$IDs$controls$interventions,
      heading = agegroups$interventions$heading,
      labels = agegroups$interventions$labels,
      values = agegroups$interventions$values
    ),
    analyses = checkboxGroup2(
      id = agegroups$IDs$controls$analyses,
      heading = agegroups$analyses$heading,
      labels = agegroups$analyses$labels,
      values = agegroups$analyses$values
    ),
    colorblind = checkboxGroup2(
      id = agegroups$IDs$controls$colorblind,
      heading = "Options",
      labels = "Enable colorblind mode",
      values = TRUE
    ),
    downloads = downloadButtonBar(
      ids = agegroups$IDs$downloads,
      heading = agegroups$downloads$heading,
      labels = agegroups$downloads$labels
    )
  )
}

controlPanel <- function(class, active = FALSE, comparators = NULL,
                         populations = NULL, ages = NULL, years = NULL,
                         outcomes = NULL, interventions = NULL,
                         analyses = NULL, colorblind = NULL, downloads = NULL) {
  tags$div(
    class = class,
    class = paste(c(class, "tab-pane", if (active) "active"), collapse = " "),
    comparators,
    populations,
    ages,
    years,
    outcomes,
    interventions,
    analyses,
    colorblind,
    downloads
  )
}
