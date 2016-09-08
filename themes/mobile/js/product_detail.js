$(function() {

	"use strict";
	
	(function main(){
		$(function() {
			$(".overlay-popup .detail-info-entry .entry").hide();
			$(".overlay-popup .detail-info-entry .entry").removeClass('active');
			
			$(".overlay-popup .detail-info-entry").each(function( index ) {
				$( this ).children(".entry").first().show();
			});
			
			$("#add-to-cart").click(function() {
				$.ajax({
						type: "post",
						url: "#APPLICATION.absoluteUrlWeb#core/services/cartService.cfc",
						dataType: 'json',
						data: {
							method: 'addProductToCart',
							productid: selectedProductId,
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
			
			$(".entry").click(function() {
				var aid = $(this).attr('aid');
				var avid = $(this).attr('avid');
				
				$(".overlay-popup .attr-" + aid).hide();
				$(".overlay-popup #attr-val-" + avid).show();
								
				var insert = true;
				
				for (var i = 0; i < optionArray.length; i++) {
					if(optionArray[i].attributeid == aid)
					{
						optionArray[i].attributevalueid = avid;
						insert = false;
						break;
					}
				}
				
				if(insert == true)
				{
					var option = new Object();
					option.attributeid = aid;
					option.attributevalueid = avid;
					optionArray.push(option);
				}
				
				if(optionArray.length == optionArrayLength)
				{
					var optionList = '';
					for (var i = 0; i < optionArray.length; i++) {
						optionList = optionList + optionArray[i].attributevalueid + ',';
					}
					
					$.ajax({
							type: "get",
							url: requestUrl,
							dataType: 'json',
							data: {
								method: 'getProduct',
								parentProductId: parentProductId,
								attributeValueIdList: optionList,
								customerGroupName: customerGroupName
							},		
							success: function(result) {
								var oriPrice = result.ORIGINALPRICE;
								var curPrice = result.CURRENTPRICE;
								var stock = result.STOCK;
								var productid = result.PRODUCTID;
								
								if(curPrice > 0) {
									$(".price-detail").hide();
									if(oriPrice > curPrice) {
										$(".detail-info-entry .prev").html(currencySymbol + ' ' + oriPrice);
										$(".detail-info-entry .current").html(currencySymbol + ' ' + curPrice);
										$(".detail-info-entry .prev").show();
										$(".detail-info-entry .current").show();
									} else {
										$(".detail-info-entry .prev").hide();
										$(".detail-info-entry .current").show();
										$(".detail-info-entry .current").html(result.CURRENTPRICE);
									}
								} else {
									$(".detail-info-entry .prev").hide();
									$(".detail-info-entry .current").hide();
									$(".price-detail").html('Price is not available');
									$(".price-detail").show();
								}
								
								if(stock > 0)
								{
									$("#stock-detail").html(stock + ' in stock');
								}
								else
								{
									$("#stock-detail").html('Stock is not available');
								}
								
								if(curPrice > 0 && stock > 0)
								{
									selectedProductId = productid;
									$("##add-to-cart").show();
									$("##add-to-cart-disabled").hide();
								}
								else
								{
									selectedProductId = parentProductId;
									$("##add-current-to-cart").hide();
									$("##add-current-to-cart-disabled").show();
								}
							}
					});
				}
			});
			/*
			$("##add-current-to-wishlist").click(function() {
				$.ajax({
							type: "get",
							url: "#APPLICATION.absoluteUrlWeb#core/services/trackingService.cfc",
							dataType: 'json',
							data: {
								method: 'addTrackingRecord',
								productId: $("##selected_product_id").val(),
								trackingRecordType: 'wishlist'
							},		
							success: function(result) {
								if(result.TRACKINGRECORDID)
								{
									wishlistdialog.dialog( "open" );			
								}
								else
								{
									console.log('Fail to add record');
								}
							}
				});
			});
			*/
		});
	})();
});