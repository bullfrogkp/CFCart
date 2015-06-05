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
	<div style="margin-top:25px;" class="single_field">
		<cfif ArrayLen(REQUEST.pageData.customer.getAddresses()) GT 0>
			<cfloop array="#REQUEST.pageData.customer.getAddresses()#" index="address">
				<div style="width:49%;float:left;">
					<table id="current-address-table" class="shipping-address-selected" style="width:100%;">	
						<tr>
							<td style="font-weight:bold;">Street: </td>
							<td>
								<input name="street" id="street" type="text" maxlength="100" size="25" style="width:180px;" value="#address.getStreet()#">
							</td>
						</tr>
						  
						<tr>
							<td style="font-weight:bold;">City: </td>
							<td>
								<input name="city" id="city" type="text" maxlength="40" size="25" style="width:180px;" value="#address.getCity()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Province: </td>
							<td>
								<select name="province_id" id="province_id" style="width:186px;">
									<option value="">Please select...</option>
									<cfloop array="#REQUEST.pageData.provinces#" index="province">
										<option value="#province.getProvinceId()#"
										<cfif address.getProvince().getProvinceId() EQ province.getProvinceId()>
										selected
										</cfif>
										>#province.getProvinceName()#</option>
									</cfloop>
								</select>
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Postal Code: </td>
							<td>
								<input name="postal_code" id="postal_code" type="text" maxlength="10" size="10" style="width:180px;" value="#address.getPostalCode()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Country: </td>
							<td>
								<select name="shipto_country_id" id="shipto_country_id" style="width:186px;">
									<option value="">Please select...</option>
									<cfloop array="#REQUEST.pageData.countries#" index="country">
										<option value="#country.getCountryId()#"
										<cfif address.getCountry().getCountryId() EQ country.getCountryId()>
										selected
										</cfif>
										>#country.getCountryname()#</option>
									</cfloop>
								</select>
							</td>
						</tr>
						<tr>
							<td></td>
							<td style="padding-top:10px;"><button>Update</button></td>
						</tr>
					</table>
				</div>
			</cfloop>
		<cfelse>
			No address found.
		</cfif>
	</div>
	<div style="clear:both;"></div>
</div>
		
</cfoutput>