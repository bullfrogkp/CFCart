<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.keywords = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "Dashboard | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.categoryService = new #APPLICATION.component_path_root#core.services.categoryService() />
		
		<cfif StructKeyExists()
		<cfset LOCAL.categoryService.
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>