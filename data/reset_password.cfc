<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"reset_password")>
			<cfif Trim(FORM.new_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your new password.") />
			</cfif>
			<cfif Trim(FORM.confirm_new_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please confirm your new password.") />
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	<!----------------------------------------------------------------------------------------------------------------------------------------------------->
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Reset Password | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.linkId = SESSION.temp.linkId />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<!----------------------------------------------------------------------------------------------------------------------------------------------------->
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"reset_password")>
			<cfset LOCAL.linkActiveStateType = EntityLoad("link_state_type",{name="active"},true) />
			<cfset LOCAL.linkProcessedStateType = EntityLoad("link_state_type",{name="processed"},true) />
			<cfset LOCAL.link = EntityLoadByPK("link",FORM.u) />
			
			<cfset LOCAL.customer = LOCAL.link.getCustomer() />
			<cfset LOCAL.customer.setPassword(Trim(FORM.new_password)) />
			<cfset LOCAL.link.setLinkStateType(LOCAL.linkProcessedStateType) />
			
			<cfset EntitySave(LOCAL.customer) />
			<cfset EntitySave(LOCAL.link) />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#reset_password_done.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>