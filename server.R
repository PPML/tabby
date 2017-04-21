function(input, output, session) {
  includeTab(estimatesTab, id = "estimates", tour = reactive(input$tour))
  includeTab(trendsTab, id = "trends")
  includeTab(agesTab, id = "ages")
}
