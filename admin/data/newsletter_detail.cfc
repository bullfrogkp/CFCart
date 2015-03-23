<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.review = EntityLoadByPK("review", FORM.id)>
			<cfset LOCAL.review.setReviewStatusType(EntityLoadByPK('review_status_type',FORM.review_status_type_id)) />
			
			<cfset EntitySave(LOCAL.review) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Review has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.review.getReviewId()#" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.newsletter = EntityLoadByPK("newsletter", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.newsletter.getSubject()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.subject = isNull(LOCAL.pageData.newsletter.getSubject())?"":LOCAL.pageData.newsletter.getSubject() />
				<cfset LOCAL.pageData.formData.name = isNull(LOCAL.pageData.newsletter.getDisplayName())?"":LOCAL.pageData.newsletter.getDisplayName() />
				<cfset LOCAL.pageData.formData.content = isNull(LOCAL.pageData.newsletter.getContent())?"":LOCAL.pageData.newsletter.getContent() />
				<cfset LOCAL.pageData.formData.type = isNull(LOCAL.pageData.newsletter.getType())?"":LOCAL.pageData.newsletter.getType() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Newsletter | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfset LOCAL.pageData.formData.subject = "" />
			<cfset LOCAL.pageData.formData.name = "" />
			<cfset LOCAL.pageData.formData.content = "" />
			<cfset LOCAL.pageData.formData.type = "" />
			<cfset LOCAL.pageData.formData.id = "" />
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>