<cfoutput>
<script>
	$(document).ready(function() {
		function incrementValue(eid, increment){
			$('##eid').val(Math.max(parseInt($('##eid').val()) + increment, 0));
		}
		
		$(".plus").click(function() {
			var e = $("##product_count_" + $(this).attr("trid"));
			e.val(Math.max(parseInt(e.val()) + 1, 0));
		});
		
		$(".minus").click(function() {
			var e = $("##product_count_" + $(this).attr("trid"));
			e.val(Math.max(parseInt(e.val()) - 1, 0));
		});
		
		$(".update-count").click(function() {
			$("##tracking_record_id") = $(this).attr("trid"));
		});
	});
</script>

<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Shopping Cart</span> 
</div>
			<style>
			.myaccount-table td {
			text-align:center;
			}
			</style>
			<form method="post">
			<input type="hidden" name="tracking_record_id" value="" />
			<div class="myaccount-table">
				<table>
					
					<tr class="cart_menu">
						<td class="image">Product</td>
						<td class="description"></td>
						<td class="price">Price</td>
						<td class="quantity">Quantity</td>
						<td class="total">Total</td>
						<td></td>
					</tr>
				
					<cfloop array="#REQUEST.pageData.trackingRecords#" index="cartItem">
						<cfset product = cartItem.getProduct() />
						<cfif NOT IsNull(product.getParentProduct())>
							<cfset productLink = product.getParentProduct().getDetailPageURL() />
						<cfelse>
							<cfset productLink = product.getDetailPageURL() />
						</cfif>
						<tr>
							<td class="cart_product">
								<a href="#productLink#">
									<img style="width:150px" src="#product.getDefaultImageLink(type='small')#" alt="#product.getDisplayName()#">
								</a>
							</td>
							<td class="cart_description">
								<h4><a href="#productLink#">#product.getDisplayName()#</a></h4>
								<p>SKU: #product.getSku()#</p>
							</td>
							<td class="cart_price">
								<p>#DollarFormat(product.getPrice(customerGroupName = SESSION.user.customerGroupName))#</p>
							</td>
							<td class="cart_quantity">
								<div class="cart_quantity_button">
									<button type="button" class="minus" trid="#cartItem.getTrackingRecordId()#">-</button>
									<input id="product_count_#cartItem.getTrackingRecordId()#" name="count" type="text" value="#cartItem.getCount()#" style="width:30px;text-align:center;" size="2" />
									<button type="button" class="plus" trid="#cartItem.getTrackingRecordId()#">+</button>
									<input type="submit" class="update-count" trid="#cartItem.getTrackingRecordId()#" name="update_count" value="update" />
								</div>
							</td>
							<td class="cart_total">
								<p class="cart_total_price">#DollarFormat(cartItem.getCount() * product.getPrice(customerGroupName = SESSION.user.customerGroupName))#</p>
							</td>
							<td class="cart_delete">
								<img src="#SESSION.absoluteUrlTheme#images/delete2.png" style="width:20px;" />
							</td>
						</tr>
					</cfloop>
				</table>
			</div>
			<!---
			<div id="shipping-estimate">
				<div style="font-weight:bold;">Estimate Shipping and Tax</div>
				<p>Enter your destination to get a shipping estimate.</p>
				<ul class="user_info">
					<li class="single_field">
						<div class="label">Country:</div>
						<select>
							<option>United States</option>
							<option>Bangladesh</option>
							<option>UK</option>
							<option>India</option>
							<option>Pakistan</option>
							<option>Ucrane</option>
							<option>Canada</option>
							<option>Dubai</option>
						</select>
						
					</li>
					<li class="single_field">
						<div class="label">State / Province:</div>
						<select>
							<option>Select</option>
							<option>Dhaka</option>
							<option>London</option>
							<option>Dillih</option>
							<option>Lahore</option>
							<option>Alaska</option>
							<option>Canada</option>
							<option>Dubai</option>
						</select>
					
					</li>
					<li class="single_field">
						<div class="label">Zip/Postal Code:</div>
						<input type="text">
					</li>
					<li class="single_field">
						<input type="button" value="Get Estimate" class="btn-signup" style="margin-top:10px;font-size:12px;">
					</li>
				</ul>
			</div>
			--->
			<div id="coupon">
				<div style="font-weight:bold;">Discount Codes</div>
				<p>Enter your coupon code if you have one.</p>
				<input type="text" id="coupon_code" name="coupon_code" value="" style="width:564px">
				<div style="margin-top:10px;">
					<button class="btn-signup" type="submit" name="apply_coupon" value="Apply Coupon" style="font-size:12px;"><span>Apply Coupon</span></button>
				</div>
			</div>
			<div id="checkout">
				<ul>
					<li>Sub Total <span>#DollarFormat(REQUEST.pageData.subTotal)#</span></li>
					<li>Tax <span>#DollarFormat(REQUEST.pageData.tax)#</span></li>
					<li>Total <span>#DollarFormat(REQUEST.pageData.total)#</span></li>
				</ul>
				<p style="float:right;font-weight:bold;">PayPal securely processes payments for PinMyDeals</p>
				<input type="image" name="submit_cart" src="#SESSION.absoluteUrlTheme#images/checkout_paypal.gif" alt="Submit Form" style="float:right;" />
			</div>
			</form>
</cfoutput>