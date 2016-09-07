$(function() {

	"use strict";

	function getProductId(){
		$( "#results-num" ).html(str);
	}
	
	(function main(){
		$(function() {
			$(".overlay-popup .detail-info-entry .entry").hide();
			$(".overlay-popup .detail-info-entry .entry").removeClass('active');
			
			$(".overlay-popup .detail-info-entry").each(function( index ) {
				$( this ).children(".entry").first().show();
			});
			
			$(".entry").click(function() {
				var aid = $(this).attr('aid');
				var avid = $(this).attr('avid');
				
				$(".overlay-popup .attr-" + aid).hide();
				$(".overlay-popup #attr-val-" + avid).show();
				
				selectedProductId = getProductId();
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
			
			$(".filter-options div").click(function() {
				$(this).closest('.filter-options').css("border-color","red");
				$(this).closest('.filter-options').siblings().css("border-color","##CCC");
				
				var index = $(this).closest('.filter-options').attr('attributevalueid');
				var value = optionStruct[index];
				var insert = true;
				
				for (var i = 0; i < optionArray.length; i++) {
					if(optionArray[i].attributeid == value)
					{
						optionArray[i].attributevalueid = index;
						insert = false;
						break;
					}
				}
				
				if(insert == true)
				{
					var option = new Object();
					option.attributeid = value;
					option.attributevalueid = index;
					optionArray.push(option);
				}
				
				if(optionArray.length == #REQUEST.pageData.requiredAttributeCount#)
				{
					var optionList = '';
					for (var i = 0; i < optionArray.length; i++) {
						optionList = optionList + optionArray[i].attributevalueid + ',';
					}
					
					$.ajax({
							type: "get",
							url: "#APPLICATION.absoluteUrlWeb#core/services/productService.cfc",
							dataType: 'json',
							data: {
								method: 'getProduct',
								parentProductId: #REQUEST.pageData.product.getProductId()#,
								attributeValueIdList: optionList,
								customerGroupName: '#SESSION.user.customerGroupName#'
							},		
							success: function(result) {
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