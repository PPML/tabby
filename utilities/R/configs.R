#' Load config files
#'
#' These variables store the data found in the config files. This config data
#' helps build the server and ui of the Tabby application
#'
#' @name configs
NULL

#' @rdname configs
#' @export
config_plots <- function() {
  yaml::read_yaml(system.file("configs", "config-plots.yaml", package = "utilities", mustWork = TRUE))
}

#' @rdname configs
#' @export
config_estimates <- function() {
  yaml::read_yaml(system.file("configs", "config-estimates.yaml", package = "utilities", mustWork = TRUE))
}

#' @rdname configs
#' @export
config_trends <- function() {
  yaml::read_yaml(system.file("configs", "config-trends.yaml", package = "utilities", mustWork = TRUE))
}

#' @rdname configs
#' @export
config_agegroups <- function() {
  yaml::read_yaml(system.file("configs", "config-agegroups.yaml", package = "utilities", mustWork = TRUE))
}
