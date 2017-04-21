#' Import Fonts
#'
#' Import the necessary fonts.
#'
#' @export
import_fonts <- function() {
  # borrowed from https://github.com/hrbrmstr/hrbrthemes/blob/master/R/roboto-condensed.r#L160
  # thank you harbor master

  font_dir <- system.file("fonts", package = "eyeglass")

  suppressWarnings(
    suppressMessages(extrafont::font_import(font_dir, prompt = FALSE))
  )

  message(
    sprintf("You will likely need to install these fonts on your system as\nYou can find them in [%s]", font_dir)
  )
}
