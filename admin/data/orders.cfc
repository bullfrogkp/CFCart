<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Orders | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.orders = EntityLoad("order") />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>