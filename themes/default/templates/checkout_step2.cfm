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
margin-left:-17px;
font-size:12px;
width:100%;
}
##products > li {
float:left;
width: 400px;
text-align:center;
margin-left:17px;
}

.dd-select {
  font-size:12px;
}

.dd-option-text, .dd-selected-text {
	font-size:12px;
	float:right;
	margin-right:20px;
}

.dd-option-image, .dd-selected-image {
	height:33px;
}

.dd-option-description, .dd-selected-description {
	float:right;
	text-align:right;
	margin-top:3px;
	margin-right:20px;
	width:160px;
	font-size:12px;
}
</style>
<form method="post">
	<ul id="products">
		<cfloop array="#SESSION.order.productArray#" index="item">
			<cfset product = EntityLoadByPK("product",item.productId) />
			<li>
				<img src="#product.getDefaultImageLink(type='small')#" style="width:53px;float:left;border:1px solid ##ccc;margin-right:5px;">
				<div id="shipping_methods_div" style="text-align:center;float:left;">
					<select id="shipping-methods-#product.getProductId()#">
						<cfloop from="1" to="#ArrayLen(product.getProductShippingMethodRelas())#" index="i">
							<cfset s = product.getProductShippingMethodRelas()[i] />
							<option value="#s.getProductShippingMethodRelaId()#" data-imagesrc="#APPLICATION.absoluteUrlWeb#images/uploads/shipping/#s.getShippingMethod().getShippingCarrier().getImageName()#"
								data-description="#DollarFormat(s.getPrice())#">Quantity: #item.count# &nbsp;&nbsp;#s.getShippingMethod().getShippingCarrier().getDisplayName()# - #s.getShippingMethod().getDisplayName()#</option>
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