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
								
								if(result.ORIGINALPRICE > result.CURRENTPRICE) {
									$(".detail-info-entry .prev").html(result.ORIGINALPRICE);
									$(".detail-info-entry .current").html(result.CURRENTPRICE);
									$(".detail-info-entry .prev").show();
								} else {
									$(".detail-info-entry .prev").hide();
									$(".detail-info-entry .current").html(result.CURRENTPRICE);
								}
								
								
								
								var price = result.PRICE;
								var stock = result.STOCK;
								var productid = result.PRODUCTID;
							
							
								if(price > 0)
								{
									$("##price-amount").html('$' + price.toFixed(2));
								}
								else
								{
									$("##price-amount").html('Price is not available');
								}
								
								if(stock > 0)
								{
									$("##stock-count").html(stock + ' in stock');
								}
								else
								{
									$("##stock-count").html('Stock is not available');
								}
								
								if(price > 0 && stock > 0)
								{
									$("##selected_product_id").val(productid);
									$("##add-current-to-cart").show();
									$("##add-current-to-cart-disabled").hide();
									$("##add-current-to-wishlist").show();
									$("##add-current-to-wishlist-disabled").hide();
								}
								else
								{
									$("##selected_product_id").val(#REQUEST.pageData.product.getProductId()#);
									$("##add-current-to-cart").hide();
									$("##add-current-to-cart-disabled").show();
									$("##add-current-to-wishlist").hide();
									$("##add-current-to-wishlist-disabled").show();
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