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
    shiny::includeMarkdown(system.file("about-tabby.md", package = "utilities", mustWork = TRUE))
  )
}
