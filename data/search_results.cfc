<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		<cfset LOCAL.pageData.title = "Search Results | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		<!---
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		<cfset LOCAL.productService.setIsDeleted(false) />
		<cfset LOCAL.productService.setIsEnabled(true) />
		<cfset LOCAL.productService.setPageNumber(LOCAL.pageData.pageNumber) />
		<cfset LOCAL.productService.setRecordsPerPage(APPLICATION.recordsPerPageFrontend) />
		<cfset LOCAL.productService.setCategoryId(LOCAL.categoryId) />
		<cfset LOCAL.recordStruct = LOCAL.productService.getRecords() />
		<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(recordStruct = LOCAL.recordStruct, currentPage = LOCAL.pageData.pageNumber) />
		--->
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>