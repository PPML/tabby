#' Launch Shiny App
#'
#' Launch the eyeglass shiny application.
#'
#' @export
launch <- function() {
  suppressMessages(extrafont::loadfonts())
  shiny::addResourcePath("eyeglass", system.file("app/www", package = "eyeglass"))
  runApp(appDir = system.file("inst", "app", package = "eyeglass"))
}
