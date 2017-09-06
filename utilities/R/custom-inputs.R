radioButtons2 <- function(id, heading, labels, values, selected, ...) {
  tags$div(
    id = id,
    class = "shiny-input-radiogroup shiny-input-container",
    role = "radiogroup",
    `aria-labelledby` = id,
    tags$label(
      class = "control-label",
      `for` = id,
      heading
    ),
    tags$div(
      class = "shiny-options-group",
      Map(
        function(lab, val, sel) {
          tags$div(
            class = "radio",
            role = "radio",
            `aria-checked` = FALSE,
            tags$label(
              tags$input(
                type = "radio",
                name = id,
                value = val,
                checked = if (sel) NA
              ),
              tags$span(
                lab
              )
            )
          )
        },
        labels,
        values,
        selected
      )
    )
  )
}

checkboxGroup2 <- function(id, heading, labels, values) {
  tags$div(
    id = id,
    class = "shiny-input-checkboxgroup shiny-input-container",
    tags$label(
      class = "control-label",
      `for` = id,
      heading
    ),
    tags$div(
      class = "shiny-options-group",
      Map(
        function(lab, val) {
          tags$div(
            class = "checkbox",
            role = "checkbox",
            tags$label(
              tags$input(
                type = "checkbox",
                name = id,
                value = val,
                tags$span(lab)
              )
            )
          )
        },
        labels,
        values
      )
    )
  )
}

downloadButtonBar <- function(ids, heading, labels, aria = NULL) {
  tags$div(
    tags$label(
      class = "control-label",
      heading
    ),
    tags$div(
      do.call(
        tagAppendAttributes,
        c(
          list(
            tag = tags$div(
              class = "btn-group",
              role = "group",
              Map(
                function(id, label) {
                  tags$a(
                    id = id,
                    class = "btn btn-default shiny-download-link",
                    href = "",
                    target = "_blank",
                    download = NA,
                    label
                  )
                },
                ids,
                labels
              )
            )
          ),
          aria
        )
      )
    )
  )
}
