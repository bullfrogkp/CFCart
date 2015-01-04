<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.page_data = {} />
		<cfset ORMReload() />
		<cfset LOCAL.page_data.site_pages = EntityLoad("site_pages") />
		
		<cfreturn LOCAL.page_data />	
	</cffunction>
</cfcomponent>