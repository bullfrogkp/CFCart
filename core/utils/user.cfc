<cfcomponent output="false">
	<cffunction name="getUser" access="public" returntype="struct">
	    <cfset var LOCAL = {} />
		
		<cfset LOCAL.userName = CGI.REMOTE_ADDR />
		<cfset LOCAL.userGroup = "default" />
	   
		<cfreturn LOCAL />
	</cffunction>
</cfcomponent>