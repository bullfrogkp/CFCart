<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Newsletters | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.newsletters = EntityLoad("newsletter") />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>