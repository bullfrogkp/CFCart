<cfcomponent extends="master"> 
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryId = ListGetAt(CGI.PATH_INFO,2,"/")> 
		<cfset LOCAL.pageData.pageNumber = ListGetAt(CGI.PATH_INFO,3,"/")> 
		<cfset LOCAL.pageData.sortTypeId = ListGetAt(CGI.PATH_INFO,4,"/") />
		<cfif ListLen(CGI.PATH_INFO,"/") EQ 5>
			<cfset LOCAL.filterList = ListGetAt(CGI.PATH_INFO,5,"/") />
		<cfelse>
			<cfset LOCAL.filterList = "" />
		</cfif>
		
		<cfset LOCAL.currentFilterStruct = {} />
		
		<cfloop list="#LOCAL.filterList#" index="LOCAL.filterAndValue">
			<cfset LOCAL.filterId = ListGetAt(LOCAL.filterAndValue,1,"=") />
			<cfset LOCAL.filterValueId = ListGetAt(LOCAL.filterAndValue,2,"=") />
			<cfset LOCAL.currentFilterStruct["#LOCAL.filterId#"] = LOCAL.filterValueId />
		</cfloop>
		
		<cfset LOCAL.pageData.category = EntityLoadByPK("category",LOCAL.categoryId) />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		<cfset LOCAL.productService.setIsDeleted(false) />
		<cfset LOCAL.productService.setIsEnabled(true) />
		<cfset LOCAL.productService.setPageNumber(LOCAL.pageData.pageNumber) />
		<cfset LOCAL.productService.setRecordsPerPage(APPLICATION.recordsPerPageFrontend) />
		<cfset LOCAL.productService.setCategoryId(LOCAL.categoryId) />
		
		<cfset LOCAL.productService.setFilters(currentFilterStruct) />
		<cfset LOCAL.productService.setSortTypeId(LOCAL.pageData.sortTypeId) />
		
		<cfset LOCAL.recordStruct = LOCAL.productService.getRecords() />
		<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(recordStruct = LOCAL.recordStruct, currentPage = LOCAL.pageData.pageNumber) />
		
		<cfset LOCAL.pageData.subCategoryTree = LOCAL.categoryService.getCategoryTree(parentCategoryId = LOCAL.categoryId) />
		
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.category.getDisplayName()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = LOCAL.pageData.category.getDescription() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.category.getKeywords() />
		<cfset LOCAL.pageData.categoryArray = _getCategoryArray(category = LOCAL.pageData.category) />
	
		<cfset LOCAL.pageData.currentPage = EntityLoad("page", {name = getPageName()},true)> 
		<cfset LOCAL.pageData.advertisementSection = EntityLoad("page_section", {name="advertisement",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.advertisementSection.setCategory(LOCAL.pageData.category) />
		<cfset LOCAL.pageData.bestSellerSection = EntityLoad("page_section", {name="best seller",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.pageData.bestSellerSection.setCategory(LOCAL.pageData.category) />
	
		<cfif LOCAL.pageData.category.getDisplayCategoryList() EQ true>
			<cfset LOCAL.pageData.allCategories = EntityLoad("category", {isDeleted = false, isEnabled = true})> 
		</cfif>
	
		<cfset LOCAL.pageData.filterArray = _getFilterArray(	category = LOCAL.pageData.category
															, 	sortTypeId = LOCAL.pageData.sortTypeId
															, 	currentFilterStruct = LOCAL.currentFilterStruct) />
															
		<cfset LOCAL.pageData.pageArray = _getPageArray(	currentPage = LOCAL.pageData.pageNumber
														, 	totalPages = LOCAL.pageData.paginationInfo.totalPages
														,	categoryName = LOCAL.pageData.category.getDisplayName()
														,	categoryId = LOCAL.pageData.category.getCategoryId()
														, 	sortTypeId = LOCAL.pageData.sortTypeId
														, 	filterStruct = LOCAL.currentFilterStruct) />
														
		<cfset LOCAL.pageData.sortTypeArray = _getSortTypeArray(	categoryName = LOCAL.pageData.category.getDisplayName()
																,	categoryId = LOCAL.pageData.category.getCategoryId()
																, 	sortTypeId = LOCAL.pageData.sortTypeId
																, 	filterStruct = LOCAL.currentFilterStruct) />												
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
		<cfargument name="sortTypeId" type="numeric" required="true" />
		<cfargument name="currentFilterStruct" type="struct" required="true" />
		
		<cfset var LOCAL = {} />
				
		<cfset LOCAL.filterArray = [] />
		<cfset LOCAL.category = ARGUMENTS.category />
		
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
					<cfset LOCAL.newFilterValue.selected = false />
					
					<cfset LOCAL.filterFound = false />
					<cfset LOCAL.currentFilterStruct = Duplicate(ARGUMENTS.currentFilterStruct) />
					<cfloop collection="#LOCAL.currentFilterStruct#" item="LOCAL.currentFilterId">
						<cfset LOCAL.currentFilterValueId = LOCAL.currentFilterStruct["#LOCAL.currentFilterId#"] />
						
						<cfif 	LOCAL.currentFilterId EQ LOCAL.filter.getFilterId()
								AND
								LOCAL.currentFilterValueId NEQ LOCAL.filterValue.getFilterValueId()>
							<cfset LOCAL.currentFilterStruct["#LOCAL.currentFilterId#"] = LOCAL.filterValue.getFilterValueId() />
							<cfset LOCAL.filterFound = true />
							<cfbreak />
						<cfelseif 	LOCAL.currentFilterId EQ LOCAL.filter.getFilterId()
									AND
									LOCAL.currentFilterValueId EQ LOCAL.filterValue.getFilterValueId()>
							<cfset LOCAL.currentFilterStruct["#LOCAL.currentFilterId#"] = "" />
							<cfset LOCAL.filterFound = true />
							<cfset LOCAL.newFilterValue.selected = true />
							<cfbreak />
						</cfif>
					</cfloop>
					
					<cfif LOCAL.filterFound EQ false>
						<cfset LOCAL.currentFilterStruct["#LOCAL.filter.getFilterId()#"] = LOCAL.filterValue.getFilterValueId() />
					</cfif>
					
					<cfset LOCAL.newFilterValue.link = CGI.SCRIPT_NAME & _buildPathInfo(categoryName = LOCAL.category.getDisplayName()
																						, categoryId = LOCAL.category.getCategoryId()
																						, pageNumber = 1
																						, sortTypeId = ARGUMENTS.sortTypeId
																						, filterStruct = LOCAL.currentFilterStruct
																						) />
					<cfset ArrayPrepend(LOCAL.filterStruct.filterValueArray, LOCAL.newFilterValue) />
				</cfloop>
			</cfif>
			
			<cfset ArrayPrepend(LOCAL.filterArray, LOCAL.filterStruct) />
		</cfloop>
				
		<cfreturn LOCAL.filterArray />	
	</cffunction>
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_getSortTypeArray" access="private" output="false" returnType="array">
		<cfargument name="categoryName" type="string" required="true" />
		<cfargument name="categoryId" type="numeric" required="true" />
		<cfargument name="sortTypeId" type="numeric" required="true" />
		<cfargument name="filterStruct" type="struct" required="true" />
		
		<cfset var LOCAL = {} />
				
		<cfset LOCAL.sortTypeArray = [] />
		
		<cfset LOCAL.sortType = {} />
		<cfset LOCAL.sortType.name = "New Arrivals" />
		<cfset LOCAL.sortType.id = 1 />
		<cfif ARGUMENTS.sortTypeId EQ 1>
			<cfset LOCAL.sortType.selected = true />
		<cfelse>
			<cfset LOCAL.sortType.selected = false />
		</cfif>
		<cfset LOCAL.sortType.link = CGI.SCRIPT_NAME & _buildPathInfo(categoryName = ARGUMENTS.categoryName
																	, categoryId = ARGUMENTS.categoryId
																	, pageNumber = 1
																	, sortTypeId = 1
																	, filterStruct = ARGUMENTS.filterStruct) />
																	
		<cfset ArrayAppend(LOCAL.sortTypeArray, LOCAL.sortType) />
		
		<cfset LOCAL.sortType = {} />
		<cfset LOCAL.sortType.name = "Top Selling" />
		<cfset LOCAL.sortType.id = 2 />
		<cfif ARGUMENTS.sortTypeId EQ 2>
			<cfset LOCAL.sortType.selected = true />
		<cfelse>
			<cfset LOCAL.sortType.selected = false />
		</cfif>
		<cfset LOCAL.sortType.link = CGI.SCRIPT_NAME & _buildPathInfo(categoryName = ARGUMENTS.categoryName
																	, categoryId = ARGUMENTS.categoryId
																	, pageNumber = 1
																	, sortTypeId = 2
																	, filterStruct = ARGUMENTS.filterStruct) />
		
		<cfset ArrayAppend(LOCAL.sortTypeArray, LOCAL.sortType) />
		
		<cfset LOCAL.sortType = {} />
		<cfset LOCAL.sortType.name = "Price" />
		<cfset LOCAL.sortType.id = 3 />
		<cfif ARGUMENTS.sortTypeId EQ 3>
			<cfset LOCAL.sortType.selected = true />
		<cfelse>
			<cfset LOCAL.sortType.selected = false />
		</cfif>
		
		<cfset LOCAL.sortType.link = CGI.SCRIPT_NAME & _buildPathInfo(categoryName = ARGUMENTS.categoryName
																	, categoryId = ARGUMENTS.categoryId
																	, pageNumber = 1
																	, sortTypeId = 3
																	, filterStruct = ARGUMENTS.filterStruct) />
		
		<cfset ArrayAppend(LOCAL.sortTypeArray, LOCAL.sortType) />
		
		<cfset LOCAL.sortType = {} />
		<cfset LOCAL.sortType.name = "Review" />
		<cfset LOCAL.sortType.id = 4 />
		<cfif ARGUMENTS.sortTypeId EQ 4>
			<cfset LOCAL.sortType.selected = true />
		<cfelse>
			<cfset LOCAL.sortType.selected = false />
		</cfif>
		<cfset LOCAL.sortType.link = CGI.SCRIPT_NAME & _buildPathInfo(categoryName = ARGUMENTS.categoryName
																	, categoryId = ARGUMENTS.categoryId
																	, pageNumber = 1
																	, sortTypeId = 4
																	, filterStruct = ARGUMENTS.filterStruct) />
																	
		<cfset ArrayAppend(LOCAL.sortTypeArray, LOCAL.sortType) />
				
		<cfreturn LOCAL.sortTypeArray />	
	</cffunction>
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_buildPathInfo" access="private" output="false" returnType="string">
		<cfargument name="categoryName" type="string" required="true" />
		<cfargument name="categoryId" type="numeric" required="true" />
		<cfargument name="pageNumber" type="numeric" required="true" />
		<cfargument name="sortTypeId" type="numeric" required="true" />
		<cfargument name="filterStruct" type="struct" required="true" />
		
		<cfset var pathInfo = "/#URLEncodedFormat(ARGUMENTS.categoryName)#/#ARGUMENTS.categoryId#/#ARGUMENTS.pageNumber#/#ARGUMENTS.sortTypeId#/" />
		
		<cfloop collection="#ARGUMENTS.filterStruct#" item="LOCAL.filterId">
			<cfif ARGUMENTS.filterStruct["#LOCAL.filterId#"] NEQ "">
				<cfset pathInfo &= LOCAL.filterId & "=" & ARGUMENTS.filterStruct["#LOCAL.filterId#"] & "," />
			</cfif>
		</cfloop>
		
		<cfreturn pathInfo />	
	</cffunction>
	<!---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="_getPageArray" access="private" output="false" returnType="array">
		<cfargument name="currentPage" type="string" required="true" />
		<cfargument name="totalPages" type="string" required="true" />
		<cfargument name="categoryName" type="string" required="true" />
		<cfargument name="categoryId" type="numeric" required="true" />
		<cfargument name="sortTypeId" type="numeric" required="true" />
		<cfargument name="filterStruct" type="struct" required="true" />
		
		<cfset var LOCAL = {} />
				
		<cfset LOCAL.pageArray = [] />
		
		<cfif ARGUMENTS.currentPage GT 3 AND ARGUMENTS.totalPages GT 5>
			<cfset LOCAL.pageStruct = {} />
			<cfset LOCAL.pageStruct.number = "&laquo;" />
			<cfset LOCAL.pageStruct.selected = false />
			<cfset LOCAL.pageStruct.link = CGI.SCRIPT_NAME & _buildPathInfo(categoryName = ARGUMENTS.categoryName
														, categoryId = ARGUMENTS.categoryId
														, pageNumber = 1
														, sortTypeId = ARGUMENTS.sortTypeId
														, filterStruct = ARGUMENTS.filterStruct) />
			<cfset ArrayAppend(LOCAL.pageArray, LOCAL.pageStruct) />
		</cfif>
		
		<cfif ARGUMENTS.totalPages LTE 5>
			<cfset LOCAL.from = 1 />
			<cfset LOCAL.to = ARGUMENTS.totalPages />
		<cfelseif ARGUMENTS.totalPages GT 5 AND ARGUMENTS.currentPage LTE 3>
			<cfset LOCAL.from = 1 />
			<cfset LOCAL.to = 5 />
		<cfelseif ARGUMENTS.totalPages GT 5 AND ARGUMENTS.currentPage GT 3 AND ARGUMENTS.currentPage LTE (ARGUMENTS.totalPages - 3)>
			<cfset LOCAL.from = ARGUMENTS.currentPage - 2 />
			<cfset LOCAL.to = ARGUMENTS.currentPage + 2 />
		<cfelseif ARGUMENTS.totalPages GT 5 AND ARGUMENTS.currentPage GT (ARGUMENTS.totalPages - 3)> 
			<cfset LOCAL.from = ARGUMENTS.totalPages - 5 />
			<cfset LOCAL.to = ARGUMENTS.totalPages />
		</cfif>
		
		<cfloop from="#LOCAL.from#" to="#LOCAL.to#" index="LOCAL.i">
			<cfset LOCAL.pageStruct = {} />
			<cfset LOCAL.pageStruct.number = LOCAL.i />
			
			<cfif LOCAL.i EQ ARGUMENTS.currentPage>
				<cfset LOCAL.pageStruct.selected = true />
			<cfelse>
				<cfset LOCAL.pageStruct.selected = false />
			</cfif>
			
			<cfset LOCAL.pageStruct.link = CGI.SCRIPT_NAME & _buildPathInfo(categoryName = ARGUMENTS.categoryName
														, categoryId = ARGUMENTS.categoryId
														, pageNumber = LOCAL.i
														, sortTypeId = ARGUMENTS.sortTypeId
														, filterStruct = ARGUMENTS.filterStruct) />
			<cfset ArrayAppend(LOCAL.pageArray, LOCAL.pageStruct) />
		</cfloop>
		
		<cfif ARGUMENTS.currentPage LT ARGUMENTS.totalPages-2 AND ARGUMENTS.totalPages GT 5>
			<cfset LOCAL.pageStruct = {} />
			<cfset LOCAL.pageStruct.number = "&raquo;" />
			<cfset LOCAL.pageStruct.selected = false />
			<cfset LOCAL.pageStruct.link = CGI.SCRIPT_NAME & _buildPathInfo(categoryName = ARGUMENTS.categoryName
														, categoryId = ARGUMENTS.categoryId
														, pageNumber = ARGUMENTS.totalPages
														, sortTypeId = ARGUMENTS.sortTypeId
														, filterStruct = ARGUMENTS.filterStruct) />
			<cfset ArrayAppend(LOCAL.pageArray, LOCAL.pageStruct) />
		</cfif>
				
		<cfreturn LOCAL.pageArray />	
	</cffunction>
</cfcomponent>