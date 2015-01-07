<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Profile</span> 
</div>
			<cfinclude template="myaccount_sidenav.cfm" />
			<div id="myaccount-content">
				<h1>My Profile</h1>
				<div style="margin-top:20px;" class="single_field">
					<div>
						<table id="current-address-table" class="shipping-address-selected" style="width:100%;margin-top:20px;">	
							<tr>
								<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Account Information
								</th>
							</tr>
							<tbody>
							<tr>
								<td style="font-weight:bold;">First Name: </td>
								<td>
									<input name="shipto_street" id="shipto_street" type="text" maxlength="100" size="25" style="width:180px;">
									
									&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="street-validation-shipping">Please enter your street</span>
								</td>
							</tr>
							  
							<tr>
								<td style="font-weight:bold;">Last Name: </td>
								<td>
									<input name="shipto_city" id="shipto_city" type="text" maxlength="40" size="25" style="width:180px;">
									
									&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="city-validation-shipping">Please enter your city</span>
								</td>
							</tr>
							
							<tr>
								<td style="font-weight:bold;">Email: </td>
								<td>
									<input name="shipto_city" id="shipto_city" type="text" maxlength="40" size="25" style="width:180px;">
									
									&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="city-validation-shipping">Please enter your city</span>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="padding-top:10px;">
								<table style="margin-left:-3px;">
									<tbody><tr>
										<td>
											<input type="checkbox" name="billing_info_different" id="billing_info_different" value="1" onclick="if(this.checked) $('##new-billing-address').slideDown(500); else $('##new-billing-address').slideUp(500);">
										</td>
										<td>&nbsp;Check here if you want to subscribe our new product information</td>
									</tr>
								</tbody></table>
								</td>
							</tr>
							<tr>
								<td></td>
								<td style="padding-top:10px;"><button>Update</button></td>
							</tr>
							
							<tr>
								<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Change Password
								</th>
							</tr>
							
							<tr>
								<td style="font-weight:bold;">Current Password: </td>
								<td>
									<input name="shipto_street" id="shipto_street" type="text" maxlength="100" size="25" style="width:180px;">
									
									&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="street-validation-shipping">Please enter your street</span>
								</td>
							</tr>
							  
							<tr>
								<td style="font-weight:bold;">New Password: </td>
								<td>
									<input name="shipto_city" id="shipto_city" type="text" maxlength="40" size="25" style="width:180px;">
									
									&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="city-validation-shipping">Please enter your city</span>
								</td>
							</tr>
							
							<tr>
								<td style="font-weight:bold;">Confirm New Password: </td>
								<td>
									<input name="shipto_city" id="shipto_city" type="text" maxlength="40" size="25" style="width:180px;">
									
									&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="city-validation-shipping">Please enter your city</span>
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