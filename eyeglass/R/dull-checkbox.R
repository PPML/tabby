checkboxes <- function(id, labels, values, checked = NULL, columns = 1,
                       iconNotChecked = "square-o", iconChecked = "check-square-o") {
  if (!is.null(checked) && !is.logical(checked)) {
    if (length(checked) != 1 && length(checked) != length(values)) {
      stop("`checked` must have length 1 or same length as `values`",
           call. = FALSE)
    }

    if (!(checked %in% values)) {
      stop("invalid `checked` value", call. = FALSE)
    }

    checked <- values == checked
  }

  if (is.logical(checked) && length(checked) != length(values)) {
    stop("`checked` must have same length as `values` if logical", call. = FALSE)
  }

  if (columns > length(values)) {
    stop("too many columns specified", call. = FALSE)
  }

  if (columns <= 0) {
    stop("`columns` must be at least 1", call. = FALSE)
  }

  if (is.null(checked)) {
    checked <- rep.int(FALSE, length(values))
  }

  iconNotChecked <- icon2unicode(iconNotChecked)
  iconChecked <- icon2unicode(iconChecked)

  makeCheckbox <- function(value, label, checked) {
    tags$div(
      class = "dull-checkbox",
      tags$label(
        tags$input(
          name = id,
          type = "checkbox",
          value = value,
          checked = if (checked) "checked"
        ),
        tags$span(
          `data-icon-not-checked` = iconNotChecked,
          `data-icon-checked` = iconChecked,
          class = "dull-checkbox-indicator"
        ),
        tags$span(class = "dull-checkbox-description", label)
      )
    )
  }

  tagList(
    singleton(tags$head(tags$link(rel = "stylesheet", href = "eyeglass/css/dull-checkbox.css"))),
    singleton(tags$head(tags$script(src = "eyeglass/js/dull-checkbox.js"))),
    tags$div(
      class = "dull-input-checkboxgroup",
      id = id,
      `data-input-id` = id,
      tags$div(
        class = "dull-options-group clear-fix",
        if (columns == 1) {
          pmap(
            list(value = values, label = labels, checked = checked),
            makeCheckbox
          )
        } else {
          map(
            split3(seq_along(values), columns),
            ~ tags$div(
              class = "dull-options-column",
              pmap(
                list(value = values[.], label = labels[.], checked = checked[.]),
                makeCheckbox
              )
            )
          )
        }
      )
    )
  )
}
