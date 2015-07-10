<cfcomponent extends="master"> 
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"add_review")>
			<cfset LOCAL.review = EntityNew("review") />
			<cfset LOCAL.review.setReviewerName(Trim(FORM.reviewer_name)) />
			<cfset LOCAL.review.setSubject(Trim(FORM.review_subject)) />
			<cfset LOCAL.review.setRating(FORM.review_rating) />
			<cfset LOCAL.review.setMessage(Trim(FORM.review_message)) />			
			<cfset LOCAL.review.setCreatedDatetime(Now()) />			
			<cfset LOCAL.review.setCreatedUser(SESSION.user.userName) />			
			<cfset LOCAL.review.setIsDeleted(false) />			
			<cfset LOCAL.review.setProduct(EntityLoadByPK("product",FORM.current_product_id)) />			
			<cfset LOCAL.review.setReviewStatusType(EntityLoad("review_status_type",{name = "pending"},true)) />
			<cfset EntitySave(LOCAL.review) />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		<cfset LOCAL.trackingService = new "#APPLICATION.componentPathRoot#core.services.trackingService"(cfid = COOKIE.cfid, cftoken = COOKIE.cftoken) />
		<cfset LOCAL.productId = ListGetAt(CGI.PATH_INFO,2,"/")> 
		<cfset LOCAL.productService.setId(LOCAL.productId) />
		
		<cfset LOCAL.pageData.product = EntityLoadByPK("product",LOCAL.productId) />
		
		<cfset LOCAL.pageData.allImages = EntityLoad("product_image", {product = LOCAL.pageData.product})> 
		
		<cfset LOCAL.reviewStatusType = EntityLoad("review_status_type", {name = "approved"}, true)> 
		<cfset LOCAL.pageData.reviews = EntityLoad("review", {product = LOCAL.pageData.product, reviewStatusType = LOCAL.reviewStatusType})> 
		
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayNameMV()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = LOCAL.pageData.product.getDescriptionMV() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.product.getKeywordsMV() />
		<!---
		<cfset LOCAL.pageData.shippingMethods = LOCAL.productService.getFrontendProductShippingMethods() />
		--->
		<cfif LOCAL.pageData.product.isProductAttributeComplete()>
			<cfset LOCAL.pageData.requiredAttributeCount = ArrayLen(EntityLoad("attribute_set_attribute_rela", {attributeSet = LOCAL.pageData.product.getAttributeSet(), required = true})) />
		</cfif>	
		
		<cfset LOCAL.trackingService.addTrackingRecord(productId = LOCAL.productId, trackingRecordType = "history") />
														
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>