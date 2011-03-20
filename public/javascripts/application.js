// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function stretch_portal_content() {
            if ($(window).height() > $('body').innerHeight())
            {$('#container').height(
       $(window).height() -($('body').innerHeight() - $('#container').outerHeight(true)));}}

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
     if(tallest<450){
        tallest=450;
    }
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

$(document).ready(function(){

$('a[rel=image]').colorbox({
  scalePhotos: false,
  preloading:true,
  height: '85%',
  width:  '90%',
  transition: 'fade',
  speed: 500,
  current: "{current} of {total} photos"
});

});

$(document).ready(function(){

 $('#toggle_address_fields').toggle( function() {$('#toggle_contact_fields').attr('value','Activé');
     $('#address :input').removeAttr('disabled');
},function() {$('#toggle_contact_fields').attr('value','Désactiver');
  $('#address :input').attr('disabled', 'disabled');

});});

$(document).ready(function(){
 $('#toggle_contact_fields').toggle(function() {$('#toggle_contact_fields').attr('value','Activé');
     $('#contact :input').removeAttr('disabled');
},function() {$('#toggle_contact_fields').attr('value','Désactiver');
  $('#contact :input').attr('disabled', 'disabled');

} );});
