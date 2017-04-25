#' Eyeglass Application Tab Components
#'
#' Build out the tabs of the eyeglass application.
#'
#' @keywords internal
#' @name tab-side-panel
#' @export
tabSidePanel <- function(id, active = FALSE, comparators = NULL,
                         populations = NULL, ages = NULL, years = NULL,
                         outcomes = NULL, interventions = NULL,
                         analyses = NULL) {
  ns <- NS(id)
  class <- paste0(id, "-tab")

  tags$div(
    id = id,
    class = paste(c(class, "tab-pane", if (active) "active"), collapse = " "),
    tags$div(
      if (!is.null(comparators)) {
        section(
          id = ns("comparator-controls"),
          heading = comparators$heading,
          radio(
            id = ns("comparator"),
            values = comparators$choices,
            labels = comparators$labels,
            selected = comparators$selected
          )
        )
      },
      if (!is.null(c(populations, ages, outcomes, interventions, analyses))) {
        section(
          id = ns("data-controls"),
          heading = "Data",
          collapsed = FALSE,
          if (!is.null(populations)) {
            section(
              id = ns("population-controls"),
              heading = populations$heading,
              collapsed = FALSE,
              bar(
                id = ns("population"),
                values = populations$choices,
                labels = populations$labels,
                selected = populations$selected
              )
            )
          },
          if (!is.null(ages)) {
            section(
              id = ns("age-controls"),
              heading = ages$heading,
              collapsed = FALSE,
              bar(
                id = ns("age"),
                values = ages$values,
                labels = ages$labels,
                selected = ages$selected
              )
            )
          },
          if (!is.null(years)) {
            section(
              id = ns("year-controls"),
              heading = years$heading,
              collapsed = FALSE,
              sliderInput(
                inputId = ns("year"),
                label = NULL,
                min = years$min,
                max = years$max,
                value = years$min,
                step = years$step,
                sep = "",
                dragRange = FALSE,
                ticks = FALSE
                # animate = animationOptions(
                #   interval = 500,
                #   loop = TRUE,
                #   playButton = icon("play"),
                #   pauseButton = icon("pause")
                # )
              )
            )
          },
          if (!is.null(outcomes)) {
            section(
              id = ns("outcome-controls"),
              heading = outcomes$heading,
              collapsed = FALSE,
              radio(
                id = ns("outcome"),
                values = outcomes$choices,
                label = outcomes$labels,
                selected = outcomes$selected
              )
            )
          },
          if (!is.null(interventions)) {
            section(
              id = ns("intervention-controls"),
              heading = interventions$heading,
              collapsed = FALSE,
              checkboxes(
                id = ns("intervention"),
                values = interventions$choices,
                labels = interventions$labels
              )
            )
          },
          if (!is.null(analyses)) {
            section(
              id = ns("analysis-controls"),
              heading = analyses$heading,
              collapsed = FALSE,
              checkboxes(
                id = ns("analysis"),
                values = analyses$choices,
                labels = analyses$labels
              )
            )
          }
        )
      }
    )
  )
}

#' @keywords internal
#' @rdname tab-side-panel
#' @export
tabMainPanel <- function(id, ..., active = FALSE, click = FALSE,
                         dblclick = FALSE, brush = FALSE) {
  ns <- NS(id)
  class <- paste0(id, "-tab")

  additionalTags <- eval(substitute(tagList(...)))

  tags$div(
    class = paste(c(class, "tab-pane", if (active) " active"), collapse = " "),
    tags$h3(
      class = "plot-title",
      textOutput(
        outputId = ns("title")
      )
    ),
    tags$h4(
      class = "plot-subtitle",
      textOutput(
        outputId = ns("subtitle")
      )
    ),
    plotOutput(
      outputId = ns("plot"),
      dblclick = if (dblclick) {
        dblclickOpts(id = ns("dblclick"))
      },
      brush = if (brush) {
        brushOpts(
          id = ns("brush"),
          fill = "transparent",
          stroke = "#000000"
        )
      },
      click = if (click) {
        clickOpts(
          id = ns("click")
        )
      }
    ),
    additionalTags,
    fluidRow(
      column(1),
      column(
        width = 5,
        class = "plot-options",
        tags$h5("Options"),
        checkboxes(
          id = ns("color"),
          values = "colorblind",
          labels = "Color-blind friendly palette"
        )
      ),
      column(
        width = 6,
        class = "download-options",
        tags$h5("Download"),
        downloadInputs(ns("download"))
      )
    )
  )
}
