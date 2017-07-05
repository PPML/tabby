function(input, output, session) {
  # estimates server ----
  estimatesData <- reactive({
    req(
      input[[estimates$IDs$controls$comparators]], input[[estimates$IDs$controls$outcomes]],
      c(input[[estimates$IDs$controls$interventions]], input[[estimates$IDs$controls$analyses]], "base_case")
    )

    .ESTIMATES %>%
      filter(
        population == input[[estimates$IDs$controls$populations]],
        age_group == input[[estimates$IDs$controls$ages]],
        outcome == input[[estimates$IDs$controls$outcomes]],
        scenario %in% c(input[[estimates$IDs$controls$interventions]], input[[estimates$IDs$controls$analyses]], "base_case"),
        comparator == input[[estimates$IDs$controls$comparators]]
      ) %>%
      arrange(scenario) %>%
      mutate(
        year_adj = year + position_year(scenario),
        year_adj = if_else(year < 2025, year, year_adj)
      )
  })

  estimatesRegions <- NULL
  makeReactiveBinding("estimatesRegions")

  observeEvent(input[[estimates$IDs$brush]], {
    bp <- brushedPoints(estimatesData(), input[[estimates$IDs$brush]], "year_adj", "value")

    if (NROW(bp)) {
      estimatesRegions <<- bp %>%
        bind_rows(estimatesRegions) %>%
        distinct(outcome, scenario, population, year, year_adj, value)
    }
  })

  observeEvent(estimatesData(), {
    estimatesRegions <<- NULL
  })

  observeEvent(input[[estimates$IDs$dblclick]], {
    estimatesRegions <<- NULL
  })

  observeEvent(input[[estimates$IDs$click]], {
    np <- nearPoints(estimatesData(), input[[estimates$IDs$click]], "year_adj", "value", maxpoints = 1)

    if (NROW(np)) {
      if (!is.null(estimatesRegions) && NROW(inner_join(estimatesRegions, np))) {
        estimatesRegions <<- anti_join(
          estimatesRegions, np,
          by = c("outcome", "scenario", "population", "year", "year_adj", "value")
        )
      } else {
        estimatesRegions <<- np %>%
          bind_rows(estimatesRegions) %>%
          distinct(outcome, scenario, population, year, year_adj, value)
      }
    }
  })

  estimatesLabels <- reactive({
    if (is.null(estimatesRegions)) {
      return(NULL)
    }

    padding_x <- 5

    label_df <- estimatesRegions %>%
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

  output[[estimates$IDs$title]] <- reactive({
    req(
      input[[estimates$IDs$controls$outcome]],
      input[[estimates$IDs$controls$population]],
      input[[estimates$IDs$controls$age]]
    )

    msg <- sprintf(
      "%s, in the %s, %s",
      estimates$outcomes$labels[[input[[estimates$IDs$controls$outcomes]]]],
      estimates$populations$formatted[[input[[estimates$IDs$controls$populations]]]],
      estimates$ages$formatted[[input[[estimates$IDs$controls$ages]]]]
    )

    session$sendCustomMessage(
      "update-alt-text",
      list(
        selector = paste0("#", estimates$IDs$plot, " img"),
        text = msg
      )
    )

    msg
  })

  output[[estimates$IDs$subtitle]] <- reactive({
    req(
      input[[estimates$IDs$controls$comparators]],
      input[[estimates$IDs$controls$outcomes]],
      input[[estimates$IDs$controls$populations]],
      input[[estimates$IDs$controls$ages]]
    )

    estimates$comparators$formatted[[input[[estimates$IDs$controls$comparators]]]]
  })

  estimatesPlot <- reactive({
    color <- if (length(input[[estimates$IDs$controls$colorblind]])) "colorblind" else "standard"

    # outputName <- session$ns("plot")
    # session$clientData[[paste0("output_", outputName, "_width")]]
    # session$clientData[[paste0("output_", outputName , "_height")]]

    data <- spread(estimatesData(), type, value)

    title <- sprintf(
      "%s, in the %s, %s",
      estimates$outcomes$labels[[input[[estimates$IDs$controls$outcomes]]]],
      estimates$populations$formatted[[input[[estimates$IDs$controls$populations]]]],
      estimates$ages$formatted[[input[[estimates$IDs$controls$ages]]]]
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
      estimatesLabels() +
      scale_color_manual(
        name = "Scenario",
        values = settings$color[[color]],
        labels = c(
          "base_case" = "Base case",
          estimates$interventions$labels,
          estimates$analyses$formatted
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
        name = estimates$outcomes$formatted[[input[[estimates$IDs$controls$outcomes]]]]
      ) +
      labs(
        title = title,
        subtitle = estimates$comparators$formatted[[input[[estimates$IDs$controls$comparators]]]]
      ) +
      guides(
        color = guide_legend(nrow = min(n_distinct(data$scenario), 2)),
        linetype = FALSE
      ) +
      theme_bw() +
      theme(
        text = element_text(size = 14),
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

  output[[estimates$IDs$plot]] <- renderPlot({
    estimatesPlot() +
      theme(
        plot.title = element_blank(),
        plot.subtitle = element_blank()
      )
  })

  # trends server ----
  trendsData <- reactive({
    req(
      input[[trends$IDs$controls$comparators]],
      input[[trends$IDs$controls$outcomes]],
      c(
        input[[trends$IDs$controls$interventions]],
        input[[trends$IDs$controls$analyses]],
        "base_case"
      )
    )

    .TRENDS %>%
      filter(
        population == input[[trends$IDs$controls$populations]],
        age_group == input[[trends$IDs$controls$ages]],
        outcome == input[[trends$IDs$controls$outcomes]],
        scenario %in% c(
          input[[trends$IDs$controls$interventions]],
          input[[trends$IDs$controls$analyses]],
          "base_case"
        ),
        comparator == input[[trends$IDs$controls$comparators]]
      ) %>%
      arrange(scenario) %>%
      mutate(
        year_adj = year + position_year(scenario)
      )
  })

  output[[trends$IDs$title]] <- reactive({
    req(
      input[[trends$IDs$controls$outcomes]],
      input[[trends$IDs$controls$populations]],
      input[[trends$IDs$controls$ages]]
    )

    sprintf(
      "%s, in the %s, %s",
      trends$outcomes$labels[[input[[trends$IDs$controls$outcomes]]]],
      trends$populations$formatted[[input[[trends$IDs$controls$populations]]]],
      trends$ages$formatted[[input[[trends$IDs$controls$ages]]]]
    )
  })

  output[[trends$IDs$subtitle]] <- reactive({
    req(
      input[[trends$IDs$controls$outcomes]],
      input[[trends$IDs$controls$populations]],
      input[[trends$IDs$controls$ages]]
    )

    trends$comparators$formatted[[input[[trends$IDs$controls$comparators]]]]
  })

  trendsPlot <- reactive({
    color <- if (length(input[[trends$IDs$controls$colorblind]])) "colorblind" else "standard"

    # outputName <- session$ns("plot")
    # session$clientData[[paste0("output_", outputName, "_width")]]
    # session$clientData[[paste0("output_", outputName , "_height")]]

    data <- spread(trendsData(), type, value)

    title <- sprintf(
      "%s, in the %s, %s",
      trends$outcomes$labels[[input[[trends$IDs$controls$outcomes]]]],
      trends$populations$formatted[[input[[trends$IDs$controls$populations]]]],
      trends$ages$formatted[[input[[trends$IDs$controls$ages]]]]
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
          trends$interventions$labels,
          trends$analyses$formatted
        )
      ) +
      scale_color_manual(
        values = settings$color[[color]],
        labels = c(
          "base_case" = "Base case",
          trends$interventions$labels,
          trends$analyses$formatted
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
        name = trends$outcomes$formatted[[input[[trends$IDs$controls$outcomes]]]]
      ) +
      labs(
        title = title,
        subtitle = trends$comparators$formatted[[input[[trends$IDs$controls$comparators]]]]
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
        text = element_text(size = 14),
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

  output[[trends$IDs$plot]] <- renderPlot({
    trendsPlot() +
      theme(
        plot.title = element_blank(),
        plot.subtitle = element_blank()
      )
  })


  # ages server ----
  agegroupsData <- reactive({
    req(
      input[[agegroups$IDs$controls$populations]],
      input[[agegroups$IDs$controls$outcomes]],
      c(
        input[[agegroups$IDs$controls$populations]],
        input[[agegroups$IDs$controls$analyses]],
        "base_case"
      ),
      input[[agegroups$IDs$controls$years]] >= 2016 &&
        input[[agegroups$IDs$controls$years]] <= 2100
    )

    .AGEGROUPS %>%
      filter(
        population == input[[agegroups$IDs$controls$populations]],
        outcome == input[[agegroups$IDs$controls$outcomes]],
        year == if (input[[agegroups$IDs$controls$years]] == 2100) 2099 else
          input[[agegroups$IDs$controls$years]],
        scenario %in% c(
          input[[agegroups$IDs$controls$interventions]],
          input[[agegroups$IDs$controls$analyses]],
          "base_case"
        )
      )
  })

  output[[agegroups$IDs$title]] <- reactive({
    req(
      input[[agegroups$IDs$controls$populations]],
      input[[agegroups$IDs$controls$outcomes]],
      input[[agegroups$IDs$controls$years]] >= 2016 &&
        input[[agegroups$IDs$controls$years]] <= 2100
    )

    sprintf(
      "%s, in the %s, for %s",
      agegroups$outcomes$labels[[input[[agegroups$IDs$controls$outcomes]]]],
      agegroups$populations$formatted[[input[[agegroups$IDs$controls$populations]]]],
      input[[agegroups$IDs$controls$years]]
    )
  })

  agegroupsPlot <- reactive({
    color <- if (length(input[[agegroups$IDs$controls$colorblind]])) "colorblind" else "standard"
    # outputName <- session$ns("plot")
    # session$clientData[[paste0("output_", outputName, "_width")]]
    # session$clientData[[paste0("output_", outputName , "_height")]]

    data <- spread(agegroupsData(), type, value)

    title <- sprintf(
      "%s, in the %s, for %s",
      agegroups$outcomes$labels[[input[[agegroups$IDs$controls$outcomes]]]],
      agegroups$populations$formatted[[input[[agegroups$IDs$controls$populations]]]],
      input[[agegroups$IDs$controls$years]]
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
        name = agegroups$outcomes$formatted[[input[[agegroups$IDs$controls$outcomes]]]]
      ) +
      scale_fill_manual(
        name = "Scenario",
        values = settings$color[[color]],
        labels = c(
          "base_case" = "Base case",
          agegroups$interventions$labels,
          agegroups$analyses$formatted
        )
      ) +
      scale_color_manual(
        name = "Scenario",
        values = darken(settings$color[[color]], 1.75),
        labels = c(
          "base_case" = "Base case",
          agegroups$interventions$labels,
          agegroups$analyses$formatted
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
        text = element_text(size = 14),
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

  output[[agegroups$IDs$plot]] <- renderPlot({
    agegroupsPlot() +
      theme(
        plot.title = element_blank()
      )
  })

  # downloads ----
  # estimates png ----
  output[[estimates$IDs$downloads$png]] <- downloadHandler(
    filename = "tabby-estimates-plot.png",
    content = function(file) {
      png(file, res = 72, width = 13, height = 9, units = "in")
      print(estimatesPlot())
      dev.off()
    }
  )

  # estimates pdf ----
  output[[estimates$IDs$downloads$pdf]] <- downloadHandler(
    filename = "tabby-estimates-plot.pdf",
    content = function(file) {
      this <- estimatesPlot()
      pdf(file, width = 11, height = 8, title = this$plot$title)
      print(this)
      dev.off()
    }
  )

  # estimates pptx ----
  output[[estimates$IDs$downloads$pptx]] <- downloadHandler(
    filename = "tabby-estimates-plot.pptx",
    content = function(file) {
      tmp <- tempfile(fileext = "jpg")
      on.exit(unlink(tmp))

      this <- try(estimatesPlot(), silent = TRUE)

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
    }
  )

  # estimates xlsx ----
  output[[estimates$IDs$downloads$xlsx]] <- downloadHandler(
    filename = "tabby-estimates-data.xlsx",
    content = function(file) {
      estimatesData() %>%
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

  # estimates csv ----
  output[[estimates$IDs$downloads$csv]] <- downloadHandler(
    filename = "tabby-estimates-data.csv",
    content = function(file) {
      estimatesData() %>%
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

  # trends png ----
  output[[trends$IDs$downloads$png]] <- downloadHandler(
    filename = "tabby-trends-plot.png",
    content = function(file) {
      png(file, res = 72, width = 13, height = 9, units = "in")
      print(trendsPlot())
      dev.off()
    }
  )

  # trends pdf ----
  output[[trends$IDs$downloads$pdf]] <- downloadHandler(
    filename = "tabby-trends-plot.pdf",
    content = function(file) {
      this <- trendsPlot()
      pdf(file, width = 11, height = 8, title = this$plot$title)
      print(this)
      dev.off()
    }
  )

  # trends pptx ----
  output[[trends$IDs$downloads$pptx]] <- downloadHandler(
    filename = "tabby-trends-plot.pptx",
    content = function(file) {
      tmp <- tempfile(fileext = "jpg")
      on.exit(unlink(tmp))

      this <- try(trendsPlot(), silent = TRUE)

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
    }
  )

  # trends xlsx ----
  output[[trends$IDs$downloads$xlsx]] <- downloadHandler(
    filename = "tabby-trends-data.xlsx",
    content = function(file) {
      trendsData() %>%
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

  # trends csv ----
  output[[trends$IDs$downloads$csv]] <- downloadHandler(
    filename = "tabby-trends-data.csv",
    content = function(file) {
      trendsData() %>%
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

  # agegroups png ----
  output[[agegroups$IDs$downloads$png]] <- downloadHandler(
    filename = "tabby-agegroups-plot.png",
    content = function(file) {
      png(file, res = 72, width = 13, height = 9, units = "in")
      print(agegroupsPlot())
      dev.off()
    }
  )

  # agegroups pdf ----
  output[[agegroups$IDs$downloads$pdf]] <- downloadHandler(
    filename = "tabby-agegroups-plot.pdf",
    content = function(file) {
      this <- agegroupsPlot()
      pdf(file, width = 11, height = 8, title = this$plot$title)
      print(this)
      dev.off()
    }
  )

  # agegroups pptx ----
  output[[agegroups$IDs$downloads$pptx]] <- downloadHandler(
    filename = "tabby-agegroups-plot.pptx",
    content = function(file) {
      tmp <- tempfile(fileext = "jpg")
      on.exit(unlink(tmp))

      this <- try(agegroupsPlot(), silent = TRUE)

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
    }
  )

  # agegroups xlsx ----
  output[[agegroups$IDs$downloads$xlsx]] <- downloadHandler(
    filename = "tabby-agegroups-data.xlsx",
    content = function(file) {
      agegroupsData() %>%
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

  # agegroups csv ----
  output[[agegroups$IDs$downloads$csv]] <- downloadHandler(
    filename = "tabby-agegroups-data.csv",
    content = function(file) {
      agegroupsData() %>%
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
