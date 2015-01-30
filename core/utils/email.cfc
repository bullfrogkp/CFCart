<cfcomponent>
	<cffunction name="sendRequest" access="remote" returntype="string" output="false">
		<cfargument name="contact_name" type="string" required="true">
		<cfargument name="contact_phone" type="string" required="true">
		<cfargument name="contact_email" type="string" required="true">
		<cfargument name="user" type="string" required="true">
		<cfargument name="contact_message" type="string" required="false" default="">
		 
		<cfset var LOCAL = {} />
		<cfset var LOCAL.ret_val = "0" />
		
		<cfif IsValid("email",ARGUMENTS.contact_email) AND Trim(ARGUMENTS.contact_phone) NEQ "" AND Trim(ARGUMENTS.contact_name) NEQ "">
		
			<cfset sendDirectEmail(	from_email = APPLICATION.customer_service_email
								,	to_email = APPLICATION.customer_service_email
								,	email_subject = "客户咨询 (#Trim(ARGUMENTS.contact_name)#:#Trim(ARGUMENTS.contact_phone)#)"
								,	email_content = Trim(ARGUMENTS.contact_message)
								,	email_type = "html") />							
			<cfset LOCAL.ret_val = "1" />
		</cfif>
						
		<cfreturn LOCAL.ret_val /> 
	</cffunction>
	
	<cffunction name="sendDirectEmail" access="public" returntype="void">
	    <cfargument name="from_email" type="string" required="true" />
	    <cfargument name="to_email" type="string" required="true" />
		<cfargument name="email_subject" type="string" required="true" />
		<cfargument name="email_content" type="string" required="true" />
		<cfargument name="email_type" type="string" required="true" />
				
		<cfmail from="#Trim(ARGUMENTS.from_email)#" 
				to="#Trim(ARGUMENTS.to_email)#" 
				type="#ARGUMENTS.email_type#"
				subject="#Trim(ARGUMENTS.email_subject)#">#Trim(ARGUMENTS.email_content)#</cfmail>
		
	</cffunction>
</cfcomponent>