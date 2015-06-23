<cfcomponent extends="master">	
	<!---
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"update_cutomer_info")>
			<cfif Trim(FORM.shipto_first_name) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping first name.") />
			</cfif>
			<cfif Trim(FORM.shipto_last_name) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping last name.") />
			</cfif>
			<cfif Trim(FORM.shipto_phone) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping phone number.") />
			</cfif>
			<cfif Trim(FORM.shipto_street) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping street name.") />
			</cfif>
			<cfif Trim(FORM.shipto_city) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping city name.") />
			</cfif>
			<cfif NOT IsNumeric(FORM.shipto_province_id)>
				<cfset ArrayAppend(LOCAL.messageArray,"Please choose your shipping province.") />
			</cfif>
			<cfif Trim(FORM.shipto_postal_code) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping postal code.") />
			</cfif>
			<cfif NOT IsNumeric(FORM.shipto_country_id)>
				<cfset ArrayAppend(LOCAL.messageArray,"Please choose your shipping country.") />
			</cfif>
			
			<cfif StructKeyExists(FORM,"billing_info_is_different")>
				<cfif Trim(FORM.billto_first_name) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing first name.") />
				</cfif>
				<cfif Trim(FORM.billto_last_name) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing last name.") />
				</cfif>
				<cfif Trim(FORM.billto_phone) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing phone number.") />
				</cfif>
				<cfif Trim(FORM.billto_street) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing street name.") />
				</cfif>
				<cfif Trim(FORM.billto_city) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing city name.") />
				</cfif>
				<cfif NOT IsNumeric(FORM.billto_province_id)>
					<cfset ArrayAppend(LOCAL.messageArray,"Please choose your billing province.") />
				</cfif>
				<cfif Trim(FORM.billto_postal_code) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing postal code.") />
				</cfif>
				<cfif NOT IsNumeric(FORM.billto_country_id)>
					<cfset ArrayAppend(LOCAL.messageArray,"Please choose your billing country.") />
				</cfif>
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	--->
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Change Address | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		
		<cfif IsNumeric(SESSION.user.customerId)>
			<cfset LOCAL.pageData.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
		</cfif>	
		
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.pageData.message.messageArray = SESSION.temp.message.messageArray />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfset SESSION.order.sameAddress = false />
		
		<cfif StructKeyExists(FORM,"shipto_this_address")>			
			<cfset LOCAL.address = EntityLoadByPK("address",FORM.existing_address_id) />
			
			<cfset SESSION.order.billingAddress = {} />
			<cfset SESSION.order.billingAddress.useExistingAddress = true />
			<cfset SESSION.order.billingAddress.addressId = LOCAL.address.getAddressId() />
			<cfset SESSION.order.billingAddress.company = LOCAL.address.getCompany() />
			<cfset SESSION.order.billingAddress.firstName = LOCAL.address..getFirstName() />
			<cfset SESSION.order.billingAddress.middleName = LOCAL.address.getMiddleName() />
			<cfset SESSION.order.billingAddress.lastName = LOCAL.address.getLastName() />
			<cfset SESSION.order.billingAddress.phone = LOCAL.address.getPhone() />
			<cfset SESSION.order.billingAddress.unit = LOCAL.address.getUnit() />
			<cfset SESSION.order.billingAddress.street = LOCAL.address.getStreet() />
			<cfset SESSION.order.billingAddress.city = LOCAL.address.getCity() />
			<cfset SESSION.order.billingAddress.postalCode = LOCAL.address.getPostalCode() />
			<cfset SESSION.order.billingAddress.provinceId = LOCAL.address.getProvince().getProvinceId() />
			<cfset SESSION.order.billingAddress.provinceCode = LOCAL.address.getProvince().getCode() />
			<cfset SESSION.order.billingAddress.countryId = LOCAL.address.getCountry().getCountryId() />
			<cfset SESSION.order.billingAddress.countryCode = LOCAL.address.getCountry().getCode() />
		<cfelseif StructKeyExists(FORM,"shipping_to_new_address")>
			<cfset SESSION.order.billingAddress = {} />
			<cfset SESSION.order.billingAddress.useExistingAddress = false />
			<cfset SESSION.order.billingAddress.addressId = "" />
			<cfset SESSION.order.billingAddress.company = Trim(FORM.shipto_company) />
			<cfset SESSION.order.billingAddress.firstName = Trim(FORM.shipto_first_name) />
			<cfset SESSION.order.billingAddress.middleName = Trim(FORM.shipto_middle_name) />
			<cfset SESSION.order.billingAddress.lastName = Trim(FORM.shipto_last_name) />
			<cfset SESSION.order.billingAddress.phone = Trim(FORM.shipto_phone) />
			<cfset SESSION.order.billingAddress.unit = Trim(FORM.shipto_unit) />
			<cfset SESSION.order.billingAddress.street = Trim(FORM.shipto_street) />
			<cfset SESSION.order.billingAddress.city = Trim(FORM.shipto_city) />
			<cfset SESSION.order.billingAddress.postalCode = Trim(FORM.shipto_postal_code) />
			
			<cfset LOCAL.province = EntityLoadByPK("province",FORM.shipto_province_id) />
			<cfset SESSION.order.billingAddress.provinceId = FORM.shipto_province_id />
			<cfset SESSION.order.billingAddress.provinceCode = LOCAL.province.getCode() />
			
			<cfset LOCAL.country = EntityLoadByPK("country",FORM.shipto_country_id) />
			<cfset SESSION.order.billingAddress.countryId = FORM.shipto_country_id />
			<cfset SESSION.order.billingAddress.countryCode = LOCAL.country.getCode() />
			
			<cfset SESSION.order.customer.company = Trim(FORM.shipto_company) />
		</cfif>
				
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_confirmation.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>