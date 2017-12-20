$(function () {
  $('[data-toggle="tooltip"]').tooltip();
});

$(document).ready(function() {
  $(".navbar").on("keypress", "a", function(e) {
    if (e.keyCode == 13) {
      $(this).tab("show");
    }
  });
  $("input[type='checkbo']").on("change", function(e) {
    var $this = $(this);
    if ($this.is(":checked")) {
      $this.attr("aria-checked", "true");
    } else {
      $this.attr("aria-checked", "false");
    }
  });
});
