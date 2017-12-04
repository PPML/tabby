#' Load config files
#'
#' These variables store the data found in the config files. This config data
#' helps build the server and ui of the Tabby application
#'
#' @name configs
NULL

#' @rdname configs
#' @export
plots <- yaml::read_yaml(system.file("configs", "config-plots.yaml", package = "utilities", mustWork = TRUE))

#' @rdname configs
#' @export
estimates <- yaml::read_yaml(system.file("configs", "config-estimates.yaml", package = "utilities", mustWork = TRUE))

#' @rdname configs
#' @export
trends <- yaml::read_yaml(system.file("configs", "config-trends.yaml", package = "utilities", mustWork = TRUE))

#' @rdname configs
#' @export
agegroups <- yaml::read_yaml(system.file("configs", "config-agegroups.yaml", package = "utilities", mustWork = TRUE))
