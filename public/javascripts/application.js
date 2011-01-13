// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(function($) {
  var fade = function() { $(".loading").toggle() };

  $(".page")
    .bind("ajax:beforeSend", function(data, status, xhr) {
      $(".page").css({ opacity: 0.5 });
    })
    .bind("ajax:success", function(data, status, xhr) {
      $('body').animate({scrollTop:0}, 'fast');
      $(".page").html(status);
      $(".page").fadeTo('fast', 1);
    });
});
