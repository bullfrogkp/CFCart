<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfif FORM.name EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid name.") />
			</cfif>
			<cfif FORM.detail EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the content.") />
			</cfif>
			<cfif FORM.title EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the page title.") />
			</cfif>
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
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.content = EntityLoadByPK("site_content", FORM.id)> 
			<cfset LOCAL.content.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.content.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.content = EntityNew("site_content") />
			<cfset LOCAL.content.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.content.setCreatedDatetime(Now()) />
			<cfset LOCAL.content.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.content.setName(LCase(Trim(FORM.name))) />
			<cfset LOCAL.content.setDisplayName(Trim(FORM.name)) />
			<cfset LOCAL.content.setContent(Trim(FORM.content)) />
			<cfset LOCAL.content.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.content.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.content.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.content.setIsEnabled(FORM.is_enabled) />
			
			<cfset EntitySave(LOCAL.content) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Content has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.content.getContentId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.content.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.content) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Content '#LOCAL.content.getName()#' has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/contents.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>		
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.content = EntityLoadByPK("site_content", URL.id)> 
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.content.getName()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.deleteButtonClass = "" />	
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.name = isNull(LOCAL.pageData.content.getName())?"":LOCAL.pageData.content.getName() />
			<cfset LOCAL.pageData.formData.content = isNull(LOCAL.pageData.content.getContent())?"":LOCAL.pageData.content.getContent() />
			<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.content.getTitle())?"":LOCAL.pageData.content.getTitle() />
			<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.content.getKeywords())?"":LOCAL.pageData.content.getKeywords() />
			<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.content.getDescription())?"":LOCAL.pageData.content.getDescription() />
			<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.content.getIsEnabled())?"":LOCAL.pageData.content.getIsEnabled() />
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>