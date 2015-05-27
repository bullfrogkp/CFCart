<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Customer Information</span> 
</div>
	<form method="post">
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
			
			<table id="current-address-table" class="shipping-address-selected" style="width:100%;margin-top:20px;">	
				<tr>
					<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Shipping Information</th>
				</tr>
				<tbody>
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
						<table style="margin-left:-3px;">
							<tbody><tr>
								<td>
									<input type="checkbox" name="billing_info_is_different" id="billing_info_is_different" value="1" onclick="if(this.checked) $('##new-billing-address').slideDown(500); else $('##new-billing-address').slideUp(500);">
								</td>
								<td>&nbsp;Check here is your billing information is different</td>
							</tr>
						</tbody></table>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div id="new-billing-address" style="display:none;">
				<table id="current-address-table" class="shipping-address-selected" style="width:100%;">	
					<tr>
						<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Billing Information</th>
					</tr>
					<tbody>
						<tr>
							<td style="font-weight:bold;width:93px;">First Name:</td>
							<td>
								<input name="billto_first_name" id="billto_first_name" type="text" maxlength="32" size="30" style="width:180px;">
								
								&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="first-name-validation-billing">Please enter your first name</span>
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Last Name:</td>
							<td>
								<input name="billto_last_name" id="billto_last_name" type="text" maxlength="32" size="30" style="width:180px;">
								
								&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="last-name-validation-billing">Please enter your last name</span>
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Phone:</td>
							<td>
								<input name="billto_phone" id="billto_phone" type="text" maxlength="32" size="30" style="width:180px;">
								
								&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="phone-validation-billing">Please enter your phone number</span>
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Unit: </td>
							<td>
								<input name="billto_unit" id="billto_unit" type="text" maxlength="100" size="25" style="width:180px;">
								
								&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="street-validation-billing">Please enter your street</span>
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Street: </td>
							<td>
								<input name="billto_street" id="billto_street" type="text" maxlength="100" size="25" style="width:180px;">
								
								&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="street-validation-billing">Please enter your street</span>
							</td>
						</tr>
						  
						<tr>
							<td style="font-weight:bold;">City: </td>
							<td>
								<input name="billto_city" id="billto_city" type="text" maxlength="40" size="25" style="width:180px;">
								
								&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="city-validation-billing">Please enter your city</span>
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Province: </td>
							<td>
								<select name="billto_province_id" id="billto_province_id" style="width:186px;">
									<option value="">Please select...</option>
									<cfloop array="#REQUEST.pageData.provinces#" index="province">
										<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
									</cfloop>
									</select>
								&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="province-validation-billing">Please select your province</span>
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Postal Code: </td>
							<td>
								<input name="billto_postal_code" id="billto_postal_code" type="text" maxlength="10" size="10" style="width:180px;">
								
								&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="postal-code-validation-billing">Please enter your postal code</span>
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Country: </td>
							<td>
								<select name="billto_country_id" id="billto_country_id" style="width:186px;">
									<option value="">Please select...</option>
									<cfloop array="#REQUEST.pageData.countries#" index="country">
										<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
									</cfloop>
								</select>
								&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="country-validation-billing">Please select your country</span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div style="clear:both;"></div>
	<div  style="border-top:1px solid ##CCC;margin-top:20px;">
	<input type="submit" name="update_cutomer_info" value="Next Step" class="btn-signup" style="margin-top:10px;font-size:12px;">
	</div>
	</form>

</cfoutput>