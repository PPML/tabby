$('.nav-pills a').on('shown.bs.tab', function(e) {
  var target = $(e.target).attr("href");
  if (target == "#ages") {
    $("#comparator-choices")
      .fadeTo(300, 0.75)
      .css("pointer-events", "none");
    $("#comparator-choice-1")
      .prop("checked", true);
  } else {
    $("#comparator-choices")
      .fadeTo(300, 1.0)
      .css("pointer-events", "auto");
  }
});
