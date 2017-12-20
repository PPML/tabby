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
        label = labels,
        value = values,
        this = paste0(id, "-", seq_along(labels)),
        select = selected,
        desc = descriptions,
        d_id = paste0(id, "Outcome-", seq_along(descriptions)),
        function(label, value, this, select, desc, d_id) {
          tags$div(
            class = "radio",
            role = "radio",
            `aria-checked` = FALSE,
            tags$label(
              `for` = this,
              tags$input(
                type = "radio",
                name = id,
                id = this,
                value = value,
                checked = if (select) NA
              ),
              tags$span(
                label
              )
            ),
            if (desc != "") {
              tags$span(
                class = "fa fa-question-circle-o",
                `data-toggle` = "tooltip",
                `data-placement` = "top",
                title = desc,
                tabindex = 0,
                `aria-describedby` = paste0("#", d_id),
                tags$span(
                  id = d_id,
                  class = "sr-only",
                  `aria-hidden` = TRUE,
                  desc
                )
              )
            }
          )
        }
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
        label = labels,
        value = values,
        this = paste0(id, "-", seq_along(labels)),
        desc = descriptions,
        d_id = paste0(id, "Description-", seq_along(descriptions)),
        function(label, value, this, desc, d_id) {
          tags$div(
            class = "checkbox",
            role = "checkbox",
            tags$label(
              `for` = this,
              tags$input(
                type = "checkbox",
                `aria-checked` = "false",
                name = id,
                id = this,
                value = value,
                tags$span(label)
              )
            ),
            if (desc != "") {
              tags$span(
                class = "fa fa-question-circle-o",
                `data-toggle` = "tooltip",
                `data-placement` = "top",
                title = desc,
                tabindex = 0,
                `aria-describedby` = paste0("#", d_id),
                tags$span(
                  id = d_id,
                  class = "sr-only",
                  `aria-hidden` = TRUE,
                  desc
                )
              )
            }
          )
        }
      )
    )
  )
}

downloadButtonBar <- function(ids, heading, labels) {
  descriptions <- paste(
    "This link acts like a button. Click this link to download",
    c(
      "the visualization as a PNG file.",
      "the visualization as a PDF file.",
      "the visualization as a Power Point file.",
      "the data used in the visualization as CSV file.",
      "the data used in the visualization as an Excel file."
    )
  )

  tags$div(
    tags$label(
      class = "control-label",
      heading
    ),
    tags$div(
      tags$div(
        class = "btn-group",
        role = "group",
        Map(
          id = ids,
          label = labels,
          desc = descriptions,
          d_id = paste0(ids, "Description"),
          function(id, label, desc, d_id) {
            tags$a(
              id = id,
              class = "btn btn-default shiny-download-link",
              href = "",
              target = "_blank",
              download = NA,
              `aria-describedby` = d_id,
              tabindex = 0,
              label,
              tags$span(
                class = "sr-only",
                id = d_id,
                `aria-hidden` = TRUE,
                desc
              )
            )
          }
        )
      )
    )
  )
}
