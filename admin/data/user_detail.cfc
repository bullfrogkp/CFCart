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
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.user.getUserId()#" />
			
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
			<cfset LOCAL.pageData.user = EntityLoadByPK("user", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.user.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.username = isNull(LOCAL.pageData.user.getUsername())?"":LOCAL.pageData.user.getUsername() />
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.user.getDisplayName())?"":LOCAL.pageData.user.getDisplayName() />
				<cfset LOCAL.pageData.formData.email = isNull(LOCAL.pageData.user.getEmail())?"":LOCAL.pageData.user.getEmail() />
				<cfset LOCAL.pageData.formData.phone = isNull(LOCAL.pageData.user.getPhone())?"":LOCAL.pageData.user.getPhone() />
				<cfset LOCAL.pageData.formData.last_login_datetime = isNull(LOCAL.pageData.user.getLastLoginDatetime())?"":LOCAL.pageData.user.getLastLoginDatetime() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "User Detail | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.username = "" />
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.email = "" />
				<cfset LOCAL.pageData.formData.phone = "" />
				<cfset LOCAL.pageData.formData.last_login_datetime = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>