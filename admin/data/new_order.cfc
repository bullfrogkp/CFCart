<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"submit_order") AND Trim(FORM.first_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid first name.") />
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = _setRedirectURL() />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif StructKeyExists(FORM,"submit_order") OR StructKeyExists(FORM,"add_new_product")>
		
			<cfif IsNumeric(FORM.id)>
				<cfset LOCAL.order = EntityLoadByPK("order", FORM.id) /> 
			<cfelse>
				<cfset LOCAL.order = EntityNew("order") /> 
			</cfif>
			
			<cfset LOCAL.order.setTrackingNumber(Trim(FORM.tracking_number)) />
			<cfset LOCAL.order.setPhone(Trim(FORM.phone)) />
			<cfset LOCAL.order.setTotal(Trim(FORM.total)) />
			<cfset LOCAL.order.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.order.setSubtotalAmount(FORM.subtotal_amount) />
			<cfset LOCAL.order.setShippingAmount(FORM.shipping_amount) />
			<cfset LOCAL.order.setTaxAmount(FORM.tax_amount) />
			<cfset LOCAL.order.setTotalAmount(FORM.total_amount) />
			
			<cfset LOCAL.order.setShippingFirstName(Trim(FORM.shipping_first_name)) />
			<cfset LOCAL.order.setShippingMiddleName(Trim(FORM.shipping_middle_name)) />
			<cfset LOCAL.order.setShippingLastName(Trim(FORM.shipping_last_name)) />
			<cfset LOCAL.order.setShippingStreet(Trim(FORM.shipping_street)) />
			<cfset LOCAL.order.setShippingCity(Trim(FORM.shipping_city)) />
			<cfset LOCAL.order.setShippingPostalCode(Trim(FORM.shipping_postal_code)) />
			
			<cfif FORM.shipping_province_id NEQ "">
				<cfset LOCAL.order.setShippingProvince(EntityLoadByPK("province",FORM.shipping_province_id)) />
			</cfif>
			<cfif FORM.shipping_country_id NEQ "">
				<cfset LOCAL.order.setShippingCountry(EntityLoadByPK("country",FORM.shipping_country_id)) />
			</cfif>
		
			<cfset LOCAL.order.setBillingFirstName(Trim(FORM.billing_first_name)) />
			<cfset LOCAL.order.setBillingMiddleName(Trim(FORM.billing_middle_name)) />
			<cfset LOCAL.order.setBillingLastName(Trim(FORM.billing_last_name)) />
			<cfset LOCAL.order.setBillingStreet(Trim(FORM.billing_street)) />
			<cfset LOCAL.order.setBillingCity(Trim(FORM.billing_city)) />
			<cfset LOCAL.order.setBillingPostalCode(Trim(FORM.billing_postal_code)) />
			
			<cfif FORM.billing_province_id NEQ "">
				<cfset LOCAL.order.setBillingProvince(EntityLoadByPK("province",FORM.billing_province_id)) />
			</cfif>
			<cfif FORM.billing_country_id NEQ "">
				<cfset LOCAL.order.setBillingCountry(EntityLoadByPK("country",FORM.billing_country_id)) />
			</cfif>
			
			<cfif FORM.payment_method_id NEQ "">
				<cfset LOCAL.order.setPaymentMethod(EntityLoadByPK("payment_method",FORM.payment_method_id)) />
			</cfif>
			<cfset LOCAL.order.setCoupon(EntityLoad("coupon",{coupon = FORM.coupon})) />
						
			<cfset LOCAL.newStatus = EntityLoad("order_status",{name = "placed"}) />
			<cfset LOCAL.newStatus.setStartDatetime(LOCAL.currentStatus.getEndDatetime()) />
			<cfset LOCAL.order.addStatus(LOCAL.newStatus) />
			
			<cfif StructKeyExists(FORM,"add_new_product")>
				<cfset LOCAL.newProduct = EntityLoadByPK("product",FORM.new_product_id) />
				<cfset LOCAL.newProduct.setShippingMethod(EntityLoadByPK("shipping_method",FORM.new_product_shipping_method_id)) />
				<cfset EntitySave(LOCAL.newProduct) /> 
				
				<cfset LOCAL.order.addProduct(LOCAL.newProduct) />
				
				<cfset EntitySave(LOCAL.order) /> 
				
				<cfset ArrayAppend(SESSION.temp.message.messageArray,"New product has been added.") />
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.customer.getCustomerId()#" />
			<cfelse>
				<cfset EntitySave(LOCAL.order) />
				<cfset ArrayAppend(SESSION.temp.message.messageArray,"Order has been saved successfully.") />
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/order_detail.cfm?id=#LOCAL.order.getOrderId()#" />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.title = "New Order | #APPLICATION.applicationName#" />
		
		<cfif StructKeyExists(URL,"id")>
			<cfset LOCAL.pageData.order = EntityLoadByPK("order",URL.id) />
			
			<cfset LOCAL.pageData.formData.first_name = isNull(LOCAL.pageData.order.getFirstName())?"":LOCAL.pageData.order.getFirstName() />
			<cfset LOCAL.pageData.formData.middle_name = isNull(LOCAL.pageData.order.getMiddleName())?"":LOCAL.pageData.order.getMiddleName() />
			<cfset LOCAL.pageData.formData.last_name = isNull(LOCAL.pageData.order.getLastName())?"":LOCAL.pageData.order.getLastName() />
			<cfset LOCAL.pageData.formData.phone = isNull(LOCAL.pageData.order.getPhone())?"":LOCAL.pageData.order.getPhone() />
			<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.order.getDescription())?"":LOCAL.pageData.order.getDescription() />
			
			<cfset LOCAL.pageData.formData.shipping_company = isNull(LOCAL.pageData.order.getShippingCompany())?"":LOCAL.pageData.order.getShippingCompany() />
			<cfset LOCAL.pageData.formData.shipping_street = isNull(LOCAL.pageData.order.getShippingStreet())?"":LOCAL.pageData.order.getShippingStreet() />
			<cfset LOCAL.pageData.formData.shipping_city = isNull(LOCAL.pageData.order.getShippingCity())?"":LOCAL.pageData.order.getShippingCity() />
			<cfset LOCAL.pageData.formData.shipping_province = isNull(LOCAL.pageData.order.getShippingProvince())?"":LOCAL.pageData.order.getShippingProvince().getDisplayName() />
			<cfset LOCAL.pageData.formData.shipping_postal_code = isNull(LOCAL.pageData.order.getShippingPostalCode())?"":LOCAL.pageData.order.getShippingPostalCode() />
			<cfset LOCAL.pageData.formData.shipping_country = isNull(LOCAL.pageData.order.getShippingCountry())?"":LOCAL.pageData.order.getShippingCountry().getDisplayName() />
			
			<cfset LOCAL.pageData.formData.billing_company = isNull(LOCAL.pageData.order.getBillingCompany())?"":LOCAL.pageData.order.getBillingCompany() />
			<cfset LOCAL.pageData.formData.billing_street = isNull(LOCAL.pageData.order.getBillingStreet())?"":LOCAL.pageData.order.getBillingStreet() />
			<cfset LOCAL.pageData.formData.billing_city = isNull(LOCAL.pageData.order.getBillingCity())?"":LOCAL.pageData.order.getBillingCity() />
			<cfset LOCAL.pageData.formData.billing_province_id = isNull(LOCAL.pageData.order.getBillingProvince())?"":LOCAL.pageData.order.getBillingProvince().getProvinceId() />
			<cfset LOCAL.pageData.formData.billing_postal_code = isNull(LOCAL.pageData.order.getBillingPostalCode())?"":LOCAL.pageData.order.getBillingPostalCode() />
			<cfset LOCAL.pageData.formData.billing_country_id = isNull(LOCAL.pageData.order.getBillingCountry())?"":LOCAL.pageData.order.getBillingCountry().getCountryId() />
		<cfelse>
			<cfset LOCAL.pageData.formData.first_name = "" />
		</cfif>
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>