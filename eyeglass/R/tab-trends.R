#' Trends Application Tab
#'
#' A tab for the TB model trend results. This function should not be called
#' directly. Rather the function is passed to [includeTab].
#'
#' @param input Shiny input.
#' @param output Shiny output.
#' @param session Shiny session.
#'
#' @md
#' @keywords internal
#' @name trends-tab
#' @export
trendsTab <- function(input, output, session) {
  data <- reactive({
    req(
      input$comparator, input$outcome,
      c(input$intervention, input$analysis, "base_case")
    )

    .TRENDS %>%
      filter(
        population == input$population,
        age_group == input$age,
        outcome == input$outcome,
        scenario %in% c(input$intervention, input$analysis, "base_case"),
        comparator == input$comparator
      ) %>%
      arrange(scenario) %>%
      mutate(
        year_adj = year + position_year(scenario)
      )
  })

  dataRange <- reactive({
    .TRENDS %>%
      filter(
        comparator == input$comparator,
        population == input$population,
        outcome == input$outcome,
        scenario %in% c(input$intervention, input$analysis, "base_case")
      ) %>%
      .$value %>% {
        c(0, max(.))
      }

  })

  output$title <- reactive({
    req(input$outcome, input$population, input$age)
    sprintf(
      "%s, in the %s, %s",
      outcomes$estimates$labels[[input$outcome]],
      populations$formatted[[input$population]],
      ages$estimates$formatted[[input$age]]
    )
  })

  output$subtitle <- reactive({
    req(input$outcome, input$population, input$age)
    comparators$formatted[[input$comparator]]
  })

  plotter <- reactive({
    color <- input$color %||% "standard"

    outputName <- session$ns("plot")
    session$clientData[[paste0("output_", outputName, "_width")]]
    session$clientData[[paste0("output_", outputName , "_height")]]

    data <- spread(data(), type, value)
    dataRange <- isolate(dataRange())

    title <- sprintf(
      "%s, in the %s, %s",
      outcomes$trends$labels[[input$outcome]],
      populations$formatted[[input$population]],
      ages$trends$formatted[[input$age]]
    )

    ggplot(data) +
      geom_ribbon(
        mapping = aes(
          x = year,
          ymin = ci_low,
          ymax = ci_high,
          fill = scenario,
          linetype = scenario == "base_case"
        ),
        alpha = 0.3
      ) +
      geom_line(
        mapping = aes(
          x = year,
          y = mean,
          color = scenario,
          linetype = scenario == "base_case"
        ),
        size = 1.05,
        linejoin = "round"
      ) +
      scale_fill_manual(
        values = settings$color[[color]],
        labels = c(
          "base_case" = "Base case",
          interventions$labels,
          analyses$formatted
        )
      ) +
      scale_color_manual(
        values = settings$color[[color]],
        labels = c(
          "base_case" = "Base case",
          interventions$labels,
          analyses$formatted
        )
      ) +
      scale_linetype_manual(
        values = c("FALSE" = "solid", "TRUE" = "22")
      ) +
      scale_x_continuous(
        name = "Year",
        breaks = c(2016, 2025, 2050, 2075, 2100)
      ) +
      scale_y_continuous(
        name = outcomes$trends$formatted[[input$outcome]],
        limits = dataRange
      ) +
      labs(
        title = title,
        subtitle = comparators$formatted[[input$comparator]]
      ) +
      guides(
        color = guide_legend(
          title = "Scenario",
          nrow = min(n_distinct(data$scenario), 2)
        ),
        fill = guide_legend(
          title = "Scenario",
          nrow = min(n_distinct(data$scenario), 2)
        ),
        linetype = FALSE
      ) +
      theme_bw() +
      theme(
        text = element_text(family = "Helvetica-Narrow", size = 14),
        plot.title = element_text(
          size = rel(1.5),
          margin = margin(0, 0, 10 , 0)
        ),
        plot.subtitle = element_text(
          size = rel(1.25),
          margin = margin(0, 0, 10, 0)
        ),
        axis.title = element_text(size = rel(1.15)),
        axis.title.x = element_text(margin = margin(t = 20)),
        axis.title.y = element_text(margin = margin(r = 20)),
        axis.text = element_text(size = rel(1)),
        legend.position = "bottom",
        legend.direction = "horizontal",
        legend.justification = c(0, 0),
        legend.text = element_text(size = rel(0.85)),
        legend.title = element_text(size = rel(1.15)),
        legend.key = element_rect(size = 2),
        legend.key.size = unit(2, "lines"), #unit(0.75, "cm"),
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(size = 0.15, color = "#989898")
      )
  })

  output$plot <- renderPlot({
    plotter() +
      theme(
        plot.title = element_blank(),
        plot.subtitle = element_blank()
      )
  })

  callModule(downloadController, "download", plot = plotter, data = data)
}
