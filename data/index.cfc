<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.currentPage = EntityLoad("page", {name=getPageName()},true)> 
		
		<cfset LOCAL.pageData.title = LOCAL.pageData.currentPage.getTitle() />
		<cfset LOCAL.pageData.description = LOCAL.pageData.currentPage.getDescription() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.currentPage.getKeywords() />
		
		<cfset LOCAL.pageData.modules = _convertModules(EntityLoad("page_module",{page = LOCAL.pageData.currentPage})) />
				
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>