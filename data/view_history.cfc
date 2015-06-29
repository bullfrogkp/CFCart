﻿<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "View History | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.pageData.trackingRecords = new "#APPLICATION.componentPathRoot#core.services.trackingService"().getTrackingRecords(trackingRecordType = "shopping cart") />
		<cfset LOCAL.pageData.subCategoryTree = LOCAL.categoryService.getCategoryTree(isSpecial = false) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>