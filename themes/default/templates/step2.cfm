<cfoutput>
<script>
	$(document).ready(function() {
		<cfloop array="#SESSION.order.productArray#" index="item">
			<cfset product = EntityLoadByPK("product",item.productId) /><cfdump var="#product.getProductShippingMethodRelas()#" top="1" abort>
			<cfif ArrayLen(product.getProductShippingMethodRelas()) GT 0>
				var ddData#product.getProductId()# = [
					<cfloop from="1" to="#ArrayLen(product.getProductShippingMethodRelas())#" index="i">
						<cfset s = product.getProductShippingMethodRelas()[i] />
						{
							text: "#s.getShippingMethod().getShippingCarrier().getDisplayName()# - #s.getShippingMethod().getDisplayName()#: #DollarFormat(s.getPrice())#",
							value: #s.getProductShippingMethodRelaId()#,
							selected: false,
							imageSrc: "#APPLICATION.absoluteUrlWeb#images/uploads/shipping/#s.getShippingMethod().getShippingCarrier().getImageName()#"
						}
						<cfif i LT ArrayLen(product.getProductShippingMethodRelas())>
						,
						</cfif>
					</cfloop>
				];

				$('.shipping-methods-#product.getProductId()#').ddslick({
					data: ddData#product.getProductId()#,
					width: 300,
					imagePosition: "left",
					selectText: "Select your shipping method",
					onSelected: function (data) {
						console.log(data);
					}
				});
			</cfif>
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
						<cfloop array="#SESSION.order.productArray#" index="item">
							<cfset product = EntityLoadByPK("product",item.productId) />
							<li style="border:1px solid ##ccc">
								<img class="thumbnail-img" src="#product.getDefaultImageLink(type='small')#">
								<div class="thumbnail-name">#product.getDisplayName()#</div>
								<div id="shipping_methods_div" style="margin-top:15px;padding-top:17px;border-top:1px dashed ##ccc;">
									<div id="shipping-methods-#product.getProductId()#"></div>
								</div>
							</li>
						</cfloop>
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