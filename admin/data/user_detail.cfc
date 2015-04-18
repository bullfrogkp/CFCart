<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.user = EntityLoadByPK("user", FORM.id)> 
			<cfset LOCAL.user.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.user.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.user = EntityNew("user") />
			<cfset LOCAL.user.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.user.setCreatedDatetime(Now()) />
			<cfset LOCAL.user.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.user.setUsername(Trim(FORM.username)) />
			<cfset LOCAL.user.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.user.setPassword(Hash(Trim(FORM.password))) />
			<cfset LOCAL.user.setEmail(Trim(FORM.email)) />
			<cfset LOCAL.user.setPhone(Trim(FORM.phone)) />
			
			<cfset EntitySave(LOCAL.user) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"User has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.user.getUserlId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.user.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.user) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"User has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/users.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.user = EntityLoadByPK("system_email", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.user.getSubject()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.subject = isNull(LOCAL.pageData.user.getSubject())?"":LOCAL.pageData.user.getSubject() />
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.user.getDisplayName())?"":LOCAL.pageData.user.getDisplayName() />
				<cfset LOCAL.pageData.formData.content = isNull(LOCAL.pageData.user.getContent())?"":LOCAL.pageData.user.getContent() />
				<cfset LOCAL.pageData.formData.type = isNull(LOCAL.pageData.user.getType())?"":LOCAL.pageData.user.getType() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.user.getIsEnabled())?"":LOCAL.pageData.user.getIsEnabled() />
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