<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.keywords = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "Dashboard | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		
		<cfif IsDefined(getURLStruct().category_id)>
			
			<cfset LOCAL.categoryService.setCategoryId(getURLStruct().category_id) />
		</cfif>
		
		<cfset LOCAL.pageData.categories = LOCAL.categoryService.getCategories() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>