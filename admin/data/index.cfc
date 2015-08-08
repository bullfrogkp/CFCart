<cfcomponent extends="master">
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Dashboard | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.pageData.newOrders = EntityLoad("order",{isNew = true, isDeleted = false}, "createdDatetime Desc") />
		<cfset LOCAL.pageData.newCustomers = EntityLoad("customer",{isNew = true, isDeleted = false, isEnabled = true}, "createdDatetime Desc") />
		<cfset LOCAL.pageData.newReviews = EntityLoad("review",{isNew = true, isDeleted = false}, "createdDatetime Desc") />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>