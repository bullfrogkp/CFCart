<cfcomponent extends="master">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Coupons | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.customerGroups = EntityLoad("coupon",{isDeleted = false}) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>