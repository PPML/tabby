Shiny.addCustomMessageHandler("trigger-button",
  function(message) {
    if (!message.id) {
      return null;
    }

    document.getElementById(message.id).click();

    return false;
  }
);

/*$(document).ready(function() {
  var agesInt = $('#ages-intervention');
  var agesAnl = $('#ages-analysis');

  agesInt.addClass('disabled');
  agesAnl.addClass('disabled');

  $('#ages-year').change(function(e) {
    if ($('#ages-year').find('input:checked').val() == '2016') {
      agesInt.addClass('disabled');
      agesAnl.addClass('disabled');
    } else {
      agesInt.removeClass('disabled');
      agesAnl.removeClass('disabled');
    }
  });
});*/
