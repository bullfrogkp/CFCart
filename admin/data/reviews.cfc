<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Reviews | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.reviews = EntityLoad("review") />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>