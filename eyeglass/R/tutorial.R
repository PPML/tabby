#' Add a Tour
#'
#' Adds tour events to a tab.
#'
#' @export
includeTour <- function() {
  cenv <- parent.frame()

  tourEvent <- function(event, expr) {
    sub <- substitute(event)
    observeEvent(
      eventExpr = sub, event.env = cenv, once = TRUE, handlerExpr = expr,
      event.quoted = TRUE, ignoreInit = TRUE
    )
  }

  tourNotification <- function(id, ui, type = "default") {
    showNotification(
      id = id,
      ui = ui,
      duration = NULL,
      closeButton = TRUE,
      type = type
    )
  }

  tourNotification(
    id = "tour-welcome",
    tags$div(
      tags$h5("Welcome!"),
      tags$p(
        "This is an interactive tour of the application.",
        "As you click through the application notifications like this one",
        "will appear offering advice, hints, and tips."
      ),
      tags$p(
        "To close a notification click the ",
        icon("check"), " in the top right corner of the box."
      )
    )
  )

  tourEvent(input$comparator, {
    tourNotification(
      id = "tour-comparator",
      tags$div(
        tags$h5("Comparators"),
        tags$p("There are three possible comparators for the model outputs."),
        tags$p(tags$strong("Estimated values"), "- N/A"),
        tags$p(tags$strong("Percentage of base case value in the same year"), "- N/A"),
        tags$p(tags$strong("Percentage of base case value in 2016"), "- N/A")
      )
    )
  })

  tourEvent(input$population, {
    tourNotification(
      id = "tour-population",
      tags$div(
        tags$h5("Populations"),
        tags$p("There are three possible populations."),
        tags$p(tags$strong("Total"), "- total US population."),
        tags$p(tags$strong("US-born"), "- US, US-born population"),
        tags$p(tags$strong("Foreign-born"), "- US, foreign-born population")
      )
    )
  })

  tourEvent(input$age, {
    tourNotification(
      id = "tour-age",
      tags$div(
        tags$h5("Age groups"),
        tags$p("There are 4 possible age groups."),
        tags$p(tags$strong("All"), "- N/A"),
        tags$p(tags$strong("0 to 24"), "- N/A"),
        tags$p(tags$strong("25 to 64"), "- N/A"),
        tags$p(tags$strong("64+"), "- N/A")
      )
    )
  })

  tourEvent(input$outcome, {
    tourNotification(
      id = "tour-outcome",
      tags$div(
        tags$h5("Outcomes"),
        tags$p("There are 5 model outcomes."),
        tags$p(tags$strong("New TB infections"), "- N/A"),
        tags$p(tags$strong("LTBI prevalence"), "- N/A"),
        tags$p(tags$strong("TB incidence"), "- N/A"),
        tags$p(tags$strong("MDR-TB in new TB cases"), "- N/A"),
        tags$p(tags$strong("TB-related deaths"), "- N/A")
      )
    )
  })

  tourEvent(c(input$intervention, input$analysis), {
    tourNotification(
      id = "tour-brushing",
      type = "warning",
      tags$div(
        tags$h5("Highlighting data points"),
        tags$p(
          "Now that you have added a scenario let's try adding some point labels. You can label a point by",
          "clicking on it or label multiple points by clicking and dragging your cursor."
        ),
        tags$p(tags$strong(
          "To remove all labels double click anywhere on the plot."
        ))
      )
    )
  })


  int1 <- reactive(req(input$intervention == "intervention_1"), cenv)
  observeEvent(int1(), once = TRUE, {
    tourNotification(
      id = "tour-intervention-1",
      tags$div(
        tags$h5("TLTBI for new immigrants"),
        tags$p("Provision of LTBI testing and treatment for all new legal immigrants entering the US.")
      )
    )
  })

  int2 <- reactive(req(input$intervention == "intervention_2"), cenv)
  observeEvent(int2(), once = TRUE, {
    tourNotification(
      id = "tour-intervention-2",
      tags$div(
        tags$h5("Improved TLTBI in the US"),
        tags$p(
          "Intensification of the current LTBI targeted testing and treatment",
          "policy for high-risk populations, doubling treatment uptake within",
          "each risk group compared to current levels, and increasing the",
          "fraction cured among individuals initiating LTBI treatment, via a 3-month Isoniazid-Rifapentine drug regimen."
        )
      )
    )
  })

  int3 <- reactive(req(input$intervention == "intervention_3"), cenv)
  observeEvent(int3(), once = TRUE, {
    tourNotification(
      id = "tour-intervention-3",
      tags$div(
        tags$h5("Better case detection"),
        tags$p(
          "Improved detection of active TB cases, such that the duration of untreated active disease (time from TB incidence to the initiation of treatment) is reduced by 50%."
        )
      )
    )
  })

  int4 <- reactive(req(input$intervention == "intervention_4"), cenv)
  observeEvent(int4(), once = TRUE, {
    tourNotification(
      id = "tour-intervention-4",
      tags$div(
        tags$h5("Better TB treatment"),
        tags$p(
          "Improved treatment quality for active TB, such that treatment default, failure rates, and the fraction of individuals receiving an incorrect drug regimen are reduced by 50% from current levels."
        )
      )
    )
  })

  int5 <- reactive(req(input$intervention == "intervention_5"), cenv)
  observeEvent(int5(), once = TRUE, {
    tourNotification(
      id = "tour-intervention-5",
      tags$div(
        tags$h5("All improvements"),
        tags$p(
          "The combination of all other intervention scenarios."
        )
      )
    )
  })

  add1 <- reactive(req(input$analysis == "scenario_1"), cenv)
  observeEvent(add1(), once = TRUE, {
    tourNotification(
      id = "tour-additional-1",
      tags$div(
        tags$h5("No transmission within the United States after 2016"),
        tags$p(
          "A hypothetical scenario in which, from 2016 onwards, no individuals acquire M. tb infection from transmission within the United States. In this scenario the only source of new LTBI cases is from existing infection in new immigrants."
        )
      )
    )
  })

  add2 <- reactive(req(input$analysis == "scenario_2"), cenv)
  observeEvent(add2(), once = TRUE, {
    tourNotification(
      id = "tour-additional-2",
      tags$div(
        tags$h5("No LTBI among all immigrants after 2016"),
        tags$p(
          "A hypothetical scenario, from 2016 onwards, all individuals immigrating to the United States are free of M. tb infection, while maintaining the same total volume of immigration."
        )
      )
    )
  })
}
