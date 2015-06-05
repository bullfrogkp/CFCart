<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"update_password")>
			<cfif Trim(FORM.current_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your current password.") />
			</cfif>
			<cfif Trim(FORM.new_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your new password.") />
			</cfif>
			<cfif Trim(FORM.confirm_new_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please confirm your new password.") />
			</cfif>
			<cfif Trim(FORM.new_password) NEQ "" AND Trim(FORM.confirm_new_password) NEQ "" AND Trim(FORM.new_password) NEQ Trim(FORM.confirm_new_password)>
				<cfset ArrayAppend(LOCAL.messageArray,"Passwords don't match.") />
			</cfif>
			
			<cfif ArrayLen(LOCAL.messageArray) EQ 0>
				<cfset LOCAL.customerService = new "#APPLICATION.componentPathRoot#core.services.customerService"() />
				<cfset LOCAL.customerService.setUsername(SESSION.user.userName) />
				<cfset LOCAL.customerService.setPassword(Trim(FORM.current_password)) />
				<cfif LOCAL.customerService.isUserValid() EQ false>
					<cfset ArrayAppend(LOCAL.messageArray,"Password is not correct.") />
				</cfif>
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
		
		<cfset LOCAL.pageData.title = "Change Password | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<!----------------------------------------------------------------------------------------------------------------------------------------------------->
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
		
		<cfif StructKeyExists(FORM,"update_password")>
			<cfset LOCAL.customer.setPassword(Trim(FORM.new_password)) />
			<cfset EntitySave(LOCAL.customer) />
		</cfif>
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#myaccount/change_password.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>