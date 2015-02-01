<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.page_title = "Prospect International Consulting Ltd." />
		<cfset LOCAL.pageData.description = "Prospect International Consulting Ltd." />
		<cfset LOCAL.pageData.keywords = "Prospect International Consulting Ltd." />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/step1.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>