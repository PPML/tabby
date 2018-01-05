$(function () {
  $('[data-toggle="tooltip"]').tooltip();
});

$(document).ready(function() {
  $(".navbar").on("keypress", "a", function(e) {
    if (e.keyCode == 13) {
      $(this).tab("show");
    }
  });
  $("input[type='checkbox']").on("change", function(e) {
    var $this = $(this);
    if ($this.is(":checked")) {
      $this.attr("aria-checked", "true");
    } else {
      $this.attr("aria-checked", "false");
    }
  });
  $("input[type='radio']").on("change", function(e) {
    var $this = $(this);
    $this.closest("div[role='radiogroup']")
      .find("input[type='radio']")
      .map(function(i, e) {
        $(e).attr("aria-checked", $(e).is(":checked"));
      });
  });
});
