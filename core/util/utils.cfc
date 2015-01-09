<cfcomponent output="false">
	<cffunction name="handleError" access="public" returntype="void" output="false">
		<cfargument type="any" name="cfcatch" required=true /> 
		
		<cfset var error_string = "" />
		<cfset var exception_string = "" />
		<cfset var session_string = "" />
			
		<cfif IsDefined("SESSION")>
			<cfinvoke component="#APPLICATION.component_path_root#core.utils" method="struct2string" returnvariable="session_string">
				<cfinvokeargument name="input_struct" value="#SESSION#">
			</cfinvoke>
		</cfif>

		<cfinvoke component="#APPLICATION.component_path_root#core.utils" method="exception2string" returnvariable="exception_string">
			<cfinvokeargument name="ex" value="#cfcatch#">
		</cfinvoke>
		
		<cfset error_string = exception_string & session_string />
		
		<cflog text="#error_string#" />
		
		<cfif cfcatch.type NEQ "url_error">
			<cfinvoke component="#APPLICATION.component_path_root#core.utils.email" method="sendDirectEmail">
				<cfinvokeargument name="from_email" value="#APPLICATION.email_development#">
				<cfinvokeargument name="to_email" value="#APPLICATION.email_admin#">
				<cfinvokeargument name="email_subject" value="Exception">
				<cfinvokeargument name="email_content" value="#error_string#">
				<cfinvokeargument name="email_type" value="text">
			</cfinvoke>	
		</cfif>
	</cffunction>
</cfcomponent>