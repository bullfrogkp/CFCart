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
		
		<cfset SESSION.order.sameAddress = true />
		<cfset SESSION.order.isExistingCustomer = true />
		<cfset SESSION.order.customer = {} />
		<cfset SESSION.order.customer.customerId = SESSION.user.customerId />
			
		<cfif StructKeyExists(FORM,"pickup_order")>	
			<cfset SESSION.order.pickupOrder = true />
			
			<cfset SESSION.order.customer.email = Trim(FORM.pickup_email) />
			<cfset SESSION.order.customer.phone = Trim(FORM.pickup_phone) />
			<cfset SESSION.order.customer.firstName = "" />
			<cfset SESSION.order.customer.middleName = "" />
			<cfset SESSION.order.customer.lastName = "" />
			<cfset SESSION.order.customer.company = "" />
			
			<cfset SESSION.order.totalShippingFee = 0 />
			<cfset SESSION.order.totalTax = 0 />
			<cfset LOCAL.provinceId = EntityLoad("site_info",{},true).getProvince().getProvinceId() />
			<cfloop array="#SESSION.order.productArray#" index="LOCAL.item">
				<cfset LOCAL.product = EntityLoadByPK("product",LOCAL.item.productId) />
				<cfset LOCAL.shippingMethod = EntityLoad("shipping_method",{name="pickup"},true) />
				<cfset LOCAL.productShippingMethodRela = EntityLoad("product_shipping_method_rela",{product=LOCAL.product,shippingMethod=LOCAL.shippingMethod},true) />
				<cfset LOCAL.item.productShippingMethodRelaId = "" />
				<cfset LOCAL.item.totalShippingFee = 0 />
				<cfset LOCAL.item.singleTax = LOCAL.item.singlePrice * LOCAL.product.getTaxRate(provinceId = LOCAL.provinceId) />
				<cfset LOCAL.item.totalTax = LOCAL.item.singleTax * LOCAL.item.count />
				<cfset SESSION.order.totalTax += LOCAL.item.totalTax />
			</cfloop>
			
			<cfset SESSION.order.totalPrice = SESSION.order.subTotalPrice + SESSION.order.totalTax />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_confirmation.cfm" />
		<cfelse>
			<cfset LOCAL.customer = EntityLoadByPK("customer", SESSION.user.customerId) />
		
			<cfset SESSION.order.customer.email = LOCAL.customer.getEmail() />
			<cfset SESSION.order.customer.phone = LOCAL.customer.getPhone() />
			<cfset SESSION.order.customer.firstName = LOCAL.customer.getFirstName() />
			<cfset SESSION.order.customer.middleName = LOCAL.customer.getMiddleName() />
			<cfset SESSION.order.customer.lastName = LOCAL.customer.getLastName() />
			<cfset SESSION.order.customer.company = LOCAL.customer.getCompany() />
			
			<cfif StructKeyExists(FORM,"shipto_this_address")>			
				<cfset LOCAL.useExistingAddress = true />
				<cfset LOCAL.pickupOrder = false />
				<cfset LOCAL.address = EntityLoadByPK("address",FORM.existing_address_id) />
			<cfelseif StructKeyExists(FORM,"shipping_to_new_address")>
				<cfset LOCAL.useExistingAddress = false />
				<cfset LOCAL.pickupOrder = false />
				<cfset LOCAL.address = EntityNew("address") />
				<cfset LOCAL.address.setCompany(Trim(FORM.shipto_company)) />
				<cfset LOCAL.address.setFirstName(Trim(FORM.shipto_first_name)) />
				<cfset LOCAL.address.setMiddleName(Trim(FORM.shipto_middle_name)) />
				<cfset LOCAL.address.setLastName(Trim(FORM.shipto_last_name)) />
				<cfset LOCAL.address.setPhone(Trim(FORM.shipto_phone)) />
				<cfset LOCAL.address.setUnit(Trim(FORM.shipto_unit)) />
				<cfset LOCAL.address.setStreet(Trim(FORM.shipto_street)) />
				<cfset LOCAL.address.setCity(Trim(FORM.shipto_city)) />
				<cfset LOCAL.address.setPostalCode(Trim(FORM.shipto_postal_code)) />
				<cfset LOCAL.address.setProvince(EntityLoadByPK("province",FORM.shipto_province_id)) />
				<cfset LOCAL.address.setCountry(EntityLoadByPK("province",FORM.shipto_country_id)) />
				<cfset LOCAL.address.setCustomer(EntityLoadByPK("customer",SESSION.user.customerId)) />
				<cfset EntitySave(LOCAL.address) />
			</cfif>
				
			<cfset SESSION.order.shippingAddress = {} />
			<cfset SESSION.order.shippingAddress.useExistingAddress = LOCAL.useExistingAddress />
			<cfset SESSION.order.shippingAddress.addressId = LOCAL.address.getAddressId() />
			<cfset SESSION.order.shippingAddress.company = LOCAL.address.getCompany() />
			<cfset SESSION.order.shippingAddress.firstName = LOCAL.address..getFirstName() />
			<cfset SESSION.order.shippingAddress.middleName = LOCAL.address.getMiddleName() />
			<cfset SESSION.order.shippingAddress.lastName = LOCAL.address.getLastName() />
			<cfset SESSION.order.shippingAddress.phone = LOCAL.address.getPhone() />
			<cfset SESSION.order.shippingAddress.unit = LOCAL.address.getUnit() />
			<cfset SESSION.order.shippingAddress.street = LOCAL.address.getStreet() />
			<cfset SESSION.order.shippingAddress.city = LOCAL.address.getCity() />
			<cfset SESSION.order.shippingAddress.postalCode = LOCAL.address.getPostalCode() />
			<cfset SESSION.order.shippingAddress.provinceId = LOCAL.address.getProvince().getProvinceId() />
			<cfset SESSION.order.shippingAddress.countryId = LOCAL.address.getCountry().getCountryId() />
			
			<cfset SESSION.order.billingAddress = Duplicate(SESSION.order.shippingAddress) />
			
			<cfset SESSION.order.totalTax = 0 />
			<cfloop array="#SESSION.order.productArray#" index="LOCAL.item">
				<cfset LOCAL.product = EntityLoadByPK("product",LOCAL.item.productId) />
				<cfset LOCAL.item.singleTax = LOCAL.item.singlePrice * LOCAL.product.getTaxRate(provinceId = SESSION.order.shippingAddress.provinceId) />
				<cfset LOCAL.item.totalTax = LOCAL.item.singleTax * LOCAL.item.count />
				<cfset SESSION.order.totalTax += LOCAL.item.totalTax />
			</cfloop>
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/step2.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>