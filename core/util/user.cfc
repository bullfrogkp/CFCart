<cfcomponent output="false">
	<cffunction name="getUser" access="public" returntype="string">
	    <cfset var LOCAL = StructNew() />
		<cfif IsDefined("SESSION.admin_name")>
			<cfset LOCAL.user_name = SESSION.admin_name />
		<cfelse>
			<cfset LOCAL.user_name = CGI.REMOTE_ADDR />
		</cfif>
	   
		<cfreturn LOCAL.user_name />
	</cffunction>
</cfcomponent>