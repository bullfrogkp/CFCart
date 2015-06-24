<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfif FORM.name EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid name.") />
			</cfif>
			<cfif FORM.detail EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your content.") />
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
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.content = EntityLoadByPK("content", URL.id)> 
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.content.getName()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.deleteButtonClass = "" />	
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.name = isNull(LOCAL.pageData.content.getName())?"":LOCAL.pageData.content.getName() />
			<cfset LOCAL.pageData.formData.content = isNull(LOCAL.pageData.content.getContent())?"":LOCAL.pageData.content.getContent() />
			<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.content.getIsEnabled())?"":LOCAL.pageData.content.getIsEnabled() />
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>