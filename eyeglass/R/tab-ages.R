#' Ages Tab
#'
#' An application tab for age groups
#'
#' @keywords internal
#' @name ages-tab
#' @md
#' @export
agesTab <- function(input, output, session) {
  data <- reactive({
    req(
      input$population, input$outcome,
      c(input$intervention, input$analysis, "base_case"),
      input$year >= 2016 && input$year <= 2100
    )

    .AGEGROUPS %>%
      filter(
        population == input$population,
        outcome == input$outcome,
        year == if (input$year == 2100) 2099 else input$year,
        scenario %in% c(input$intervention, input$analysis, "base_case")
      )
  })

  # allyears <- reactive({
  #   req(
  #     input$population, input$outcome,
  #     c(input$intervention, input$analysis, "base_case")
  #   )
  #
  #   .AGEGROUPS %>%
  #     filter(
  #       population == input$population,
  #       outcome == input$outcome,
  #       scenario %in% c(input$intervention, input$analysis, "base_case")
  #     )
  # })

  output$title <- reactive({
    req(
      input$outcome, input$population,
      input$year >= 2016 && input$year <= 2100
    )

    sprintf(
      "%s, in the %s, for %s",
      outcomes$ages$labels[[input$outcome]],
      populations$formatted[[input$population]],
      input$year
    )
  })

  plotter <- reactive({
    color <- input$color %||% "standard"

    outputName <- session$ns("plot")
    session$clientData[[paste0("output_", outputName, "_width")]]
    session$clientData[[paste0("output_", outputName , "_height")]]

    data <- spread(data(), type, value)

    title <- sprintf(
      "%s, in the %s, for %s",
      outcomes$ages$labels[[input$outcome]],
      populations$formatted[[input$population]],
      input$year
    )

    dodge <- position_dodge(0.85)

    ggplot(data, aes(x = age_group)) +
      geom_bar(
        mapping = aes(
          y = mean,
          fill = scenario
        ),
        stat = "identity",
        position = dodge
      ) +
      geom_linerange(
        mapping = aes(
          ymin = data$ci_low,
          ymax = data$ci_high,
          color = scenario
        ),
        position = dodge
      ) +
      scale_x_discrete(
        name = "Age group",
        limits = naturalsort(unique(data$age_group))
      ) +
      scale_y_continuous(
        name = outcomes$ages$formatted[[input$outcome]]
        # limits = c(0, max(allyears()$value))  # comment this line to demo shift y-axis breaks
      ) +
      scale_fill_manual(
        name = "Scenario",
        values = settings$color[[color]],
        labels = c(
          "base_case" = "Base case",
          interventions$labels,
          analyses$formatted
        )
      ) +
      scale_color_manual(
        name = "Scenario",
        values = darken(settings$color[[color]], 1.75),
        labels = c(
          "base_case" = "Base case",
          interventions$labels,
          analyses$formatted
        )
      ) +
      labs(
        title = title
      ) +
      guides(
        fill = guide_legend(
          title = "Scenario",
          nrow = min(n_distinct(data$scenario), 2)
        )
      ) +
      theme_bw() +
      theme(
        text = element_text(family = settings$font, size = 14),
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
        panel.grid.major.y = element_line(size = 0.15, color = "#989898"),
        strip.background = element_blank(),
        strip.text = element_blank()
      )
  })

  output$plot <- renderPlot({
    plotter() +
      theme(
        plot.title = element_blank()
      )
  })

  callModule(downloadController, "download", plot = plotter, data = data)
}
