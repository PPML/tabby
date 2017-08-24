$(document).ready(function() {
  $(".navbar").on("keypress", "a", function(e) {
    console.log("keypress");
    if (e.keyCode == 32 || e.keyCode == 13) {
      $(this).tab("show");
    }
  });
});
