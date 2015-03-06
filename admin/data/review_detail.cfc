<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.review = EntityLoadByPK("review", FORM.id)>
			<cfset LOCAL.review.setStatus(EntityLoadByPK('review_status',FORM.review_status_id)) />
			
			<cfset EntitySave(LOCAL.review) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Review has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.review.getReviewId()#" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
	
		<cfset LOCAL.pageData.review = EntityLoadByPK("review", URL.id)> 
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.review.getSubject()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.deleteButtonClass = "" />	
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.subject = isNull(LOCAL.pageData.review.getSubject())?"":LOCAL.pageData.review.getSubject() />
			<cfset LOCAL.pageData.formData.rating = isNull(LOCAL.pageData.review.getRating())?"":LOCAL.pageData.review.getRating() />
			<cfset LOCAL.pageData.formData.message = isNull(LOCAL.pageData.review.getMessage())?"":LOCAL.pageData.review.getMessage() />
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>