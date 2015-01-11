<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.page_data = {} />
		
		<cfset LOCAL.page_data.page_title = "Prospect International Consulting Ltd." />
		<cfset LOCAL.page_data.description = "Prospect International Consulting Ltd." />
		<cfset LOCAL.page_data.keywords = "Prospect International Consulting Ltd." />
		
		<cfreturn LOCAL.page_data />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirect_url = "#APPLICATION.absolute_url_web#search_results.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>