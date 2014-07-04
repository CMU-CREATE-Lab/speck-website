var url = window.location.href;

jQuery(document).ready(function($){
  $("#header a").filter(function() {
    return this.href == url;
  }).addClass("active_nav");

  $(".expander").simpleexpand();

  $(".expander").on("click", function() {
    $(this).find(".toggle_expand").toggle();
    $(this).find(".toggle_collapse").toggle();
  });
});
