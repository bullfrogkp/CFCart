<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryId = ListGetAt(CGI.PATH_INFO,2,"/")> 
		<cfset LOCAL.pageData.pageNumber = ListGetAt(CGI.PATH_INFO,3,"/")> 
		<cfset LOCAL.pageData.activeFilterValueIdList = ListGetAt(CGI.PATH_INFO,4,"/") />
		<cfset LOCAL.pageData.orderBy = ListGetAt(CGI.PATH_INFO,5,"/") />
		<cfset LOCAL.pageData.category = EntityLoadByPK("category",LOCAL.categoryId) />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		<cfset LOCAL.productService.setIsDeleted(false) />
		<cfset LOCAL.productService.setIsEnabled(true) />
		<cfset LOCAL.productService.setPageNumber(LOCAL.pageData.pageNumber) />
		<cfset LOCAL.productService.setRecordsPerPage(APPLICATION.recordsPerPageFrontend) />
		<cfset LOCAL.productService.setCategoryId(LOCAL.categoryId) />
		
		<cfset LOCAL.recordStruct = LOCAL.productService.getRecords() />
		<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(recordStruct = LOCAL.recordStruct, currentPage = LOCAL.pageData.pageNumber) />
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.subCategoryTree = LOCAL.categoryService.getCategoryTree(parentCategoryId = LOCAL.categoryId) />
		
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.category.getDisplayName()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = LOCAL.pageData.category.getDescription() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.category.getKeywords() />
		<cfset LOCAL.pageData.categoryArray = _getCategoryArray(category = LOCAL.pageData.category) />
	
		<cfset LOCAL.pageData.currentPage = EntityLoad("page", {name = getPageName()},true)> 
		<cfset LOCAL.pageData.advertisementSection = EntityLoad("page_section", {name="advertisement",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.bestSellerSection = EntityLoad("page_section", {name="best seller",page=LOCAL.pageData.currentPage},true)> 
	
		<cfset LOCAL.pageData.filterArray = _getFilterArray(category = LOCAL.pageData.category) />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_getCategoryArray" access="private" output="false" returnType="array">
		<cfargument name="category" type="any" required="true" />
		<cfset var LOCAL = {} />
				
		<cfset LOCAL.categoryArray = [] />
		<cfset LOCAL.category = ARGUMENTS.category />
		
		<cfset ArrayPrepend(LOCAL.categoryArray, LOCAL.category) />
			
		<cfloop condition = "NOT IsNull(LOCAL.category.getParentCategory())">
			<cfset LOCAL.category = LOCAL.category.getParentCategory() />
			<cfset ArrayPrepend(LOCAL.categoryArray, LOCAL.category) />
		</cfloop>
				
		<cfreturn LOCAL.categoryArray />	
	</cffunction>
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_getFilterArray" access="private" output="false" returnType="array">
		<cfargument name="category" type="any" required="true" />
		<cfargument name="pageNumber" type="numeric" required="true" />
		<cfargument name="sortTypeId" type="numeric" required="true" />
		<cfargument name="filterValueIdList" type="array" required="true" />
		
		<cfset var LOCAL = {} />
				
		<cfset LOCAL.filterArray = [] />
		<cfset LOCAL.category = ARGUMENTS.category />
		<cfset LOCAL.filterValueIdList = ARGUMENTS.filterValueIdList />
		
		<cfloop array="#LOCAL.category.getCategoryFilterRelas()#" index="LOCAL.categoryFilterRela">
			<cfset LOCAL.filter = LOCAL.categoryFilterRela.getFilter() />
			
			<cfset LOCAL.filterStruct = {} />
			<cfset LOCAL.filterStruct.filterName = LOCAL.filter.getDisplayName() />
			<cfset LOCAL.filterStruct.filterValueArray = [] />
			
			<cfif NOT IsNull(LOCAL.categoryFilterRela.getFilterValues())>
				<cfloop array="#LOCAL.categoryFilterRela.getFilterValues()#" index="LOCAL.filterValue">
					<cfset LOCAL.newFilterValue = {} />
					<cfset LOCAL.newFilterValue.name = LOCAL.filterValue.getDisplayName() />
					<cfset LOCAL.newFilterValue.value = LOCAL.filterValue.getValue() />
					
					<cfif ListFind(LOCAL.filterValueIdList, LOCAL.filterValue.getFilterValueId())>
						<cfset List
					</cfif>
					
					
					<cfset LOCAL.newFilterValue.link = _buildPathInfo(categoryName = LOCAL.category.getDisplayName()
																	, categoryId = LOCAL.category.getCategoryId()
																	, pageNumber = ARGUMENTS.pageNumber
																	, sortTypeId = ARGUMENTS.sortTypeId
																	, filterValues = ARGUMENTS.filterValues
																	) />
					<cfset ArrayPrepend(LOCAL.filterStruct.filterValueArray, LOCAL.newFilterValue) />
				</cfloop>
			</cfif>
			
			<cfset ArrayPrepend(LOCAL.filterArray, LOCAL.filterStruct) />
		</cfloop>
				
		<cfreturn LOCAL.filterArray />	
	</cffunction>
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_buildPathInfo" access="private" output="false" returnType="string">
		<cfargument name="categoryName" type="string" required="true" />
		<cfargument name="categoryId" type="numeric" required="true" />
		<cfargument name="pageNumber" type="numeric" required="true" />
		<cfargument name="sortTypeId" type="numeric" required="true" />
		<cfargument name="filterValueIdList" type="array" required="true" />
		
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.pathInfo = "/#URLEncodedFormat(ARGUMENTS.categoryName)#/#ARGUMENTS.categoryId#/#ARGUMENTS.pageNumber#/#ARGUMENTS.sortTypeId#/#ARGUMENTS.filterValueIdList#"
		
		<cfreturn LOCAL.pathInfo />	
	</cffunction>
</cfcomponent>