#' Include an Application Tab
#'
#' Based on shiny's `callModule`.
#'
#' @param tab A tab function, much like a module function.
#' @param id The id of the tab.
#' @param session Mostly ignored.
#'
#' @seealso
#'
#' [estimatesTab], [trendsTab]
#'
#' @md
#' @name include-tab
#' @export
includeTab <- function(tab, id, ..., session = getDefaultReactiveDomain()) {
  childScope <- session$makeScope(id)
  withReactiveDomain(childScope, {
    if (!is.function(tab)) {
      stop("`tab` must be a function", call. = FALSE)
    }

    tab(childScope$input, childScope$output, childScope, ...)
  })
}
