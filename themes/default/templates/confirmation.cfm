﻿<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Confirmation</span> 
</div>
<form method="post">
	<div id="order-confirmation" class="single_field" style="margin-top:20px;">
		<style>
			.myaccount-table td {
			text-align:center;
			}
		</style>
		<div class="myaccount-table" style="width:100%;float:margin-top:30px;">
			<table>
				<tr class="cart_menu">
					<td>Product</td>
					<td>Quantity</td>
					<td>Price</td>
					<td>Subtotal</td>
					<td>Tax</td>
					<td>Shipping</td>
				</tr>
				
				<cfloop array="#SESSION.order.productArray#" index="item">
					<cfset product = EntityLoadByPK("product",item.productId) />
					<cfset productShippingMethodRela = EntityLoadByPK("product_shipping_method_rela",item.productShippingMethodRelaId) />
					<tr>
						<td>
							<h4>#product.getDisplayName()#</h4>
							<p>SKU: #product.getSku()#</p>
						</td>
						<td>
							<p>#item.count#</p>
						</td>
						<td>
							<p>#DollarFormat(item.price)#</p>
						</td>
						<td>
							<p>#DollarFormat(item.price * item.count)#</p>
						</td>
						<td>
							<p>#DollarFormat(item.tax)#</p>
						</td>
						<td>
							<p>#productShippingMethodRela.getShippingMethod().getShippingCarrier().getDisplayName()# - #productShippingMethodRela.getShippingMethod().getDisplayName()#: #DollarFormat(productShippingMethodRela.getPrice())# (2 - 3 days)</p>
						</td>
					</tr>
				</cfloop>
			</table>
		</div>
		<div id="shipping-addresses" style="width:27%;float:left;margin-top:27px;">
			<table>
				<tr>
				<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Shipping Address</th>
				</tr>
					<tbody><tr>
						<td class="first-col">First Name:</td>
						<td>fff</td>
					</tr>
					
					<tr>
						<td class="first-col">Last Name:</td>
						<td>ffff</td>
					</tr>
					
					<tr>
						<td class="first-col">Phnoe:</td>
						<td>6476666666</td>
					</tr>
					
					<tr>
						<td style="padding-top:3px;padding-bottom:3px;" class="first-col">Street:</td>
						<td style="padding-top:3px;padding-bottom:3px;">6087A yonge st.</td>
					</tr>

					<tr>
						<td class="first-col">City:</td>
						<td>north york</td>
					</tr>

					<tr>
						<td class="first-col">Province:</td>
						<td>Ontario</td>
					</tr>
					<tr>
						<td class="first-col">Postal Code:</td>
						<td>m2m 3w2</td>
					</tr>
					<tr>
						<td class="first-col">Country:</td>
						<td>Canada</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="billing-addresses" style="width:27%;float:left;margin-top:27px;">
			<table>
				<tr>
					<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Billing Address</th>
				</tr>
					<tbody><tr>
						<td class="first-col">First Name:</td>
						<td>fff</td>
					</tr>
					
					<tr>
						<td class="first-col">Last Name:</td>
						<td>ffff</td>
					</tr>
					
					<tr>
						<td class="first-col">Phnoe:</td>
						<td>6476666666</td>
					</tr>
					
					<tr>
						<td style="padding-top:3px;padding-bottom:3px;" class="first-col">Street:</td>
						<td style="padding-top:3px;padding-bottom:3px;">6087A yonge st.</td>
					</tr>

					<tr>
						<td class="first-col">City:</td>
						<td>north york</td>
					</tr>

					<tr>
						<td class="first-col">Province:</td>
						<td>Ontario</td>
					</tr>
					<tr>
						<td class="first-col">Postal Code:</td>
						<td>m2m 3w2</td>
					</tr>
					<tr>
						<td class="first-col">Country:</td>
						<td>Canada</td>
					</tr>
					
				</tbody>
			</table>
		</div>
	
		<div id="checkout" style="height:auto;margin-top:30px;">
			<ul>
				<li>Cart Sub Total <span>$59</span></li>
				<li>Eco Tax <span>$2</span></li>
				<li>Shipping Cost <span>Free</span></li>
				<li>Total <span>$61</span></li>
			</ul>
		</div>
	</div>
	<div style="clear:both;"></div>
	
	<div  style="border-top:1px solid ##CCC;margin-top:20px;">
		<input type="submit" name="submit_order" value="Place Order" class="btn-signup" style="margin-top:10px;font-size:12px;">
	</div>
</form>
</cfoutput>