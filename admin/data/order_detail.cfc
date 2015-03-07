<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"save_tracking_number") AND Trim(FORM.tracking_number) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid tracking number.") />
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
		<cfelseif StructKeyExists(FORM,"save_tracking_number")>
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
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.order = EntityLoadByPK("order", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.order.getTrackingNumber()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
		<cfelse>
			<cfset LOCAL.pageData.coupon = EntityNew("order") />
			<cfset LOCAL.pageData.title = "New Order | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
		</cfif>
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
		<!---
			<cfset LOCAL.pageData.formData.code = isNull(LOCAL.pageData.coupon.getCode())?"":LOCAL.pageData.coupon.getCode() />
			<cfset LOCAL.pageData.formData.start_date = isNull(LOCAL.pageData.coupon.getStartDate())?"":LOCAL.pageData.coupon.getStartDate() />
			<cfset LOCAL.pageData.formData.end_date = isNull(LOCAL.pageData.coupon.getEndDate())?"":LOCAL.pageData.coupon.getEndDate() />
			<cfset LOCAL.pageData.formData.discount_type_id = isNull(LOCAL.pageData.coupon.getDiscountType())?"":LOCAL.pageData.coupon.getDiscountType().getDiscountTypeId() />
		--->
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>