fluidPage(
  includeScript("www/js/update-alt-text.js"),
  includeScript("www/js/tab-keypress.js"),
  tags$head(
    tags$style(
      type = "text/css",
      ".main-content { margin-top: 65px; }",
      ".recalculating { opacity: 1.0; }",
      ".nav a { cursor: pointer; }",
      ".tooltip-inner { width: 150px; }"
    )
  ),
  tags$div(
    role = "tabpanel",
    tags$nav(
      class = "navbar-dull navbar navbar-default navbar-fixed-top",
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
  ),
  fluidRow(
    class = "main-content",
    column(
      width = 4,
      class = "tab-content",
      utilities::estimatesControlPanel(),
      utilities::trendsControlPanel(),
      utilities::agegroupsControlPanel()
    ),
    column(
      width = 8,
      class = "tab-content",
      utilities::estimatesVisualizationPanel(),
      utilities::trendsVisualizationPanel(),
      utilities::agegroupsVisualizationPanel()
    )
  )
)
