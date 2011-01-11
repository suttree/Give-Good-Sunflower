// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(function($) {
  var fade = function() { $(".loading").toggle() };

  $(".sunflower")
    .bind("ajax:loading",  fade)
    .bind("ajax:complete", fade)
    .bind("ajax:success", function(data, status, xhr) {
      $(".sunflower").css({ opacity: 0.6 }).fadeTo("normal", 1);
      $(".sunflower").html(status);
    });
});
