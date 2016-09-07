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
					productid: $("#username").val(),
					quantity: $("#quantity").html();
				}
		})
		.done(function(data) {		
			var str = '';
			for(var i=0;i<data.products.length;i++) {
				str += '<div class="cart-entry"><a class="image"><img src="'+data.products[i].image+'" alt="'+data.products[i].name+'"></a><div class="content"><a class="title" href="'+data.products[i].href+'">'+data.products[i].name+'</a><div class="quantity">Quantity: '+data.products[i].quantity+'</div><div class="price">'+data.products[i].price+'</div></div></div>';
			}
			
			str += '<div class="summary"><div class="subtotal">Subtotal: '+data.subtotal+'</div><div class="grandtotal">Grand Total <span>'+data.total+'</span></div></div><div class="cart-buttons"><div class="column"><a class="button style-3" href="cart.cfm">view cart</a><div class="clear"></div></div><div class="column"><a class="button style-4" href="checkout/checout_paypal_express.cfm">checkout</a><div class="clear"></div></div><div class="clear"></div></div>';
			
			$(".popup-container").html(str);   
		})
		.fail(function(data) {
			alert( "error" );
		})
		.always(function(data) {
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