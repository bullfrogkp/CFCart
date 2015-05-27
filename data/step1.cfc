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
			<cfset SESSION.order.customer.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
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
			<cfset SESSION.order.shippingAddress.useExistingAddress = true />
			<cfset SESSION.order.shippingAddress.address = EntityLoadByPK("address",FORM.existing_address_id) />
			<cfset SESSION.order.billingAddress.useExistingAddress = true />
			<cfset SESSION.order.billingAddress.address = EntityLoadByPK("address",FORM.existing_address_id) />
		<cfelse>
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
			<cfset SESSION.order.shippingAddress.province = EntityLoadByPK("province",FORM.shipto_province_id) />
			<cfset SESSION.order.shippingAddress.country = EntityLoadByPK("country",FORM.shipto_country_id) />
			
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
			<cfset SESSION.order.billingAddress.province = EntityLoadByPK("province",FORM.shipto_province_id) />
			<cfset SESSION.order.billingAddress.country = EntityLoadByPK("country",FORM.shipto_country_id) />
		</cfif>		
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/step2.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>