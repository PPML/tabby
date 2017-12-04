radioButtons2 <- function(id, heading, labels, values, selected, ...,
                          descriptions = NULL) {
  if (is.null(descriptions)) {
    descriptions <- rep.int("", length(labels))
  }

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
        function(lab, val, sel, desc) {
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
            ),
            if (desc != "") {
              tags$span(
                class = "fa fa-question-circle-o",
                `data-toggle` = "tooltip",
                `data-placement` = "top",
                title = desc,
                `aria-describedby` = "#outcomeDescription",
                tags$span(
                  id = "outcomeDescription",
                  class = "sr-only",
                  `aria-hidden` = TRUE,
                  desc
                )
              )
            }
          )
        },
        labels,
        values,
        selected,
        descriptions
      )
    )
  )
}

checkboxGroup2 <- function(id, heading, labels, values, descriptions = NULL) {
  if (is.null(descriptions)) {
    descriptions <- rep.int("", length(labels))
  }

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
        function(lab, val, desc) {
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
            ),
            if (desc != "") {
              tags$span(
                class = "fa fa-question-circle-o",
                `data-toggle` = "tooltip",
                `data-placement` = "top",
                title = desc,
                `aria-describedby` = "#outcomeDescription",
                tags$span(
                  id = "outcomeDescription",
                  class = "sr-only",
                  `aria-hidden` = TRUE,
                  desc
                )
              )
            }
          )
        },
        labels,
        values,
        descriptions
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
