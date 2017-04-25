#' Estimates Application Tab
#'
#' A tab for the TB model estimate results. This function should not be called
#' directly. Rather the function is passed to [includeTab].
#'
#' @param input Shiny input.
#' @param output Shiny output.
#' @param session Shiny session.
#'
#' @md
#' @keywords internal
#' @name estimates-tab
#' @export
estimatesTab <- function(input, output, session, tour = NULL) {
  observeEvent(tour(), ignoreInit = TRUE, {
    includeTour()
  })

  data <- reactive({
    req(
      input$comparator, input$outcome,
      c(input$intervention, input$analysis, "base_case")
    )

    .ESTIMATES %>%
      filter(
        population == input$population,
        age_group == input$age,
        outcome == input$outcome,
        scenario %in% c(input$intervention, input$analysis, "base_case"),
        comparator == input$comparator
      ) %>%
      arrange(scenario) %>%
      mutate(
        year_adj = year + position_year(scenario),
        year_adj = if_else(year < 2025, year, year_adj)
      )
  })

  regions <- NULL
  makeReactiveBinding("regions")

  observeEvent(input$brush, {
    bp <- brushedPoints(data(), input$brush, "year_adj", "value")

    if (NROW(bp)) {
      regions <<- bp %>%
        bind_rows(regions) %>%
        distinct(outcome, scenario, population, year, year_adj, value)
    }
  })

  observeEvent(data(), {
    regions <<- NULL
  })

  observeEvent(input$dblclick, {
    regions <<- NULL
  })

  observeEvent(input$click, {
    np <- nearPoints(data(), input$click, "year_adj", "value", maxpoints = 1)

    if (NROW(np)) {
      regions <<- np %>%
        bind_rows(regions) %>%
        distinct(outcome, scenario, population, year, year_adj, value)
    }
  })

  dataRange <- reactive({
    .ESTIMATES %>%
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

  labels <- reactive({
    if (is.null(regions)) {
      return(NULL)
    }

    padding_x <- 5

    label_df <- regions %>%
      group_by(year) %>%
      mutate(
        nudge_x = ifelse(
          mean(year_adj) < year_adj,
          max(year_adj) - year_adj + padding_x,
          min(year_adj) - year_adj - padding_x
        )
      ) %>%
      ungroup() %>%
      select(scenario, year, year_adj, value, starts_with("nudge"))

    geom_label_repel(
      mapping = aes(
        x = year_adj,
        y = value,
        color = scenario,
        label = signif(value, 3)
      ),
      data = label_df,
      # fill = "transparent",
      family = "Arsenal",
      fontface = "bold",
      size = 4,
      box.padding = unit(0.20, "lines"),
      point.padding = unit(0.75, "lines"),
      force = 1.0,
      show.legend = FALSE,
      nudge_x = label_df$nudge_x,
      min.segment.length = unit(0.25, "lines")
    )
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
    req(input$outcome, input$population, input$age, input$comparator)
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
      outcomes$estimates$labels[[input$outcome]],
      populations$formatted[[input$population]],
      ages$estimates$formatted[[input$age]]
    )

    ggplot(data) +
      geom_rect(
        data = .REGIONS,
        mapping = aes(
          xmin = right_bound,
          xmax = left_bound,
          ymin = bottom_bound,
          ymax = top_bound
        ),
        # alpha = 0.50,
        fill = "#EBEBEB"
      ) +
      geom_pointrange(
        mapping = aes(
          year_adj, mean,
          ymin = ci_low, ymax = ci_high,
          color = scenario
        ),
        fatten = 2
      ) +
      labels() +
      scale_color_manual(
        name = "Scenario",
        values = settings$color[[color]],
        labels = c(
          "base_case" = "Base case",
          interventions$labels,
          analyses$formatted
        )
      ) +
      scale_x_continuous(
        name = "Year",
        breaks = c(2000, 2025, 2050, 2075, 2100),
        labels = c("2016", "2025", "2050", "2075", "2100"),
        limits = range(.REGIONS$right_bound, .REGIONS$left_bound),
        expand = c(0, 0)
      ) +
      scale_y_continuous(
        name = outcomes$estimates$formatted[[input$outcome]],
        limits = dataRange
      ) +
      labs(
        title = title,
        subtitle = comparators$formatted[[input$comparator]]
      ) +
      guides(
        color = guide_legend(nrow = min(n_distinct(data$scenario), 2)),
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
        axis.ticks = element_blank(),
        legend.position = "bottom",
        legend.justification = c(0, 0),
        legend.text = element_text(size = rel(0.85)),
        legend.title = element_text(size = rel(1.15)),
        legend.key.size = unit(1, "cm"),
        legend.box.spacing = unit(8, "mm"),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        panel.border = element_blank(),
        panel.ontop = TRUE
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
