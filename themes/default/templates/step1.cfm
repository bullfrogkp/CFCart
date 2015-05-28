<cfoutput>
<script>
	$(document).ready(function() {
		
		$(".use-this-address").click(function() {
			$("##existing_address_id").val($(this).attr("addressid"));
		});
		
	});
</script>

<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Customer Information</span> 
</div>
	<form method="post">
	<input type="hidden" name="existing_address_id" value="" />
	<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
		<div style="font-size:12px;color:red;margin:20px 0 20px 20px;">
			<ul>
				<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
					<li>#msg#</li>
				</cfloop>
			</ul>
		</div>
	</cfif>
	<div id="checkout-info" class="single_field">
		<div id="checkout-addresses" style="width:40%;float:left;margin-top:20px;">
		
			<cfif IsNumeric(SESSION.user.customerId)>
				<cfset customer = EntiyLoadByPK("customer",SESSION.user.customerId) />
				<cfif ArrayLen(customer.getAddresses()) GT 0>
					<ul>
						<cfloop array="#customer.getAddresses()#" index="address">
							<li>
								#address.getFullName()#<br/>
								#address.getUnit()# #address.getStreet()#<br/>
								#address.getCity()#, #address.getProvince().getDisplayName()# #address.getPostalCode()#<br/>
								#address.getCountry().getDisplayName()#<br/>
								<input type="submit" class="use-this-address" addressid="#address.getAddressId()#" name="user_this_address" value="Use this address" />
							</li>
						</cfloop>
					</ul>
				</cfif>
			<cfelse>
				<table style="width:100%;">	
					<tr>
						<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Contact</th>
					</tr>
					<tr>
						<td style="font-weight:bold;width:93px;">Email:</td>
						<td>
							<input name="new_email" id="new_email" type="text" maxlength="32" size="30" style="width:180px;"> 
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="email-validation">Please enter a valid email address</span>
						</td>
					</tr>
				</table>
			</cfif>
			
			<table id="current-address-table" class="shipping-address-selected" style="width:100%;margin-top:20px;">	
				<tr>
					<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Add a new address</th>
				</tr>
				<tbody>
					<tr>
						<td style="font-weight:bold;width:93px;">Company:</td>
						<td>
							<input name="shipto_company" id="shipto_company" type="text" maxlength="32" size="30" style="width:180px;">
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;width:93px;">First Name:</td>
						<td>
							<input name="shipto_first_name" id="shipto_first_name" type="text" maxlength="32" size="30" style="width:180px;">
							
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="first-name-validation-shipping">Please enter your first name</span>
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;width:93px;">Middle Name:</td>
						<td>
							<input name="shipto_middle_name" id="shipto_middle_name" type="text" maxlength="32" size="30" style="width:180px;">
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;">Last Name:</td>
						<td>
							<input name="shipto_last_name" id="shipto_last_name" type="text" maxlength="32" size="30" style="width:180px;">
							
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="last-name-validation-shipping">Please enter your last name</span>
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;">Phone:</td>
						<td>
							<input name="shipto_phone" id="shipto_phone" type="text" maxlength="32" size="30" style="width:180px;">
							
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="phone-validation-shipping">Please enter your phone number</span>
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;">Unit: </td>
						<td>
							<input name="shipto_unit" id="shipto_unit" type="text" maxlength="100" size="25" style="width:180px;">
							
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="street-validation-shipping">Please enter your street</span>
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;">Street: </td>
						<td>
							<input name="shipto_street" id="shipto_street" type="text" maxlength="100" size="25" style="width:180px;">
							
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="street-validation-shipping">Please enter your street</span>
						</td>
					</tr>
					  
					<tr>
						<td style="font-weight:bold;">City: </td>
						<td>
							<input name="shipto_city" id="shipto_city" type="text" maxlength="40" size="25" style="width:180px;">
							
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="city-validation-shipping">Please enter your city</span>
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;">Province: </td>
						<td>
							<select name="shipto_province_id" id="shipto_province_id" style="width:186px;">
								<option value="">Please select...</option>
								<cfloop array="#REQUEST.pageData.provinces#" index="province">
									<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
								</cfloop>
							</select>
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="province-validation-shipping">Please select your province</span>
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;">Postal Code: </td>
						<td>
							<input name="shipto_postal_code" id="shipto_postal_code" type="text" maxlength="10" size="10" style="width:180px;">
							
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="postal-code-validation-shipping">Please enter your postal code</span>
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;">Country: </td>
						<td>
							<select name="shipto_country_id" id="shipto_country_id" style="width:186px;">
								<option value="">Please select...</option>
								<cfloop array="#REQUEST.pageData.countries#" index="country">
									<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
								</cfloop>
							</select>
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="country-validation-shipping">Please select your country</span>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding-top:10px;">
							<input type="submit" value="Ship to this address" name="shipping_to_new_address" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div style="clear:both;"></div>
	</form>
</cfoutput>