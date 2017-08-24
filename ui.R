fluidPage(
  # tags$head(
  #   tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css?family=Arsenal|Quicksand:400,700"),
  #   singleton(tags$link(rel = "stylesheet", href = "eyeglass/css/main.css")),
  #   singleton(tags$link(rel = "stylesheet", href = "eyeglass/css/notifications.css")),
  #   singleton(tags$link(rel = "stylesheet", href = "shared/font-awesome/css/font-awesome.min.css"))
  # ),
  includeScript("www/js/update-alt-text.js"),
  includeScript("www/js/tab-keypress.js"),
  fluidRow(
    column(
      width = 12,
      role = "tabpanel",
      tags$nav(
        class = "navbar-dull navbar navbar-default",
        tags$div(
          class = "container-fluid",
          tags$ul(
            id = "tab",
            class = "nav navbar-nav navbar-left",
            tags$li(
              class = "active",
              tags$a(
                `data-toggle` = "tab",
                `data-value` = "estimates",
                `data-target` = ".estimates-tab",
                tabindex = 0,
                tags$span(
                  tagAppendAttributes(
                    icon("line-chart"),
                    `aria-hidden` = TRUE
                  ),
                  "Estimates"
                )
              )
            ),
            tags$li(
              tags$a(
                `data-toggle` = "tab",
                `data-value` = "trends",
                `data-target` = ".trends-tab",
                tabindex = 0,
                tags$span(
                  tagAppendAttributes(
                    icon("area-chart"),
                    `aria-hidden` = TRUE
                  ),
                  "Time trends"
                )
              )
            ),
            tags$li(
              tags$a(
                `data-toggle` = "tab",
                `data-value` = "ages",
                `data-target` = ".agegroups-tab",
                tabindex = 0,
                tags$span(
                  tagAppendAttributes(
                    icon("bar-chart"),
                    `aria-hidden` = TRUE
                  ),
                  "Age groups"
                )
              )
            )
          )
        )
      )
    )
  ),
  fluidRow(
    column(
      width = 4,
      class = "tab-content",
      estimatesControlPanel(),
      trendsControlPanel(),
      agegroupsControlPanel()
    ),
    column(
      width = 8,
      class = "tab-content",
      estimatesVisualizationPanel(),
      trendsVisualizationPanel(),
      agegroupsVisualizationPanel()
    )
  )
)
