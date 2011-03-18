// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association , "g")
  $(link).parent().before(content.replace(regexp, new_id));
}
$(function() {
  var tallest = 0;
  var $columnsToEqualize = $(".column");
  $columnsToEqualize.each(function() {
    var thisHeight = $(this).height();
    if (thisHeight > tallest) {
      tallest = thisHeight;
    }
  });
  $columnsToEqualize.height(tallest);
});
$(function() {
  var tallest = 0;
  var $columnsToEqualize = $(".header");
  $columnsToEqualize.each(function() {
    var thisHeight = $(this).height();
    if (thisHeight > tallest) {
      tallest = thisHeight;
    }
  });
  $columnsToEqualize.height(tallest);
});
 $(document).ready( function() {
    stretch_portal_content();
 $(window).resize( stretch_portal_content );
 });
function stretch_portal_content() {
            if ($(window).height() > $('body').innerHeight())
            {$('#portal-content').height(
       $(window).height() -($('body').innerHeight() - $('#portal-content').outerHeight(true)));}}

$(document).ready(function(){

$('a[rel=celeb]').colorbox({
  height:'80%',
  width:'60%',
  transition: 'fade',
  speed: 500,
  current: "{current} of {total} celebrity photos"
});

});


