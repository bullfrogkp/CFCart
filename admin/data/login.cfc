<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfset SESSION.admin_user = "pan" />
		<cfset LOCAL.redirect_url = "index.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>