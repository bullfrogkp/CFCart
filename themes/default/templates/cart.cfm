<cfoutput>
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
						<tr>
							<td class="cart_product">
								<a href="#product.getDetailPageURL()#">
									<img src="#product.getDefaultImageLink(type='small')#" alt="#product.getDisplayName()#">
								</a>
							</td>
							<td class="cart_description">
								<h4><a href="#product.getDetailPageURL()#">#product.getDisplayName()#</a></h4>
								<p>SKU: #product.getSku()#</p>
							</td>
							<td class="cart_price">
								<p>#DollarFormat(product.getPrice(customerGroupName = SESSION.user.customerGroupName))#</p>
							</td>
							<td class="cart_quantity">
								<div class="cart_quantity_button">
									<button id="minus">-</button>
									<input id="value" name="count" type="text" value="#cartItem.getCount()#" style="width:30px;text-align:center;" size="2" />
									<button id="plus">+</button>
									<input type="submit" name="update_count" value="update" />
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
			<div id="coupon">
				<div style="font-weight:bold;">Discount Codes</div>
				<p>Enter your coupon code if you have one.</p>
				<input type="text" id="coupon_code" name="coupon_code" value="" style="width:275px">
				<div style="margin-top:10px;"><button class="btn-signup" type="button" value="Apply Coupon" style="font-size:12px;"><span>Apply Coupon</span></button></div>
			</div>
			<div id="checkout">
				<ul>
					<li>Cart Sub Total <span>$59</span></li>
					<li>Eco Tax <span>$2</span></li>
					<li>Shipping Cost <span>Free</span></li>
					<li>Total <span>$61</span></li>
				</ul>
				<p style="float:right;font-weight:bold;">PayPal securely processes payments for TomTop</p>
				<input type="image" src="#SESSION.absoluteUrlTheme#images/checkout_paypal.gif" alt="Submit Form" style="float:right;" />
			</div>
			</form>
</cfoutput>