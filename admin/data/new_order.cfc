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
				<cfset LOCAL.pageData.order = EntityLoadByPK("order", FORM.id) /> 
			<cfelse>
				<cfset LOCAL.pageData.order = EntityNew("order") /> 
			</cfif>
			
			<cfset LOCAL.pageData.order.setTrackingNumber(Trim(FORM.tracking_number)) />
			<cfset LOCAL.pageData.order.setCoupon(Trim(FORM.coupon)) />
			<cfset LOCAL.pageData.order.setPhone(Trim(FORM.phone)) />
			
			<cfset LOCAL.pageData.order.setShippingFirstName(Trim(FORM.shipping_first_name)) />
			<cfset LOCAL.pageData.order.setShippingMiddleName(Trim(FORM.shipping_middle_name)) />
			<cfset LOCAL.pageData.order.setShippingLastName(Trim(FORM.shipping_last_name)) />
			<cfset LOCAL.pageData.order.setShippingStreet(Trim(FORM.shipping_street)) />
			<cfset LOCAL.pageData.order.setShippingCity(Trim(FORM.shipping_city)) />
			<cfset LOCAL.pageData.order.setShippingPostalCode(Trim(FORM.shipping_postal_code)) />
			<cfset LOCAL.pageData.order.setShippingProvince(EntityLoadByPK("province",FORM.shipping_province_id)) />
			<cfset LOCAL.pageData.order.setShippingCountry(EntityLoadByPK("country",FORM.shipping_country_id)) />
		
			
			
			<cfset LOCAL.currentStatus = EntityLoad("order_status",{orderId = FORM.id, endDatetime = JavaCast("NULL","")}) />
			
			<cfset LOCAL.currentStatus.setEndDatetime(Now()) />
			<cfset EntitySave(LOCAL.currentStatus) />
			
			<cfset LOCAL.newStatus = EntityNew("order_status") />
			<cfset LOCAL.newStatus.setStatusType(EntityLoad("order_status_type", FORM.order_status_type_id)) />
			<cfset LOCAL.newStatus.setStartDatetime(LOCAL.currentStatus.getEndDatetime()) />
			<cfset LOCAL.order.addStatus(LOCAL.newStatus) />
			
			<cfset EntitySave(LOCAL.order) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Order status has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.order.getOrderId()#&active_tab_id=3" />
		<cfelseif StructKeyExists(FORM,"add_new_product")>
			<cfset LOCAL.coupon = EntityLoadByPK("coupon", FORM.id)>
			<cfset LOCAL.coupon.setIsDeleted(true) />
			
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