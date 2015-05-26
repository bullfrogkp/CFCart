<cfoutput>
<script>
	$(document).ready(function() {
		<cfloop array="#SESSION.order.productArray#" index="item">
		var ddData#item.product.getProductId()# = [
			<cfset s = item.product.getProductShippingMethodRelas() />
			<cfloop query="s">
				{
					text: "#s.getShippingMethod().getShippingCarrier().getDisplayName()# - #s.getShippingMethod().getDisplayName()#: #DollarFormat(s.getCalculatedPrice())#",
					value: #s.product_shipping_method_rela_id#,
					selected: false,
					imageSrc: "#APPLICATION.absoluteUrlWeb#images/uploads/shipping/#s.image_name#"
				}
				<cfif s.currentRow LT s.recordCount>
				,
				</cfif>
			</cfloop>
		];

		$('.order-product-#item.product.getProductId()#').ddslick({
			data: ddData#item.product.getProductId()#,
			width: 300,
			imagePosition: "left",
			selectText: "Select your shipping method",
			onSelected: function (data) {
				console.log(data);
			}
		});
		</cfloop>
	});
</script>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Shipping</span> 
</div>
	<form method="post">
	<div id="checkout-info" class="single_field">
		<div class="cat-thumbnails">
				<div>
					<ul class="rig columns-4">
						
						<li style="border:1px solid ##ccc">
							<a href="/cfcart/product_detail.cfm/products1/11">
								<img class="thumbnail-img" src="/cfcart/images/site/no_image_available.png">
							</a>
							<div class="thumbnail-name"><a href="/cfcart/product_detail.cfm/products1/11">products1</a></div>
							<div id="shipping_methods_div" style="margin-top:15px;padding-top:17px;border-top:1px dashed ##ccc;">
								<div id="shipping_methods"></div>
							</div>
						</li>
					
						<li style="border:1px solid ##ccc">
							<a href="/cfcart/product_detail.cfm/uhuhuh/16">
								<img class="thumbnail-img" src="/cfcart/images/site/no_image_available.png">
							</a>
							<div class="thumbnail-name"><a href="/cfcart/product_detail.cfm/uhuhuh/16">uhuhuh</a></div>
							<div class="thumbnail-price">$0.00</div>
							<img class="free-shipping-icon" src="/cfcart/images/freeshipping.jpg" style="width:120px;margin-top:7px;">
							<div class="product-overlay">
								<div class="overlay-content">
									<div class="thumbnail-rating"></div>
									<div class="thumbnail-review"><a href="/cfcart/product_detail.cfm/uhuhuh/16">(0 Reviews)</a></div>
									<div class="thumbnail-cart"><a class="btn add-to-cart" style="padding-right:13px;">Add to cart</a></div>
								</div>
							</div>
						</li>
					
						<li style="border:1px solid ##ccc">
							<a href="/cfcart/product_detail.cfm/kkk/17">
								<img class="thumbnail-img" src="/cfcart/images/uploads/product/17/small_image2.jpg">
							</a>
							<div class="thumbnail-name"><a href="/cfcart/product_detail.cfm/kkk/17">kkk</a></div>
							<div class="thumbnail-price">$0.00</div>
							<img class="free-shipping-icon" src="/cfcart/images/freeshipping.jpg" style="width:120px;margin-top:7px;">
							<div class="product-overlay">
								<div class="overlay-content">
									<div class="thumbnail-rating"></div>
									<div class="thumbnail-review"><a href="/cfcart/product_detail.cfm/kkk/17">(0 Reviews)</a></div>
									<div class="thumbnail-cart"><a class="btn add-to-cart" style="padding-right:13px;">Add to cart</a></div>
								</div>
							</div>
						</li>
					
						<li style="border:1px solid ##ccc">
							<a href="/cfcart/product_detail.cfm/opopop/18">
								<img class="thumbnail-img" src="/cfcart/images/uploads/product/18/small_image3.jpg">
							</a>
							<div class="thumbnail-name"><a href="/cfcart/product_detail.cfm/opopop/18">opopop</a></div>
							<div class="thumbnail-price">$0.00</div>
							<img class="free-shipping-icon" src="/cfcart/images/freeshipping.jpg" style="width:120px;margin-top:7px;">
							<div class="product-overlay">
								<div class="overlay-content">
									<div class="thumbnail-rating"></div>
									<div class="thumbnail-review"><a href="/cfcart/product_detail.cfm/opopop/18">(0 Reviews)</a></div>
									<div class="thumbnail-cart"><a class="btn add-to-cart" style="padding-right:13px;">Add to cart</a></div>
								</div>
							</div>
						</li>
							
					</ul>
				</div>
			</div>
	</div>
	<div style="clear:both;"></div>
	<div  style="border-top:1px solid ##CCC;margin-top:20px;">
	<input type="submit" value="Next Step" class="btn-signup" style="margin-top:10px;font-size:12px;">
	</div>
	</form>

</cfoutput>