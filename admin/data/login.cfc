<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfset SESSION.adminUser = "pan" />
		<cfset LOCAL.redirectUrl = "index.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>