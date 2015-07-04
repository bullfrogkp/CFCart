<cfcomponent extends="master">	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif NOT(StructKeyExists(URL.u) AND Trim(URL.u) NEQ "")>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#invalid_link.cfm" />
		<cfelse>
			<cfset LOCAL.linkStateType = EntityLoad("link_state_type",{name="active"},true) />
			<cfset LOCAL.link = EntityLoad("link",{uuid = Trim(URL.u), linkStateType = LOCAL.linkStateType}, true) />
			<cfif IsNull(LOCAL.link)>
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#invalid_link.cfm" />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processURLDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(FORM,"send_email")>
			<cfset LOCAL.customer = EntityLoad("customer",{email=Trim(FORM.email)},true) />
			
			<cfset LOCAL.emailService = new "#APPLICATION.componentPathRoot#core.services.email"() />
			<cfset LOCAL.emailService.setFromEmail(APPLICATION.emailCustomerService) />
			<cfset LOCAL.emailService.setToEmail(Trim(FORM.email)) />
			<cfset LOCAL.emailService.setContentName("reset password") />
			
			<cfset LOCAL.replaceStruct = {} />
			<cfset LOCAL.replaceStruct.customerName = LOCAL.customer.getFirstname() />
			
			<cfset LOCAL.emailService.setReplaceStruct(LOCAL.replaceStruct) />
			<cfset LOCAL.emailService.sendEmail() />
		
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#email_sent.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>