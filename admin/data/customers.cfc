<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Customers | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.customerService = new "#APPLICATION.componentPathRoot#core.services.customerService"() />
		
		<cfif StructKeyExists(URL,"customer_id") AND IsNumeric(URL.customer_id)>
			<cfset LOCAL.customerService.setCustomerId(URL.customer_id) />
		</cfif>
		<cfif StructKeyExists(URL,"is_enabled") AND IsNumeric(URL.is_enabled)>
			<cfset LOCAL.customerService.setIsEnabled(URL.is_enabled) />
		</cfif>
		<cfif StructKeyExists(URL,"search_keyword") AND Trim(URL.search_keyword) NEQ "">
			<cfset LOCAL.customerService.setSearchKeywords(Trim(URL.search_keyword)) />
		</cfif>
		
		<cfset LOCAL.pageData.customers = LOCAL.customerService.getCustomers() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>