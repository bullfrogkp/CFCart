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
		
		<cfif StructKeyExists(FORM,"submit_order")>
		
			<cfif IsNumeric(FORM.id)>
				<cfset LOCAL.order = EntityLoadByPK("order", FORM.id) /> 
			<cfelse>
				<cfset LOCAL.order = EntityNew("order") /> 
			</cfif>
			
			<cfset LOCAL.order.setTrackingNumber(Trim(FORM.tracking_number)) />
			<cfset LOCAL.order.setPhone(Trim(FORM.phone)) />
			<cfset LOCAL.order.setTotal(Trim(FORM.total)) />
			
			<cfset LOCAL.order.setShippingFirstName(Trim(FORM.shipping_first_name)) />
			<cfset LOCAL.order.setShippingMiddleName(Trim(FORM.shipping_middle_name)) />
			<cfset LOCAL.order.setShippingLastName(Trim(FORM.shipping_last_name)) />
			<cfset LOCAL.order.setShippingStreet(Trim(FORM.shipping_street)) />
			<cfset LOCAL.order.setShippingCity(Trim(FORM.shipping_city)) />
			<cfset LOCAL.order.setShippingPostalCode(Trim(FORM.shipping_postal_code)) />
			<cfset LOCAL.order.setShippingProvince(EntityLoadByPK("province",FORM.shipping_province_id)) />
			<cfset LOCAL.order.setShippingCountry(EntityLoadByPK("country",FORM.shipping_country_id)) />
		
			<cfset LOCAL.order.setBillingFirstName(Trim(FORM.billing_first_name)) />
			<cfset LOCAL.order.setBillingMiddleName(Trim(FORM.billing_middle_name)) />
			<cfset LOCAL.order.setBillingLastName(Trim(FORM.billing_last_name)) />
			<cfset LOCAL.order.setBillingStreet(Trim(FORM.billing_street)) />
			<cfset LOCAL.order.setBillingCity(Trim(FORM.billing_city)) />
			<cfset LOCAL.order.setBillingPostalCode(Trim(FORM.billing_postal_code)) />
			<cfset LOCAL.order.setBillingProvince(EntityLoadByPK("province",FORM.billing_province_id)) />
			<cfset LOCAL.order.setBillingCountry(EntityLoadByPK("country",FORM.billing_country_id)) />
			
			<cfset LOCAL.order.setPaymentMethod(EntityLoadByPK("payment_method",FORM.payment_method_id)) />
			<cfset LOCAL.order.setCoupon(EntityLoadByPK("coupon",FORM.coupon_id)) />
			
			<cfset LOCAL.currentStatus = EntityLoad("order_status",{orderId = FORM.id, endDatetime = JavaCast("NULL","")}) />
			
			<cfset LOCAL.currentStatus.setEndDatetime(Now()) />
			<cfset EntitySave(LOCAL.currentStatus) />
			
			<cfset LOCAL.newStatus = EntityNew("order_status") />
			<cfset LOCAL.newStatus.setStatusType(EntityLoad("order_status_type", FORM.order_status_type_id)) />
			<cfset LOCAL.newStatus.setStartDatetime(LOCAL.currentStatus.getEndDatetime()) />
			<cfset LOCAL.order.addStatus(LOCAL.newStatus) />
			
			<cfset EntitySave(LOCAL.order) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Order has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/order_detail.cfm?id=#LOCAL.order.getOrderId()#" />
		<cfelseif StructKeyExists(FORM,"add_new_product")>
			<cfif IsNumeric(FORM.id)>
				<cfset LOCAL.order = EntityLoadByPK("order", FORM.id) /> 
			<cfelse>
				<cfset LOCAL.order = EntityNew("order") /> 
			</cfif>
			
			<cfset EntitySave(LOCAL.coupon) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Coupon #LOCAL.coupon.getCode()# has been deleted.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/coupons.cfm" />
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
		<cfelse>
			<cfset LOCAL.pageData.formData.first_name = "" />
		</cfif>
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>