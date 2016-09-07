$(function() {

	"use strict";

	$(".entry").click(function() {
		var aid = $(this).attr('aid');
		var avid = $(this).attr('avid');
		
		$(".overlay-popup .attr-" + aid).hide();
		$(".overlay-popup #attr-val-" + avid).show();
	});

	$("#add-to-cart").click(function() {
		$.ajax({
				type: "post",
				url: "#APPLICATION.absoluteUrlWeb#core/services/cartService.cfc",
				dataType: 'json',
				data: {
					method: 'addProductToCart',
					productid: $("##username").val(),
					quantity: 
				}
		})
		.done(function() {
			$("##login-section").slideUp();
		})
		.fail(function() {
			alert( "error" );
		})
		.always(function() {
			alert( "complete" );
		});
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