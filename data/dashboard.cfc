<cfcomponent extends="master">	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif NOT IsNumeric(SESSION.user.customerId)>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#index.cfm" />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Dashboard | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
		<cfset LOCAL.pageData.latestOrderArray = EntityLoad("order",{customer = LOCAL.pageData.customer, isComplete = true}, "createdDatetime Desc", {maxResults = 1}) />
		<cfif NOT ArrayIsEmpty(LOCAL.pageData.latestOrderArray)>
			<cfset LOCAL.pageData.latestOrderStatusArray = EntityLoad("order_status",{order = LOCAL.pageData.latestOrderArray[1]}, "startDatetime Desc", {maxResults = 1}) />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>