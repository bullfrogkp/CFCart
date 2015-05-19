<cfcomponent output="false">
	<cffunction name="getUser" access="public" returntype="struct">
	    <cfset var LOCAL = {} />
		
		<cfset LOCAL.userName = CGI.REMOTE_ADDR />
		<cfset LOCAL.defaultCustomerGroup = EntityLoad("customer_group",{isDefault = true},true) />
		<cfset LOCAL.customerGroupName = LOCAL.defaultCustomerGroup.getName() />
	   
		<cfreturn LOCAL />
	</cffunction>
</cfcomponent>