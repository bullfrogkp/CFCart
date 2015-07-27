<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"update_cutomer_info")>			
			<cfif Trim(FORM.shipto_first_name) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your first name.") />
			</cfif>
			<cfif Trim(FORM.shipto_last_name) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your last name.") />
			</cfif>
			<cfif Trim(FORM.shipto_street) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the shipping street.") />
			</cfif>
			<cfif Trim(FORM.shipto_city) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the shipping city.") />
			</cfif>
			<cfif NOT IsNumeric(FORM.shipto_province_id)>
				<cfset ArrayAppend(LOCAL.messageArray,"Please choose your shipping province.") />
			</cfif>
			<cfif Trim(FORM.shipto_postal_code) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the shipping postal code.") />
			</cfif>
			<cfif NOT IsNumeric(FORM.shipto_country_id)>
				<cfset ArrayAppend(LOCAL.messageArray,"Please choose your shipping country.") />
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Customer Information | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.pageData.message.messageArray = SESSION.temp.message.messageArray />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<!--- set flags --->
		<cfset SESSION.cart.setIsExistingCustomer(true) />
		<cfset SESSION.cart.setSameAddress(true) />
		<cfset SESSION.cart.setRegisterCustomer(false) />

		<cfset LOCAL.customerStruct = SESSION.cart.getCustomerStruct() />
		<cfset LOCAL.customerEntity = EntityLoadByPK("customer",LOCAL.customerStruct.customerId) />
		<cfset LOCAL.customerStruct.email = LOCAL.customerEntity.getEmail() />
		
		<cfif StructKeyExists(FORM,"shipto_this_address")>		
			<cfset LOCAL.address = EntityLoadByPK("address",FORM.existing_address_id) />
			<cfset LOCAL.shippingAddress = {} />
			<cfset LOCAL.shippingAddress.useExistingAddress = true />
			<cfset LOCAL.shippingAddress.addressId = LOCAL.address.getAddressId() />
			<cfset LOCAL.shippingAddress.company = LOCAL.address.getCompany() />
			<cfset LOCAL.shippingAddress.firstName = LOCAL.address..getFirstName() />
			<cfset LOCAL.shippingAddress.middleName = LOCAL.address.getMiddleName() />
			<cfset LOCAL.shippingAddress.lastName = LOCAL.address.getLastName() />
			<cfset LOCAL.shippingAddress.phone = LOCAL.address.getPhone() />
			<cfset LOCAL.shippingAddress.unit = LOCAL.address.getUnit() />
			<cfset LOCAL.shippingAddress.street = LOCAL.address.getStreet() />
			<cfset LOCAL.shippingAddress.city = LOCAL.address.getCity() />
			<cfset LOCAL.shippingAddress.postalCode = LOCAL.address.getPostalCode() />
			<cfset LOCAL.shippingAddress.provinceId = LOCAL.address.getProvince().getProvinceId() />
			<cfset LOCAL.shippingAddress.provinceCode = LOCAL.address.getProvince().getCode() />
			<cfset LOCAL.shippingAddress.countryId = LOCAL.address.getCountry().getCountryId() />
			<cfset LOCAL.shippingAddress.countryCode = LOCAL.address.getCountry().getCode() />
			
			<cfset LOCAL.customerStruct.firstName = LOCAL.address.getFirstName() />
			<cfset LOCAL.customerStruct.middleName = LOCAL.address.getMiddleName() />
			<cfset LOCAL.customerStruct.lastName = LOCAL.address.getLastName() />
			<cfset LOCAL.customerStruct.company = LOCAL.address.getCompany() />
			<cfset LOCAL.customerStruct.phone = LOCAL.address.getPhone() />
		<cfelseif StructKeyExists(FORM,"shipping_to_new_address")>
			<cfset LOCAL.shippingAddress = {} />
			<cfset LOCAL.shippingAddress.useExistingAddress = false />
			<cfset LOCAL.shippingAddress.addressId = "" />
			<cfset LOCAL.shippingAddress.company = Trim(FORM.shipto_company) />
			<cfset LOCAL.shippingAddress.firstName = Trim(FORM.shipto_first_name) />
			<cfset LOCAL.shippingAddress.middleName = Trim(FORM.shipto_middle_name) />
			<cfset LOCAL.shippingAddress.lastName = Trim(FORM.shipto_last_name) />
			<cfset LOCAL.shippingAddress.phone = Trim(FORM.shipto_phone) />
			<cfset LOCAL.shippingAddress.unit = Trim(FORM.shipto_unit) />
			<cfset LOCAL.shippingAddress.street = Trim(FORM.shipto_street) />
			<cfset LOCAL.shippingAddress.city = Trim(FORM.shipto_city) />
			<cfset LOCAL.shippingAddress.postalCode = Trim(FORM.shipto_postal_code) />
			
			<cfset LOCAL.province = EntityLoadByPK("province",FORM.shipto_province_id) />
			<cfset LOCAL.shippingAddress.provinceId = FORM.shipto_province_id />
			<cfset LOCAL.shippingAddress.provinceCode = LOCAL.province.getCode() />
			
			<cfset LOCAL.country = EntityLoadByPK("country",FORM.shipto_country_id) />
			<cfset LOCAL.shippingAddress.countryId = FORM.shipto_country_id />
			<cfset LOCAL.shippingAddress.countryCode = LOCAL.country.getCode() />
			
			<cfset LOCAL.customerStruct.firstName = Trim(FORM.shipto_first_name) />
			<cfset LOCAL.customerStruct.middleName = Trim(FORM.shipto_middle_name) />
			<cfset LOCAL.customerStruct.lastName = Trim(FORM.shipto_last_name) />
			<cfset LOCAL.customerStruct.company = Trim(FORM.shipto_company) />
			<cfset LOCAL.customerStruct.phone = Trim(FORM.shipto_phone) />
		</cfif>
		
		<cfset LOCAL.billingAddress = Duplicate(LOCAL.shippingAddress) />
		
		<cfset SESSION.cart.setCustomerStruct(LOCAL.customerStruct) />
		<cfset SESSION.cart.setShippingAddressStruct(LOCAL.shippingAddress) />
		<cfset SESSION.cart.setBillingAddressStruct(LOCAL.billingAddress) />
		<cfset SESSION.cart.calculate() />		
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_step2.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>