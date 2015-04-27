<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.page_title = "Home | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "Prospect International Consulting Ltd." />
		<cfset LOCAL.pageData.keywords = "Prospect International Consulting Ltd." />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>