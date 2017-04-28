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
  onerror <- "tb-plot-error.gif"

  generateFileName <- function(ext) {
    function() {
      if (is.ggplot(try(plot(), silent = TRUE))) {
        strftime(Sys.Date(), paste0("tb-plot-%F.", ext))
      } else {
        onerror
      }
    }
  }

  getErrorGif <- function(file) {
    download.file("https://media.giphy.com/media/3oKIPE2IyKmNgUzalq/giphy.gif", file)
  }

  plotOkay <- function(file) {
    str_sub(file, -3) != "gif"
  }

  output$png <- downloadHandler(
    filename = generateFileName("png"),
    content = function(file) {
      if (plotOkay(file)) {
        png(file, res = 72, width = 13, height = 9, units = "in")
        print(plot())
        dev.off()
      } else {
        getErrorGif(file)
      }
    }
  )

  output$pdf <- downloadHandler(
    filename = generateFileName("pdf"),
    content = function(file) {
      if (plotOkay(file)) {
        this <- plot()
        pdf(file, width = 11, height = 8, title = this$plot$title)
        print(this)
        dev.off()
      } else {
        getErrorGif(file)
      }
    }
  )

  output$pptx <- downloadHandler(
    filename = generateFileName("pptx"),
    content = function(file) {
      if (plotOkay(file)) {
        tmp <- tempfile(fileext = "jpg")
        on.exit(unlink(tmp))

        this <- try(plot(), silent = TRUE)

        jpeg(tmp, res = 72, width = 13, height = 9, units = "in")

        if (is.ggplot(this)) {
          print(this)
        }

        dev.off()

        read_pptx() %>%
          add_slide(layout = "Title and Content", master = "Office Theme") %>%
          ph_with_text(type = "title", str = "") %>%
          ph_with_img(type = "body", src = tmp, width = 7, height = 5) %>%
          print(target = file)
      } else {
        getErrorGif(file)
      }
    }
  )

  output$xlsx <- downloadHandler(
    filename = generateFileName("xlsx"),
    content = function(file) {
      if (plotOkay(file)) {
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
      } else {
        getErrorGif(file)
      }
    }
  )

  output$csv <- downloadHandler(
    filename = generateFileName("csv"),
    content = function(file) {
      if (plotOkay(file)) {
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
      } else {
        getErrorGif(file)
      }
    }
  )
}
