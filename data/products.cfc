<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryId = ListGet(CGI.PATH_INFO,2,"/")> 
		<cfset LOCAL.pageNumber = ListGet(CGI.PATH_INFO,3,"/")> 
		<cfset LOCAL.pageData.category = EntityLoadByPK("category",LOCAL.categoryId) />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.categoryService.setIsDeleted(false) />
		<cfset LOCAL.categoryService.setIsEnabled(true) />
		<cfset LOCAL.categoryService.setPageNumber(LOCAL.pageNumber)) />
		
		<cfset LOCAL.recordStruct = LOCAL.categoryService.getRecords() />
		<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(LOCAL.recordStruct) /> 
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree(parentCategoryId = LOCAL.categoryId) />
		
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.category.getDisplayName()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = LOCAL.pageData.category.getDescription() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.category.getKeywords() />
		<cfset LOCAL.pageData.categoryNameArray = _getCategoryNameArray(category = LOCAL.pageData.category) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_getCategoryNameArray" access="private" output="false" returnType="array">
		<cfargument name="category" type="object" required="true" />
		<cfset var LOCAL = {} />
				
		<cfset LOCAL.categoryArray = [] />
		<cfset LOCAL.category = ARGUMENTS.category />
		
		<cfloop condition = "NOT IsNull(LOCAL.category.getParentCategory())">
			<cfset ArrayPrepend(LOCAL.categoryArray, LOCAL.category.getDisplayName()) />
			<cfset LOCAL.category = LOCAL.category.getParentCategory() />
		</cfloop>
				
		<cfreturn LOCAL.categoryArray />	
	</cffunction>
</cfcomponent>