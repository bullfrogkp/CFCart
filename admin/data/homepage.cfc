<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.homePage = EntityLoadByPK("page", FORM.id)> 
			<cfset LOCAL.homePage.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.homePage.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.homePage = EntityNew("page") />
			<cfset LOCAL.homePage.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.homePage.setCreatedDatetime(Now()) />
			<cfset LOCAL.homePage.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.homePage.setContent(Trim(FORM.slide_content)) />			
			<cfset EntitySave(LOCAL.homePage) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Content has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.homePage.getPageId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_ad")>
			
			<cfset LOCAL.ad = EntityLoadByPK("homepage_ad",FORM.deleted_ad_id) />
			<cfset LOCAL.ad.setDeleted(true) />
			<cfset EntitySave(LOCAL.ad) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Ad has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.ad.getAdId()#" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		<cfset LOCAL.pageData.discountTypes = EntityLoad("discount_type") />
		<cfset LOCAL.pageData.couponStatusTypes = EntityLoad("coupon_status_type") />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.coupon = EntityLoadByPK("coupon", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.coupon.getCouponCode()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.coupon_code = isNull(LOCAL.pageData.coupon.getCouponCode())?"":LOCAL.pageData.coupon.getCouponCode() />
				<cfset LOCAL.pageData.formData.threshold_amount = isNull(LOCAL.pageData.coupon.getThresholdAmount())?"":LOCAL.pageData.coupon.getThresholdAmount() />
				<cfset LOCAL.pageData.formData.start_date = isNull(LOCAL.pageData.coupon.getStartDate())?"":DateFormat(LOCAL.pageData.coupon.getStartDate(),"mm/dd/yyyy") />
				<cfset LOCAL.pageData.formData.end_date = isNull(LOCAL.pageData.coupon.getEndDate())?"":DateFormat(LOCAL.pageData.coupon.getEndDate(),"mm/dd/yyyy") />
				<cfset LOCAL.pageData.formData.discount_type_id = isNull(LOCAL.pageData.coupon.getDiscountType())?"":LOCAL.pageData.coupon.getDiscountType().getDiscountTypeId() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Coupon | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.coupon_code = "" />
				<cfset LOCAL.pageData.formData.threshold_amount = "" />
				<cfset LOCAL.pageData.formData.start_date = "" />
				<cfset LOCAL.pageData.formData.end_date = "" />
				<cfset LOCAL.pageData.formData.discount_type_id = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>