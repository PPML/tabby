#' Preview A Plot
#'
#' A small render of a Shiny plot.
#'
#' @param id Namespace id.
#'
#' @keywords internal
#' @name plot-preview
#' @md
#' @export
plotPreview <- function(id) {
  plotOutput(
    outputId = id,
    inline = TRUE
  )
}

#' @keywords internal
#' @rdname plot-preview
#' @export
renderPreview <- function(p) {
  renderPlot(height = 200, width = 200, {
    p() +
      theme(
        title = element_blank(),
        text = element_blank(),
        legend.position = "none",
        axis.ticks = element_blank()
      )
  })
}
