$(document).ready(function() {
    $("label[for='agegroupYears']")
    .attr('tabindex', '0')
    .first()
    .append("<span class='sr-only'> Use the up and down arrow keys in the next input-element to select the year.</span>");

    $("label[for='estimatesLabels']")
    .attr('tabindex', '0')
    .first()
    .append("<span class='sr-only'> Use the left and right arrow keys in the next input-element to select the data labels shown in the visualization.</span>");
});
