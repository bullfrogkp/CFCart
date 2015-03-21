<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"save_shipping_tracking_number") AND Trim(FORM.shipping_tracking_number) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping tracking number.") />
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
		
		<cfif StructKeyExists(FORM,"save_status")>
			<cfset LOCAL.order = EntityLoadByPK("order", FORM.id)> 
			
			<cfset LOCAL.currentStatus = EntityLoad("order_status",{orderId = FORM.id, current = true}, true) />
			
			<cfset LOCAL.currentStatus.setEndDatetime(Now()) />
			<cfset EntitySave(LOCAL.currentStatus) />
			
			<cfset LOCAL.newStatus = EntityNew("order_status") />
			<cfset LOCAL.newStatus.setStatusType(EntityLoad("order_status_type", FORM.order_status_type_id)) />
			<cfset LOCAL.newStatus.setStartDatetime(LOCAL.currentStatus.getEndDatetime()) />
			<cfset EntitySave(LOCAL.newStatus) />
			
			<cfset LOCAL.order.addStatus(LOCAL.newStatus) />
			
			<cfset EntitySave(LOCAL.order) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Order status has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.order.getOrderId()#" />
			
		<cfelseif StructKeyExists(FORM,"save_shipping_tracking_number")>
		
			<cfset LOCAL.order = EntityLoadByPK("order", FORM.id)> 
			
			<cfset LOCAL.order.setShippingTrackingNumber(FORM.shipping_tracking_number) />
			
			<cfset EntitySave(LOCAL.order) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Shipping tracking number has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.order.getOrderId()#&active_tab_id=tab_2" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.order = EntityLoadByPK("order", URL.id)> 
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.order.getOrderTrackingNumber()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.currentOrderStatus = EntityLoad("order_status",{order_id = LOCAL.pageData.order.getOrderId(), current = true},true) />

		<cfset LOCAL.pageData.orderSubtotalAmount = 0 />
		<cfset LOCAL.pageData.orderShippingAmount = 0 />
		<cfset LOCAL.pageData.orderTaxAmount = 0 />
		<cfset LOCAL.pageData.orderTotalAmount = 0 />
		<cfloop array="#LOCAL.pageData.order.getProducts()#" index="LOCAL.product">
			<cfset LOCAL.pageData.orderSubtotalAmount += LOCAL.product.getSubtotalAmount() />
			<cfset LOCAL.pageData.orderShippingAmount += LOCAL.product.getShippingAmount() />
			<cfset LOCAL.pageData.orderTaxAmount += LOCAL.product.getTaxAmount() />
			<cfset LOCAL.pageData.orderTotalAmount += LOCAL.product.getTotalAmount() />
		</cfloop>
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.shipping_tracking_number = "" />
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>