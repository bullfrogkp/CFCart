<cfoutput>
<script>
	$(document).ready(function() {
		<cfloop array="#SESSION.order.productArray#" index="item">
			<cfset product = EntityLoadByPK("product",item.productId) />
			<cfif ArrayLen(product.getProductShippingMethodRelas()) GT 0>
				$('##shipping-methods-#product.getProductId()#').ddslick({
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
<style>
##products {
margin-top:20px;
list-style-type:none;
margin-left:-12px;
font-size:12px;
}
##products > li {
float:left;
width: 231px;
text-align:center;
margin-left:12px;
}

##products li .thumbnail-img {
width: 200px;
}
</style>
<form method="post">
	<ul id="products">
		<cfloop array="#SESSION.order.productArray#" index="item">
			<cfset product = EntityLoadByPK("product",item.productId) />
			<li style="border:1px solid ##ccc">
				<img class="thumbnail-img" src="#product.getDefaultImageLink(type='small')#">
				<div class="thumbnail-name">#product.getDisplayName()#</div>
				<div id="shipping_methods_div" style="margin-top:15px;padding:10px;text-align:center;">
					<select id="shipping-methods-#product.getProductId()#">
						<cfloop from="1" to="#ArrayLen(product.getProductShippingMethodRelas())#" index="i">
							<cfset s = product.getProductShippingMethodRelas()[i] />
							<option value="#s.getProductShippingMethodRelaId()#" data-imagesrc="#APPLICATION.absoluteUrlWeb#images/uploads/shipping/#s.getShippingMethod().getShippingCarrier().getImageName()#"
								data-description="#DollarFormat(s.getPrice())#">#s.getShippingMethod().getShippingCarrier().getDisplayName()# - #s.getShippingMethod().getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
			</li>
		</cfloop>
	</ul>
	<div style="clear:both;"></div>
	<div style="border-top:1px solid ##CCC;margin-top:20px;">
		<input type="submit" value="Next Step" class="btn-signup" style="margin-top:10px;font-size:12px;">
	</div>
</form>
</cfoutput>