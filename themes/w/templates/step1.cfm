<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
</div>
	<div id="checkout-info" class="single_field">
		<div id="checkout-addresses" style="width:40%;float:left;margin-top:20px;">
		<table style="width:100%;">	
			<tr>
				<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Contact</th>
			</tr>
			<tr>
				<td style="font-weight:bold;width:93px;">Email:</td>
				<td>
					<input name="new_contact_email" id="new_contact_email" type="text" maxlength="32" size="30" style="width:180px;"> 
					&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="email-validation">Please enter a valid email address</span>
				</td>
			</tr>
		</table>
		
		<table id="current-address-table" class="shipping-address-selected" style="width:100%;margin-top:20px;">	
			<tr>
				<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Shipping Information</th>
			</tr>
			<tbody><tr>
				<td style="font-weight:bold;width:93px;">First Name:</td>
				<td>
					<input name="shipto_first_name" id="shipto_first_name" type="text" maxlength="32" size="30" style="width:180px;">
					
					&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="first-name-validation-shipping">Please enter your first name</span>
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
						
							<option value="1">Alberta</option>
						
							<option value="2">British Columbia</option>
						
							<option value="3">Manitoba</option>
						
							<option value="4">New Brunswick</option>
						
							<option value="5">Newfoundland and Labrador</option>
						
							<option value="6">Northwest Territories</option>
						
							<option value="7">Nova Scotia</option>
						
							<option value="8">Nunavut</option>
						
							<option value="9">Ontario</option>
						
							<option value="10">Prince Edward Island</option>
						
							<option value="11">Quebec</option>
						
							<option value="12">Saskatchewan</option>
						
							<option value="13">Yukon</option>
						
							<option value="14">Alabama</option>
						
							<option value="15">Alaska</option>
						
							<option value="16">Arizona</option>
						
							<option value="17">Arkansas</option>
						
							<option value="18">California</option>
						
							<option value="19">Colorado</option>
						
							<option value="20">Connecticut</option>
						
							<option value="21">Delaware</option>
						
							<option value="22">Florida</option>
						
							<option value="23">Georgia</option>
						
							<option value="24">Hawaii</option>
						
							<option value="25">Idaho</option>
						
							<option value="26">Illinois</option>
						
							<option value="27">Indiana</option>
						
							<option value="28">Iowa</option>
						
							<option value="29">Kansas</option>
						
							<option value="30">Louisiana</option>
						
							<option value="31">Maine</option>
						
							<option value="32">Maryland</option>
						
							<option value="33">Michigan</option>
						
							<option value="34">Minnesota</option>
						
							<option value="35">Mississippi</option>
						
							<option value="36">Missouri</option>
						
							<option value="37">Montana</option>
						
							<option value="38">Nebraska</option>
						
							<option value="39">Nevada</option>
						
							<option value="40">New Hampshire</option>
						
							<option value="41">New Jersey</option>
						
							<option value="42">New Mexico</option>
						
							<option value="43">New York</option>
						
							<option value="44">North Carolina</option>
						
							<option value="45">North Dakota</option>
						
							<option value="46">Ohio</option>
						
							<option value="47">Oklahoma</option>
						
							<option value="48">Oregon</option>
						
							<option value="49">Rhode Island</option>
						
							<option value="50">South Carolina</option>
						
							<option value="51">South Dakota</option>
						
							<option value="52">Tennessee</option>
						
							<option value="53">Texas</option>
						
							<option value="54">Utah</option>
						
							<option value="55">Vermont</option>
						
							<option value="56">Washington</option>
						
							<option value="57">West Virginia</option>
						
							<option value="58">Wisconsin</option>
						
							<option value="59">Wyoming</option>
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
						
							<option value="1">Canada</option>
						
							<option value="2">Usa</option>
						</select>
					&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="country-validation-shipping">Please select your country</span>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top:10px;">
				<table style="margin-left:-3px;">
					<tbody><tr>
						<td>
							<input type="checkbox" name="billing_info_different" id="billing_info_different" value="1" onclick="if(this.checked) $('##new-billing-address').slideDown(500); else $('##new-billing-address').slideUp(500);">
						</td>
						<td>&nbsp;Check here is your billing information is different</td>
					</tr>
				</tbody></table>
				</td>
			</tr>
		</tbody></table>
		<!--
		<table id="current-address-table" class="shipping-address-selected" style="width:100%;">	
			<tr>
				<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Billing Information</th>
			</tr>
			<tbody><tr>
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
						
							<option value="1">Alberta</option>
						
							<option value="2">British Columbia</option>
						
							<option value="3">Manitoba</option>
						
							<option value="4">New Brunswick</option>
						
							<option value="5">Newfoundland and Labrador</option>
						
							<option value="6">Northwest Territories</option>
						
							<option value="7">Nova Scotia</option>
						
							<option value="8">Nunavut</option>
						
							<option value="9">Ontario</option>
						
							<option value="10">Prince Edward Island</option>
						
							<option value="11">Quebec</option>
						
							<option value="12">Saskatchewan</option>
						
							<option value="13">Yukon</option>
						
							<option value="14">Alabama</option>
						
							<option value="15">Alaska</option>
						
							<option value="16">Arizona</option>
						
							<option value="17">Arkansas</option>
						
							<option value="18">California</option>
						
							<option value="19">Colorado</option>
						
							<option value="20">Connecticut</option>
						
							<option value="21">Delaware</option>
						
							<option value="22">Florida</option>
						
							<option value="23">Georgia</option>
						
							<option value="24">Hawaii</option>
						
							<option value="25">Idaho</option>
						
							<option value="26">Illinois</option>
						
							<option value="27">Indiana</option>
						
							<option value="28">Iowa</option>
						
							<option value="29">Kansas</option>
						
							<option value="30">Louisiana</option>
						
							<option value="31">Maine</option>
						
							<option value="32">Maryland</option>
						
							<option value="33">Michigan</option>
						
							<option value="34">Minnesota</option>
						
							<option value="35">Mississippi</option>
						
							<option value="36">Missouri</option>
						
							<option value="37">Montana</option>
						
							<option value="38">Nebraska</option>
						
							<option value="39">Nevada</option>
						
							<option value="40">New Hampshire</option>
						
							<option value="41">New Jersey</option>
						
							<option value="42">New Mexico</option>
						
							<option value="43">New York</option>
						
							<option value="44">North Carolina</option>
						
							<option value="45">North Dakota</option>
						
							<option value="46">Ohio</option>
						
							<option value="47">Oklahoma</option>
						
							<option value="48">Oregon</option>
						
							<option value="49">Rhode Island</option>
						
							<option value="50">South Carolina</option>
						
							<option value="51">South Dakota</option>
						
							<option value="52">Tennessee</option>
						
							<option value="53">Texas</option>
						
							<option value="54">Utah</option>
						
							<option value="55">Vermont</option>
						
							<option value="56">Washington</option>
						
							<option value="57">West Virginia</option>
						
							<option value="58">Wisconsin</option>
						
							<option value="59">Wyoming</option>
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
						
							<option value="1">Canada</option>
						
							<option value="2">Usa</option>
						</select>
					&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="country-validation-billing">Please select your country</span>
				</td>
			</tr>
		</tbody></table>
		-->
		</div>
		<div id="checkout-shipping" style="width:60%;float:right;padding-top:20px;">
		<table>
				<tbody><tr>
					<th id="shipping-header" colspan="2" align="left">
						<div style="padding-bottom:30px;line-height:18px;">
						<img src="http://www.soofanphotography.com/images/ups.jpg" width="38" style="float:left;margin-right:15px;">
						The shipping cost is calculate by using the UPS API. UPS shipping will allow customers to get up-to-the-minute access to UPS shipping services while checking out orders, based on the cart and location.
						</div>
						<div class="clear"></div>
					</th>
				</tr>
				<tr>
					<th id="shipping-header" colspan="2" align="left">
						<span style="font-size:14px;font-weight:bold;padding-bottom:20px;">Choose Shipping Method</span>
						<div align="center" class="validation-falied" style="margin-left:20px;float:left;padding:3px 4px 3px 4px;width:240px;color:white;display:none;background-color:red;font-size:12px;font-weight:bold;" id="shipping-validation">Please select your shipping method</div>
						<div style="clear:both;height:10px;"></div>	
					</th>
				</tr>
				
				
					<tr>
						<td style="padding-top:4px;width:20px;">
							<input name="shipping_method_id" type="radio" value="1" id="shipping_method_id_1" class="shipping-method-radio"> 
						</td>
						<td>
							<strong>UPS Standard</strong>
						</td>
					</tr>
					<tr>
						<td></td>
						
							<td style="padding-bottom:10px;line-height:18px;">
						Rely on guaranteed economical ground delivery for your less-urgent shipments.</td>
					</tr>
				
					<tr>
						<td style="padding-top:4px;width:20px;">
							<input name="shipping_method_id" type="radio" value="2" id="shipping_method_id_2" class="shipping-method-radio"> 
						</td>
						<td>
							<strong>UPS Express</strong>
						</td>
					</tr>
					<tr>
						<td></td>
						
							<td style="line-height:18px;">
						Take advantage of this faster one-to-three day shipping service with guaranteed morning delivery times throughout the world</td>
					</tr>
				
				
			</tbody></table>
		</div>
	</div>
	<div style="clear:both;"></div>
	<div  style="border-top:1px solid ##000;text-align:right;margin-top:20px;">
	<input type="button" value="Next Step" class="btn-signup" style="margin-top:10px;font-size:12px;">
	</div>

</cfoutput>