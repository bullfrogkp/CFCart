$(function() {

	"use strict";

	$(".entry").click(function() {
		var aid = $(this).attr('aid');
		var avid = $(this).attr('avid');
		
		$(".overlay-popup .attr-" + aid).hide();
		$(".overlay-popup #attr-val-" + avid).show();
	});
	
	(function main(){
		$(function() {
			$(".overlay-popup .detail-info-entry .entry").hide();
			$(".overlay-popup .detail-info-entry .entry").removeClass('active');
			
			$(".overlay-popup .detail-info-entry").each(function( index ) {
				  $( this ).children(".entry").first().show();
			});
		});
	})();
});