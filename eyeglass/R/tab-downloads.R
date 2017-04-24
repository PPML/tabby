downloadInputs <- function(id) {
  ns <- NS(id)

  tags$div(
    class = "dull-download-container",
    singleton(tags$head(tags$link(rel = "stylesheet", href = "eyeglass/css/dull-downloads.css"))),
    tags$div(
      class = "btn-group",
      tags$button(
        type = "button",
        class = "dull-download-button btn btn-default",
        disabled = NA,
        icon("download")
      ),
      Map(
        function(type, id) {
          tagSetChildren(
            downloadButton(
              outputId = id
            ),
            icon(type, "fa-lg")
          )
        },
        type = paste0(
          "file-", c("image", "pdf", "powerpoint", "excel", "text"), "-o"
        ),
        id = ns(c("png", "pdf", "pptx", "xlsx", "csv"))
      )
    )
  )
}

downloadController <- function(input, output, session, plot, data) {
  output$png <- downloadHandler(
    filename = function() {
      strftime(Sys.Date(), "tb-plot-%F.png")
    },
    content = function(file) {
      png(file, res = 72, width = 720)
      print(plot())
      dev.off()
    }
  )

  output$pdf <- downloadHandler(
    filename = function() {
      strftime(Sys.Date(), "tb-plot-%F.pdf")
    },
    content = function(file) {
      this <- plot()
      pdf(file, width = 9, height = 7, title = this$plot$title)
      print(this)
      dev.off()
      embed_fonts(file, outfile = file)
    }
  )

  output$pptx <- downloadHandler(
    filename = function() {
      strftime(Sys.Date(), "tb-plot-slide-%F.pptx")
    },
    content = function(file) {
      tmp <- tempfile(fileext = "jpg")
      on.exit(unlink(tmp))

      jpeg(tmp, res = 72, width = 680)
      print(plot())
      dev.off()

      read_pptx() %>%
        add_slide(layout = "Title and Content", master = "Office Theme") %>%
        ph_with_text(type = "title", str = "") %>%
        ph_with_img(type = "body", src = tmp, width = 7, height = 5) %>%
        print(target = file)
    }
  )

  output$xlsx <- downloadHandler(
    filename = function() {
      strftime(Sys.Date(), "tb-plot-data-%F.xlsx")
    },
    content = function(file) {
      data() %>%
        mutate(
          year = ifelse(year == 2000, 2016, year)
        ) %>%
        spread(type, value) %>%
        select(
          outcome, scenario, age_group, year, mean, ci_high, ci_low
        ) %>%
        openxlsx::write.xlsx(
          file = file,
          colNames = TRUE
        )
    }
  )

  output$csv <- downloadHandler(
    filename = function() {
      strftime(Sys.Date(), "tb-plot-data-%F.csv")
    },
    content = function(file) {
      data() %>%
        mutate(
          year = ifelse(year == 2000, 2016, year)
        ) %>%
        spread(type, value) %>%
        select(
          outcome, scenario, age_group, year, mean, ci_high, ci_low
        ) %>%
        write.csv(
          file = file,
          row.names = FALSE
        )
    }
  )
}
