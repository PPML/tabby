Shiny.addCustomMessageHandler("update-alt-text", function(msg) {
    var $selector = msg.selector;
    var $text = msg.text;
    $($selector).attr("alt", $text);
});
