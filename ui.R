fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css?family=Arsenal|Quicksand:400,700"),
    singleton(tags$link(rel = "stylesheet", href = "eyeglass/css/main.css")),
    singleton(tags$link(rel = "stylesheet", href = "eyeglass/css/notifications.css")),
    singleton(tags$link(rel = "stylesheet", href = "shared/font-awesome/css/font-awesome.min.css"))
  ),
  tags$nav(
    class = "navbar-dull navbar navbar-default",
    tags$div(
      class = "container-fluid",
      tags$div(
        class = "navbar-header",
        tags$a(
          class = "navbar-brand",
          href = "#",
          tags$img(src = "eyeglass/images/ppml-logo-tiny.png")
        )
      ),
      tags$ul(
        id = "tab",
        class = "nav navbar-nav navbar-left",
        tags$li(
          class = "active",
          tags$a(
            `data-toggle` = "tab",
            `data-value` = "estimates",
            `data-target` = ".estimates-tab",
            tags$span(
              icon("line-chart"),
              "Estimates"
            )
          )
        ),
        tags$li(
          tags$a(
            `data-toggle` = "tab",
            `data-value` = "trends",
            `data-target` = ".trends-tab",
            tags$span(
              icon("area-chart"),
              "Time trends"
            )
          )
        ),
        tags$li(
          tags$a(
            `data-toggle` = "tab",
            `data-value` = "ages",
            `data-target` = ".ages-tab",
            tags$span(
              icon("bar-chart"),
              "Age groups"
            )
          )
        )
      ),
      tags$form(
        class = "navbar-form navbar-right",
        tags$button(
          class = "btn btn-default navbar-button action-button shiny-bound-input",
          type = "button",
          id = "tour",
          "Take tour"
        )
      )
    )
  ),
  tags$div(
    class = "tab-content",
    fluidRow(
      class = "tab-pane active estimates-tab trends-tab ages-tab",
      column(
        width = 4,
        class = "tab-content",
        tabSidePanel(
          id = "estimates",
          active = TRUE,
          comparators = comparators,
          populations = populations,
          ages = ages$estimates,
          outcomes = outcomes$estimates,
          interventions = interventions,
          analyses = analyses
        ),
        tabSidePanel(
          id = "trends",
          comparators = comparators,
          populations = populations,
          ages = ages$trends,
          outcomes = outcomes$trends,
          interventions = interventions,
          analyses = analyses
        ),
        tabSidePanel(
          id = "ages",
          populations = populations,
          years = years$ages,
          outcomes = outcomes$ages,
          interventions = interventions,
          analyses = analyses
        )
      ),
      column(
        width = 8,
        class = "tab-content",
        tabMainPanel(
          id = "estimates",
          active = TRUE,
          brush = TRUE,
          click = TRUE,
          dblclick = TRUE
        ),
        tabMainPanel(
          id = "trends"
        ),
        tabMainPanel(
          id = "ages"
        )
      )
    )
  ),
  tags$footer(
    singleton(tags$script(src = "eyeglass/scripts/untitled.js")),
    singleton(tags$script(src = "eyeglass/scripts/resize.js"))
  )
)
