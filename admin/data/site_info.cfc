<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.systemEmail = EntityLoadByPK("system_email", FORM.id)> 
		<cfelse>
			<cfset LOCAL.systemEmail = EntityNew("system_email") />
			<cfset LOCAL.systemEmail.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.systemEmail.setCreatedDatetime(Now()) />
			<cfset LOCAL.systemEmail.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.systemEmail.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.systemEmail.setSubject(Trim(FORM.subject)) />
			<cfset LOCAL.systemEmail.setContent(Trim(FORM.content)) />
			<cfset LOCAL.systemEmail.setType(Trim(FORM.type)) />
			<cfset LOCAL.systemEmail.setIsEnabled(FORM.is_enabled) />
			
			<cfset EntitySave(LOCAL.systemEmail) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"System email has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.systemEmail.getSystemEmailId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.systemEmail.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.systemEmail) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"System Email '#LOCAL.systemEmail.getSubject()#' has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/system_emails.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Company Information | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.siteInfoArray = EntityLoad("site_info") /> 
		
		<cfif NOT IsNull(LOCAL.pageData.siteInfoArray)>
			<cfset LOCAL.pageData.siteInfo = LOCAL.pageData.siteInfoArray[1] /> 
		<cfelse>
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.name = "" />
				<cfset LOCAL.pageData.formData.unit = "" />
				<cfset LOCAL.pageData.formData.street = "" />
				<cfset LOCAL.pageData.formData.city = "" />
				<cfset LOCAL.pageData.formData.province = "" />
				<cfset LOCAL.pageData.formData.country = "" />
				<cfset LOCAL.pageData.formData.postal_code = "" />
				<cfset LOCAL.pageData.formData.phone = "" />
				<cfset LOCAL.pageData.formData.email = "" />
			</cfif>
		</cfif>
			
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.subject = isNull(LOCAL.pageData.systemEmail.getSubject())?"":LOCAL.pageData.systemEmail.getSubject() />
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.systemEmail.getDisplayName())?"":LOCAL.pageData.systemEmail.getDisplayName() />
				<cfset LOCAL.pageData.formData.content = isNull(LOCAL.pageData.systemEmail.getContent())?"":LOCAL.pageData.systemEmail.getContent() />
				<cfset LOCAL.pageData.formData.type = isNull(LOCAL.pageData.systemEmail.getType())?"":LOCAL.pageData.systemEmail.getType() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.systemEmail.getIsEnabled())?"":LOCAL.pageData.systemEmail.getIsEnabled() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "System Email | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.subject = "" />
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.content = "" />
				<cfset LOCAL.pageData.formData.type = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>