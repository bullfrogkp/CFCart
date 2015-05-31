<cfcomponent extends="master">	
	<!---
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"update_cutomer_info")>
			<cfif NOT IsValid("email",Trim(FORM.new_email))>
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid email address.") />
			</cfif>
			
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
		
		<cfset SESSION.order.customer = {} />
			
		<cfif IsNumeric(SESSION.user.customerId)>
			<cfset SESSION.order.customer.isExistingCustomer = true />
			<cfset SESSION.order.customer.customerId = SESSION.user.customerId />
		<cfelse>
			<cfset SESSION.order.customer.isExistingCustomer = false />
			<cfset SESSION.order.customer.email = Trim(FORM.new_email) />
			<cfset SESSION.order.customer.firstName = Trim(FORM.shipto_first_name) />
			<cfset SESSION.order.customer.middleName = Trim(FORM.shipto_middle_name) />
			<cfset SESSION.order.customer.lastName = Trim(FORM.shipto_last_name) />
			<cfset SESSION.order.customer.phone = Trim(FORM.shipto_phone) />
		</cfif>
		
		<cfset SESSION.order.shippingAddress = {} />
		<cfset SESSION.order.billingAddress = {} />
		<cfset SESSION.order.sameAddress = true />
			
		<cfif StructKeyExists(FORM,"shipto_this_address")>			
			<cfset LOCAL.address = EntityLoadByPK("address",FORM.existing_address_id) />
			
			<cfset SESSION.order.shippingAddress.useExistingAddress = true />
			<cfset SESSION.order.shippingAddress.addressId = FORM.existing_address_id />
			<cfset SESSION.order.shippingAddress.company = SESSION.order.shippingAddress.address.getCompany() />
			<cfset SESSION.order.shippingAddress.firstName = SESSION.order.shippingAddress.address.getFirstName() />
			<cfset SESSION.order.shippingAddress.middleName = SESSION.order.shippingAddress.address.getMiddleName() />
			<cfset SESSION.order.shippingAddress.lastName = SESSION.order.shippingAddress.address.getLastName() />
			<cfset SESSION.order.shippingAddress.phone = SESSION.order.shippingAddress.address.getPhone() />
			<cfset SESSION.order.shippingAddress.unit = SESSION.order.shippingAddress.address.getUnit() />
			<cfset SESSION.order.shippingAddress.street = SESSION.order.shippingAddress.address.getStreet() />
			<cfset SESSION.order.shippingAddress.city = SESSION.order.shippingAddress.address.getCity() />
			<cfset SESSION.order.shippingAddress.postalCode = SESSION.order.shippingAddress.address.getPostalCode() />
			<cfset SESSION.order.shippingAddress.provinceId = LOCAL.address.getProvince().getProvinceId() />
			<cfset SESSION.order.shippingAddress.countryId = LOCAL.address.getCountry().getCountryId() />
			
			<cfset SESSION.order.billingAddress.useExistingAddress = true />
			<cfset SESSION.order.billingAddress.addressId = FORM.existing_address_id />
			<cfset SESSION.order.billingAddress.company = SESSION.order.billingAddress.address.getCompany() />
			<cfset SESSION.order.billingAddress.firstName = SESSION.order.billingAddress.address.getFirstName() />
			<cfset SESSION.order.billingAddress.middleName = SESSION.order.billingAddress.address.getMiddleName() />
			<cfset SESSION.order.billingAddress.lastName = SESSION.order.billingAddress.address.getLastName() />
			<cfset SESSION.order.billingAddress.phone = SESSION.order.billingAddress.address.getPhone() />
			<cfset SESSION.order.billingAddress.unit = SESSION.order.billingAddress.address.getUnit() />
			<cfset SESSION.order.billingAddress.street = SESSION.order.billingAddress.address.getStreet() />
			<cfset SESSION.order.billingAddress.city = SESSION.order.billingAddress.address.getCity() />
			<cfset SESSION.order.billingAddress.postalCode = SESSION.order.billingAddress.address.getPostalCode() />
			<cfset SESSION.order.billingAddress.provinceId = LOCAL.address.getProvince().getProvinceId() />
			<cfset SESSION.order.billingAddress.countryId = LOCAL.address.getCountry().getCountryId() />
		<cfelseif StructKeyExists(FORM,"shipping_to_new_address")>
			<cfset SESSION.order.shippingAddress.useExistingAddress = false />
			<cfset SESSION.order.shippingAddress.company = Trim(FORM.shipto_company) />
			<cfset SESSION.order.shippingAddress.firstName = Trim(FORM.shipto_first_name) />
			<cfset SESSION.order.shippingAddress.middleName = Trim(FORM.shipto_middle_name) />
			<cfset SESSION.order.shippingAddress.lastName = Trim(FORM.shipto_last_name) />
			<cfset SESSION.order.shippingAddress.phone = Trim(FORM.shipto_phone) />
			<cfset SESSION.order.shippingAddress.unit = Trim(FORM.shipto_unit) />
			<cfset SESSION.order.shippingAddress.street = Trim(FORM.shipto_street) />
			<cfset SESSION.order.shippingAddress.city = Trim(FORM.shipto_city) />
			<cfset SESSION.order.shippingAddress.postalCode = Trim(FORM.shipto_postal_code) />
			<cfset SESSION.order.shippingAddress.provinceId = FORM.shipto_province_id />
			<cfset SESSION.order.shippingAddress.countryId = FORM.shipto_country_id />
			
			<cfset SESSION.order.billingAddress.useExistingAddress = false />
			<cfset SESSION.order.billingAddress.company = Trim(FORM.shipto_company) />
			<cfset SESSION.order.billingAddress.firstName = Trim(FORM.shipto_first_name) />
			<cfset SESSION.order.billingAddress.middleName = Trim(FORM.shipto_middle_name) />
			<cfset SESSION.order.billingAddress.lastName = Trim(FORM.shipto_last_name) />
			<cfset SESSION.order.billingAddress.phone = Trim(FORM.shipto_phone) />
			<cfset SESSION.order.billingAddress.unit = Trim(FORM.shipto_unit) />
			<cfset SESSION.order.billingAddress.street = Trim(FORM.shipto_street) />
			<cfset SESSION.order.billingAddress.city = Trim(FORM.shipto_city) />
			<cfset SESSION.order.billingAddress.postalCode = Trim(FORM.shipto_postal_code) />
			<cfset SESSION.order.billingAddress.provinceId = FORM.shipto_province_id />
			<cfset SESSION.order.billingAddress.countryId = FORM.shipto_country_id />
		</cfif>	

		<cfset SESSION.order.totalTax = 0 />
		
		<cfloop array="#SESSION.order.productArray#" index="LOCAL.item">
			<cfset LOCAL.product = EntityLoadByPK("product",LOCAL.item.productId) />
			<cfset LOCAL.item.singleTax = LOCAL.item.singlePrice * LOCAL.product.getTaxRate(provinceId = SESSION.order.shippingAddress.provinceId) />
			<cfset LOCAL.item.totalTax = LOCAL.item.singleTax * LOCAL.item.count />
			<cfset SESSION.order.totalTax += LOCAL.item.totalTax />
		</cfloop>
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/step2.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>