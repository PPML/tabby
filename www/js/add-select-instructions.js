$(document).ready(function() {
    $("label[for='agegroupYears']")
    .attr('tabindex', '0')
    .first()
    .append("<span class='sr-only'> After tabbing to the next element, use the up and down arrow keys in the next input-element to select the year.</span>");

    $("label[for='estimatesLabels']")
    .attr('tabindex', '0')
    .first()
    .append("<span class='sr-only'> After tabbing to the next element, use the up and down arrow keys to select the data labels shown in the visualization.</span>");

    $("label[for='estimatesInterventionsOrAnalyses']")
    .attr('tabindex', '0')
    .first()
    .append("<span class='sr-only'> After tabbing to the next element, use the up and down arrow keys to select one of Modeled Scenarios or Sensitivity Analyses for visualization. After choosing one of these sets of model outputs, the options available in the next checkbox panel are changed accordingly so that the user may select those outputs for rendering in graphs and in downloadable outputs.</span>");

    $("label[for='trendsInterventionsOrAnalyses']")
    .attr('tabindex', '0')
    .first()
    .append("<span class='sr-only'> After tabbing to the next element, use the up and down arrow keys to select one of Modeled Scenarios or Sensitivity Analyses for visualization. After choosing one of these sets of model outputs, the options available in the next checkbox panel are changed accordingly so that the user may select those outputs for rendering in graphs and in downloadable outputs.</span>");

    $("label[for='agegroupsInterventionsOrAnalyses']")
    .attr('tabindex', '0')
    .first()
    .append("<span class='sr-only'> After tabbing to the next element, use the up and down arrow keys to select one of Modeled Scenarios or Sensitivity Analyses for visualization. After choosing one of these sets of model outputs, the options available in the next checkbox panel are changed accordingly so that the user may select those outputs for rendering in graphs and in downloadable outputs.</span>");

});
