bar <- function(id, values, labels, selected) {
  if (!is.logical(selected)) {
    selected <- which(selected == values)
  }

  tagList(
    singleton(tags$link(rel = "stylesheet", href = "eyeglass/css/dull-button-group.css")),
    singleton(tags$script(src = "eyeglass/js/dull-button-group.js")),
    tags$div(
      id = id,
      class = "dull-input-bar",
      tags$div(
        class = "dull-options-group",
        pmap(
          list(values, labels, selected),
          function(value, label, selected) {
            tags$div(
              class = "dull-bar-cell",
              tags$label(
                class = "dull-bar-input-label",
                tags$input(
                  type = "radio",
                  name = id,
                  class = "dull-bar-input",
                  value = value,
                  checked = if (selected) "checked"
                ),
                tags$span(label)
              )
            )
          }
        )
      )
    )
  )
}
