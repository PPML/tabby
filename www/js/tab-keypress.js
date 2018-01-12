$(function () {
  $('[data-toggle="tooltip"]').tooltip();
});

$(document).ready(function() {
  $(".navbar").on("keypress", "a", function(e) {
    if (e.keyCode == 13 || e.keyCode == 32) {
      $(this).tab("show");
    }
  });
  $("input[type='checkbox']").on("change", function(e) {
    var $this = $(this);
    $this.closest("div[role='checkboxgroup']")
      .find("div[role='checkbox']")
      .map(function(i, e) {
        var $btn = $(e).find("input[type='checkbox']");
        var $label = $(e).find("label");
        var $val = $btn.is(":checked");
        $label.attr("aria-checked", $val);
        $btn.attr("aria-checked", $val);
        $(e).attr("aria-checked", $val);
      });
  });
  $("input[type='radio']").on("change", function(e) {
    var $this = $(this);
    $this.closest("div[role='radiogroup']")
      .find("div[role='radio']")
      .map(function(i, e) {
        var $btn = $(e).find("input[type='radio']");
        var $label = $(e).find("label");
        var $val = $btn.is(":checked");
        $label.attr("aria-checked", $val);
        $btn.attr("aria-checked", $val);
        $(e).attr("aria-checked", $val);
      });
  });

});
