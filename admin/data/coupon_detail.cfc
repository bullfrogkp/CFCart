﻿<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif FORM.discount_type_id EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please choose a valid discount type.") />
		</cfif>
		
		<cfif Trim(FORM.code) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid coupon code.") />
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
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfif IsNumeric(FORM.id)>
				<cfset LOCAL.coupon = EntityLoadByPK("coupon", FORM.id)> 
			<cfelse>
				<cfset LOCAL.coupon = EntityNew("coupon") />
				<cfset LOCAL.coupon.setCreatedUser(SESSION.adminUser) />
				<cfset LOCAL.coupon.setCreatedDatetime(Now()) />
			</cfif>
			
			<cfset LOCAL.coupon.setCode(Trim(FORM.code)) />
			<cfset LOCAL.coupon.setDiscountType(EntityLoadByPK("discount_type",FORM.discount_type_id)) />
			<cfif IsDate(Trim(FORM.start_date))>
				<cfset LOCAL.coupon.setStartDate(Trim(FORM.start_date)) />
			</cfif>
			<cfif IsDate(Trim(FORM.end_date))>
				<cfset LOCAL.coupon.setEndDate(Trim(FORM.end_date)) />
			</cfif>
			
			<cfset EntitySave(LOCAL.coupon) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Coupon has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.coupon.getCouponId()#" />
		<cfelseif StructKeyExists(FORM,"delete_item")>
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
			<cfset LOCAL.pageData.coupon = EntityLoadByPK("coupon", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.coupon.getCode()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
		<cfelse>
			<cfset LOCAL.pageData.coupon = EntityNew("coupon") />
			<cfset LOCAL.pageData.title = "New Coupon | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
		</cfif>
		
		<cfset LOCAL.pageData.discountTypes = EntityLoad("discount_type") />
		<cfset LOCAL.pageData.couponStatus = EntityLoad("coupon_status") />
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.code = isNull(LOCAL.pageData.coupon.getCode())?"":LOCAL.pageData.coupon.getCode() />
			<cfset LOCAL.pageData.formData.start_date = isNull(LOCAL.pageData.coupon.getStartDate())?"":LOCAL.pageData.coupon.getStartDate() />
			<cfset LOCAL.pageData.formData.end_date = isNull(LOCAL.pageData.coupon.getEndDate())?"":LOCAL.pageData.coupon.getEndDate() />
			<cfset LOCAL.pageData.formData.discount_type_id = isNull(LOCAL.pageData.coupon.getDiscountType())?"":LOCAL.pageData.coupon.getDiscountType().getDiscountTypeId() />
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>