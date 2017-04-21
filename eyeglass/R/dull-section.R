section <- function(id, heading, ..., class = NULL, iconCollapsed = "angle-right",
                    iconOpen = "angle-down",  collapsed = FALSE) {
  ns <- NS(id)

  iconCollapsed <- icon2unicode(iconCollapsed)
  iconOpen <- icon2unicode(iconOpen)

  tags$div(
    singleton(tags$head(tags$link(rel = "stylesheet", href = "eyeglass/css/dull-section.css"))),
    singleton(tags$head(tags$link(src = "eyeglass/js/dull-section.js"))),
    class = paste(c("dull-section", class), collapse = " "),
    tags$div(
      class = "dull-section-toggle",
      tags$label(
        class = if (collapsed) "collapsed",
        `data-toggle` = "collapse",
        `data-target` = paste0("#", ns("content")),
        tags$span(
          `data-icon-collapsed` = iconCollapsed,
          `data-icon-expanded` = iconOpen,
          heading
        )
      )
    ),
    tags$div(
      id = ns("content"),
      class = paste0("dull-section-content collapse", if (!collapsed) " in"),
      ...
    )
  )
}
