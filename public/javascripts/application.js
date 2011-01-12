// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(function($) {
  var fade = function() { $(".loading").toggle() };

  $(".sunflower")
    .bind("ajax:beforeSend", function(data, status, xhr) {
      $(".sunflower").css({ opacity: 0.5 });
    })
    .bind("ajax:success", function(data, status, xhr) {
      $(".sunflower").html(status);
      $(".sunflower").fadeTo('fast', 1);
    });
});
