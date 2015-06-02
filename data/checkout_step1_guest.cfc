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
		
		<cfset SESSION.order.isExistingCustomer = false />
		<cfset SESSION.order.sameAddress = true />
		<cfset SESSION.order.customer = {} />
		<cfset SESSION.order.customer.customerId = "" />
		
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
				<cfset LOCAL.item.productShippingMethodRelaId = LOCAL.productShippingMethodRela.getProductShippingMethodRelaId() />
				<cfset LOCAL.item.totalShippingFee = 0 />
				<cfset LOCAL.item.singleTax = LOCAL.item.singlePrice * LOCAL.product.getTaxRate(provinceId = LOCAL.provinceId) />
				<cfset LOCAL.item.totalTax = LOCAL.item.singleTax * LOCAL.item.count />
				<cfset SESSION.order.totalTax += LOCAL.item.totalTax />
			</cfloop>
			
			<cfset SESSION.order.totalPrice = SESSION.order.subTotalPrice + SESSION.order.totalTax />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_confirmation.cfm" />
		<cfelseif StructKeyExists(FORM,"shipping_to_new_address")>
			<cfset SESSION.order.pickupOrder = false />
			
			<cfset SESSION.order.customer.email = Trim(FORM.new_email) />
			<cfset SESSION.order.customer.phone = Trim(FORM.shipto_phone) />
			<cfset SESSION.order.customer.firstName = Trim(FORM.shipto_first_name) />
			<cfset SESSION.order.customer.middleName = Trim(FORM.shipto_middle_name) />
			<cfset SESSION.order.customer.lastName = Trim(FORM.shipto_last_name) />
			<cfset SESSION.order.customer.company = Trim(FORM.shipto_company) />
				
			<cfset SESSION.order.shippingAddress = {} />
			<cfset SESSION.order.shippingAddress.useExistingAddress = false />
			<cfset SESSION.order.shippingAddress.addressId = "" />
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
			
			<cfset SESSION.order.billingAddress = Duplicate(SESSION.order.shippingAddress) />
			
			<cfset SESSION.order.totalTax = 0 />
			
			<cfloop array="#SESSION.order.productArray#" index="LOCAL.item">
				<cfset LOCAL.product = EntityLoadByPK("product",LOCAL.item.productId) />
				<cfset LOCAL.item.singleTax = LOCAL.item.singlePrice * LOCAL.product.getTaxRate(provinceId = SESSION.order.shippingAddress.provinceId) />
				<cfset LOCAL.item.totalTax = LOCAL.item.singleTax * LOCAL.item.count />
				<cfset SESSION.order.totalTax += LOCAL.item.totalTax />
			</cfloop>
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_step2.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>