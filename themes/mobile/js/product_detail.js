$(function() {

	"use strict";

	$(".entry").click(function() {
		var aid = $(this).attr('aid');
		var avid = $(this).attr('avid');
		
		$(".overlay-popup .attr-" + aid).hide();
		$(".overlay-popup #attr-val-" + avid).show();
	});
});