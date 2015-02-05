<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Categories | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		
		<cfif StructKeyExists(URL,"category_id") AND IsNumeric(URL.category_id)>
			<cfset LOCAL.categoryService.setCategoryId(URL.category_id) />
		</cfif>
		<cfif StructKeyExists(URL,"category_is_enabled") AND IsNumeric(URL.category_is_enabled)>
			<cfset LOCAL.categoryService.setCategoryIsEnabled(URL.category_is_enabled) />
		</cfif>
		<cfif StructKeyExists(URL,"search_keyword") AND Trim(URL.search_keyword) NEQ "">
			<cfset LOCAL.categoryService.setCategorySearchKeywords(Trim(URL.search_keyword)) />
		</cfif>
		
		<cfset LOCAL.pageData.categories = LOCAL.categoryService.getCategories() />
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>