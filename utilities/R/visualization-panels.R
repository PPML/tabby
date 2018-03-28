estimatesVisualizationPanel <- function() {
  tagAppendAttributes(
    visualizationPanel(
      id = estimates$IDs$panels$visualization,
      title = estimates$IDs$title,
      subtitle = estimates$IDs$subtitle,
      plot = estimates$IDs$plot,
      alt = "New TB infections, in the total US population, all age groups",
      brush = brushOpts(
        id = estimates$IDs$brush,
        fill = "transparent",
        stroke = "#000000"
      ),
      click = clickOpts(estimates$IDs$click),
      dblclick = dblclickOpts(estimates$IDs$dblclick),
    ),
    class = "estimates-tab"
  )
}

trendsVisualizationPanel <- function() {
  tagAppendAttributes(
    visualizationPanel(
      id = trends$IDs$panels$visualization,
      title = trends$IDs$title,
      subtitle = trends$IDs$subtitle,
      plot = trends$IDs$plot,
      alt = "New TB infections, in the total US population, all age groups"
    ),
    class = "trends-tab"
  )
}

agegroupsVisualizationPanel <- function() {
  tagAppendAttributes(
    visualizationPanel(
      id = agegroups$IDs$panels$visualization,
      title = agegroups$IDs$title,
      subtitle = NULL,
      plot = agegroups$IDs$plot,
      alt = "LTBI prevalence (per million), in the total US population, for 2016"
    ),
    class = "agegroups-tab"
  )
}

visualizationPanel <- function(id, title, subtitle, plot, alt = NULL, brush = NULL,
                               click = NULL, dblclick = NULL, active = FALSE) {
  class <- paste0(id, "-tab")

  tags$div(
    class = paste(c(class, "tab-pane", if (active) " active"), collapse = " "),
    if (!is.null(title)) {
      tags$h3(
        textOutput(title)
      )
    },
    if (!is.null(subtitle)) {
      tags$h4(
        textOutput(subtitle)
      )
    },
    do.call(
      tagAppendAttributes,
      c(
        list(
          tag = tags$div(
            id = plot,
            class = "shiny-plot-output",
            style = "width: 100%; height: 700px;",
            `data-alt` = alt,
            tags$img(alt = alt)
          )
        )
      )
    )
  )
}
