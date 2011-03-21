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
function equalize_column(){
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
}
/*$(function() {
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
});*/
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

$(document).ready(function(){

	$("ul.subnav").parent().append("<span></span>"); //Only shows drop down trigger when js is enabled - Adds empty span tag after ul.subnav

	$("ul.topnav li span").click(function() { //When trigger is clicked...

		//Following events are applied to the subnav itself (moving subnav up and down)
		$(this).parent().find("ul.subnav").slideDown('fast').show(); //Drop down the subnav on click

		$(this).parent().hover(function() {
		}, function(){
			$(this).parent().find("ul.subnav").slideUp('slow'); //When the mouse hovers out of the subnav, move it back up
		});

		//Following events are applied to the trigger (Hover events for the trigger)
		}).hover(function() {
			$(this).addClass("subhover"); //On hover over, add class "subhover"
		}, function(){	//On Hover Out
			$(this).removeClass("subhover"); //On hover out, remove class "subhover"
	});

});