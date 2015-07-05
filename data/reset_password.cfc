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
		
		<cfset LOCAL.pageData.customerId = SESSION.temp.customerId />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<!----------------------------------------------------------------------------------------------------------------------------------------------------->
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.customer = EntityLoadByPK("customer",FORM.customer_id) />
		
		<cfif StructKeyExists(FORM,"reset_password")>
			<cfset LOCAL.customer.setPassword(Trim(FORM.new_password)) />
			<cfset EntitySave(LOCAL.customer) />
		</cfif>
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#reset_password_done.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>