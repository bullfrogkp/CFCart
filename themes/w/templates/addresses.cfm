<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Addresses</span> 
</div>
				
	
			
			
			<cfinclude template="myaccount_sidenav.cfm" />
			<div id="myaccount-content">
				<h1>My Addresses</h1>
				<div style="margin-top:20px;" class="single_field">
					<div style="width:49%;float:left;">
						<table id="current-address-table" class="shipping-address-selected" style="width:100%;margin-top:20px;">	
							<tr>
								<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Shipping Information
								</th>
							</tr>
							<tbody>
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
								<td></td>
								<td style="padding-top:10px;"><button>Update</button></td>
							</tr>
						</tbody>
					</table>
				
					</div>
					<div style="width:49%;float:right;">
						<table id="current-address-table" class="shipping-address-selected" style="width:100%;margin-top:20px;">	
							<tr>
								<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Billing Information</th>
							</tr>
							<tbody>
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
								<td></td>
								<td style="padding-top:10px;"><button>Update</button></td>
							</tr>
						</tbody>
					</table>
					</div>
					<div style="clear:both;"></div>
				</div>
			</div>
		
</cfoutput>