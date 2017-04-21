radio <- function(id, values, labels, selected = NULL,
                  iconNotSelected = "circle-thin", iconSelected = "circle") {
  if (!is.null(selected) && !is.logical(selected)) {
    if (length(selected) != 1 && length(selected) != length(values)) {
      stop("`selected` must have length 1 or same length as `values`",
           call. = FALSE)
    }

    if (!(selected %in% values)) {
      stop("invalid `selected` value", call. = FALSE)
    }

    selected <- values == selected
  }

  iconNotSelected <- icon2unicode(iconNotSelected)
  iconSelected <- icon2unicode(iconSelected)

  tagList(
    singleton(tags$head(tags$link(rel = "stylesheet", href = "eyeglass/css/dull-radio.css"))),
    singleton(tags$head(tags$script(src = "eyeglass/js/dull-radio.js"))),
    tags$div(
      id = id,
      class = "dull-input-radiogroup",
      pmap(
        list(
          value = values,
          label = labels,
          selected = selected %||% FALSE
        ),
        function(value, label, selected) {
          tags$div(
            class = "dull-radio",
            tags$label(
              tags$input(
                type = "radio",
                name = id,
                value = value,
                checked = if (selected) "checked"
              ),
              tags$span(
                `data-icon-not-selected` = iconNotSelected,
                `data-icon-selected` = iconSelected,
                class = "dull-radio-indicator"
              ),
              tags$span(class = "dull-radio-description", label)
            )
          )
        })
    )
  )
}
